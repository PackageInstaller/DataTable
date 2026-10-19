using System;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssHistoryRecordTab : LoopScrollBaseItem
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private ActButton _itemBtn;

	[SerializeField]
	private TextMeshProUGUI _date;

	[SerializeField]
	private Color _selectColor;

	[SerializeField]
	private Color _normalColor;

	[SerializeField]
	private GameObject _select;

	public CanvasGroup CanvasGroup;

	private int _idx;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		_idx = idx;
	}

	public void RefreshUI(UnityAction<int, Abyss> callBack, Abyss abyss)
	{
		_itemBtn.SetBtnClick(() =>
		{
			callBack?.Invoke(_idx, abyss);
		});
		if (abyss != null)
		{
			int id = abyss.Id;
			if (RuntimeConfigs.data.abyssGroupDatas.TryGetValue(id, out var value))
			{
				DateTime localDateTime = DateTimeOffset.FromUnixTimeMilliseconds(value.abyssGroupEndTs).LocalDateTime;
				_date.text = localDateTime.ToString("yyyy-MM-dd");
			}
		}
	}

	public void SetSelect(bool value)
	{
		_select?.SetActive(value);
		_date.color = (value ? _selectColor : _normalColor);
		if (value)
		{
			_betterAnimation.GetSequence("Select").Play();
		}
		else
		{
			_betterAnimation.GetSequence("Normal").Play();
		}
	}

	public void PlayAnimation()
	{
		_betterAnimation.GetSequence("Show").Play();
	}
}
