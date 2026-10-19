using System;
using ACT.Sound;
using Bamboo.Chronos;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI;

public class ActButton : ActSelectable<ActButton.ActButtonParams>
{
	[Serializable]
	public class ActButtonParams : ActSelectableParams
	{
		[SerializeField]
		private bool allowDoubleClick;

		[SerializeField]
		private bool allowLongPress;

		[SerializeField]
		private float doubleClickTime = 0.5f;

		[SerializeField]
		private float longPressWaitTime = 1.5f;

		[SerializeField]
		private float longPressUpdateTime = 0.5f;

		[SerializeField]
		private EventReference clickSoundReference;

		[SerializeField]
		private AudioEventReference audioClickSoundReference;

		[SerializeField]
		private AudioEventReference audioPressedSoundReference;

		[SerializeField]
		private EventReference pressedSoundReference;

		[SerializeField]
		private EventReference unInteractableClickSoundReference;

		[SerializeField]
		private AudioEventReference audioUnInteractableClickSoundReference;

		[SerializeField]
		private GameObject highlightedGameObject;

		[SerializeField]
		private GameObject pressedGameObject;

		[SerializeField]
		private GameObject selectGameObject;

		[SerializeField]
		private bool noClickSound;

		[SerializeField]
		private BaseAnimationParams _animationParams;

		public bool AllowDoubleClick => allowDoubleClick;

		public bool AllowLongPress => allowLongPress;

		public float DoubleClickTime => doubleClickTime;

		public float LongPressWaitTime => longPressWaitTime;

		public float LongPressUpdateTime => longPressUpdateTime;

		public AudioEventReference ClickSoundReference
		{
			get
			{
				if (!noClickSound)
				{
					if (!audioClickSoundReference.IsNull())
					{
						return audioClickSoundReference;
					}
					return _DefaultClickSound;
				}
				return default;
			}
			set
			{
				audioClickSoundReference = value;
			}
		}

		public AudioEventReference ClickUnInteractableSoundReference
		{
			get
			{
				return audioUnInteractableClickSoundReference;
			}
			set
			{
				audioUnInteractableClickSoundReference = value;
			}
		}

		public AudioEventReference PressedSoundReference
		{
			get
			{
				if (!noClickSound)
				{
					if (!audioPressedSoundReference.IsNull())
					{
						return audioPressedSoundReference;
					}
					return new AudioEventReference(null);
				}
				return default;
			}
			set
			{
				audioPressedSoundReference = value;
			}
		}

		public GameObject HighlightedGameObject => highlightedGameObject;

		public GameObject PressedGameObject => pressedGameObject;

		public GameObject SelectGameObject => selectGameObject;

		public bool NoClickSound => noClickSound;
	}

	public enum ActButtonEvent
	{
		OnClick,
		OnDoubleClick,
		OnLongPress,
		OnLongPressUpdate,
		OnDown,
		OnUp,
		OnEnter,
		OnExit
	}

	private static AudioEventReference _defaultClickSound;

	[SerializeField]
	private UnityEvent m_OnClick = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnUnInteractableClick = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnDoubleClick = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnLongPress = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnLongPressUpdate = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnDown = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnUp = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnEnter = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnExit = new UnityEvent();

	private float _lastDownTime;

	private bool _isLongPress;

	private Delayer _longPressDelayer;

	private Looper _longPressUpdateLooper;

	private static AudioEventReference _DefaultClickSound
	{
		get
		{
			if (_defaultClickSound.IsNull())
			{
				_defaultClickSound = new AudioEventReference("event:/UI/Common/Button_Click");
			}
			return _defaultClickSound;
		}
	}

	protected ActButtonParams Params
	{
		get
		{
			if (_params == null)
			{
				_params = new ActButtonParams();
			}
			return _params;
		}
	}

	public UnityEvent OnClick
	{
		get
		{
			return m_OnClick;
		}
		set
		{
			m_OnClick = value;
		}
	}

	public UnityEvent OnUnInteractableClick
	{
		get
		{
			return m_OnUnInteractableClick;
		}
		set
		{
			m_OnUnInteractableClick = value;
		}
	}

	public UnityEvent OnDoubleClick
	{
		get
		{
			return m_OnDoubleClick;
		}
		set
		{
			m_OnDoubleClick = value;
		}
	}

	public UnityEvent OnLongPress
	{
		get
		{
			return m_OnLongPress;
		}
		set
		{
			m_OnLongPress = value;
		}
	}

	public UnityEvent OnLongPressUpdate
	{
		get
		{
			return m_OnLongPressUpdate;
		}
		set
		{
			m_OnLongPressUpdate = value;
		}
	}

