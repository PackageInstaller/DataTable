using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public abstract class BaseUIComponent<T> : BaseUIComponent where T : class, IInputController, new()
{
	[NonSerialized]
	private T _controller;

	protected sealed override void ReleaseUIController()
	{
		_controller?.Deactivate();
		_controller = null;
	}

	public T GetController()
	{
		return _controller;
	}

	protected T CreateInputBindingController()
	{
		if (_controller != null)
		{
			return _controller;
		}
		T val = _controller ?? (_controller = (T)Activator.CreateInstance(typeof(T)));
		val.InitView(this);
		OnInputControllerCreate();
		return val;
	}

	protected virtual void OnInputControllerCreate()
	{
	}
}
public abstract class BaseUIComponent : LuminSerializedMonoBehaviour, IBaseUIComponent, IOperatePromptIconCollectionProvider
{
	[SerializeField]
	[HideInInspector]
	private List<OperateBtnPrompt> _cachedOperateBtnPrompts = new List<OperateBtnPrompt>();

	[HideInInspector]
	public Action onClose;

	private IBaseUIView _parent;

	private ImageAssetStation m_Station;

	private OperatePromptIconCollection _promptIconIconCollection;

	private List<OperateBtnPrompt> _pendingOperateBtnPrompts;

	public IReadOnlyList<OperateBtnPrompt> CachedOperateBtnPrompts => _cachedOperateBtnPrompts;

	public virtual IBaseUIView ParentUIView
	{
		get
		{
			if (_parent != null)
			{
				return _parent;
			}
			_parent = FetchParentView();
			return _parent;
		}
	}

	public virtual ImageAssetStation Station
	{
		get
		{
			ImageAssetStation station = m_Station;
			if (station != null && !station.IsReleased)
			{
				return m_Station;
			}
			return m_Station ?? (m_Station = ParentUIView?.Station);
		}
		set
		{
			m_Station = value;
		}
	}

	public virtual object Context { get; set; }

	public bool IsDestroyed { get; private set; }

	IBaseUIController IBaseUIComponent.GetUIController()
	{
		return GetUIController();
	}

	protected virtual IBaseUIController GetUIController()
	{
		return null;
	}

	public bool IsUIView()
	{
		return GetUIController() != null;
	}

	public virtual IInputController GetInputBindingController()
	{
		return null;
	}

	private IBaseUIView FetchParentView()
	{
		Transform parent = transform;
		while (parent != null)
		{
			if (parent.GetComponent<BaseUIComponent>() is IBaseUIView result)
			{
				return result;
			}
			parent = parent.transform.parent;
		}
		return null;
	}

	private ImageAssetStation FetchParentViewStation()
	{
		Transform parent = transform;
		while (parent != null)
		{
			if (parent.GetComponent<BaseUIComponent>() is IBaseUIView baseUIView)
			{
				return baseUIView.Station;
			}
			parent = parent.transform.parent;
		}
		return null;
	}

	private void OnDestroy()
	{
		if (!IsDestroyed)
		{
			IsDestroyed = true;
			ReleaseIconCollection();
			ReleaseUIController();
			OnUnityDestroy();
		}
	}

	protected virtual void OnUnityDestroy()
	{
	}

	protected virtual void ReleaseUIController()
	{
	}

	public IOperatePromptIconCollection GetPromptCollection()
	{
		return _promptIconIconCollection;
	}

	void IOperatePromptIconCollectionProvider.InitCollection()
	{
		if (GetInputBindingController() != null)
		{
			if (_promptIconIconCollection == null)
			{
				_promptIconIconCollection = new OperatePromptIconCollection(HandleInputDeviceChange, GetInputBindingController);
			}
			_promptIconIconCollection.InitPromptCollectionBy(this);
			FlushPendingOperateBtnPrompts();
			_promptIconIconCollection.Init();
		}
	}

	void IOperatePromptIconCollectionProvider.UnInitCollection()
	{
		_promptIconIconCollection?.UnInit();
	}

	void IOperatePromptIconCollectionProvider.Refresh()
	{
		_promptIconIconCollection?.Refresh();
	}

