using System.Collections.Generic;
using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class GamePadTipsComp : MonoBehaviour
{
	[Header("预制体设置")]
	[SerializeField]
	[Tooltip("OperateBtnPrompt 预制体")]
	private GameObject operateBtnPromptPrefab;

	[Header("容器设置")]
	[SerializeField]
	[Tooltip("提示按钮的父容器")]
	private Transform promptContainer;

	[SerializeField]
	[Tooltip("池子")]
	private Transform pool;

	[Header("对象池设置")]
	[SerializeField]
	[Tooltip("对象池初始容量")]
	private int poolInitialCapacity = 5;

	[SerializeField]
	[Tooltip("对象池最大容量")]
	private int poolMaxCapacity = 20;

	private Queue<OperateBtnPrompt> _promptPool;

	private Dictionary<string, OperateBtnPrompt> _activePrompts;

	private List<OperateBtnPrompt> _allPrompts;

	private List<GamePadTipsAction> _gamePadTipsActions;

	public List<GamePadTipsAction> GamePadTipsActions => _gamePadTipsActions;

	private void Awake()
	{
		_gamePadTipsActions = ListPool<GamePadTipsAction>.Get();
		InitializePool();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void OnInputModeChanged(DeviceInputMode inputMode)
	{
		SetGamePadTipsActive(inputMode == DeviceInputMode.Gamepad);
	}

	private void SetGamePadTipsActive(bool isActive)
	{
		gameObject.SetActive(isActive);
	}

	private void EnsureInitialized()
	{
		if (_promptPool == null || _activePrompts == null || _allPrompts == null)
		{
			InitializePool();
		}
	}

	private void InitializePool()
	{
		_promptPool = new Queue<OperateBtnPrompt>(poolInitialCapacity);
		_activePrompts = new Dictionary<string, OperateBtnPrompt>();
		_allPrompts = new List<OperateBtnPrompt>();
		if (promptContainer == null)
		{
			promptContainer = transform;
		}
		for (int i = 0; i < poolInitialCapacity; i++)
		{
			CreateNewPrompt();
		}
	}

	private OperateBtnPrompt CreateNewPrompt(bool setActive = false, bool addToPool = true)
	{
		if (operateBtnPromptPrefab == null)
		{
			Debug.LogError("[GamePadTipsComp] OperateBtnPrompt 预制体未设置！");
			return null;
		}
		GameObject gameObject = Object.Instantiate(operateBtnPromptPrefab, promptContainer);
		OperateBtnPrompt component = gameObject.GetComponent<OperateBtnPrompt>();
		if (component == null)
		{
			Debug.LogError("[GamePadTipsComp] 预制体上没有找到 OperateBtnPrompt 组件！");
			Object.Destroy(gameObject);
			return null;
		}
		gameObject.SetActive(setActive);
		_allPrompts.Add(component);
		if (!setActive & addToPool)
		{
			_promptPool.Enqueue(component);
		}
		return component;
	}

	private OperateBtnPrompt GetFromPool()
	{
		OperateBtnPrompt operateBtnPrompt;
		if (_promptPool.Count > 0)
		{
			operateBtnPrompt = _promptPool.Dequeue();
		}
		else
		{
			if (_allPrompts.Count >= poolMaxCapacity)
			{
				Debug.LogWarning("[GamePadTipsComp] 对象池已达到最大容量，无法创建更多对象！");
				return null;
			}
			operateBtnPrompt = CreateNewPrompt(setActive: false, addToPool: false);
		}
		if (operateBtnPrompt != null)
		{
			operateBtnPrompt.gameObject.SetActive(value: false);
			operateBtnPrompt.transform.SetParent(promptContainer);
		}
		return operateBtnPrompt;
	}

	private void ReturnToPool(OperateBtnPrompt prompt)
	{
		if (!(prompt == null))
		{
			prompt.gameObject.SetActive(value: false);
			prompt.transform.SetParent(pool);
			if (!_promptPool.Contains(prompt))
			{
				_promptPool.Enqueue(prompt);
			}
		}
	}

	public void RegisterInputAction(string inputAction, int localizeKey = 0, string localizeTable = "Common", string bindingAction = null, bool needLongPress = false)
	{
		EnsureInitialized();
		if (string.IsNullOrEmpty(inputAction))
		{
			Debug.LogWarning("[GamePadTipsComp] InputAction 名称为空！");
			return;
		}
		if (_activePrompts.ContainsKey(inputAction))
		{
			UnregisterInputAction(inputAction);
		}
		OperateBtnPrompt fromPool = GetFromPool();
		if (!(fromPool == null))
		{
			fromPool.SetBindingAction(string.IsNullOrEmpty(bindingAction) ? inputAction : bindingAction);
			fromPool.SetNeedLongPress(needLongPress);
			fromPool.SetLocalizeString(localizeKey, localizeTable);
			fromPool.RefreshIcon();
			fromPool.gameObject.SetActive(value: true);
			fromPool.SetVisible(vis: true);
			_activePrompts[inputAction] = fromPool;
		}
	}

	public void UnregisterInputAction(string inputAction)
	{
		EnsureInitialized();
		if (!string.IsNullOrEmpty(inputAction) && _activePrompts.TryGetValue(inputAction, out var value))
		{
			ReturnToPool(value);
			_activePrompts.Remove(inputAction);
		}
	}

	public void RegisterInputActions(params GamePadTipsAction[] inputActions)
	{
		ClearAllPrompts();
		if (inputActions != null)
		{
			for (int i = 0; i < inputActions.Length; i++)
			{
				RegisterInputAction(inputActions[i].inputAction, inputActions[i].localizeKey, inputActions[i].localizeTable, inputActions[i].bindingAction, inputActions[i].needLongPress);
				_gamePadTipsActions?.Add(inputActions[i]);
			}
		}
	}

	public void RegisterInputActions(List<GamePadTipsAction> inputActions)
	{
		EnsureInitialized();
		if (inputActions != null)
		{
			for (int i = 0; i < inputActions.Count; i++)
			{
				RegisterInputAction(inputActions[i].inputAction, inputActions[i].localizeKey, inputActions[i].localizeTable, inputActions[i].bindingAction, inputActions[i].needLongPress);
				_gamePadTipsActions?.Add(inputActions[i]);
			}
		}
	}

	public OperateBtnPrompt GetPrompt(string inputAction)
	{
		EnsureInitialized();
		_activePrompts.TryGetValue(inputAction, out var value);
		return value;
	}

	public void RefreshAllPrompts()
	{
		EnsureInitialized();
		foreach (OperateBtnPrompt value in _activePrompts.Values)
		{
			if (value != null)
			{
				value.RefreshIcon();
			}
		}
	}

	public void ClearAllPrompts()
	{
		EnsureInitialized();
		foreach (string item in new List<string>(_activePrompts.Keys))
		{
			UnregisterInputAction(item);
		}
		_gamePadTipsActions?.Clear();
	}

	public void SetPromptVisible(string inputAction, bool visible)
	{
		EnsureInitialized();
		if (_activePrompts.TryGetValue(inputAction, out var value))
		{
			value.SetVisible(visible);
		}
	}

	public void SetAllPromptsVisible(bool visible)
	{
		EnsureInitialized();
		foreach (OperateBtnPrompt value in _activePrompts.Values)
		{
			if (value != null)
			{
				value.SetVisible(visible);
			}
		}
	}

	public int GetActivePromptCount()
	{
		EnsureInitialized();
		return _activePrompts.Count;
	}

	public int GetPoolCount()
	{
		EnsureInitialized();
		return _promptPool.Count;
	}

	private void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		if (_allPrompts != null)
		{
			foreach (OperateBtnPrompt allPrompt in _allPrompts)
			{
				if (allPrompt != null && allPrompt.gameObject != null)
				{
					Object.Destroy(allPrompt.gameObject);
				}
			}
			_allPrompts.Clear();
		}
		_promptPool?.Clear();
		_activePrompts?.Clear();
		ListPool<GamePadTipsAction>.Release(_gamePadTipsActions);
		_gamePadTipsActions = null;
	}
}
