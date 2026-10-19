using System;
using System.Collections.Generic;
using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class ActToggle : ActSelectable<ActToggle.ActToggleParams>, ICanvasElement
{
	[Serializable]
	public class ActToggleParams : ActSelectableParams
	{
		[Serializable]
		public class ActToggleAnimationParams : BaseAnimationParams
		{
			public string enterOnName;

			public string enterOffName;

			public float enterDelayS;

			public string onName;

			public string offName;
		}

		public ActToggleAnimationParams animationParams;

		[HideInInspector]
		public EventReference clickSound;

		public AudioEventReference audioClickSound;

		[HideInInspector]
		public EventReference onSound;

		public AudioEventReference audioOnSound;

		[HideInInspector]
		public EventReference offSound;

		public AudioEventReference audioOffSound;
	}

	[Serializable]
	public class ToggleOnEvent : UnityEvent
	{
		[NonSerialized]
		private List<UnityAction> _runtimeListeners;

		private List<UnityAction> RuntimeListeners => _runtimeListeners ?? (_runtimeListeners = new List<UnityAction>());

		public new void AddListener(UnityAction call)
		{
			if (call != null)
			{
				RuntimeListeners.Add(call);
				base.AddListener(call);
			}
		}

		public new void RemoveListener(UnityAction call)
		{
			if (call != null)
			{
				_runtimeListeners?.Remove(call);
				base.RemoveListener(call);
			}
		}

		public new void RemoveAllListeners()
		{
			_runtimeListeners?.Clear();
			base.RemoveAllListeners();
		}

		public void InvokePersistentListeners()
		{
			List<UnityAction> runtimeListeners = _runtimeListeners;
			if (runtimeListeners == null || runtimeListeners.Count == 0)
			{
				Invoke();
				return;
			}
			for (int i = 0; i < runtimeListeners.Count; i++)
			{
				base.RemoveListener(runtimeListeners[i]);
			}
			try
			{
				Invoke();
			}
			finally
			{
				for (int j = 0; j < runtimeListeners.Count; j++)
				{
					base.AddListener(runtimeListeners[j]);
				}
			}
		}
	}

	[Serializable]
	public class ToggleOnColorEvent : UnityEvent<Color32>
	{
	}

	[Serializable]
	public class ToggleOffEvent : UnityEvent
	{
	}

	private bool _settingFromGroup;

	private AudioEventReference _pointerEnterSound;

	[SerializeField]
	private int _index;

	[SerializeField]
	private bool _isOn;

	[FormerlySerializedAs("m_Group")]
	[SerializeField]
	private ActToggleGroup _group;

	public bool isLock;

	public bool customSelected;

	public Toggle.ToggleEvent onValueChanged = new Toggle.ToggleEvent();

	public ToggleOnEvent onToggleOn = new ToggleOnEvent();

	public ToggleOnEvent onToggleOff = new ToggleOnEvent();

	public UnityEvent onToggleClick = new UnityEvent();

	public int Index => _index;

	public bool IsOn => _isOn;

	public ActToggleGroup Group
	{
		get
		{
			return _group;
		}
		set
		{
			if ((bool)_group)
			{
				_group.UnregisterToggle(this);
			}
			_group = value;
			if ((bool)_group)
			{
				_group.RegisterToggle(this);
			}
		}
	}

	protected ActToggleParams Params
	{
		get
		{
			if (_params == null)
			{
				_params = new ActToggleParams();
			}
			if (_params.animationParams == null)
			{
				_params.animationParams = new ActToggleParams.ActToggleAnimationParams();
			}
			return _params;
		}
	}

	public void ResetIndex(int index)
	{
		_index = index;
	}

	public void SetIsOn(bool val)
	{
		if (val == _isOn)
		{
			return;
		}
		_isOn = val;
		if (_isOn)
		{
			PlayAnimation(Params.animationParams.onName);
			if (!Params.audioOnSound.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(Params.audioOnSound);
			}
			onToggleOn.Invoke();
			if (!_settingFromGroup && (bool)_group)
			{
				_group.SetToggleOn(this);
			}
		}
		else
		{
			PlayAnimation(Params.animationParams.offName);
			if (!Params.audioOffSound.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(Params.audioOffSound);
			}
			onToggleOff.Invoke();
		}
		onValueChanged?.Invoke(_isOn);
	}

	internal void SetIsOnFromGroup(bool val)
	{
		_settingFromGroup = true;
		try
		{
			SetIsOn(val);
		}
		finally
		{
			_settingFromGroup = false;
		}
	}

	public void SetIsOnWithoutNotify(bool val)
	{
		if (val != _isOn)
		{
			_isOn = val;
			if (_isOn)
			{
				PlayAnimation(Params.animationParams.onName);
				onToggleOn.InvokePersistentListeners();
			}
			else
			{
				PlayAnimation(Params.animationParams.offName);
				onToggleOff.InvokePersistentListeners();
			}
		}
	}

	public void OnGroupInit(ActToggleGroup group, int index, bool isOn)
	{
		_index = index;
		_isOn = isOn;
		if (_animation != null)
		{
			string text = (isOn ? Params.animationParams.enterOnName : Params.animationParams.enterOffName);
			if (!string.IsNullOrEmpty(text))
			{
				AnimationBuilder sequence = _animation.GetSequence(text);
				if (Params.animationParams.enterDelayS > 0f)
				{
					sequence.SetDelay((float)_index * Params.animationParams.enterDelayS);
				}
				sequence.Play();
			}
		}
		if (isOn)
		{
			onToggleOn.Invoke();
		}
		else
		{
			onToggleOff.Invoke();
		}
	}

	private void RegisterSelf2Group()
	{
		if (_group != null)
		{
			_index = _group.RegisterToggle(this);
		}
	}

	private void UnregisterSelf2Group()
	{
		if (_group != null)
		{
			_group.UnregisterToggle(this);
		}
	}

	public int GetIndexInGroup()
	{
		return _index;
	}

	protected override string GetAnimationName(SelectionState state)
	{
		return state switch
		{
			SelectionState.Disabled => Params.animationParams.disableName, 
			SelectionState.Normal => Params.animationParams.normalName, 
			SelectionState.Highlighted => Params.animationParams.highlightName, 
			SelectionState.Pressed => Params.animationParams.pressName, 
			SelectionState.Selected => _isOn ? Params.animationParams.onName : Params.animationParams.offName, 
			SelectionState.Locked => Params.animationParams.lockedName, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	protected override SelectionState GetCurState()
	{
		if (isLock)
		{
			return SelectionState.Locked;
		}
		if (!IsInteractable())
		{
			return SelectionState.Disabled;
		}
		if (_isPointerDown && _isPointerInside)
		{
			return SelectionState.Pressed;
		}
		if ((_isSelected && _isPointerInside) || customSelected)
		{
			return SelectionState.Selected;
		}
		if (_isPointerInside)
		{
			return SelectionState.Highlighted;
		}
		return SelectionState.Normal;
	}

	public void SetIsSelected(bool selected)
	{
		customSelected = selected;
	}

	public void SetPointerEnterSound(string soundPath)
	{
		_pointerEnterSound = (string.IsNullOrEmpty(soundPath) ? default(AudioEventReference) : new AudioEventReference(soundPath));
	}

	protected override void OnEnterImp()
	{
		base.OnEnterImp();
		if (!_pointerEnterSound.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(_pointerEnterSound);
		}
	}

	protected override void AwakeImply()
	{
		if (_params == null)
		{
			_params = new ActToggleParams();
		}
		if (_params.animationParams == null)
		{
			_params.animationParams = new ActToggleParams.ActToggleAnimationParams();
		}
		RegisterSelf2Group();
	}

	protected override void OnDestroyImp()
	{
		UnregisterSelf2Group();
	}

	protected override void OnEnableImp()
	{
		RegisterSelf2Group();
	}

	protected override void OnDisableImp()
	{
		UnregisterSelf2Group();
	}

	protected override void OnClickImp()
	{
		if (!Params.audioClickSound.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(Params.audioClickSound);
		}
		InternalToggle();
	}

	protected override void OnSubmitImp()
	{
		InternalToggle();
	}

	private void InternalToggle()
	{
		if (IsActive() && IsInteractable())
		{
			onToggleClick?.Invoke();
			if (!IsOn && (bool)_group)
			{
				_group.SetToggleOn(this);
			}
		}
	}

	public void SetClickInterval(float interval)
	{
		if (_group != null)
		{
			_group.SetClickInterval(interval);
		}
	}

	public float GetClickInterval()
	{
		if (!(_group != null))
		{
			return 0f;
		}
		return _group.ClickInterval;
	}

	public void Rebuild(CanvasUpdate executing)
	{
	}

	public void LayoutComplete()
	{
	}

	public void GraphicUpdateComplete()
	{
	}
}
