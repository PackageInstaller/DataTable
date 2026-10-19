using System;
using System.Collections.Generic;
using System.Reflection;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Utilities;

namespace ACT.Battle;

public class GameInputActionManager : Singleton<GameInputActionManager>
{
	internal enum CompositeBindingPartType
	{
		Unknown,
		Modifier,
		Binding
	}

	private delegate void InputActionCallbackProcess(InputAction.CallbackContext context);

	public class ActionKeyBindingInfo
	{
		public readonly string ActionPath;

		private readonly List<string> _bindingKeyLocations;

		private readonly List<int> _compositeBindingIndexes;

		private readonly List<CompositeBindingPartType> _compositeBindingPartTypes;

		private readonly List<InputControl> _compositeControls;

		private readonly List<CompositeBindingPartType> _compositeControlPartTypes;

		private List<string> _registeredBindingPaths;

		public MonoECS.CompositeMode GetMode()
		{
			if (_bindingKeyLocations.Count <= 1)
			{
				return MonoECS.CompositeMode.NoComposite;
			}
			return MonoECS.CompositeMode.OneModifier;
		}

		internal bool TryGetCompositePartType(InputAction action, InputControl inputControl, out CompositeBindingPartType partType)
		{
			partType = CompositeBindingPartType.Unknown;
			if (_compositeBindingIndexes != null)
			{
				int bindingIndexForControl = action.GetBindingIndexForControl(inputControl);
				int count = _compositeBindingIndexes.Count;
				for (int i = 0; i < count; i++)
				{
					if (_compositeBindingIndexes[i] == bindingIndexForControl)
					{
						partType = _compositeBindingPartTypes[i];
						return true;
					}
				}
			}
			if (_compositeControls == null)
			{
				return false;
			}
			int count2 = _compositeControls.Count;
			for (int j = 0; j < count2; j++)
			{
				if (_compositeControls[j] == inputControl)
				{
					partType = _compositeControlPartTypes[j];
					return true;
				}
			}
			return false;
		}

		internal bool IsModifierKeyDown()
		{
			if (_compositeControls == null || _compositeControlPartTypes == null)
			{
				return false;
			}
			int count = _compositeControls.Count;
			for (int i = 0; i < count; i++)
			{
				if (_compositeControlPartTypes[i] == CompositeBindingPartType.Modifier)
				{
					InputControl inputControl = _compositeControls[i];
					if (inputControl != null && inputControl.device.added && inputControl.IsPressed(0.001f))
					{
						return true;
					}
				}
			}
			return false;
		}

		internal void RegisterBindingControls(InputAction inputAction, Dictionary<string, List<ActionKeyBindingInfo>> bindingInfoMap)
		{
			if (_compositeControls == null || _compositeControlPartTypes == null)
			{
				return;
			}
			int count = _compositeControls.Count;
			for (int i = 0; i < count; i++)
			{
				if (_compositeControlPartTypes[i] != CompositeBindingPartType.Binding)
				{
					continue;
				}
				InputControl inputControl = _compositeControls[i];
				if (inputControl == null)
				{
					continue;
				}
				InputBinding? bindingForControl = inputAction.GetBindingForControl(inputControl);
				if (!bindingForControl.HasValue)
				{
					continue;
				}
				string effectivePath = bindingForControl.GetValueOrDefault().effectivePath;
				if (_registeredBindingPaths == null)
				{
					_registeredBindingPaths = new List<string>();
				}
				if (!_registeredBindingPaths.Contains(effectivePath))
				{
					if (!bindingInfoMap.TryGetValue(effectivePath, out var value))
					{
						value = new List<ActionKeyBindingInfo>();
						bindingInfoMap.Add(effectivePath, value);
					}
					value.Add(this);
					_registeredBindingPaths.Add(effectivePath);
				}
			}
		}

		internal void UnregisterBindingControls(Dictionary<string, List<ActionKeyBindingInfo>> bindingInfoMap)
		{
			if (_registeredBindingPaths == null)
			{
				return;
			}
			foreach (string registeredBindingPath in _registeredBindingPaths)
			{
				if (bindingInfoMap.TryGetValue(registeredBindingPath, out var value))
				{
					value.Remove(this);
					if (value.Count == 0)
					{
						bindingInfoMap.Remove(registeredBindingPath);
					}
				}
			}
			_registeredBindingPaths.Clear();
		}

		public string GetKeyBinding(int index)
		{
			bool flag = index < 0;
			int num = (flag ? (-1) : 0);
			index = Math.Abs(index);
			if (index + num >= _bindingKeyLocations.Count)
			{
				return string.Empty;
			}
			if (!flag)
			{
				return _bindingKeyLocations[index];
			}
			List<string> bindingKeyLocations = _bindingKeyLocations;
			int num2 = index;
			return bindingKeyLocations[bindingKeyLocations.Count - num2];
		}

		private static string GetActionPath(InputAction action)
		{
			return action.actionMap.name + "/" + action.name;
		}

		public ActionKeyBindingInfo(InputAction action, List<string> keyLocations)
		{
			ActionPath = GetActionPath(action);
			_bindingKeyLocations = keyLocations;
		}

		internal ActionKeyBindingInfo(InputAction action, List<string> keyLocations, List<int> compositeBindingIndexes, List<CompositeBindingPartType> compositeBindingPartTypes, List<InputControl> compositeControls, List<CompositeBindingPartType> compositeControlPartTypes)
		{
			ActionPath = GetActionPath(action);
			_bindingKeyLocations = keyLocations;
			_compositeBindingIndexes = compositeBindingIndexes;
			_compositeBindingPartTypes = compositeBindingPartTypes;
			_compositeControls = compositeControls;
			_compositeControlPartTypes = compositeControlPartTypes;
		}

		public ActionKeyBindingInfo(InputAction action, string keyLocation)
		{
			ActionPath = GetActionPath(action);
			_bindingKeyLocations = new List<string> { keyLocation };
		}
	}

	private struct ActionBindingInfo
	{
		public IGameInputBindingHandle Handle;

		public MethodInfo Method;

		public GameInputBindingAttributeBase Attribute;
	}

	public const string IgnoredOnUIHitCheck = "IgnoreOnUIHitCheck";

	private Dictionary<InputAction, InputActionCallbackProcess> _actionContextProcesses;

	private Dictionary<InputAction, string> _actionToPaths;

	private Dictionary<string, InputAction> _pathToActions;

	private HashSet<IGameInputBindingHandle> _activeHandles;

	private Dictionary<InputAction, MethodInvokeHelper> _actionToInvokes;