	public UnityEvent OnDown
	{
		get
		{
			return m_OnDown;
		}
		set
		{
			m_OnDown = value;
		}
	}

	public UnityEvent OnUp
	{
		get
		{
			return m_OnUp;
		}
		set
		{
			m_OnUp = value;
		}
	}

	public UnityEvent OnEnter
	{
		get
		{
			return m_OnEnter;
		}
		set
		{
			m_OnEnter = value;
		}
	}

	public UnityEvent OnExit
	{
		get
		{
			return m_OnExit;
		}
		set
		{
			m_OnExit = value;
		}
	}

	protected override void InstantClearState()
	{
		base.InstantClearState();
		_lastDownTime = 0f;
		_isLongPress = false;
		if (_longPressDelayer.IsValid())
		{
			_longPressDelayer.Cancel();
		}
		if (_longPressUpdateLooper.IsValid())
		{
			_longPressUpdateLooper.Cancel();
		}
	}

	public void SetButtonSound(string soundPath)
	{
		Params.ClickSoundReference = new AudioEventReference(soundPath);
	}

	protected override void OnEnterImp()
	{
		m_OnEnter?.Invoke();
		OnEnterImpState(state: true);
	}

	protected override void OnExitImp()
	{
		m_OnExit?.Invoke();
		OnEnterImpState(state: false);
	}

	protected override void OnDownImp()
	{
		m_OnDown?.Invoke();
		if (Params.AllowDoubleClick && _lastDownTime != 0f && Time.time - _lastDownTime < Params.DoubleClickTime)
		{
			OnDoubleClickImp();
		}
		_lastDownTime = Time.time;
		if (Params.AllowLongPress)
		{
			_longPressDelayer = UpdateTimer.Default.DelayMs((int)(Params.LongPressWaitTime * 1000f), () =>
			{
				_isLongPress = true;
				m_OnLongPress?.Invoke();
				_longPressUpdateLooper = UpdateTimer.Default.LoopMs((int)(Params.LongPressUpdateTime * 1000f), () =>
				{
					m_OnLongPressUpdate?.Invoke();
				});
			});
		}
		OnDownImpState(state: true);
	}

	public override void OnSelect(BaseEventData eventData)
	{
		base.OnSelect(eventData);
		if (gameObject.activeSelf && !(Params.SelectGameObject == null) && Params.SelectGameObject != null)
		{
			Params.SelectGameObject.SetActive(value: true);
		}
	}

	public override void OnDeselect(BaseEventData eventData)
	{
		base.OnDeselect(eventData);
		if (gameObject.activeSelf && !(Params.SelectGameObject == null) && Params.SelectGameObject != null)
		{
			Params.SelectGameObject.SetActive(value: false);
		}
	}

	protected override void OnUpImp()
	{
		m_OnUp?.Invoke();
		_isLongPress = false;
		if (_longPressDelayer.IsValid())
		{
			_longPressDelayer.Cancel();
		}
		if (_longPressUpdateLooper.IsValid())
		{
			_longPressUpdateLooper.Cancel();
		}
		OnDownImpState(state: false);
	}

	protected override void OnClickImp()
	{
		if (IsActive() && IsInteractable())
		{
			if (!Params.NoClickSound)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(Params.ClickSoundReference.IsNull() ? _DefaultClickSound : Params.ClickSoundReference);
			}
			m_OnClick?.Invoke();
		}
	}

	protected override void OnSubmitImp()
	{
		OnClickImp();
	}

	protected override void OnUnInteractableClickImp()
	{
		m_OnUnInteractableClick?.Invoke();
		if (!Params.ClickUnInteractableSoundReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(Params.ClickUnInteractableSoundReference);
		}
	}

	private void OnDoubleClickImp()
	{
		m_OnDoubleClick?.Invoke();
	}

	private void OnEnterImpState(bool state)
	{
		if (!Params.PressedSoundReference.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(Params.PressedSoundReference);
		}
		if (!state && Params.PressedGameObject != null)
		{
			Params.PressedGameObject.SetActive(value: false);
		}
		if (gameObject.activeSelf && !(Params.HighlightedGameObject == null))
		{
			Params.HighlightedGameObject.SetActive(state);
		}
	}

	private void OnDownImpState(bool state)
	{
		if (gameObject.activeSelf && interactable && !(Params.PressedGameObject == null))
		{
			Params.PressedGameObject.SetActive(state);
		}
	}

	public void Bind(object context)
	{
	}
}
