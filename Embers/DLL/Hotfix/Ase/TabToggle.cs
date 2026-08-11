using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(RectTransform))]
public class TabToggle : Toggle
{
	public GameObject mTabNormal;

	public GameObject mTabSelected;

	public GameObject mTabNew;

	public TextMeshProUGUI textNormal;

	public TextMeshProUGUI textSelect;

	public int enumId;

	private Action<int> _selectedAction;

	private Action<int, bool> _clickAction;

	private Action pointerClickAction;

	private bool _lastStatus;

	[SerializeField]
	private bool _allowRepeatClick = true;

	private bool initWhenStart = true;

	private bool initWhenAwake;

	private Func<object, bool> pointerClickCheck;

	private Func<object, bool> submitCheck;

	public bool AllowRepeatClick
	{
		get
		{
			return _allowRepeatClick;
		}
		set
		{
			_allowRepeatClick = value;
		}
	}

	public bool InitWhenStart
	{
		get
		{
			return initWhenStart;
		}
		set
		{
			initWhenStart = value;
		}
	}

	public bool InitWhenAwake
	{
		get
		{
			return initWhenAwake;
		}
		set
		{
			initWhenAwake = value;
		}
	}

	public Func<object, bool> PointerClickCheck
	{
		get
		{
			return pointerClickCheck;
		}
		set
		{
			pointerClickCheck = (Func<object, bool>)Delegate.Combine(pointerClickCheck, value);
		}
	}

	public Func<object, bool> SubmitCheck
	{
		get
		{
			return submitCheck;
		}
		set
		{
			submitCheck = (Func<object, bool>)Delegate.Combine(submitCheck, value);
		}
	}

	protected override void Start()
	{
		base.Start();
		if (InitWhenStart)
		{
			onValueChanged.AddListener(SetSeletedStatus);
			base.isOn = false;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		if (InitWhenAwake)
		{
			onValueChanged.AddListener(SetSeletedStatus);
			base.isOn = false;
		}
	}

	protected virtual void SetSeletedStatus(bool value)
	{
		if (!_allowRepeatClick && _lastStatus == value)
		{
			return;
		}
		if (value)
		{
			if (mTabNormal != null)
			{
				mTabNormal.SetActive(value: false);
			}
			if (mTabSelected != null)
			{
				mTabSelected.SetActive(value: true);
			}
			Selected();
		}
		else
		{
			if (mTabNormal != null)
			{
				mTabNormal.SetActive(value: true);
			}
			if (mTabSelected != null)
			{
				mTabSelected.SetActive(value: false);
			}
		}
		OnClick();
		_lastStatus = value;
	}

	private void Selected()
	{
		_selectedAction?.Invoke(enumId);
	}

	private void OnClick()
	{
		_clickAction?.Invoke(enumId, base.isOn);
	}

	public void AddSelectedAction(Action<int> action)
	{
		_selectedAction = action;
	}

	public void AddClickAction(Action<int, bool> action)
	{
		_clickAction = action;
	}

	public void AddPointerClickAction(Action action)
	{
		pointerClickAction = (Action)Delegate.Combine(pointerClickAction, action);
	}

	public void SetToggleText(string normal, string select)
	{
		if ((UnityEngine.Object)(object)textNormal != null)
		{
			((TMP_Text)textNormal).text = normal;
		}
		if ((UnityEngine.Object)(object)textSelect != null)
		{
			((TMP_Text)textSelect).text = select;
		}
	}

	public void UpdateNewState(bool isNew)
	{
		mTabNew.SetActive(isNew);
	}

	public void CancelSelect()
	{
		SetSeletedStatus(value: false);
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (PointerClickCheck == null || PointerClickCheck(enumId))
		{
			base.OnPointerClick(eventData);
			pointerClickAction?.Invoke();
		}
	}

	public override void OnSubmit(BaseEventData eventData)
	{
		if (SubmitCheck == null || SubmitCheck(enumId))
		{
			base.OnSubmit(eventData);
		}
	}
}