	private Dictionary<IGameInputBindingHandle, HashSet<string>> _handleActionBlacklistMap;

	private Dictionary<string, bool> _actionDisabledDict;

	private Dictionary<string, CustomUICompType> _actionPathToCustomUICompType;

	private Dictionary<MotionInputKey, string> _motionInputKeyToActionPath;

	private Dictionary<InputKey, string> _inputKeyToActionPath;

	private Dictionary<string, InputActionCallbackProcess> _supportedInputActionProcess;

	private readonly Dictionary<string, Dictionary<MonoECS.PromptIconDeviceType, ActionKeyBindingInfo>> _promptBindingMap = new Dictionary<string, Dictionary<MonoECS.PromptIconDeviceType, ActionKeyBindingInfo>>();

	private readonly Dictionary<string, List<ActionKeyBindingInfo>> _compositeBindingInfoMap = new Dictionary<string, List<ActionKeyBindingInfo>>();

	private readonly Dictionary<InputAction, List<ActionKeyBindingInfo>> _actionToCompositeBindingInfos = new Dictionary<InputAction, List<ActionKeyBindingInfo>>();

	private PointerCursorManager _cursorManager = new PointerCursorManager();

	private GameInputState _inputState;

	private bool _skipAllActionProcess;

	private readonly HashSet<string> _actionStopPropagationMark = new HashSet<string>();

	private const string OneModifier = "OneModifier";

	private const string CompositePartModifier = "modifier";

	private const string CompositePartBinding = "binding";

	private List<GameObject> _uiItems;

	private readonly List<RaycastResult> _mouseRaycastResults = new List<RaycastResult>();

	private PointerEventData _mousePointerEventData;

	private static readonly string[] NeedUpdateActions = new string[5] { "Player/Move", "Player/RegularAttack", "Player/SkillAttack", "Player/Jump", "Player/Dodge" };

	private const float PressedThreshold = 0.001f;

	private InputDevice _playerMoveInputDevice;

	private int _focusRestoreFrame = -1;

	private readonly Dictionary<InputAction, bool> _buttonStateDict = new Dictionary<InputAction, bool>();

	private Dictionary<Type, List<(MethodInfo, GameInputBindingAttributeBase)>> _methodCaches = new Dictionary<Type, List<(MethodInfo, GameInputBindingAttributeBase)>>();

	private HashSet<IGameInputBindingHandle> _delayActiveHandles = new HashSet<IGameInputBindingHandle>();

	private List<IGameInputBindingHandle> _registerBindingHandles;

	private bool _activateBindingMapIsDirty;

	private List<IGameInputBindingHandle> _removeWaitList;

	private List<LongPressInputHandle> _activeLongPressInputHandles;

	private readonly List<LongPressInputHandle> _needRemoveLongPressHandles = new List<LongPressInputHandle>();

	private readonly List<LongPressInputHandle> _needNotifiedLongPressHandles = new List<LongPressInputHandle>();

	private List<IGameInputBindingHandle> _clearCache;

	private List<IGameInputBindingHandle> _enabledHandles;

	private List<IGameInputBindingHandle> _disabledHandles;

	private Dictionary<string, ActionBindingInfo> _migrateBindingsCache;

	private Entity _currentEntity;

	public override ContextType ContextType => ContextType.GAME;

	public IMouseCursorManager PointerCursor => _cursorManager;

	public TouchPointerManager TouchPointer { get; } = new TouchPointerManager();

	public bool IsActive { get; private set; } = true;

	public event Action<string, bool> OnActionDisabledChanged;

	public event Action<GameInputState> onInputStateChanged;

	public bool CheckInputStateEqual(GameInputState state)
	{
		return _inputState == state;
	}

	public bool CheckInputStateActive(GameInputState state)
	{
		return (_inputState & state) != 0;
	}

	public bool SetGameInputState(GameInputState state, bool active)
	{
		GameInputState inputState = _inputState;
		inputState = ((!active) ? (inputState & ~state) : (inputState | state));
		if (inputState == _inputState)
		{
			return false;
		}
		_inputState = inputState;
		_cursorManager.UpdateCursorVisible();
		onInputStateChanged?.Invoke(_inputState);
		return true;
	}

	public override void UnInit()
	{
		base.UnInit();
		Application.focusChanged -= HandleApplicationFocusChange;
		_inputState = GameInputState.None;
		_cursorManager.UpdateCursorVisible();
		TouchPointer.Clear();
		UnInitOnScreenDeviceCallback();
		if (_actionToPaths != null)
		{
			foreach (KeyValuePair<InputAction, string> actionToPath in _actionToPaths)
			{
				actionToPath.Key.performed -= OnInputActionCallback;
			}
		}
		_actionToPaths = null;
		_actionContextProcesses = null;
		ResetPlayerInput(GamePlayerInput.GetCurrent());
		_currentEntity = default;
		_delayActiveHandles.AddRange(_registerBindingHandles);
		_registerBindingHandles.Clear();
		_actionStopPropagationMark.Clear();
		_actionToInvokes.Clear();
		_activeHandles.Clear();
	}

