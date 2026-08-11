using System;
using System.Collections.Generic;
using UnityEngine.Events;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.UI;
using UnityEngine.InputSystem.Users;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/PlayerInput.html")]
[DisallowMultipleComponent]
[AddComponentMenu("Input/Player Input")]
public class PlayerInput : MonoBehaviour
{
	[Serializable]
	public class ActionEvent : UnityEvent<InputAction.CallbackContext>
	{
		[SerializeField]
		private string m_ActionId;

		[SerializeField]
		private string m_ActionName;

		public string actionId => m_ActionId;

		public string actionName => m_ActionName;

		public ActionEvent()
		{
		}

		public ActionEvent(InputAction action)
		{
			if (action == null)
			{
				throw new ArgumentNullException("action");
			}
			if (action.isSingletonAction)
			{
				throw new ArgumentException($"Action must be part of an asset (given action '{action}' is a singleton)");
			}
			if (action.actionMap.asset == null)
			{
				throw new ArgumentException($"Action must be part of an asset (given action '{action}' is not)");
			}
			m_ActionId = action.id.ToString();
			m_ActionName = action.actionMap.name + "/" + action.name;
		}

		public ActionEvent(Guid actionGUID, string name = null)
		{
			m_ActionId = actionGUID.ToString();
			m_ActionName = name;
		}
	}

	[Serializable]
	public class DeviceLostEvent : UnityEvent<PlayerInput>
	{
	}

	[Serializable]
	public class DeviceRegainedEvent : UnityEvent<PlayerInput>
	{
	}

	[Serializable]
	public class ControlsChangedEvent : UnityEvent<PlayerInput>
	{
	}

	public const string DeviceLostMessage = "OnDeviceLost";

	public const string DeviceRegainedMessage = "OnDeviceRegained";

	public const string ControlsChangedMessage = "OnControlsChanged";

	[SerializeField]
	[Tooltip("Input actions associated with the player.")]
	internal InputActionAsset m_Actions;

	[SerializeField]
	[Tooltip("Determine how notifications should be sent when an input-related event associated with the player happens.")]
	internal PlayerNotifications m_NotificationBehavior;

	[SerializeField]
	[Tooltip("UI InputModule that should have it's input actions synchronized to this PlayerInput's actions.")]
	internal InputSystemUIInputModule m_UIInputModule;

	[Tooltip("Event that is triggered when the PlayerInput loses a paired device (e.g. its battery runs out).")]
	[SerializeField]
	internal DeviceLostEvent m_DeviceLostEvent;

	[SerializeField]
	internal DeviceRegainedEvent m_DeviceRegainedEvent;

	[SerializeField]
	internal ControlsChangedEvent m_ControlsChangedEvent;

	[SerializeField]
	internal ActionEvent[] m_ActionEvents;

	[SerializeField]
	internal bool m_NeverAutoSwitchControlSchemes;

	[SerializeField]
	internal string m_DefaultControlScheme;

	[SerializeField]
	internal string m_DefaultActionMap;

	[SerializeField]
	internal int m_SplitScreenIndex = -1;

	[SerializeField]
	[Tooltip("Reference to the player's view camera. Note that this is only required when using split-screen and/or per-player UIs. Otherwise it is safe to leave this property uninitialized.")]
	internal Camera m_Camera;

	[NonSerialized]
	private InputValue m_InputValueObject;

	[NonSerialized]
	internal InputActionMap m_CurrentActionMap;

	[NonSerialized]
	private int m_PlayerIndex = -1;

	[NonSerialized]
	private bool m_InputActive;

	[NonSerialized]
	private bool m_Enabled;

	[NonSerialized]
	internal bool m_ActionsInitialized;

	[NonSerialized]
	private Dictionary<string, string> m_ActionMessageNames;

	[NonSerialized]
	private InputUser m_InputUser;

	[NonSerialized]
	private Action<InputAction.CallbackContext> m_ActionTriggeredDelegate;

	[NonSerialized]
	private CallbackArray<Action<PlayerInput>> m_DeviceLostCallbacks;

	[NonSerialized]
	private CallbackArray<Action<PlayerInput>> m_DeviceRegainedCallbacks;

	[NonSerialized]
	private CallbackArray<Action<PlayerInput>> m_ControlsChangedCallbacks;

	[NonSerialized]
	private CallbackArray<Action<InputAction.CallbackContext>> m_ActionTriggeredCallbacks;

	[NonSerialized]
	private Action<InputControl, InputEventPtr> m_UnpairedDeviceUsedDelegate;

	[NonSerialized]
	private Func<InputDevice, InputEventPtr, bool> m_PreFilterUnpairedDeviceUsedDelegate;

	[NonSerialized]
	private bool m_OnUnpairedDeviceUsedHooked;

	[NonSerialized]
	private Action<InputDevice, InputDeviceChange> m_DeviceChangeDelegate;

