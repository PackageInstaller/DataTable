#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class KnapsackPropData : PropData
{
	private bool isNew;

	private KnapsackPropData parentData;

	private Dictionary<long, KnapsackPropData> childDatas = new Dictionary<long, KnapsackPropData>();

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public new int Amount
	{
		get
		{
			return amount;
		}
		set
		{
			Set(ref amount, value, "Amount");
			parentData?.RefreshAmount();
		}
	}

	public KnapsackPropData()
	{
	}

	public KnapsackPropData(DRProp drProp, int amount = 1, bool isNew = false)
	{
		Init(drProp, amount, isNew);
	}

	private void Init(DRProp drProp, int amount = 1, bool isNew = false)
	{
		base.Init(drProp, amount);
		IsNew = isNew;
	}

	public static KnapsackPropData Create(DRProp drProp, int amount = 1, bool isNew = false)
	{
		if (drProp == null)
		{
			return new KnapsackPropData();
		}
		return new KnapsackPropData(drProp, amount, isNew);
	}

	public static KnapsackPropData Create(int id, int amount = 1, bool isNew = false)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(id);
		if (dataRow == null)
		{
			Log.Error($"根据道具Id【{id}】没有找到相应的道具配置...");
			return new KnapsackPropData();
		}
		return new KnapsackPropData(dataRow, amount, isNew);
	}

	public static KnapsackPropData Create(long uid, int id, long expireTimeStamp, int amount = 1, bool isNew = false)
	{
		KnapsackPropData knapsackPropData = new KnapsackPropData();
		knapsackPropData.Init(uid, id, expireTimeStamp, amount, isNew);
		return knapsackPropData;
	}

	private void Init(long uid, int id, long expireTimeStamp, int amount = 1, bool isNew = false)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(id);
		if (dataRow == null)
		{
			Log.Error($"根据道具Id【{id}】没有找到相应的道具配置...");
			return;
		}
		Init(dataRow, amount, isNew);
		InitExpireData(uid, dataRow.TimeLimited, expireTimeStamp);
	}

	public void AddCount(int count)
	{
		Amount = Mathf.Min(Amount + count, base.MaxCount);
	}

	public void SetCount(int count)
	{
		Amount = Mathf.Min(count, base.MaxCount);
	}

	public int Attach(KnapsackPropData data)
	{
		Amount = Mathf.Min(Amount + data.Amount, base.MaxCount);
		return Amount;
	}

	public void Cover(DRProp drProp, int amount = 1, bool isNew = false)
	{
		if (drProp != null && drProp.Id == base.Id)
		{
			Init(drProp, amount, isNew);
		}
	}

	public void Cover(long uid, int id, long expireTimeStamp, int amount = 1, bool isNew = false)
	{
		if (uid == base.Uid)
		{
			Init(uid, id, expireTimeStamp, amount, isNew);
		}
	}

	public void SetData(string iconPath, int amount = 1, string name = null)
	{
		base.Icon = iconPath;
		Amount = amount;
		base.Name = name;
	}

	public override bool CanDecompose()
	{
		if (base.PropTimeLimitEnum != PropTimeLimitEnum.Permanent)
		{
			return false;
		}
		return base.CanDecompose();
	}

	public static KnapsackPropData CreateExpireSet(int propId, List<KnapsackPropData> childDataList)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(propId);
		if (dataRow == null)
		{
			Log.Error($"根据道具Id【{propId}】没有找到相应的道具配置...");
			return new KnapsackPropData();
		}
		KnapsackPropData knapsackPropData = new KnapsackPropData(dataRow, 0);
		if (knapsackPropData.PropTimeLimitEnum == PropTimeLimitEnum.Permanent)
		{
			return new KnapsackPropData();
		}
		knapsackPropData.RefreshChildList(childDataList);
		return knapsackPropData;
	}

	public void RefreshChildList(List<KnapsackPropData> list)
	{
		childDatas.Clear();
		if (list != null)
		{
			foreach (KnapsackPropData item in list)
			{
				if (item != null && item.Id == base.Id && item.Uid != 0L && item.PropTimeLimitEnum != PropTimeLimitEnum.Permanent && !childDatas.ContainsKey(item.Uid))
				{
					item.parentData = this;
					childDatas.Add(item.Uid, item);
				}
			}
		}
		RefreshAmount();
	}

	private void RefreshAmount()
	{
		if (childDatas == null || childDatas.Count <= 0)
		{
			Amount = 0;
			return;
		}
		int value = 0;
		childDatas.Values.ToList().ForEach(delegate(KnapsackPropData p)
		{
			value += p?.Amount ?? 0;
		});
		Amount = value;
	}
}