	public override void Init()
	{
		base.Init();
		Application.focusChanged += HandleApplicationFocusChange;
		if (_actionContextProcesses == null)
		{
			_actionContextProcesses = new Dictionary<InputAction, InputActionCallbackProcess>();
		}
		_actionContextProcesses.Clear();
		if (_actionToPaths == null)
		{
			_actionToPaths = new Dictionary<InputAction, string>();
		}
		_actionToPaths.Clear();
		if (_pathToActions == null)
		{
			_pathToActions = new Dictionary<string, InputAction>();
		}
		_pathToActions.Clear();
		if (_actionToInvokes == null)
		{
			_actionToInvokes = new Dictionary<InputAction, MethodInvokeHelper>();
		}
		_actionToInvokes.Clear();
		if (_activeHandles == null)
		{
			_activeHandles = new HashSet<IGameInputBindingHandle>();
		}
		_activeHandles.Clear();
		if (_registerBindingHandles == null)
		{
			_registerBindingHandles = new List<IGameInputBindingHandle>();
		}
		_registerBindingHandles.Clear();
		RefreshActiveInputActionMap();
		if (_actionDisabledDict == null)
		{
			_actionDisabledDict = new Dictionary<string, bool>();
		}
		_actionDisabledDict.Clear();
		if (_handleActionBlacklistMap == null)
		{
			_handleActionBlacklistMap = new Dictionary<IGameInputBindingHandle, HashSet<string>>();
		}
		_handleActionBlacklistMap.Clear();
		if (_actionPathToCustomUICompType == null)
		{
			_actionPathToCustomUICompType = new Dictionary<string, CustomUICompType>
			{
				{
					"Player/Jump",
					CustomUICompType.JumpBtn
				},
				{
					"Player/Dodge",
					CustomUICompType.DodgeBtn
				},
				{
					"Player/RegularAttack",
					CustomUICompType.AttackBtn
				},
				{
					"Player/SkillAttack",
					CustomUICompType.SpAttackBtn
				},
				{
					"Player/Vibrate",
					CustomUICompType.UltraBtn
				}
			};
		}
		if (_motionInputKeyToActionPath == null)
		{
			_motionInputKeyToActionPath = new Dictionary<MotionInputKey, string>
			{
				{
					MotionInputKey.normalAttack,
					"Player/RegularAttack"
				},
				{
					MotionInputKey.skillAttck,
					"Player/SkillAttack"
				}
			};
		}
		if (_inputKeyToActionPath == null)
		{
			_inputKeyToActionPath = new Dictionary<InputKey, string>
			{
				{
					InputKey.regularAttack,
					"Player/RegularAttack"
				},
				{
					InputKey.skill,
					"Player/SkillAttack"
				},
				{
					InputKey.heavyAttack,
					"Player/SkillAttack"
				},
				{
					InputKey.switch1Character,
					"Player/Switch1Character"
				},
				{
					InputKey.switch2Character,
					"Player/Switch2Character"
				},
				{
					InputKey.switch3Character,
					"Player/Switch3Character"
				},
				{
					InputKey.vibrate,
					"Player/Vibrate"
				},
				{
					InputKey.jump,
					"Player/Jump"
				},
				{
					InputKey.dodge,
					"Player/Dodge"
				},
				{
					InputKey.interactClaw,
					"Player/Claw"
				},
				{
					InputKey.map,
					"UI/Map"
				},
				{
					InputKey.bag,
					"UI/Bag"
				},
				{
					InputKey.character,
					"UI/Character"
				},
				{
					InputKey.esc,
					"UI/Esc"
				},
				{
					InputKey.activity,
					"UI/Activity"
				},
				{
					InputKey.cardPool,
					"UI/CardPool"
				},
				{
					InputKey.summary,
					"UI/Summary"
				},
				{
					InputKey.task,
					"UI/Task"
				},
				{
					InputKey.openTeam,
					"UI/Team"
				}
			};
		}
		InitOnScreenDeviceCallback();
		_cursorManager.Setup(this);
	}

	private void HandleApplicationFocusChange(bool focus)
	{
		if (!focus)
		{
			_buttonStateDict.Clear();
			_actionStopPropagationMark.Clear();
			_skipAllActionProcess = false;
			_focusRestoreFrame = -1;
			ResetLongPressInputHandles();
			ResetCurrentPlayerInput();
		}
		else
		{
			_focusRestoreFrame = Time.frameCount;
		}
	}

	private void ResetLongPressInputHandles()
	{
		if (_activeLongPressInputHandles == null || _activeLongPressInputHandles.Count == 0)
		{
			return;
		}
		foreach (LongPressInputHandle activeLongPressInputHandle in _activeLongPressInputHandles)
		{
			activeLongPressInputHandle.Clear();
		}
		_activeLongPressInputHandles.Clear();
		_needNotifiedLongPressHandles.Clear();
		_needRemoveLongPressHandles.Clear();
	}

	public void ResetCurrentPlayerInput()
	{
		ResetPlayerInput(GamePlayerInput.GetCurrent());
	}

	private void InitOnScreenDeviceCallback()
	{
		LuminApplication.SetHandleOnScreenDeviceCallback<float>(HandleOnScreenDeviceFloatInputAction);
		LuminApplication.SetHandleOnScreenDeviceCallback<bool>(HandleOnScreenDeviceBoolInputAction);
		LuminApplication.SetHandleOnScreenDeviceCallback<Vector2>(HandleOnScreenDeviceVec2InputAction);
	}

	private void UnInitOnScreenDeviceCallback()
	{
		LuminApplication.SetHandleOnScreenDeviceCallback<float>(null);
		LuminApplication.SetHandleOnScreenDeviceCallback<bool>(null);
		LuminApplication.SetHandleOnScreenDeviceCallback<Vector2>(null);
	}

	private void HandleOnScreenDeviceFloatInputAction(string path, float value)
	{
		HandleOnScreenDeviceInputActionCallback(path, value);
	}

	private void HandleOnScreenDeviceBoolInputAction(string path, bool value)
	{
		HandleOnScreenDeviceInputActionCallback(path, value);
	}

	private void HandleOnScreenDeviceVec2InputAction(string path, Vector2 value)
	{
		HandleOnScreenDeviceInputActionCallback(path, value);
	}

	private void HandleOnScreenDeviceInputActionCallback<T>(string path, T value) where T : struct
	{
		if (_pathToActions.TryGetValue(path, out var value2))
		{
			UpdateActionInput(value2, in value, needFilterMouseAction: false);
		}
	}