	[NonSerialized]
	private bool m_OnDeviceChangeHooked;

	internal static int s_AllActivePlayersCount;

	internal static PlayerInput[] s_AllActivePlayers;

	private static Action<InputUser, InputUserChange, InputDevice> s_UserChangeDelegate;

	private static int s_InitPairWithDevicesCount;

	private static InputDevice[] s_InitPairWithDevices;

	private static int s_InitPlayerIndex = -1;

	private static int s_InitSplitScreenIndex = -1;

	private static string s_InitControlScheme;

	internal static bool s_DestroyIfDeviceSetupUnsuccessful;

	public bool inputIsActive => m_InputActive;

	[Obsolete("Use inputIsActive instead.")]
	public bool active => inputIsActive;

	public int playerIndex => m_PlayerIndex;

	public int splitScreenIndex => m_SplitScreenIndex;

	public InputActionAsset actions
	{
		get
		{
			if (!m_ActionsInitialized && base.gameObject.activeInHierarchy)
			{
				InitializeActions();
			}
			return m_Actions;
		}
		set
		{
			if (m_Actions == value)
			{
				return;
			}
			if (m_Actions != null)
			{
				m_Actions.Disable();
				if (m_ActionsInitialized)
				{
					UninitializeActions();
				}
			}
			m_Actions = value;
			if (m_Enabled)
			{
				ClearCaches();
				AssignUserAndDevices();
				InitializeActions();
				if (m_InputActive)
				{
					ActivateInput();
				}
			}
		}
	}

	public string currentControlScheme
	{
		get
		{
			if (!m_InputUser.valid)
			{
				return null;
			}
			return m_InputUser.controlScheme?.name;
		}
	}

	public string defaultControlScheme
	{
		get
		{
			return m_DefaultControlScheme;
		}
		set
		{
			m_DefaultControlScheme = value;
		}
	}

	public bool neverAutoSwitchControlSchemes
	{
		get
		{
			return m_NeverAutoSwitchControlSchemes;
		}
		set
		{
			if (m_NeverAutoSwitchControlSchemes == value)
			{
				return;
			}
			m_NeverAutoSwitchControlSchemes = value;
			if (m_Enabled)
			{
				if (!value && !m_OnUnpairedDeviceUsedHooked)
				{
					StartListeningForUnpairedDeviceActivity();
				}
				else if (value && m_OnUnpairedDeviceUsedHooked)
				{
					StopListeningForUnpairedDeviceActivity();
				}
			}
		}
	}

	public InputActionMap currentActionMap
	{
		get
		{
			return m_CurrentActionMap;
		}
		set
		{
			InputActionMap inputActionMap = m_CurrentActionMap;
			m_CurrentActionMap = null;
			inputActionMap?.Disable();
			m_CurrentActionMap = value;
			m_CurrentActionMap?.Enable();
		}
	}

	public string defaultActionMap
	{
		get
		{
			return m_DefaultActionMap;
		}
		set
		{
			m_DefaultActionMap = value;
		}
	}

	public PlayerNotifications notificationBehavior
	{
		get
		{
			return m_NotificationBehavior;
		}
		set
		{
			if (m_NotificationBehavior != value)
			{
				if (m_Enabled)
				{
					UninitializeActions();
				}
				m_NotificationBehavior = value;
				if (m_Enabled)
				{
					InitializeActions();
				}
			}
		}
	}

	public ReadOnlyArray<ActionEvent> actionEvents
	{
		get
		{
			return m_ActionEvents;
		}
		set
		{
			if (m_Enabled)
			{
				UninitializeActions();
			}
			m_ActionEvents = value.ToArray();
			if (m_Enabled)
			{
				InitializeActions();
			}
		}
	}

	public DeviceLostEvent deviceLostEvent
	{
		get
		{
			if (m_DeviceLostEvent == null)
			{
				m_DeviceLostEvent = new DeviceLostEvent();
			}
			return m_DeviceLostEvent;
		}
	}

	public DeviceRegainedEvent deviceRegainedEvent
	{
		get
		{
			if (m_DeviceRegainedEvent == null)
			{
				m_DeviceRegainedEvent = new DeviceRegainedEvent();
			}
			return m_DeviceRegainedEvent;
		}
	}

	public ControlsChangedEvent controlsChangedEvent
	{
		get
		{
			if (m_ControlsChangedEvent == null)
			{
				m_ControlsChangedEvent = new ControlsChangedEvent();
			}
			return m_ControlsChangedEvent;
		}
	}

	public Camera camera
	{
		get
		{
			return m_Camera;
		}
		set
		{
			m_Camera = value;
		}
	}

	public InputSystemUIInputModule uiInputModule
	{
		get
		{
			return m_UIInputModule;
		}
		set
		{
			if (!(m_UIInputModule == value))
			{
				if (m_UIInputModule != null && m_UIInputModule.actionsAsset == m_Actions)
				{
					m_UIInputModule.actionsAsset = null;
				}
				m_UIInputModule = value;
				if (m_UIInputModule != null && m_Actions != null)
				{
					m_UIInputModule.actionsAsset = m_Actions;
				}
			}
		}
	}

