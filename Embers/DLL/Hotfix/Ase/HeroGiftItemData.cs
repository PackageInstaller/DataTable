using System;
using Sirenix.Utilities;

namespace Ase;

public class HeroGiftItemData : OptionBase
{
	private HeroModel _heroModel;

	private PropData _propData;

	private int _ownCount;

	private int _useCount;

	private int _useCountToFeelingMax;

	private long _totalEx1;

	public int OwnCount
	{
		get
		{
			return _ownCount;
		}
		set
		{
			Set(ref _ownCount, value, "OwnCount");
		}
	}

	public int UseCount
	{
		get
		{
			return _useCount;
		}
		set
		{
			value = Math.Min(OwnCount, value);
			value = Math.Max(0, value);
			Set(ref _useCount, value, "UseCount");
		}
	}

	public long TotalEx1 => _totalEx1;

	public PropData PropData => _propData;

	public HeroGiftItemData()
	{
	}

	public HeroGiftItemData(OptionBase parent, HeroModel heroModel, KnapsackPropData propData)
	{
		base.parent = parent;
		_propData = propData;
		OwnCount = propData.Amount;
		UseCount = 0;
		SetHeroData(heroModel);
	}

	private void SetHeroData(HeroModel heroModel)
	{
		_heroModel = heroModel;
		GetCountToFellingMax();
	}

	private void GetCountToFellingMax()
	{
		long needTotalExp = 0L;
		DRTrust[] dataRows = GameEntry.DataTable.GetDataRows((DRTrust p) => p.Id > _heroModel.FeelingLevel);
		if (dataRows != null && dataRows.Length != 0)
		{
			dataRows.ForEach(delegate(DRTrust p)
			{
				needTotalExp += p.TrustValue;
			});
		}
		if (needTotalExp <= 0)
		{
			_useCountToFeelingMax = 0;
			return;
		}
		long num = needTotalExp - _heroModel.FeelingExp;
		int num2 = 0;
		if (_heroModel.FavorGift.Contains(_propData.Id))
		{
			int num3 = _heroModel.FavorGift.IndexOf(_propData.Id);
			num2 = ((_heroModel.ExTrust.Count > num3) ? _heroModel.ExTrust[num3] : 0);
		}
		_totalEx1 = _propData.Ex1 + num2;
		double a = (double)num / (double)_totalEx1;
		_useCountToFeelingMax = (int)Math.Ceiling(a);
	}

	public void OnAddBtnClick()
	{
		if (UseCount >= _useCountToFeelingMax)
		{
			UseCount = _useCountToFeelingMax;
		}
		else
		{
			UseCount++;
		}
		parent.ItemOnClick(this);
	}

	public void OnDecBtnClick()
	{
		if (UseCount <= 0)
		{
			CancelUse();
		}
		else
		{
			UseCount--;
		}
		parent.ItemOnClick(this);
	}

	public void OnMaxBtnClick()
	{
		UseCount = Math.Min(_useCountToFeelingMax, OwnCount);
		parent.ItemOnClick(this);
	}

	public void CancelUse()
	{
		UseCount = 0;
	}
}
