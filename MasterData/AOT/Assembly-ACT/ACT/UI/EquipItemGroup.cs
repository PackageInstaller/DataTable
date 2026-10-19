using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Game.Data;
using ACT.UI.ChipPack;
using UnityEngine;

namespace ACT.UI;

public class EquipItemGroup : BaseEquipComponent
{
	public const string SHOW = "Show";

	public const string HIED = "Hide";

	public const string SUBVIEWSHOW = "SubviewShow";

	public const string SUBVIEWHIDE = "SubviewHide";

	[SerializeField]
	private Transform[] root1;

	[SerializeField]
	private List<EquipItem> equipItems;

	[SerializeField]
	public ActToggleGroup toggleGroup;

	[SerializeField]
	private BetterAnimation m_Animation;

	private Action<int> onSelectItem;

	private int currentIndex;

	public override void Awake()
	{
		base.Awake();
		for (int i = 0; i < equipItems.Count; i++)
		{
			equipItems[i].Register(i);
		}
	}

	public void PlayAnimation(string sequenceName, Action<AnimationBuilder> onComplete = null)
	{
		m_Animation.GetSequence(sequenceName)?.OnComplete(onComplete).Play();
	}

	public void Refresh(Character character)
	{
		if (isOpen)
		{
			for (int i = 0; i < equipItems.Count; i++)
			{
				equipItems[i].Init(character.GetEquipInSlot(i + 1));
			}
			currentIndex = 0;
			SelectItem(ShouldDefaultSelectFirstSlot() ? currentIndex : (-1));
		}
	}

	private static bool ShouldDefaultSelectFirstSlot()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null)
		{
			return true;
		}
		DeviceInputMode inputMode = instance.InputMode;
		if (inputMode != DeviceInputMode.KeyboardAndMouse)
		{
			return inputMode == DeviceInputMode.Gamepad;
		}
		return true;
	}

	public void InitData(Action<int> onSelectItem)
	{
		this.onSelectItem = onSelectItem;
		toggleGroup.Init(-1);
	}

	public void SetHoverEnabled(bool enabled)
	{
		for (int i = 0; i < equipItems.Count; i++)
		{
			equipItems[i].SetHoverEnabled(enabled);
		}
	}

	public EquipItem GetEquipItem(int index)
	{
		return equipItems[index];
	}

	public void BtnClick(int index)
	{
		onSelectItem?.Invoke(index);
	}

	public void BtnClick()
	{
		BtnClick(currentIndex);
	}

	private void SelectItem(int index)
	{
		for (int i = 0; i < equipItems.Count; i++)
		{
			equipItems[i].Selected(index == i);
		}
	}

	public void TurnToNext()
	{
		if (currentIndex < equipItems.Count - 1)
		{
			currentIndex++;
		}
		SelectItem(currentIndex);
	}

	public void TurnToPrevious()
	{
		if (currentIndex > 0)
		{
			currentIndex--;
		}
		SelectItem(currentIndex);
	}
}