	public InputUser user => m_InputUser;

	public ReadOnlyArray<InputDevice> devices
	{
		get
		{
			if (!m_InputUser.valid)
			{
				return default(ReadOnlyArray<InputDevice>);
			}
			return m_InputUser.pairedDevices;
		}
	}

	public bool hasMissingRequiredDevices
	{
		get
		{
			if (user.valid)
			{
				return user.hasMissingRequiredDevices;
			}
			return false;
		}
	}

	public static ReadOnlyArray<PlayerInput> all => new ReadOnlyArray<PlayerInput>(s_AllActivePlayers, 0, s_AllActivePlayersCount);

	public static bool isSinglePlayer
	{
		get
		{
			if (s_AllActivePlayersCount <= 1)
			{
				if (!(PlayerInputManager.instance == null))
				{
					return !PlayerInputManager.instance.joiningEnabled;
				}
				return true;
			}
			return false;
		}
	}

	public event Action<InputAction.CallbackContext> onActionTriggered
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_ActionTriggeredCallbacks.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_ActionTriggeredCallbacks.RemoveCallback(value);
		}
	}

	public event Action<PlayerInput> onDeviceLost
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_DeviceLostCallbacks.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_DeviceLostCallbacks.RemoveCallback(value);
		}
	}

	public event Action<PlayerInput> onDeviceRegained
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_DeviceRegainedCallbacks.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_DeviceRegainedCallbacks.RemoveCallback(value);
		}
	}

	public event Action<PlayerInput> onControlsChanged
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_ControlsChangedCallbacks.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			m_ControlsChangedCallbacks.RemoveCallback(value);
		}
	}

	public TDevice GetDevice<TDevice>() where TDevice : InputDevice
	{
		foreach (InputDevice device in devices)
		{
			if (device is TDevice result)
			{
				return result;
			}
		}
		return null;
	}

	public void ActivateInput()
	{
		m_InputActive = true;
		if (m_CurrentActionMap == null && m_Actions != null && !string.IsNullOrEmpty(m_DefaultActionMap))
		{
			SwitchCurrentActionMap(m_DefaultActionMap);
		}
		else
		{
			m_CurrentActionMap?.Enable();
		}
	}

	public void DeactivateInput()
	{
		m_CurrentActionMap?.Disable();
		m_InputActive = false;
	}

	[Obsolete("Use DeactivateInput instead.")]
	public void PassivateInput()
	{
		DeactivateInput();
	}

	public bool SwitchCurrentControlScheme(params InputDevice[] devices)
	{
		if (devices == null)
		{
			throw new ArgumentNullException("devices");
		}
		if (actions == null)
		{
			throw new InvalidOperationException("Must set actions on PlayerInput in order to be able to switch control schemes");
		}
		InputControlScheme? inputControlScheme = InputControlScheme.FindControlSchemeForDevices(devices, actions.controlSchemes);
		if (!inputControlScheme.HasValue)
		{
			return false;
		}
		InputControlScheme controlScheme = inputControlScheme.Value;
		SwitchControlSchemeInternal(ref controlScheme, devices);
		return true;
	}

	public void SwitchCurrentControlScheme(string controlScheme, params InputDevice[] devices)
	{
		if (string.IsNullOrEmpty(controlScheme))
		{
			throw new ArgumentNullException("controlScheme");
		}
		if (devices == null)
		{
			throw new ArgumentNullException("devices");
		}
		user.FindControlScheme(controlScheme, out var scheme);
		SwitchControlSchemeInternal(ref scheme, devices);
	}

	public void SwitchCurrentActionMap(string mapNameOrId)
	{
		if (!m_Enabled)
		{
			Debug.LogError("Cannot switch to actions '" + mapNameOrId + "'; input is not enabled", this);
			return;
		}
		if (m_Actions == null)
		{
			Debug.LogError("Cannot switch to actions '" + mapNameOrId + "'; no actions set on PlayerInput", this);
			return;
		}
		InputActionMap inputActionMap = m_Actions.FindActionMap(mapNameOrId);
		if (inputActionMap == null)
		{
			Debug.LogError($"Cannot find action map '{mapNameOrId}' in actions '{m_Actions}'", this);
		}
		else
		{
			currentActionMap = inputActionMap;
		}
	}

	public static PlayerInput GetPlayerByIndex(int playerIndex)
	{
		for (int i = 0; i < s_AllActivePlayersCount; i++)
		{
			if (s_AllActivePlayers[i].playerIndex == playerIndex)
			{
				return s_AllActivePlayers[i];
			}
		}
		return null;
	}

	public static PlayerInput FindFirstPairedToDevice(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		for (int i = 0; i < s_AllActivePlayersCount; i++)
		{
			if (s_AllActivePlayers[i].devices.ContainsReference(device))
			{
				return s_AllActivePlayers[i];
			}
		}
		return null;
	}

	public static PlayerInput Instantiate(GameObject prefab, int playerIndex = -1, string controlScheme = null, int splitScreenIndex = -1, InputDevice pairWithDevice = null)
	{
		if (prefab == null)
		{
			throw new ArgumentNullException("prefab");
		}
		s_InitPlayerIndex = playerIndex;
		s_InitSplitScreenIndex = splitScreenIndex;
		s_InitControlScheme = controlScheme;
		if (pairWithDevice != null)
		{
			ArrayHelpers.AppendWithCapacity(ref s_InitPairWithDevices, ref s_InitPairWithDevicesCount, pairWithDevice);
		}
		return DoInstantiate(prefab);
	}

	public static PlayerInput Instantiate(GameObject prefab, int playerIndex = -1, string controlScheme = null, int splitScreenIndex = -1, params InputDevice[] pairWithDevices)
	{
		if (prefab == null)
		{
			throw new ArgumentNullException("prefab");
		}
		s_InitPlayerIndex = playerIndex;
		s_InitSplitScreenIndex = splitScreenIndex;
		s_InitControlScheme = controlScheme;
		if (pairWithDevices != null)
		{
			for (int i = 0; i < pairWithDevices.Length; i++)
			{
				ArrayHelpers.AppendWithCapacity(ref s_InitPairWithDevices, ref s_InitPairWithDevicesCount, pairWithDevices[i]);
			}
		}
		return DoInstantiate(prefab);
	}

	private static PlayerInput DoInstantiate(GameObject prefab)
	{
		bool flag = s_DestroyIfDeviceSetupUnsuccessful;
		GameObject gameObject;
		try
		{
			gameObject = Object.Instantiate(prefab);
			gameObject.SetActive(value: true);
		}
		finally
		{
			s_InitPairWithDevicesCount = 0;
			if (s_InitPairWithDevices != null)
			{
				Array.Clear(s_InitPairWithDevices, 0, s_InitPairWithDevicesCount);
			}
			s_InitControlScheme = null;
			s_InitPlayerIndex = -1;
			s_InitSplitScreenIndex = -1;
			s_DestroyIfDeviceSetupUnsuccessful = false;
		}
		PlayerInput componentInChildren = gameObject.GetComponentInChildren<PlayerInput>();
		if (componentInChildren == null)
		{
			Object.DestroyImmediate(gameObject);
			Debug.LogError("The GameObject does not have a PlayerInput component", prefab);
			return null;
		}
		if (flag && (!componentInChildren.user.valid || componentInChildren.hasMissingRequiredDevices))
		{
			Object.DestroyImmediate(gameObject);
			return null;
		}
		return componentInChildren;
	}

	private void InitializeActions()
	{
		if (m_ActionsInitialized || m_Actions == null)
		{
			return;
		}
		for (int i = 0; i < s_AllActivePlayersCount; i++)
		{
			if (!(s_AllActivePlayers[i].m_Actions == m_Actions) || !(s_AllActivePlayers[i] != this))
			{
				continue;
			}
			InputActionAsset inputActionAsset = m_Actions;
			m_Actions = Object.Instantiate(m_Actions);
			for (int j = 0; j < inputActionAsset.actionMaps.Count; j++)
			{
				for (int k = 0; k < inputActionAsset.actionMaps[j].bindings.Count; k++)
				{
					m_Actions.actionMaps[j].ApplyBindingOverride(k, inputActionAsset.actionMaps[j].bindings[k]);
				}
			}
			break;
		}
		if (uiInputModule != null)
		{
			uiInputModule.actionsAsset = m_Actions;
		}
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.SendMessages:
		case PlayerNotifications.BroadcastMessages:
			InstallOnActionTriggeredHook();
			if (m_ActionMessageNames == null)
			{
				CacheMessageNames();
			}
			break;
		case PlayerNotifications.InvokeCSharpEvents:
			InstallOnActionTriggeredHook();
			break;
		case PlayerNotifications.InvokeUnityEvents:
		{
			if (m_ActionEvents == null)
			{
				break;
			}
			ActionEvent[] array = m_ActionEvents;
			foreach (ActionEvent actionEvent in array)
			{
				string actionId = actionEvent.actionId;
				if (!string.IsNullOrEmpty(actionId))
				{
					InputAction inputAction = m_Actions.FindAction(actionId);
					if (inputAction != null)
					{
						inputAction.performed += actionEvent.Invoke;
						inputAction.canceled += actionEvent.Invoke;
						inputAction.started += actionEvent.Invoke;
					}
				}
			}
			break;
		}
		}
		m_ActionsInitialized = true;
	}

	private void UninitializeActions()
	{
		if (!m_ActionsInitialized || m_Actions == null)
		{
			return;
		}
		UninstallOnActionTriggeredHook();
		if (m_NotificationBehavior == PlayerNotifications.InvokeUnityEvents && m_ActionEvents != null)
		{
			ActionEvent[] array = m_ActionEvents;
			foreach (ActionEvent actionEvent in array)
			{
				string actionId = actionEvent.actionId;
				if (!string.IsNullOrEmpty(actionId))
				{
					InputAction inputAction = m_Actions.FindAction(actionId);
					if (inputAction != null)
					{
						inputAction.performed -= actionEvent.Invoke;
						inputAction.canceled -= actionEvent.Invoke;
						inputAction.started -= actionEvent.Invoke;
					}
				}
			}
		}
		m_CurrentActionMap = null;
		m_ActionsInitialized = false;
	}

	private void InstallOnActionTriggeredHook()
	{
		if (m_ActionTriggeredDelegate == null)
		{
			m_ActionTriggeredDelegate = OnActionTriggered;
		}
		foreach (InputActionMap actionMap in m_Actions.actionMaps)
		{
			actionMap.actionTriggered += m_ActionTriggeredDelegate;
		}
	}

	private void UninstallOnActionTriggeredHook()
	{
		if (m_ActionTriggeredDelegate == null)
		{
			return;
		}
		foreach (InputActionMap actionMap in m_Actions.actionMaps)
		{
			actionMap.actionTriggered -= m_ActionTriggeredDelegate;
		}
	}

	private void OnActionTriggered(InputAction.CallbackContext context)
	{
		if (!m_InputActive)
		{
			return;
		}
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.InvokeCSharpEvents:
			DelegateHelpers.InvokeCallbacksSafe(ref m_ActionTriggeredCallbacks, context, "PlayerInput.onActionTriggered");
			break;
		case PlayerNotifications.SendMessages:
		case PlayerNotifications.BroadcastMessages:
		{
			InputAction action = context.action;
			if (context.performed || (context.canceled && action.type == InputActionType.Value))
			{
				if (m_ActionMessageNames == null)
				{
					CacheMessageNames();
				}
				string methodName = m_ActionMessageNames[action.m_Id];
				if (m_InputValueObject == null)
				{
					m_InputValueObject = new InputValue();
				}
				m_InputValueObject.m_Context = context;
				if (m_NotificationBehavior == PlayerNotifications.BroadcastMessages)
				{
					BroadcastMessage(methodName, m_InputValueObject, SendMessageOptions.DontRequireReceiver);
				}
				else
				{
					SendMessage(methodName, m_InputValueObject, SendMessageOptions.DontRequireReceiver);
				}
				m_InputValueObject.m_Context = null;
			}
			break;
		}
		}
	}

	private void CacheMessageNames()
	{
		if (m_Actions == null)
		{
			return;
		}
		if (m_ActionMessageNames != null)
		{
			m_ActionMessageNames.Clear();
		}
		else
		{
			m_ActionMessageNames = new Dictionary<string, string>();
		}
		foreach (InputAction action in m_Actions)
		{
			action.MakeSureIdIsInPlace();
			string text = CSharpCodeHelpers.MakeTypeName(action.name);
			m_ActionMessageNames[action.m_Id] = "On" + text;
		}
	}

	private void ClearCaches()
	{
	}

	private void AssignUserAndDevices()
	{
		if (m_InputUser.valid)
		{
			m_InputUser.UnpairDevices();
		}
		if (m_Actions == null)
		{
			if (s_InitPairWithDevicesCount > 0)
			{
				for (int i = 0; i < s_InitPairWithDevicesCount; i++)
				{
					m_InputUser = InputUser.PerformPairingWithDevice(s_InitPairWithDevices[i], m_InputUser);
				}
			}
			else
			{
				m_InputUser = default(InputUser);
			}
			return;
		}
		if (m_Actions.controlSchemes.Count > 0)
		{
			if (!string.IsNullOrEmpty(s_InitControlScheme))
			{
				InputControlScheme? inputControlScheme = m_Actions.FindControlScheme(s_InitControlScheme);
				if (!inputControlScheme.HasValue)
				{
					Debug.LogError($"No control scheme '{s_InitControlScheme}' in '{m_Actions}'", this);
				}
				else
				{
					TryToActivateControlScheme(inputControlScheme.Value);
				}
			}
			else if (!string.IsNullOrEmpty(m_DefaultControlScheme))
			{
				InputControlScheme? inputControlScheme2 = m_Actions.FindControlScheme(m_DefaultControlScheme);
				if (!inputControlScheme2.HasValue)
				{
					Debug.LogError($"Cannot find default control scheme '{m_DefaultControlScheme}' in '{m_Actions}'", this);
				}
				else
				{
					TryToActivateControlScheme(inputControlScheme2.Value);
				}
			}
			if (s_InitPairWithDevicesCount > 0 && (!m_InputUser.valid || !m_InputUser.controlScheme.HasValue))
			{
				InputControlScheme? inputControlScheme3 = InputControlScheme.FindControlSchemeForDevices(new ReadOnlyArray<InputDevice>(s_InitPairWithDevices, 0, s_InitPairWithDevicesCount), m_Actions.controlSchemes, null, allowUnsuccesfulMatch: true);
				if (inputControlScheme3.HasValue)
				{
					TryToActivateControlScheme(inputControlScheme3.Value);
				}
			}
			else if ((!m_InputUser.valid || !m_InputUser.controlScheme.HasValue) && string.IsNullOrEmpty(s_InitControlScheme))
			{
				using InputControlList<InputDevice> inputControlList = InputUser.GetUnpairedInputDevices();
				InputControlScheme? inputControlScheme4 = InputControlScheme.FindControlSchemeForDevices(inputControlList, m_Actions.controlSchemes);
				if (inputControlScheme4.HasValue)
				{
					TryToActivateControlScheme(inputControlScheme4.Value);
				}
			}
		}
		else if (s_InitPairWithDevicesCount > 0)
		{
			for (int j = 0; j < s_InitPairWithDevicesCount; j++)
			{
				m_InputUser = InputUser.PerformPairingWithDevice(s_InitPairWithDevices[j], m_InputUser);
			}
		}
		else
		{
			using InputControlList<InputDevice> inputControlList2 = InputUser.GetUnpairedInputDevices();
			for (int k = 0; k < inputControlList2.Count; k++)
			{
				InputDevice device = inputControlList2[k];
				if (HaveBindingForDevice(device))
				{
					m_InputUser = InputUser.PerformPairingWithDevice(device, m_InputUser);
				}
			}
		}
		if (m_InputUser.valid)
		{
			m_InputUser.AssociateActionsWithUser(m_Actions);
		}
	}

	private bool HaveBindingForDevice(InputDevice device)
	{
		if (m_Actions == null)
		{
			return false;
		}
		ReadOnlyArray<InputActionMap> actionMaps = m_Actions.actionMaps;
		for (int i = 0; i < actionMaps.Count; i++)
		{
			if (actionMaps[i].IsUsableWithDevice(device))
			{
				return true;
			}
		}
		return false;
	}

	private void UnassignUserAndDevices()
	{
		if (m_InputUser.valid)
		{
			m_InputUser.UnpairDevicesAndRemoveUser();
		}
		if (m_Actions != null)
		{
			m_Actions.devices = null;
		}
	}

	private bool TryToActivateControlScheme(InputControlScheme controlScheme)
	{
		if (s_InitPairWithDevicesCount > 0)
		{
			for (int i = 0; i < s_InitPairWithDevicesCount; i++)
			{
				InputDevice device = s_InitPairWithDevices[i];
				if (!controlScheme.SupportsDevice(device))
				{
					return false;
				}
			}
			for (int j = 0; j < s_InitPairWithDevicesCount; j++)
			{
				InputDevice device2 = s_InitPairWithDevices[j];
				m_InputUser = InputUser.PerformPairingWithDevice(device2, m_InputUser);
			}
		}
		if (!m_InputUser.valid)
		{
			m_InputUser = InputUser.CreateUserWithoutPairedDevices();
		}
		m_InputUser.ActivateControlScheme(controlScheme).AndPairRemainingDevices();
		if (user.hasMissingRequiredDevices)
		{
			m_InputUser.ActivateControlScheme(null);
			m_InputUser.UnpairDevices();
			return false;
		}
		return true;
	}

	private void AssignPlayerIndex()
	{
		if (s_InitPlayerIndex != -1)
		{
			m_PlayerIndex = s_InitPlayerIndex;
			return;
		}
		int num = int.MaxValue;
		int num2 = int.MinValue;
		for (int i = 0; i < s_AllActivePlayersCount; i++)
		{
			int val = s_AllActivePlayers[i].playerIndex;
			num = Math.Min(num, val);
			num2 = Math.Max(num2, val);
		}
		if (num != int.MaxValue && num > 0)
		{
			m_PlayerIndex = num - 1;
		}
		else if (num2 != int.MinValue)
		{
			for (int j = num; j < num2; j++)
			{
				if (GetPlayerByIndex(j) == null)
				{
					m_PlayerIndex = j;
					return;
				}
			}
			m_PlayerIndex = num2 + 1;
		}
		else
		{
			m_PlayerIndex = 0;
		}
	}

	private void OnEnable()
	{
		m_Enabled = true;
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			AssignPlayerIndex();
			InitializeActions();
			AssignUserAndDevices();
			ActivateInput();
		}
		if (s_InitSplitScreenIndex >= 0)
		{
			m_SplitScreenIndex = splitScreenIndex;
		}
		else
		{
			m_SplitScreenIndex = playerIndex;
		}
		ArrayHelpers.AppendWithCapacity(ref s_AllActivePlayers, ref s_AllActivePlayersCount, this);
		for (int i = 1; i < s_AllActivePlayersCount; i++)
		{
			int num = i;
			while (num > 0 && s_AllActivePlayers[num - 1].playerIndex > s_AllActivePlayers[num].playerIndex)
			{
				s_AllActivePlayers.SwapElements(num, num - 1);
				num--;
			}
		}
		if (s_AllActivePlayersCount == 1)
		{
			if (s_UserChangeDelegate == null)
			{
				s_UserChangeDelegate = OnUserChange;
			}
			InputUser.onChange += s_UserChangeDelegate;
		}
		if (isSinglePlayer)
		{
			if (m_Actions != null && m_Actions.controlSchemes.Count == 0)
			{
				StartListeningForDeviceChanges();
			}
			else if (!neverAutoSwitchControlSchemes)
			{
				StartListeningForUnpairedDeviceActivity();
			}
		}
		HandleControlsChanged();
		PlayerInputManager.instance?.NotifyPlayerJoined(this);
	}

	private void StartListeningForUnpairedDeviceActivity()
	{
		if (!m_OnUnpairedDeviceUsedHooked)
		{
			if (m_UnpairedDeviceUsedDelegate == null)
			{
				m_UnpairedDeviceUsedDelegate = OnUnpairedDeviceUsed;
			}
			if (m_PreFilterUnpairedDeviceUsedDelegate == null)
			{
				m_PreFilterUnpairedDeviceUsedDelegate = OnPreFilterUnpairedDeviceUsed;
			}
			InputUser.onUnpairedDeviceUsed += m_UnpairedDeviceUsedDelegate;
			InputUser.onPrefilterUnpairedDeviceActivity += m_PreFilterUnpairedDeviceUsedDelegate;
			InputUser.listenForUnpairedDeviceActivity++;
			m_OnUnpairedDeviceUsedHooked = true;
		}
	}

	private void StopListeningForUnpairedDeviceActivity()
	{
		if (m_OnUnpairedDeviceUsedHooked)
		{
			InputUser.onUnpairedDeviceUsed -= m_UnpairedDeviceUsedDelegate;
			InputUser.onPrefilterUnpairedDeviceActivity -= m_PreFilterUnpairedDeviceUsedDelegate;
			InputUser.listenForUnpairedDeviceActivity--;
			m_OnUnpairedDeviceUsedHooked = false;
		}
	}

	private void StartListeningForDeviceChanges()
	{
		if (!m_OnDeviceChangeHooked)
		{
			if (m_DeviceChangeDelegate == null)
			{
				m_DeviceChangeDelegate = OnDeviceChange;
			}
			InputSystem.onDeviceChange += m_DeviceChangeDelegate;
			m_OnDeviceChangeHooked = true;
		}
	}

	private void StopListeningForDeviceChanges()
	{
		if (m_OnDeviceChangeHooked)
		{
			InputSystem.onDeviceChange -= m_DeviceChangeDelegate;
			m_OnDeviceChangeHooked = false;
		}
	}

	private void OnDisable()
	{
		m_Enabled = false;
		int num = s_AllActivePlayers.IndexOfReference(this, s_AllActivePlayersCount);
		if (num != -1)
		{
			s_AllActivePlayers.EraseAtWithCapacity(ref s_AllActivePlayersCount, num);
		}
		if (s_AllActivePlayersCount == 0 && s_UserChangeDelegate != null)
		{
			InputUser.onChange -= s_UserChangeDelegate;
		}
		StopListeningForUnpairedDeviceActivity();
		StopListeningForDeviceChanges();
		PlayerInputManager.instance?.NotifyPlayerLeft(this);
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			DeactivateInput();
			UnassignUserAndDevices();
			UninitializeActions();
		}
		m_PlayerIndex = -1;
	}

	public void DebugLogAction(InputAction.CallbackContext context)
	{
		Debug.Log(context.ToString());
	}

	private void HandleDeviceLost()
	{
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.SendMessages:
			SendMessage("OnDeviceLost", this, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.BroadcastMessages:
			BroadcastMessage("OnDeviceLost", this, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.InvokeUnityEvents:
			m_DeviceLostEvent?.Invoke(this);
			break;
		case PlayerNotifications.InvokeCSharpEvents:
			DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceLostCallbacks, this, "onDeviceLost");
			break;
		}
	}

	private void HandleDeviceRegained()
	{
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.SendMessages:
			SendMessage("OnDeviceRegained", this, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.BroadcastMessages:
			BroadcastMessage("OnDeviceRegained", this, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.InvokeUnityEvents:
			m_DeviceRegainedEvent?.Invoke(this);
			break;
		case PlayerNotifications.InvokeCSharpEvents:
			DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceRegainedCallbacks, this, "onDeviceRegained");
			break;
		}
	}

	private void HandleControlsChanged()
	{
		switch (m_NotificationBehavior)
		{
		case PlayerNotifications.SendMessages:
			SendMessage("OnControlsChanged", this, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.BroadcastMessages:
			BroadcastMessage("OnControlsChanged", this, SendMessageOptions.DontRequireReceiver);
			break;
		case PlayerNotifications.InvokeUnityEvents:
			m_ControlsChangedEvent?.Invoke(this);
			break;
		case PlayerNotifications.InvokeCSharpEvents:
			DelegateHelpers.InvokeCallbacksSafe(ref m_ControlsChangedCallbacks, this, "onControlsChanged");
			break;
		}
	}

	private static void OnUserChange(InputUser user, InputUserChange change, InputDevice device)
	{
		switch (change)
		{
		case InputUserChange.DeviceLost:
		case InputUserChange.DeviceRegained:
		{
			for (int j = 0; j < s_AllActivePlayersCount; j++)
			{
				PlayerInput playerInput2 = s_AllActivePlayers[j];
				if (playerInput2.m_InputUser == user)
				{
					switch (change)
					{
					case InputUserChange.DeviceLost:
						playerInput2.HandleDeviceLost();
						break;
					case InputUserChange.DeviceRegained:
						playerInput2.HandleDeviceRegained();
						break;
					}
				}
			}
			break;
		}
		case InputUserChange.ControlsChanged:
		{
			for (int i = 0; i < s_AllActivePlayersCount; i++)
			{
				PlayerInput playerInput = s_AllActivePlayers[i];
				if (playerInput.m_InputUser == user)
				{
					playerInput.HandleControlsChanged();
				}
			}
			break;
		}
		}
	}

	private static bool OnPreFilterUnpairedDeviceUsed(InputDevice device, InputEventPtr eventPtr)
	{
		InputActionAsset inputActionAsset = all[0].actions;
		if (inputActionAsset != null)
		{
			return inputActionAsset.IsUsableWithDevice(device);
		}
		return false;
	}

	private void OnUnpairedDeviceUsed(InputControl control, InputEventPtr eventPtr)
	{
		if (!isSinglePlayer || neverAutoSwitchControlSchemes)
		{
			return;
		}
		PlayerInput playerInput = all[0];
		if (playerInput.m_Actions == null)
		{
			return;
		}
		InputDevice device = control.device;
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			using InputControlList<InputDevice> inputControlList = InputUser.GetUnpairedInputDevices();
			if (inputControlList.Count > 1)
			{
				int index = inputControlList.IndexOf(device);
				inputControlList.SwapElements(0, index);
			}
			ReadOnlyArray<InputDevice> readOnlyArray = playerInput.devices;
			for (int i = 0; i < readOnlyArray.Count; i++)
			{
				inputControlList.Add(readOnlyArray[i]);
			}
			if (!InputControlScheme.FindControlSchemeForDevices(inputControlList, playerInput.m_Actions.controlSchemes, out var controlScheme, out var matchResult, device))
			{
				return;
			}
			try
			{
				bool valid = playerInput.user.valid;
				if (valid)
				{
					playerInput.user.UnpairDevices();
				}
				InputControlList<InputDevice> inputControlList2 = matchResult.devices;
				for (int j = 0; j < inputControlList2.Count; j++)
				{
					playerInput.m_InputUser = InputUser.PerformPairingWithDevice(inputControlList2[j], playerInput.m_InputUser);
					if (!valid && playerInput.actions != null)
					{
						playerInput.m_InputUser.AssociateActionsWithUser(playerInput.actions);
					}
				}
				playerInput.user.ActivateControlScheme(controlScheme);
			}
			finally
			{
				matchResult.Dispose();
			}
		}
	}

	private void OnDeviceChange(InputDevice device, InputDeviceChange change)
	{
		if (change == InputDeviceChange.Added && isSinglePlayer && m_Actions != null && m_Actions.controlSchemes.Count == 0 && HaveBindingForDevice(device) && m_InputUser.valid)
		{
			InputUser.PerformPairingWithDevice(device, m_InputUser);
		}
	}

	private void SwitchControlSchemeInternal(ref InputControlScheme controlScheme, params InputDevice[] devices)
	{
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			for (int num = user.pairedDevices.Count - 1; num >= 0; num--)
			{
				if (!devices.ContainsReference(user.pairedDevices[num]))
				{
					user.UnpairDevice(user.pairedDevices[num]);
				}
			}
			foreach (InputDevice inputDevice in devices)
			{
				if (!user.pairedDevices.ContainsReference(inputDevice))
				{
					InputUser.PerformPairingWithDevice(inputDevice, user);
				}
			}
			if (!user.controlScheme.HasValue || !user.controlScheme.Value.Equals(controlScheme))
			{
				user.ActivateControlScheme(controlScheme);
			}
		}
	}
}