	private void RefreshActiveInputActionMap()
	{
		if (_supportedInputActionProcess == null)
		{
			_supportedInputActionProcess = new Dictionary<string, InputActionCallbackProcess>
			{
				{ "Axis", NotifyAxisInput },
				{ "Button", NotifyButtonInput },
				{ "Vector2", NotifyVector2Input }
			};
		}
		_pathToActions.Clear();
		_actionToPaths.Clear();
		_actionContextProcesses.Clear();
		_promptBindingMap.Clear();
		_compositeBindingInfoMap.Clear();
		_actionToCompositeBindingInfos.Clear();
		foreach (InputActionMap actionMap in MonoECS.instance.inputActionAsset.actionMaps)
		{
			string name = actionMap.name;
			foreach (InputAction action in actionMap.actions)
			{
				string text = name + "/" + action.name;
				if (!_supportedInputActionProcess.TryGetValue(action.expectedControlType, out var value))
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning("Please Check Unexpected Control Type: " + action.expectedControlType + ", Action Path: " + text);
					}
					continue;
				}
				RefreshInputActionBindingPromptInfo(action);
				action.performed -= OnInputActionCallback;
				action.performed += OnInputActionCallback;
				_pathToActions[text] = action;
				_actionToPaths[action] = text;
				_actionContextProcesses[action] = value;
			}
		}
	}

	private void OnInputActionCallback(InputAction.CallbackContext context)
	{
		_actionContextProcesses[context.action]?.Invoke(context);
	}

	private void NotifyButtonInput(InputAction.CallbackContext context)
	{
		InvokeBoolCallback(context);
	}

	private void NotifyAxisInput(InputAction.CallbackContext context)
	{
		InvokeFloatCallback(context);
	}

	private void NotifyVector2Input(InputAction.CallbackContext context)
	{
		InvokeVector2Callback(context);
	}

	public T ReadActionValue<T>(string actionPath, out InputActionPhase phase) where T : struct
	{
		phase = InputActionPhase.Disabled;
		if (!_pathToActions.TryGetValue(actionPath, out var value))
		{
			return default;
		}
		phase = value.phase;
		return value.ReadValue<T>();
	}

	private void RefreshInputActionBindingPromptInfo(InputAction action)
	{
		Dictionary<MonoECS.PromptIconDeviceType, ActionKeyBindingInfo> dictionary = new Dictionary<MonoECS.PromptIconDeviceType, ActionKeyBindingInfo>();
		ReadOnlyArray<InputBinding> bindings = action.bindings;
		int count = bindings.Count;
		for (int i = 0; i < count; i++)
		{
			InputBinding inputBinding = bindings[i];
			MonoECS.PromptIconDeviceType type2;
			string path2;
			if (inputBinding.isComposite && inputBinding.path.StartsWith("OneModifier", StringComparison.Ordinal))
			{
				int num = 0;
				List<string> list = new List<string>();
				List<int> list2 = new List<int>();
				List<CompositeBindingPartType> list3 = new List<CompositeBindingPartType>();
				List<InputControl> list4 = new List<InputControl>();
				List<CompositeBindingPartType> list5 = new List<CompositeBindingPartType>();
				MonoECS.PromptIconDeviceType key = MonoECS.PromptIconDeviceType.Unknown;
				while (count > i + num + 1)
				{
					InputBinding inputBinding2 = bindings[i + num + 1];
					if (!inputBinding2.isPartOfComposite)
					{
						break;
					}
					int num2 = i + num + 1;
					if (!MonoECS.CorrectBindingPath(inputBinding2.effectivePath, out var type, out var path))
					{
						num++;
						continue;
					}
					key = type;
					list.Add(path);
					list2.Add(num2);
					CompositeBindingPartType compositeBindingPartType = GetCompositeBindingPartType(inputBinding2.name);
					list3.Add(compositeBindingPartType);
					AddResolvedControls(action, num2, compositeBindingPartType, list4, list5);
					num++;
				}
				if (list.Count > 0)
				{
					ActionKeyBindingInfo actionKeyBindingInfo = new ActionKeyBindingInfo(action, list, list2, list3, list4, list5);
					if (dictionary.TryAdd(key, actionKeyBindingInfo))
					{
						RegisterCompositeBindingInfo(action, actionKeyBindingInfo);
					}
				}
				i += num;
			}
			else if (MonoECS.CorrectBindingPath(bindings[i].effectivePath, out type2, out path2))
			{
				dictionary.TryAdd(type2, new ActionKeyBindingInfo(action, path2));
			}
		}
		_promptBindingMap[action.name] = dictionary;
	}

	private static CompositeBindingPartType GetCompositeBindingPartType(string partName)
	{
		if (string.Equals(partName, "modifier", StringComparison.Ordinal))
		{
			return CompositeBindingPartType.Modifier;
		}
		if (string.Equals(partName, "binding", StringComparison.Ordinal))
		{
			return CompositeBindingPartType.Binding;
		}
		return CompositeBindingPartType.Unknown;
	}

	private static void AddResolvedControls(InputAction action, int bindingIndex, CompositeBindingPartType partType, List<InputControl> controls, List<CompositeBindingPartType> controlPartTypes)
	{
		ReadOnlyArray<InputControl> controls2 = action.controls;
		int count = controls2.Count;
		for (int i = 0; i < count; i++)
		{
			InputControl inputControl = controls2[i];
			if (action.GetBindingIndexForControl(inputControl) == bindingIndex)
			{
				controls.Add(inputControl);
				controlPartTypes.Add(partType);
			}
		}
	}

	private void RegisterCompositeBindingInfo(InputAction inputAction, ActionKeyBindingInfo bindingInfo)
	{
		if (!_actionToCompositeBindingInfos.TryGetValue(inputAction, out var value))
		{
			value = new List<ActionKeyBindingInfo>();
			_actionToCompositeBindingInfos.Add(inputAction, value);
		}
		value.Add(bindingInfo);
		bindingInfo.RegisterBindingControls(inputAction, _compositeBindingInfoMap);
	}

	public bool TryGetInputActionKeyBindingInfo(MonoECS.PromptIconDeviceType deviceType, string bindingAction, out ActionKeyBindingInfo bindingInfo)
	{
		bindingInfo = null;
		string[] array = bindingAction.Split("/", 2);
		string key = array[array.Length - 1];
		if (!_promptBindingMap.TryGetValue(key, out var value) || !value.TryGetValue(deviceType, out bindingInfo))
		{
			return false;
		}
		return true;
	}

	private bool TryGetCallbackCompositePartType(InputAction.CallbackContext context, string actionPath, out CompositeBindingPartType partType)
	{
		partType = CompositeBindingPartType.Unknown;
		InputControl control = context.control;
		if (control == null)
		{
			return false;
		}
		MonoECS.PromptIconDeviceType promptIconDeviceType = GetPromptIconDeviceType(control.device);
		if (TryGetInputActionKeyBindingInfo(promptIconDeviceType, actionPath, out var bindingInfo))
		{
			return bindingInfo.TryGetCompositePartType(context.action, control, out partType);
		}
		return false;
	}

	private bool CheckCompositeBindingModifierKeyDown(InputAction action, InputControl control)
	{
		if (control != null)
		{
			InputBinding? bindingForControl = action.GetBindingForControl(control);
			if (bindingForControl.HasValue)
			{
				InputBinding valueOrDefault = bindingForControl.GetValueOrDefault();
				if (_compositeBindingInfoMap.TryGetValue(valueOrDefault.effectivePath, out var value))
				{
					int count = value.Count;
					for (int i = 0; i < count; i++)
					{
						if (value[i].IsModifierKeyDown())
						{
							return true;
						}
					}
					return false;
				}
			}
		}
		return false;
	}

	private static MonoECS.PromptIconDeviceType GetPromptIconDeviceType(InputDevice inputDevice)
	{
		if (inputDevice is Mouse || inputDevice is Keyboard)
		{
			return MonoECS.PromptIconDeviceType.KeyboardAndMouse;
		}
		if (inputDevice is Gamepad)
		{
			return MonoECS.PromptIconDeviceType.Gamepad;
		}
		return MonoECS.PromptIconDeviceType.Unknown;
	}

	public void RefreshInputActionBindings(IList<InputAction> inputActions)
	{
		foreach (InputAction inputAction in inputActions)
		{
			RefreshInputActionBinding(inputAction);
		}
	}

	internal void RefreshAllInputActionBindings()
	{
		if (_actionToPaths == null)
		{
			return;
		}
		foreach (InputAction key in _actionToPaths.Keys)
		{
			RefreshInputActionBinding(key);
		}
	}

	private void RefreshInputActionBinding(InputAction inputAction)
	{
		if (inputAction != null)
		{
			ClearCompositeBindingInfo(inputAction);
			RefreshInputActionBindingPromptInfo(inputAction);
		}
	}

	private void ClearCompositeBindingInfo(InputAction inputAction)
	{
		if (!_actionToCompositeBindingInfos.Remove(inputAction, out var value))
		{
			return;
		}
		foreach (ActionKeyBindingInfo item in value)
		{
			item.UnregisterBindingControls(_compositeBindingInfoMap);
		}
	}

	private bool CheckIsOutsideOfScreen(Vector2 position)
	{
		if (position.x < 0f || position.x > (float)Screen.width || position.y < 0f || position.y > (float)Screen.height)
		{
			return true;
		}
		return false;
	}

	private bool ValidateFloat(float v)
	{
		if (!float.IsNaN(v))
		{
			return float.IsFinite(v);
		}
		return false;
	}

	private bool ValidateScreenPosition(Vector2 pos)
	{
		if (ValidateFloat(pos.x))
		{
			return ValidateFloat(pos.y);
		}
		return false;
	}

	private bool CheckIsHoverOnUI(Vector2 position)
	{
		if (_cursorManager.NeedHideCursor || !ValidateScreenPosition(position))
		{
			return _cursorManager.Visible;
		}
		return GetHoverUINodeList().Count > 0;
	}

	internal List<GameObject> GetHoverUINodeList()
	{
		if (_uiItems == null)
		{
			_uiItems = new List<GameObject>();
		}
		_uiItems.Clear();
		if (Mouse.current == null)
		{
			return _uiItems;
		}
		Vector2 vector = Mouse.current.position.ReadValue();
		if (!ValidateScreenPosition(vector))
		{
			return _uiItems;
		}
		EventSystem eventSystem = MonoECS.instance.eventSystem;
		if (_mousePointerEventData == null)
		{
			_mousePointerEventData = new PointerEventData(eventSystem);
		}
		_mousePointerEventData.position = vector;
		eventSystem.RaycastAll(_mousePointerEventData, _mouseRaycastResults);
		foreach (RaycastResult mouseRaycastResult in _mouseRaycastResults)
		{
			GameObject gameObject = mouseRaycastResult.gameObject;
			if (!(gameObject == null) && !gameObject.CompareTag("IgnoreOnUIHitCheck"))
			{
				_uiItems.Add(gameObject);
			}
		}
		return _uiItems;
	}

	private bool NeedFilterMouseAction(InputAction.CallbackContext context)
	{
		if (context.control.device is UnityEngine.InputSystem.Pointer pointer)
		{
			Vector2 position = pointer.position.ReadValue();
			if ((pointer.press.isPressed || pointer.IsPressed()) && (CheckIsOutsideOfScreen(position) || CheckIsHoverOnUI(position)))
			{
				return true;
			}
		}
		return false;
	}

	public void SetActive(bool active)
	{
		bool flag = false;
		if (active && !IsActive)
		{
			flag = true;
		}
		IsActive = active;
		if (!active)
		{
			_buttonStateDict.Clear();
			ResetPlayerMoveInputDevice();
			ClearPlayerInputState(GamePlayerInput.GetCurrent());
		}
		else if (flag)
		{
			CorrectPlayerInputs();
		}
	}

	internal void CorrectPlayerInputs()
	{
		string[] needUpdateActions = NeedUpdateActions;
		foreach (string key in needUpdateActions)
		{
			if (_pathToActions.TryGetValue(key, out var value))
			{
				switch (value.expectedControlType)
				{
				case "Axis":
					UpdateActionInput<float>(value, value.ReadValue<float>(), needFilterMouseAction: false);
					break;
				case "Vector2":
				{
					Vector2 value2 = value.ReadValue<Vector2>();
					SyncPlayerMoveInputDevice(value, in value2);
					UpdateActionInput(value, in value2, needFilterMouseAction: false);
					break;
				}
				}
			}
		}
	}

	private void UpdateActionInput<T>(InputAction action, in T value, bool needFilterMouseAction) where T : struct
	{
		if (_actionToInvokes.TryGetValue(action, out var value2))
		{
			string valueOrDefault = _actionToPaths.GetValueOrDefault(action, string.Empty);
			if (IsActive && !CheckHandleInRemoveIdleList(value2.Handle) && !_skipAllActionProcess && !_actionStopPropagationMark.Contains(valueOrDefault) && !(value2.CheckMouseAction & needFilterMouseAction))
			{
				value2.Invoke(value);
			}
			_actionStopPropagationMark.Remove(valueOrDefault);
		}
	}

	private bool CheckNeedFilterByShortcutKeyRules(InputAction.CallbackContext context)
	{
		InputAction action = context.action;
		if (!_actionToPaths.TryGetValue(action, out var value))
		{
			return true;
		}
		if (TryGetCallbackCompositePartType(context, value, out var _))
		{
			return false;
		}
		InputControl control = context.control;
		if (control != null && control.IsPressed(0.001f))
		{
			return CheckCompositeBindingModifierKeyDown(action, control);
		}
		return false;
	}

	private void InvokeFloatCallback(InputAction.CallbackContext context)
	{
		if (Application.isFocused && IsActive && !_skipAllActionProcess)
		{
			float value = context.ReadValue<float>();
			bool needFilterMouseAction = NeedFilterMouseAction(context);
			InputAction action = context.action;
			UpdateActionInput(action, in value, needFilterMouseAction);
		}
	}

	private bool IsMatchActiveInputDevice(InputAction.CallbackContext context)
	{
		InputDevice device = context.control.device;
		DeviceInputMode deviceInputMode;
		if (!(device is Mouse) && !(device is Keyboard))
		{
			deviceInputMode = ((device is Gamepad) ? DeviceInputMode.Gamepad : ((device is Touchscreen) ? DeviceInputMode.TouchScreen : DeviceInputMode.Unknown));
		}
		else
		{
			deviceInputMode = DeviceInputMode.KeyboardAndMouse;
		}
		return deviceInputMode == MonoECS.instance.InputMode;
	}

	private bool IsPlayerMoveAction(InputAction action)
	{
		if (_actionToPaths.TryGetValue(action, out var value))
		{
			return value == "Player/Move";
		}
		return false;
	}

	private bool CanProcessVector2Input(InputAction.CallbackContext context, in Vector2 value)
	{
		if (!IsPlayerMoveAction(context.action))
		{
			if (IsMatchActiveInputDevice(context))
			{
				return true;
			}
			if (_focusRestoreFrame == Time.frameCount)
			{
				return value != Vector2.zero;
			}
			return false;
		}
		InputDevice inputDevice = context.control?.device;
		if (inputDevice == null)
		{
			return false;
		}
		if (value != Vector2.zero)
		{
			_playerMoveInputDevice = inputDevice;
			return true;
		}
		if (_playerMoveInputDevice != inputDevice)
		{
			return false;
		}
		_playerMoveInputDevice = null;
		return true;
	}

	private void SyncPlayerMoveInputDevice(InputAction action, in Vector2 value)
	{
		if (IsPlayerMoveAction(action))
		{
			_playerMoveInputDevice = ((!(value != Vector2.zero)) ? null : action.activeControl?.device);
		}
	}

	private void ResetPlayerMoveInputDevice()
	{
		_playerMoveInputDevice = null;
	}

	private void InvokeVector2Callback(InputAction.CallbackContext context)
	{
		if (Application.isFocused && IsActive && !_skipAllActionProcess)
		{
			Vector2 value = context.ReadValue<Vector2>();
			if (CanProcessVector2Input(context, in value))
			{
				bool needFilterMouseAction = NeedFilterMouseAction(context);
				InputAction action = context.action;
				UpdateActionInput(action, in value, needFilterMouseAction);
			}
		}
	}

	private void InvokeBoolCallback(InputAction.CallbackContext context)
	{
		InputAction action = context.action;
		if (!Application.isFocused || !IsActive || _skipAllActionProcess || CheckNeedFilterByShortcutKeyRules(context))
		{
			return;
		}
		bool needFilterMouseAction = NeedFilterMouseAction(context);
		bool value = context.ReadValue<float>() > 0.5f;
		if (_buttonStateDict.TryGetValue(action, out var value2))
		{
			if (value2 == value)
			{
				return;
			}
		}
		else if (!value)
		{
			return;
		}
		_buttonStateDict[action] = value;
		UpdateActionInput(action, in value, needFilterMouseAction);
	}

	private bool CheckHandleInRemoveIdleList(IGameInputBindingHandle handle)
	{
		if (_removeWaitList != null)
		{
			return _removeWaitList.Contains(handle);
		}
		return false;
	}

	private List<(MethodInfo, GameInputBindingAttributeBase)> GetHandleReflectActionBindingMethodList(IGameInputBindingHandle handle)
	{
		Type type = handle.GetType();
		if (!_methodCaches.TryGetValue(type, out var value))
		{
			value = new List<(MethodInfo, GameInputBindingAttributeBase)>();
			MethodInfo[] methods = type.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			foreach (MethodInfo methodInfo in methods)
			{
				object[] customAttributes = methodInfo.GetCustomAttributes(typeof(GameInputBindingAttributeBase), inherit: true);
				if (customAttributes.Length != 0 && customAttributes[0] is GameInputBindingAttributeBase gameInputBindingAttributeBase)
				{
					if (_pathToActions.TryGetValue(gameInputBindingAttributeBase.BindingAction, out var _))
					{
						value.Add((methodInfo, gameInputBindingAttributeBase));
					}
					else if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"Controller['{type}'] Method({methodInfo.Name}) Required Input Action Path:'{gameInputBindingAttributeBase.BindingAction}' not found!.");
					}
				}
			}
			_methodCaches[type] = value;
		}
		return value;
	}

	public void Bind(IGameInputBindingHandle handle)
	{
		Bind(handle, delayActive: false);
	}

	private void Bind(IGameInputBindingHandle handle, bool delayActive)
	{
		if (handle == null)
		{
			return;
		}
		if (delayActive)
		{
			_delayActiveHandles.Add(handle);
			return;
		}
		if (_registerBindingHandles.Contains(handle))
		{
			if (_removeWaitList.Contains(handle))
			{
				_removeWaitList.Remove(handle);
			}
			_registerBindingHandles.Remove(handle);
		}
		ResetPlayerInput(GamePlayerInput.GetCurrent());
		_registerBindingHandles.Add(handle);
		_activateBindingMapIsDirty = true;
	}

	private void InvokeCurrentInputValue(MethodInvokeHelper helper)
	{
		if (helper == null)
		{
			return;
		}
		InputAction action = helper.Action;
		if (!action.wantsInitialStateCheck)
		{
			return;
		}
		switch (action.expectedControlType)
		{
		case "Button":
			helper.Invoke(_buttonStateDict.GetValueOrDefault(action, defaultValue: false));
			break;
		case "Axis":
		{
			if (!_buttonStateDict.TryGetValue(action, out var value2))
			{
				value2 = action.ReadValue<float>() > 0.5f;
				_buttonStateDict[action] = value2;
			}
			helper.Invoke(value2);
			break;
		}
		case "Vector2":
		{
			Vector2 value = action.ReadValue<Vector2>();
			SyncPlayerMoveInputDevice(action, in value);
			helper.Invoke(value);
			break;
		}
		}
	}

	public void Unbind(IGameInputBindingHandle handle)
	{
		if (handle == null)
		{
			return;
		}
		if (_delayActiveHandles.Contains(handle))
		{
			_delayActiveHandles.Remove(handle);
		}
		else if (_registerBindingHandles.Contains(handle))
		{
			if (_removeWaitList == null)
			{
				_removeWaitList = new List<IGameInputBindingHandle>();
			}
			_removeWaitList.Add(handle);
		}
	}

	private void RemoveUnusedMethodInvokeHandles()
	{
		if (_removeWaitList == null || _removeWaitList.Count == 0)
		{
			return;
		}
		foreach (IGameInputBindingHandle removeWait in _removeWaitList)
		{
			_registerBindingHandles.Remove(removeWait);
		}
		_removeWaitList.Clear();
		_activateBindingMapIsDirty = true;
	}

	public ILongPressInputHandle GetLongPressInputHandle(string actionPath, Action callback, float requiredPressTime = 0f, int repeatTimes = 1, float repeatTimeInterval = 0.5f, Action<float> onUpdate = null, Action onRelease = null)
	{
		LongPressInputHandle longPressInputHandle = new LongPressInputHandle();
		if (!_pathToActions.TryGetValue(actionPath, out var _))
		{
			return longPressInputHandle;
		}
		if (_activeLongPressInputHandles == null)
		{
			_activeLongPressInputHandles = new List<LongPressInputHandle>();
		}
		if (requiredPressTime <= 0f)
		{
			requiredPressTime = 2f;
		}
		longPressInputHandle.Reset(actionPath, callback, requiredPressTime, repeatTimes, repeatTimeInterval, onUpdate, onRelease);
		_activeLongPressInputHandles.Add(longPressInputHandle);
		return longPressInputHandle;
	}

	private void TickLongPressHandles(float deltaTime)
	{
		if (float.IsNaN(deltaTime) || _activeLongPressInputHandles == null)
		{
			return;
		}
		foreach (LongPressInputHandle activeLongPressInputHandle in _activeLongPressInputHandles)
		{
			activeLongPressInputHandle.Tick(deltaTime);
			if (activeLongPressInputHandle.TimeIsReach())
			{
				_needNotifiedLongPressHandles.Add(activeLongPressInputHandle);
				activeLongPressInputHandle.CountDown();
				if (!activeLongPressInputHandle.CanRepeat())
				{
					_needRemoveLongPressHandles.Add(activeLongPressInputHandle);
				}
			}
			if (!_pathToActions[activeLongPressInputHandle.ActionPath].IsPressed())
			{
				_needRemoveLongPressHandles.Add(activeLongPressInputHandle);
			}
		}
		foreach (LongPressInputHandle needNotifiedLongPressHandle in _needNotifiedLongPressHandles)
		{
			needNotifiedLongPressHandle.NotifyReach();
		}
		foreach (LongPressInputHandle needRemoveLongPressHandle in _needRemoveLongPressHandles)
		{
			needRemoveLongPressHandle.Clear();
			_activeLongPressInputHandles.Remove(needRemoveLongPressHandle);
		}
		_needNotifiedLongPressHandles.Clear();
		_needRemoveLongPressHandles.Clear();
	}

	public void Update(float deltaTime)
	{
		ActiveDelayBindHandles();
		TickLongPressHandles(deltaTime);
	}

	public void LateUpdate()
	{
		_skipAllActionProcess = false;
		_cursorManager.Update();
		_actionStopPropagationMark.Clear();
		ClearUnusedDisableMap();
		RemoveUnusedMethodInvokeHandles();
		RefreshDirtyActionBindingMap();
	}

	private void ClearUnusedDisableMap()
	{
		if (_clearCache == null)
		{
			_clearCache = new List<IGameInputBindingHandle>();
		}
		_clearCache.Clear();
		foreach (KeyValuePair<IGameInputBindingHandle, HashSet<string>> item in _handleActionBlacklistMap)
		{
			if (item.Key.IsDisposed)
			{
				_clearCache.Add(item.Key);
			}
		}
		foreach (IGameInputBindingHandle item2 in _clearCache)
		{
			if (_handleActionBlacklistMap.Remove(item2, out var value))
			{
				value.Clear();
				HashSetPool<string>.Release(value);
			}
		}
		_clearCache.Clear();
	}

	private void RefreshDirtyActionBindingMap()
	{
		if (!_activateBindingMapIsDirty)
		{
			return;
		}
		_activateBindingMapIsDirty = false;
		if (_migrateBindingsCache == null)
		{
			_migrateBindingsCache = new Dictionary<string, ActionBindingInfo>();
		}
		if (_disabledHandles == null)
		{
			_disabledHandles = new List<IGameInputBindingHandle>();
		}
		if (_enabledHandles == null)
		{
			_enabledHandles = new List<IGameInputBindingHandle>();
		}
		_disabledHandles.Clear();
		_enabledHandles.Clear();
		_migrateBindingsCache.Clear();
		bool flag = false;
		for (int num = _registerBindingHandles.Count - 1; num >= 0; num--)
		{
			IGameInputBindingHandle gameInputBindingHandle = _registerBindingHandles[num];
			if (flag)
			{
				_disabledHandles.Add(gameInputBindingHandle);
			}
			else
			{
				_enabledHandles.Add(gameInputBindingHandle);
				MigrateBindingActions(gameInputBindingHandle, _migrateBindingsCache);
				flag = gameInputBindingHandle.BlockElderHandle;
			}
		}
		_actionToInvokes.Clear();
		_activeHandles.Clear();
		HashSet<InputAction> hashSet = new HashSet<InputAction>();
		foreach (KeyValuePair<string, ActionBindingInfo> item in _migrateBindingsCache)
		{
			ActionBindingInfo value = item.Value;
			MethodInfo method = value.Method;
			GameInputBindingAttributeBase attribute = value.Attribute;
			IGameInputBindingHandle handle = value.Handle;
			if (_pathToActions.TryGetValue(attribute.BindingAction, out var value2))
			{
				_activeHandles.Add(handle);
				MethodInvokeHelper methodInvokeHelper = new MethodInvokeHelper(value2, handle, method, attribute.BindingAction, attribute.ParameterType, attribute.NeedCheckMouseAction);
				_actionToInvokes[value2] = methodInvokeHelper;
				InvokeCurrentInputValue(methodInvokeHelper);
				hashSet.Add(value2);
			}
		}
		foreach (IGameInputBindingHandle disabledHandle in _disabledHandles)
		{
			disabledHandle.Disable();
		}
		foreach (IGameInputBindingHandle enabledHandle in _enabledHandles)
		{
			enabledHandle.Enable();
		}
		foreach (IGameInputBindingHandle registerBindingHandle in _registerBindingHandles)
		{
			registerBindingHandle.RefreshPromptIcons();
		}
		MonoECS.instance.UpdateActiveInputActions(hashSet);
		_buttonStateDict.Clear();
		_disabledHandles.Clear();
		_enabledHandles.Clear();
		_migrateBindingsCache.Clear();
	}

	private void MigrateBindingActions(IGameInputBindingHandle handle, Dictionary<string, ActionBindingInfo> migrateMap)
	{
		List<(MethodInfo, GameInputBindingAttributeBase)> handleReflectActionBindingMethodList = GetHandleReflectActionBindingMethodList(handle);
		if (handleReflectActionBindingMethodList.Count == 0)
		{
			return;
		}
		foreach (var (method, gameInputBindingAttributeBase) in handleReflectActionBindingMethodList)
		{
			if (!migrateMap.ContainsKey(gameInputBindingAttributeBase.BindingAction) && !GetActionDisabled(handle, gameInputBindingAttributeBase.BindingAction))
			{
				migrateMap[gameInputBindingAttributeBase.BindingAction] = new ActionBindingInfo
				{
					Handle = handle,
					Attribute = gameInputBindingAttributeBase,
					Method = method
				};
			}
		}
	}

	private void ActiveDelayBindHandles()
	{
		if (_delayActiveHandles.Count == 0)
		{
			return;
		}
		foreach (IGameInputBindingHandle delayActiveHandle in _delayActiveHandles)
		{
			Bind(delayActiveHandle);
		}
		_delayActiveHandles.Clear();
	}

	private void ResetPlayerInput(GamePlayerInput playerInput)
	{
		ResetPlayerMoveInputDevice();
		playerInput.ResetAll(_currentEntity);
	}

	private void ClearPlayerInputState(GamePlayerInput playerInput)
	{
		playerInput.ClearEntityState(_currentEntity);
	}

	public void FixedUpdatePlayerInput(Entity entity)
	{
		if (entity.IsValid)
		{
			GamePlayerInput current = GamePlayerInput.GetCurrent();
			if (!_currentEntity.IsValid || _currentEntity != entity)
			{
				ClearPlayerInputState(current);
				_currentEntity = entity;
			}
			current.FixedUpdate(_currentEntity);
		}
	}

	public bool CheckActionIsPressed(string actionPath)
	{
		if (_pathToActions.TryGetValue(actionPath, out var value))
		{
			return value.IsPressed();
		}
		return false;
	}

	public bool GetActionDisabled(IGameInputBindingHandle handle, string actionPath)
	{
		if (GetActionDisabled(actionPath))
		{
			return true;
		}
		if (_handleActionBlacklistMap.TryGetValue(handle, out var value) && value.Contains(actionPath))
		{
			return true;
		}
		if (!TryGetWhiteList(handle, out var target))
		{
			return false;
		}
		return !target.Contains(actionPath);
	}

	private bool TryGetWhiteList(IGameInputBindingHandle handle, out HashSet<string> target)
	{
		target = null;
		if (!(handle is IInputController { ActionWhiteList: var actionWhiteList } inputController))
		{
			return false;
		}
		if (actionWhiteList != null)
		{
			target = actionWhiteList;
			return true;
		}
		IBaseUIController parentUIController = inputController.ParentUIController;
		if (parentUIController != null)
		{
			IBaseUIView uIView = parentUIController.GetUIView();
			if (uIView != null)
			{
				return TryGetWhiteList(uIView.InputController, out target);
			}
		}
		return false;
	}

	public void SetActionWhiteListModeEnable(IGameInputBindingHandle handle, bool enable)
	{
		if (enable)
		{
			if (handle.ActionWhiteList != null)
			{
				return;
			}
			handle.ActionWhiteList = HashSetPool<string>.Get();
		}
		else
		{
			if (handle.ActionWhiteList == null)
			{
				return;
			}
			HashSet<string> actionWhiteList = handle.ActionWhiteList;
			actionWhiteList.Clear();
			HashSetPool<string>.Release(actionWhiteList);
			handle.ActionWhiteList = null;
		}
		_activateBindingMapIsDirty = true;
	}

	public void SetActionWhiteList(IGameInputBindingHandle handle, string actionPath, bool enable)
	{
		HashSet<string> actionWhiteList = handle.ActionWhiteList;
		if (actionWhiteList != null)
		{
			bool flag = false;
			flag = ((!enable) ? actionWhiteList.Remove(actionPath) : actionWhiteList.Add(actionPath));
			_activateBindingMapIsDirty = flag;
		}
	}

	public void SetActionBlacklist(IGameInputBindingHandle handle, string actionPath, bool value)
	{
		if (handle != null)
		{
			if (!_handleActionBlacklistMap.TryGetValue(handle, out var value2))
			{
				HashSet<string> hashSet = (_handleActionBlacklistMap[handle] = HashSetPool<string>.Get());
				value2 = hashSet;
			}
			if (value)
			{
				value2.Add(actionPath);
			}
			else
			{
				value2.Remove(actionPath);
			}
			_activateBindingMapIsDirty = true;
		}
	}

	public bool GetActionDisabled(string actionPath)
	{
		return _actionDisabledDict.GetValueOrDefault(actionPath, defaultValue: false);
	}

	public void SetActionDisabled(string actionPath, bool value, bool boardcast = true)
	{
		if (!_pathToActions.TryGetValue(actionPath, out var _))
		{
			return;
		}
		_actionDisabledDict[actionPath] = value;
		_activateBindingMapIsDirty = true;
		if (boardcast)
		{
			if (_actionPathToCustomUICompType.TryGetValue(actionPath, out var value3))
			{
				DispatchUpdateOperateBtnEvt(value3, !value);
			}
			OnActionDisabledChanged?.Invoke(actionPath, value);
		}
		if (value)
		{
			GamePlayerInput.GetCurrent().ResetInputAction(actionPath);
			if (actionPath == "Player/Move")
			{
				ResetPlayerMoveInputDevice();
			}
		}
	}

	public void SetInputActive(MotionInputKey key, bool value)
	{
		if (_motionInputKeyToActionPath.TryGetValue(key, out var value2))
		{
			SetActionDisabled(value2, !value);
		}
	}

	public void SetInputActive(InputKey key, bool value)
	{
		if (_inputKeyToActionPath.TryGetValue(key, out var value2))
		{
			SetActionDisabled(value2, !value);
		}
	}

	private void DispatchUpdateOperateBtnEvt(CustomUICompType customUICompType, bool active)
	{
		UpdateOperateBtnActiveEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateOperateBtnActiveEvt>();
		evt.customUICompType = customUICompType;
		evt.active = active;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtn_UpdateBtnActive, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public bool GetHandleCallbackIsActive(IGameInputBindingHandle handle, in string actionPath)
	{
		if (_pathToActions.TryGetValue(actionPath, out var value) && _actionToInvokes.TryGetValue(value, out var value2))
		{
			return value2.Handle == handle;
		}
		return false;
	}

	public bool StopActionPropagation(string actionPath)
	{
		if (_pathToActions.ContainsKey(actionPath))
		{
			return _actionStopPropagationMark.Add(actionPath);
		}
		return false;
	}

	public void CancelAllActionProcessAtThisFrame()
	{
		_skipAllActionProcess = true;
	}

	public void InitCursor(bool ispc, bool hideCursor, MouseCursorEffectSetting cursorEffectSetting, PlayerInput playerInput)
	{
		_cursorManager.Init(ispc, hideCursor, cursorEffectSetting, playerInput);
	}

	public bool CheckHandleIsActive(IGameInputBindingHandle bindingHandle)
	{
		return _activeHandles.Contains(bindingHandle);
	}
}
