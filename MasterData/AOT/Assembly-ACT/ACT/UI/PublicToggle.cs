using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class PublicToggle : Toggle
{
	public List<GameObject> On;

	public List<GameObject> Off;

	public UnityEvent onSelected;

	public UnityEvent onMouseClick;

	public BetterAnimation anim;

	[Tooltip("处于Select态时不执行Select")]
	public bool selectedNoninteractable;

	protected override void Awake()
	{
		InitToggle();
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (!selectedNoninteractable || !isOn)
		{
			onMouseClick?.Invoke();
			base.OnPointerClick(eventData);
		}
	}

	public virtual void InitToggle()
	{
		onValueChanged.AddListener(OnValueChanged);
	}

	public void SetIsOnWithoutNotifyAndRefreshVisual(bool value)
	{
		SetIsOnWithoutNotify(value);
		RefreshVisual(value);
	}

	private void OnValueChanged(bool isOn)
	{
		if (isOn)
		{
			onSelected?.Invoke();
		}
		RefreshVisual(isOn);
	}

	private void RefreshVisual(bool isOn)
	{
		if (On != null && On.Count != 0)
		{
			foreach (GameObject item in On)
			{
				item.SetActive(isOn);
			}
		}
		if (Off == null || Off.Count == 0)
		{
			return;
		}
		foreach (GameObject item2 in Off)
		{
			item2.SetActive(!isOn);
		}
	}
}
