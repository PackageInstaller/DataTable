#define LOG_ERROR
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class BuffEntity
{
	private Dictionary<int, List<int>> buffUidLs;

	private Dictionary<int, AdventureActor> fromActors;

	private FP configBuffTime;

	private FP buffLeftTime;

	public FP inputReduceTime;

	public Buff buffConfig;

	public BuffValue buffValueConfig;

	private BuffCom _buffCom;

	private int buffNum;

	private AdventureBuffFXHandler adventureBuffFx;

	private int exceptNum;

	private bool inPool;

	private FP exceptTime;

	private bool removed;

	public bool InPool => inPool;

	public List<int> Tags { get; } = new List<int>();

	public FP LeftTime => buffLeftTime;

	public bool Removed => removed;

	public void InitBuff(Buff _buffConfig, BuffValue _buffValueConfig, BuffCom bfC, AdventureActor fromActor)
	{
		removed = false;
		inPool = false;
		buffUidLs?.Clear();
		buffNum = 0;
		buffConfig = _buffConfig;
		buffValueConfig = _buffValueConfig;
		configBuffTime = FP.FromMyriad(buffValueConfig.Time);
		Tags.Clear();
		if (buffConfig.BuffTag1 != 0)
		{
			Tags.Add(buffConfig.BuffTag1);
		}
		if (buffConfig.BuffTag2 != 0)
		{
			Tags.Add(buffConfig.BuffTag2);
		}
		if (buffConfig.BuffTag3 != 0)
		{
			Tags.Add(buffConfig.BuffTag3);
		}
		if (buffConfig.BuffTag4 != 0)
		{
			Tags.Add(buffConfig.BuffTag4);
		}
		if (buffConfig.BuffTag5 != 0)
		{
			Tags.Add(buffConfig.BuffTag5);
		}
		exceptNum = bfC.OwnerActor.effectManage.GetBuffChangeLaminatedNum(buffConfig.Id, buffConfig.GroupId, Tags);
		inputReduceTime = FP.FromMyriad(buffConfig.ReduceTime);
		_buffCom = bfC;
		InitTime();
	}

	public int GetUid()
	{
		if (buffUidLs == null || buffUidLs.Count == 0)
		{
			return 0;
		}
		return buffUidLs.Keys.ToList().get_Item(0);
	}

	public bool AddBuffNum(AdventureActor fromActor = null)
	{
		if (Removed)
		{
			return false;
		}
		if (GetMaxNum() > 1 && GetMaxNum() > GetBuffNum())
		{
			InitTime(addNum: true);
			BuffExcute(BuffManager.BuffAddType.BuffNum, fromActor);
			return true;
		}
		return false;
	}

	public void ReduceNum(int num)
	{
		for (int i = 0; i < num; i++)
		{
			if (!ReduceNum())
			{
				break;
			}
		}
	}

	public int GetBuffNum()
	{
		return buffNum;
	}

	public FP GetBuffLeftTime()
	{
		return buffLeftTime;
	}

	public void InitTime(bool addNum = false, bool iRefresh = false, AdventureActor fromActor = null)
	{
		(FP, int) buffChangeTime = _buffCom.OwnerActor.effectManage.GetBuffChangeTime(buffConfig.Id, buffConfig.GroupId, Tags);
		if (!addNum)
		{
			buffLeftTime = configBuffTime;
			buffLeftTime = buffLeftTime * (1 + FP.FromPercent(buffChangeTime.Item2)) + buffChangeTime.Item1;
			return;
		}
		Singleton<BuffEffectManager>.Instance.RefreshOnceDot(this);
		switch (buffValueConfig.TimeSuperposition)
		{
		case 2:
			buffLeftTime = (configBuffTime + exceptTime) * (1 + FP.FromPercent(buffChangeTime.Item2)) + buffChangeTime.Item1;
			break;
		case 3:
			buffLeftTime += configBuffTime;
			break;
		}
		if (iRefresh)
		{
			DispatchAddBuffEvent(BuffManager.BuffAddType.BuffNum, fromActor);
		}
	}

	public bool CheckBuffTag(int _tag)
	{
		if (Removed)
		{
			return false;
		}
		if (_tag != 0)
		{
			return Tags.Contains(_tag);
		}
		return false;
	}

	public bool CheckBuffFrom(AdventureActor fromA)
	{
		if (Removed)
		{
			return false;
		}
		if (fromA == null)
		{
			return false;
		}
		if (fromActors == null)
		{
			return false;
		}
		return fromActors.ContainsValue(fromA);
	}

	public void BuffExcute(BuffManager.BuffAddType addType, AdventureActor fromActor = null)
	{
		if (!Removed)
		{
			int num = Singleton<BuffManager>.Instance.CreateBuffUid();
			SetUid(num);
			AdventureActor adventureActor = ((fromActor == null) ? _buffCom.OwnerActor : fromActor);
			if (fromActors == null)
			{
				fromActors = new Dictionary<int, AdventureActor>();
			}
			fromActors.Add(num, adventureActor);
			_buffCom.FireBuffUiEvent(GetUid(), buffConfig.Id, buffValueConfig.Id, buffNum, buffLeftTime, buffConfig.Name);
			BuffScenceEffect(addType == BuffManager.BuffAddType.BuffNum);
			EffectExcute(num, adventureActor, addType);
			BuffEffectExcute(adventureActor, num);
			BuffReduceTime(add: true);
		}
	}

	public int GetMaxNum()
	{
		if (buffValueConfig.LaminatedNum + exceptNum > 0)
		{
			return buffValueConfig.LaminatedNum + exceptNum;
		}
		return 1;
	}

	public void AdjustNum(int num)
	{
		if (Removed || num == 0)
		{
			return;
		}
		exceptNum += num;
		int num2 = buffNum - GetMaxNum();
		if (num2 <= 0)
		{
			return;
		}
		for (int i = 0; i < num2; i++)
		{
			if (!ReduceNum())
			{
				break;
			}
		}
	}

	public void SetTime(FP time)
	{
		buffLeftTime = time;
	}

	public void AjustTime(FP value, int percent)
	{
		buffLeftTime = buffLeftTime * (1 + FP.FromPercent(percent)) + value;
	}

	public void AddLeftTime(FP time)
	{
		buffLeftTime += time;
	}

	public void AddExceptLeftTime(FP time)
	{
		exceptTime += time;
		buffLeftTime += time;
	}

	public List<AdventureEffect> GetBuffAllActiveEffects()
	{
		List<int> list = new List<int>();
		foreach (List<int> value in buffUidLs.Values)
		{
			list.AddRange(value);
		}
		return _buffCom.OwnerActor.effectManage.GetEffects(list);
	}

	public void OnUpdate(FP deltaTime)
	{
		if (Removed)
		{
			return;
		}
		if (buffValueConfig.Timing == 2)
		{
			if (GetUid() == _buffCom.GetFirstSameBuffId(buffConfig.Id))
			{
				UpdateLeftTime(deltaTime);
			}
		}
		else
		{
			UpdateLeftTime(deltaTime);
		}
		_buffCom.ReduceBuffTime(this);
		if (buffLeftTime <= 0 && configBuffTime > 0)
		{
			buffLeftTime = 0;
			_buffCom.RemoveBuff(this, BuffManager.BuffRemoveType.TimeFinish);
		}
	}

	public void UpdateLeftTime(FP deltaTime)
	{
		buffLeftTime -= deltaTime;
	}

	public void BuffEnd(BuffManager.BuffRemoveType removeType)
	{
		if (Removed)
		{
			return;
		}
		removed = true;
		if (buffUidLs != null && buffUidLs.Count > 0)
		{
			if (_buffCom.OwnerActor != null)
			{
				foreach (List<int> value in buffUidLs.Values)
				{
					_buffCom.OwnerActor.effectManage.RemoveEffectByBuff(value);
				}
				Singleton<BuffEffectManager>.Instance.RemoveBuffEffect(this);
				BuffReduceTime();
			}
			_buffCom.FireBuffUiEvent(GetUid(), buffConfig.Id, buffValueConfig.Id, 0, 0, buffConfig.Name);
			_buffCom.ResetFirstSameBuffId(this);
		}
		_buffCom.RemoveBuffTopoHeadEffect(buffConfig);
		bool flag = removeType == BuffManager.BuffRemoveType.ReycleClear;
		if (adventureBuffFx != null)
		{
			adventureBuffFx.StopFX(flag);
		}
		if (!flag && _buffCom.OwnerActor != null)
		{
			DispatchRemoveBuffEvent(removeType);
		}
	}

	public void OnClear()
	{
		inPool = true;
		buffUidLs?.Clear();
		buffNum = 0;
		buffConfig = null;
		buffValueConfig = null;
		buffLeftTime = 0;
		_buffCom = null;
		adventureBuffFx = null;
		exceptTime = 0;
		Tags?.Clear();
		fromActors?.Clear();
		exceptNum = 0;
	}

	private void SetUid(int _buffUid)
	{
		if (buffUidLs == null)
		{
			buffUidLs = new Dictionary<int, List<int>>();
		}
		buffUidLs.Add(_buffUid, new List<int>());
		buffNum = buffUidLs.Count;
	}

	private void BuffReduceTime(bool add = false)
	{
		if ((!add || !Removed) && !(_buffCom == null) && !(inputReduceTime <= 0) && _buffCom.OwnerActor is PlayerAdventureActor)
		{
			if (add && GetBuffNum() == 1)
			{
				_buffCom.AddBuffReduceTime();
			}
			else
			{
				_buffCom.RemoveBuffReduceTime();
			}
		}
	}

	private bool ReduceNum()
	{
		if (Removed)
		{
			return false;
		}
		if (buffNum <= 1)
		{
			_buffCom.RemoveBuff(this, BuffManager.BuffRemoveType.BuffNum);
			return false;
		}
		List<int> list = buffUidLs?.Keys.ToList();
		List<List<int>> list2 = buffUidLs?.Values.ToList();
		if (list2.Count > 0)
		{
			_buffCom.OwnerActor.effectManage.RemoveEffectByBuff(list2.get_Item(list2.Count - 1));
		}
		Singleton<BuffEffectManager>.Instance.RemoveBuffEffectByUid(list.get_Item(list.Count - 1));
		buffUidLs.Remove(list.get_Item(list.Count - 1));
		buffNum--;
		_buffCom.FireBuffUiEvent(GetUid(), buffConfig.Id, buffValueConfig.Id, buffNum, buffLeftTime, buffConfig.Name);
		BuffScenceEffect(iAjustNum: true);
		DispatchRemoveBuffEvent(BuffManager.BuffRemoveType.BuffNum, list.get_Item(list.Count - 1));
		return true;
	}

	private void BuffScenceEffect(bool iAjustNum)
	{
		if (Removed)
		{
			return;
		}
		if (!string.IsNullOrEmpty(buffConfig.BindEffect))
		{
			if (!iAjustNum)
			{
				adventureBuffFx = AdventureFXManager.PlayBuffFX(buffConfig.BindEffect, _buffCom.gameObject);
			}
			if (adventureBuffFx != null)
			{
				int maxNum = GetMaxNum();
				int num = buffNum;
				if (num < 1 || num > maxNum)
				{
					num = Mathf.Clamp(num, 1, maxNum);
				}
				adventureBuffFx.PlayBuffStackFX(num, maxNum);
			}
		}
		_buffCom.AddBufftTopoHeadEffect(buffConfig, buffNum);
	}

	private void EffectExcute(int uid, AdventureActor fromActor, BuffManager.BuffAddType addType = BuffManager.BuffAddType.Normal)
	{
		if (Removed || !(_buffCom.OwnerActor.effectManage != null) || uid <= 0)
		{
			return;
		}
		bool flag = true;
		for (int i = 0; i < buffValueConfig.Effects.Count; i++)
		{
			if (Removed)
			{
				break;
			}
			if (!(_buffCom.OwnerActor != null))
			{
				break;
			}
			int item = _buffCom.OwnerActor.effectManage.AddEffectByBuff(buffValueConfig.Effects.get_Item(i), fromActor);
			if (Removed)
			{
				return;
			}
			if (buffUidLs.ContainsKey(uid))
			{
				buffUidLs.get_Item(uid).Add(item);
			}
			if (flag)
			{
				DispatchAddBuffEvent(addType, fromActor);
			}
			flag = false;
		}
		if (flag)
		{
			DispatchAddBuffEvent(addType, fromActor);
		}
	}

	private void BuffEffectExcute(AdventureActor _from, int buffUid)
	{
		if (Removed)
		{
			return;
		}
		if (buffValueConfig == null)
		{
			NovaLogger.Error("buffValueConfig====NULL");
		}
		if (buffValueConfig.BuffEffects.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < buffValueConfig.BuffEffects.Count; i++)
		{
			Singleton<BuffEffectManager>.Instance.AddBuffEffect(_from, _buffCom.OwnerActor, this, buffValueConfig.BuffEffects.get_Item(i), buffUid);
			if (Removed)
			{
				break;
			}
		}
	}

	private void DispatchAddBuffEvent(BuffManager.BuffAddType addType, AdventureActor fromActor = null)
	{
		AdventureActorGetBuff adventureActorGetBuff = AdventureActorGetBuff.Generate();
		adventureActorGetBuff.sender = _buffCom.OwnerActor;
		adventureActorGetBuff.eventInfo.buffId = buffConfig.Id;
		adventureActorGetBuff.eventInfo.buffGroupId = buffConfig.GroupId;
		adventureActorGetBuff.eventInfo.buffTags.AddRange(Tags);
		adventureActorGetBuff.eventInfo.addType = addType;
		adventureActorGetBuff.buff = this;
		adventureActorGetBuff.from = fromActor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorGetBuff);
	}

	private void DispatchRemoveBuffEvent(BuffManager.BuffRemoveType removeType, int uid = 0)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = AdventureActorRemoveBuff.Generate();
		adventureActorRemoveBuff.sender = _buffCom.OwnerActor;
		adventureActorRemoveBuff.eventInfo.buffId = buffConfig.Id;
		adventureActorRemoveBuff.eventInfo.buffGroupId = buffConfig.GroupId;
		adventureActorRemoveBuff.eventInfo.buffTags.AddRange(Tags);
		adventureActorRemoveBuff.eventInfo.removeType = removeType;
		Dictionary<int, AdventureActor> dictionary = fromActors;
		if (dictionary != null && dictionary.Count > 0)
		{
			if (uid == 0)
			{
				adventureActorRemoveBuff.froms.AddRange(fromActors.Values.ToList());
			}
			else if (fromActors.ContainsKey(uid))
			{
				adventureActorRemoveBuff.froms.Add(fromActors.get_Item(uid));
				fromActors.Remove(uid);
			}
		}
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorRemoveBuff);
	}
}