	void IOperatePromptIconCollectionProvider.RegisterPrompt(OperateBtnPrompt prompt)
	{
		if (prompt == null || prompt.IsDestoried)
		{
			return;
		}
		if (!(this is IBaseUIView) && !(this is ISubUIView))
		{
			IOperatePromptIconCollectionProvider operatePromptIconCollectionProvider = FindParentPromptCollectionProvider();
			if (operatePromptIconCollectionProvider != null)
			{
				operatePromptIconCollectionProvider.RegisterPrompt(prompt);
				return;
			}
		}
		if (_promptIconIconCollection != null)
		{
			RegisterOperateBtnPrompt(prompt);
		}
		else if (!IsCachedOperateBtnPrompt(prompt))
		{
			if (_pendingOperateBtnPrompts == null)
			{
				_pendingOperateBtnPrompts = new List<OperateBtnPrompt>();
			}
			if (!_pendingOperateBtnPrompts.Contains(prompt))
			{
				_pendingOperateBtnPrompts.Add(prompt);
			}
		}
	}

	void IOperatePromptIconCollectionProvider.CancelPromptRegistration(OperateBtnPrompt prompt)
	{
		if (!(this is IBaseUIView) && !(this is ISubUIView))
		{
			IOperatePromptIconCollectionProvider operatePromptIconCollectionProvider = FindParentPromptCollectionProvider();
			if (operatePromptIconCollectionProvider != null)
			{
				operatePromptIconCollectionProvider.CancelPromptRegistration(prompt);
				return;
			}
		}
		if (_pendingOperateBtnPrompts != null)
		{
			_pendingOperateBtnPrompts.Remove(prompt);
			if (_pendingOperateBtnPrompts.Count == 0)
			{
				_pendingOperateBtnPrompts = null;
			}
		}
	}

	private IOperatePromptIconCollectionProvider FindParentPromptCollectionProvider()
	{
		Transform parent = transform.parent;
		while (parent != null)
		{
			IOperatePromptIconCollectionProvider component = parent.GetComponent<IOperatePromptIconCollectionProvider>();
			if (component != null)
			{
				return component;
			}
			parent = parent.parent;
		}
		return null;
	}

	private bool IsCachedOperateBtnPrompt(OperateBtnPrompt prompt)
	{
		IReadOnlyList<OperateBtnPrompt> cachedOperateBtnPrompts = CachedOperateBtnPrompts;
		if (cachedOperateBtnPrompts == null)
		{
			return false;
		}
		for (int i = 0; i < cachedOperateBtnPrompts.Count; i++)
		{
			if (cachedOperateBtnPrompts[i] == prompt)
			{
				return true;
			}
		}
		return false;
	}

	private void FlushPendingOperateBtnPrompts()
	{
		if (_pendingOperateBtnPrompts != null)
		{
			List<OperateBtnPrompt> pendingOperateBtnPrompts = _pendingOperateBtnPrompts;
			_pendingOperateBtnPrompts = null;
			for (int i = 0; i < pendingOperateBtnPrompts.Count; i++)
			{
				RegisterOperateBtnPrompt(pendingOperateBtnPrompts[i]);
			}
		}
	}

	private void RegisterOperateBtnPrompt(OperateBtnPrompt prompt)
	{
		if (_promptIconIconCollection != null && !(prompt == null) && !prompt.IsDestoried)
		{
			prompt.InitCollectionProvider(this);
			((IOperatePromptIconCollection)_promptIconIconCollection).Register(prompt);
		}
	}

	private void HandleInputDeviceChange(DeviceInputMode type)
	{
		if (!IsDestroyed)
		{
			IInputController inputBindingController = GetInputBindingController();
			if (inputBindingController != null)
			{
				inputBindingController.OnInputDeviceChange(type);
				OnInputDeviceChange(type);
			}
		}
	}

	protected virtual void OnInputDeviceChange(DeviceInputMode type)
	{
	}

	private void ReleaseIconCollection()
	{
		_promptIconIconCollection?.UnInit();
		_promptIconIconCollection = null;
		_pendingOperateBtnPrompts?.Clear();
		_pendingOperateBtnPrompts = null;
	}
}
