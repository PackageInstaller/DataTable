using System;
using System.Collections.Generic;

namespace RogueCard;

public class RogueCardJokerData : IComparable<RogueCardJokerData>, IEffectEntity
{
	public int id;

	public int realID;

	public int versionID;

	public RogueCardGameEffect versionEffect;

	public RogueCardGameEffect copyEffect;

	private int _addPoint;

	private int _addMutli;

	private int _mulRatio;

	public List<RogueCardGameEffect> effect = new List<RogueCardGameEffect>();

	private bool limit;

	public int addPoint
	{
		get
		{
			if (id == 306 && effect[0].action is CopyJokerEffectAction && (effect[0].action as CopyJokerEffectAction).CheckCopy())
			{
				return RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0)._addPoint;
			}
			return _addPoint;
		}
		set
		{
			if (limit)
			{
				_addPoint = Math.Max(value, 0);
			}
			else
			{
				_addPoint = value;
			}
		}
	}

	public int addMutli
	{
		get
		{
			if (id == 306 && effect[0].action is CopyJokerEffectAction && (effect[0].action as CopyJokerEffectAction).CheckCopy())
			{
				return RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0)._addMutli;
			}
			return _addMutli;
		}
		set
		{
			if (limit)
			{
				_addMutli = Math.Max(value, 0);
			}
			else
			{
				_addMutli = value;
			}
		}
	}

	public int mulRatio
	{
		get
		{
			if (id == 306 && effect[0].action is CopyJokerEffectAction && (effect[0].action as CopyJokerEffectAction).CheckCopy())
			{
				return RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0)._mulRatio;
			}
			return _mulRatio;
		}
		set
		{
			if (limit)
			{
				_mulRatio = Math.Max(value, 0);
			}
			else
			{
				_mulRatio = value;
			}
		}
	}

	public int GetPrice()
	{
		int num = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == realID).price;
		if (versionID != 0)
		{
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[versionID];
			num += rogueCardEnhanceCfg.ex_price;
		}
		return (int)Math.Floor((float)num * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerSoldRatio] / 100f));
	}

	public void ChangeSelf(RogueCardJokerData target)
	{
		int num = versionID;
		if (versionEffect != null)
		{
			versionEffect.OnDisabled();
			versionEffect = null;
		}
		versionID = 0;
		Disable();
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == target.id);
		id = target.id;
		_addPoint = target.addPoint;
		_addMutli = target.addMutli;
		_mulRatio = target.mulRatio;
		limit = rogueCardItemCfg.limit;
		int[] effect_list = rogueCardItemCfg.effect_list;
		foreach (int effectID in effect_list)
		{
			RogueCardEffectManager.Instance.RegistEffect(effectID, this);
		}
		if (num != 0)
		{
			AddVersion(num);
		}
	}

	public void CopySelf(int effectID)
	{
		if (copyEffect == null || copyEffect.effectID != effectID)
		{
			if (copyEffect != null)
			{
				copyEffect.OnDisabled();
			}
			copyEffect = null;
			RogueCardEffectManager.Instance.RegistEffect(effectID, this, isVersion: false, isCopy: true);
		}
	}

	public void ResetToOriginalForm()
	{
		int num = versionID;
		if (versionEffect != null)
		{
			versionEffect.OnDisabled();
			versionEffect = null;
		}
		versionID = 0;
		Disable();
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == realID);
		id = realID;
		_addPoint = 0;
		_addMutli = 0;
		_mulRatio = 100;
		limit = rogueCardItemCfg.limit;
		if (num != 0)
		{
			AddVersion(num);
		}
	}

	public static RogueCardJokerData CreateJokerCard(int id, int versionID = 0)
	{
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == id);
		RogueCardJokerData rogueCardJokerData = new RogueCardJokerData();
		rogueCardJokerData.id = id;
		rogueCardJokerData.realID = id;
		rogueCardJokerData._addPoint = 0;
		rogueCardJokerData.addMutli = 0;
		rogueCardJokerData.mulRatio = 100;
		rogueCardJokerData.limit = rogueCardItemCfg.limit;
		int[] effect_list = rogueCardItemCfg.effect_list;
		foreach (int effectID in effect_list)
		{
			RogueCardEffectManager.Instance.RegistEffect(effectID, rogueCardJokerData);
		}
		if (versionID != 0)
		{
			rogueCardJokerData.AddVersion(versionID);
		}
		return rogueCardJokerData;
	}

	public static RogueCardJokerData CreateJokerCard(RogueCardSaveJokerData saveData)
	{
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == saveData.real_id);
		RogueCardJokerData rogueCardJokerData = new RogueCardJokerData();
		rogueCardJokerData.id = saveData.id;
		rogueCardJokerData.realID = saveData.real_id;
		rogueCardJokerData.addPoint = saveData.add_point;
		rogueCardJokerData.addMutli = saveData.add_mutli;
		rogueCardJokerData.mulRatio = saveData.mul_ratio;
		rogueCardJokerData.limit = rogueCardItemCfg.limit;
		if (saveData.version_id != 0)
		{
			rogueCardJokerData.AddVersion(saveData.version_id);
		}
		int num = 0;
		if (saveData.id != saveData.real_id)
		{
			RogueCardItemCfg rogueCardItemCfg2 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == saveData.id);
			for (int num2 = 0; num2 < rogueCardItemCfg2.effect_list.Length; num2++)
			{
				int effectID = rogueCardItemCfg2.effect_list[num2];
				RogueCardGameEffect rogueCardGameEffect = RogueCardEffectManager.Instance.RegistEffect(effectID, rogueCardJokerData);
				rogueCardGameEffect.triggerCount = saveData.other_data[num];
				num++;
				rogueCardGameEffect.lifeCount = saveData.other_data[num];
				num++;
				if (rogueCardGameEffect.action is ChangeGlobalDataAction)
				{
					(rogueCardGameEffect.action as ChangeGlobalDataAction).changeNum = saveData.other_data[num];
				}
				num++;
			}
		}
		for (int num3 = 0; num3 < rogueCardItemCfg.effect_list.Length; num3++)
		{
			int effectID2 = rogueCardItemCfg.effect_list[num3];
			RogueCardGameEffect rogueCardGameEffect2 = RogueCardEffectManager.Instance.RegistEffect(effectID2, rogueCardJokerData);
			rogueCardGameEffect2.triggerCount = saveData.other_data[num];
			num++;
			rogueCardGameEffect2.lifeCount = saveData.other_data[num];
			num++;
			if (rogueCardGameEffect2.action is ChangeGlobalDataAction)
			{
				(rogueCardGameEffect2.action as ChangeGlobalDataAction).changeNum = saveData.other_data[num];
			}
			num++;
		}
		if (rogueCardJokerData.versionEffect != null && num + 2 < saveData.other_data.Count)
		{
			rogueCardJokerData.versionEffect.triggerCount = saveData.other_data[num];
			num++;
			rogueCardJokerData.versionEffect.lifeCount = saveData.other_data[num];
			num++;
			if (rogueCardJokerData.versionEffect.action is ChangeGlobalDataAction)
			{
				(rogueCardJokerData.versionEffect.action as ChangeGlobalDataAction).changeNum = saveData.other_data[num];
			}
			num++;
		}
		if (rogueCardJokerData.realID == 306)
		{
			RogueCardJokerData leftJoker = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
			if (leftJoker == null || leftJoker == rogueCardJokerData)
			{
				return rogueCardJokerData;
			}
			for (int num4 = 0; num4 < leftJoker.effect.Count; num4++)
			{
				RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[leftJoker.effect[num4].effectID];
				if (RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == leftJoker.realID).no_copy || leftJoker.effect[num4].triggerMoment != TriggerMoment.OnAcquire || rogueCardEffectCfg == null || rogueCardEffectCfg.action != ActionType.ChangeGlobalData)
				{
					continue;
				}
				rogueCardJokerData.CopySelf(leftJoker.effect[num4].effectID);
				if (rogueCardJokerData.copyEffect != null && num + 2 < saveData.other_data.Count)
				{
					rogueCardJokerData.copyEffect.triggerCount = saveData.other_data[num];
					num++;
					rogueCardJokerData.copyEffect.lifeCount = saveData.other_data[num];
					num++;
					if (rogueCardJokerData.copyEffect.action is ChangeGlobalDataAction)
					{
						(rogueCardJokerData.copyEffect.action as ChangeGlobalDataAction).changeNum = saveData.other_data[num];
					}
					num++;
				}
				break;
			}
		}
		return rogueCardJokerData;
	}

	public void AddVersion(int id)
	{
		versionID = id;
		RogueCardGameMain.Instance.RecordItem(2, versionID);
		RogueCardEffectManager.Instance.RegistEffect(id, this, isVersion: true);
	}

	public void Disable()
	{
		foreach (RogueCardGameEffect item in effect)
		{
			item.OnDisabled();
		}
		if (versionEffect != null)
		{
			versionEffect.OnDisabled();
		}
		if (copyEffect != null)
		{
			copyEffect.OnDisabled();
		}
		effect.Clear();
	}

	public int CompareTo(RogueCardJokerData other)
	{
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == id);
		RogueCardItemCfg rogueCardItemCfg2 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == other.id);
		if (rogueCardItemCfg.sort_priority != rogueCardItemCfg2.sort_priority)
		{
			return rogueCardItemCfg.sort_priority - rogueCardItemCfg2.sort_priority;
		}
		return id - other.id;
	}
}
