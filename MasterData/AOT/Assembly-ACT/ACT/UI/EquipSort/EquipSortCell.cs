using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.EquipSort;

public class EquipSortCell : ActToggle
{
	public EquipSortOptionType optionType;

	public TMP_Text optionIndexText;

	public LocalizeStringEvent optionName;

	public GameObject likeIcon;

	private int _priority;

	private int _propertyID;

	public int Priority
	{
		get
		{
			return _priority;
		}
		set
		{
			_priority = value;
			if ((bool)optionIndexText)
			{
				optionIndexText.gameObject.SetActive(Priority > 0);
				optionIndexText.SetText(Priority.FastToString());
			}
		}
	}

	public int PropertyID { get; set; }

	public int Sort { get; set; }

	protected override void Awake()
	{
		base.Awake();
		AddListener();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		RemoveListener();
	}

	private void AddListener()
	{
		onToggleClick.AddListener(OnClick);
	}

	private void RemoveListener()
	{
		onToggleClick.RemoveListener(OnClick);
	}

	private void OnClick()
	{
		if (optionType != EquipSortOptionType.Ascend && optionType != EquipSortOptionType.Descend)
		{
			SetIsOn(!IsOn);
		}
	}
}
