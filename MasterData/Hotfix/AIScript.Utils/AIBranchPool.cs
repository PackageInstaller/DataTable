#define LOG_ERROR
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Utils;

public class AIBranchPool
{
	protected AdventureActor _actor;

	protected List<BranchInfo> _branchInfos;

	protected int _executeImmediateBranchId;

	protected int _forceExecuteBranchId;

	protected readonly List<BranchInfo> _qualifiedBranchs = new List<BranchInfo>();

	protected readonly List<BranchInfo> _candidateBranchs = new List<BranchInfo>();

	protected Dictionary<int, int> _branchCastSkillTimes = new Dictionary<int, int>();

	protected Dictionary<int, int> _branchGroupCastSkillTimes = new Dictionary<int, int>();

	public void Init(AdventureActor actor, List<MonsterActionBranch> baseBranchInfos)
	{
		_actor = actor;
		_branchCastSkillTimes.Clear();
		_branchGroupCastSkillTimes.Clear();
		if (baseBranchInfos.Count <= 0)
		{
			return;
		}
		if (_branchInfos != null)
		{
			_branchInfos.Clear();
			_branchInfos = null;
		}
		_branchInfos = new List<BranchInfo>();
		foreach (MonsterActionBranch baseBranchInfo in baseBranchInfos)
		{
			BranchInfo item = new BranchInfo(baseBranchInfo, _actor.LogicTime, actor);
			_branchInfos.Add(item);
		}
	}

	public void RefreshBranchCastSkillTimes(BranchInfo info)
	{
		if (info != null)
		{
			if (_branchCastSkillTimes.TryGetValue(info.baseInfo.Id, out var value))
			{
				_branchCastSkillTimes.set_Item(info.baseInfo.Id, value++);
			}
			else
			{
				_branchCastSkillTimes.Add(info.baseInfo.Id, 1);
			}
			if (_branchGroupCastSkillTimes.TryGetValue(info.baseInfo.GroupId, out var value2))
			{
				_branchGroupCastSkillTimes.set_Item(info.baseInfo.GroupId, value2++);
			}
			else
			{
				_branchGroupCastSkillTimes.Add(info.baseInfo.GroupId, 1);
			}
			ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_CASTSKILLTIME, value.ToString(), 0L, 0L);
			ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_GROUP_CASTSKILLTIME, value2.ToString(), 0L, 0L);
		}
	}

	public void ClearBranchCastSkillTimes(int id = 0, int groupid = 0)
	{
		if (id > 0 && _branchCastSkillTimes.ContainsKey(id))
		{
			_branchCastSkillTimes.set_Item(id, 0);
			ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_CASTSKILLTIME, 0.ToString(), 0L, 0L);
		}
		if (groupid > 0 && _branchGroupCastSkillTimes.ContainsKey(groupid))
		{
			_branchGroupCastSkillTimes.set_Item(groupid, 0);
			ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_GROUP_CASTSKILLTIME, 0.ToString(), 0L, 0L);
		}
	}

	public void ClearBranchCD()
	{
		if (_branchInfos == null || _branchInfos.Count == 0)
		{
			return;
		}
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			branchInfo.ClearAiCdExpireTime(_actor.LogicTime);
		}
	}

	public void ResetBranchInitCD()
	{
		if (_branchInfos == null || _branchInfos.Count == 0)
		{
			return;
		}
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			branchInfo.ResetRandomAiCd();
		}
	}

	public BranchInfo CheckQualifiedBranchByCD()
	{
		BranchInfo result = null;
		if (_branchInfos == null || _branchInfos.Count == 0)
		{
			return null;
		}
		FP logicTime = _actor.LogicTime;
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			FP fP = branchInfo.aiCdExpireTime - logicTime;
			if (fP < 0f)
			{
				fP = 0f;
			}
			if (!(fP > 0f))
			{
				result = branchInfo;
				break;
			}
		}
		return result;
	}

	public BranchInfo CheckQualifiedBranch(FP targetDistance, LogicEntity target)
	{
		if (_branchInfos == null || _branchInfos.Count == 0)
		{
			return null;
		}
		FP logicTime = _actor.LogicTime;
		if (_forceExecuteBranchId != 0)
		{
			BranchInfo result = null;
			foreach (BranchInfo branchInfo4 in _branchInfos)
			{
				if (branchInfo4.baseInfo.Id == _forceExecuteBranchId)
				{
					result = branchInfo4;
					break;
				}
			}
			return result;
		}
		if (_executeImmediateBranchId != 0)
		{
			BranchInfo branchInfo = null;
			foreach (BranchInfo branchInfo5 in _branchInfos)
			{
				if (branchInfo5.baseInfo.Id == _executeImmediateBranchId)
				{
					branchInfo = branchInfo5;
					break;
				}
			}
			if (branchInfo != null)
			{
				FP fP = branchInfo.aiCdExpireTime - logicTime;
				FP fP2 = branchInfo.skillCdExpireTime - logicTime;
				if (fP < 0f)
				{
					fP = 0f;
				}
				if (fP2 < 0f)
				{
					fP2 = 0f;
				}
				if (fP > 0f || fP2 > 0f)
				{
					branchInfo = null;
				}
				if (branchInfo != null && TSRandom.Range(FP.Zero, FP.One) > FP.FromMyriad(branchInfo.baseInfo.Rate))
				{
					branchInfo = null;
				}
			}
			_executeImmediateBranchId = 0;
			return branchInfo;
		}
		ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_DISTANCE_GREATER_OR_EQU, targetDistance.ToString(), 0L, 0L);
		ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_DISTANCE_LESS, targetDistance.ToString(), 0L, 0L);
		ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.POSITION_DISTANCE_GREATER_OR_EQU, null, 0L, 0L);
		ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.POSITION_DISTANCE_LESS, null, 0L, 0L);
		long param = -1L;
		MonsterAdventureActor monsterAdventureActor = target as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			param = monsterAdventureActor.monsterToughnessInfo.toughness;
		}
		ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_TOUGHNESS_STATE, null, (_actor as MonsterAdventureActor).monsterToughnessInfo.toughness, param);
		_qualifiedBranchs.Clear();
		foreach (BranchInfo branchInfo6 in _branchInfos)
		{
			if (branchInfo6.baseInfo.Priority != -1 && !branchInfo6.closed && branchInfo6.actived)
			{
				FP fP = branchInfo6.aiCdExpireTime - logicTime;
				FP fP2 = branchInfo6.skillCdExpireTime - logicTime;
				if (fP < 0f)
				{
					fP = 0f;
				}
				if (fP2 < 0f)
				{
					fP2 = 0f;
				}
				if (!(fP > 0f) && !(fP2 > 0f))
				{
					_qualifiedBranchs.Add(branchInfo6);
				}
			}
		}
		if (_qualifiedBranchs.Count == 0)
		{
			return null;
		}
		IOrderedEnumerable<BranchInfo> orderedEnumerable = from item in _qualifiedBranchs
			orderby item.baseInfo.Priority descending, item.baseInfo.Weight descending
			select item;
		BranchInfo branchInfo2 = null;
		_candidateBranchs.Clear();
		int num = 0;
		int num2 = 0;
		foreach (BranchInfo item in orderedEnumerable)
		{
			if (branchInfo2 == null)
			{
				branchInfo2 = item;
				_candidateBranchs.Add(item);
			}
			else if (branchInfo2.baseInfo.Priority == item.baseInfo.Priority)
			{
				_candidateBranchs.Add(item);
			}
			item.weightStartIndex = num;
			item.weightEndIndex = num + item.baseInfo.Weight;
			num = item.weightEndIndex;
			num2 += item.baseInfo.Weight;
		}
		BranchInfo branchInfo3 = branchInfo2;
		if (_candidateBranchs.Count > 1)
		{
			int num3 = TSRandom.Range(0, num2);
			foreach (BranchInfo candidateBranch in _candidateBranchs)
			{
				if (num3 >= candidateBranch.weightStartIndex && num3 < candidateBranch.weightEndIndex)
				{
					branchInfo3 = candidateBranch;
					break;
				}
			}
		}
		if (TSRandom.Range(FP.Zero, FP.One) <= FP.FromMyriad(branchInfo3.baseInfo.Rate))
		{
			return branchInfo3;
		}
		return null;
	}

	public void ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType conditionType, string param, long param2 = 0L, long param3 = 0L)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.ActiveConditionType1 == (int)conditionType)
			{
				ActiveOrDeactive(branchInfo, conditionType, param, active: true, param2, param3);
			}
			if (branchInfo.baseInfo.DeActiveConditionType1 == (int)conditionType)
			{
				ActiveOrDeactive(branchInfo, conditionType, param, active: false, param2, param3);
			}
		}
	}

	protected void ActiveOrDeactive(BranchInfo info, HotfixEnum.monsterAIBranchActiveConditionType conditionType, string param, bool active, long param2 = 0L, long param3 = 0L)
	{
		string text = (active ? info.baseInfo.ActiveParam1 : info.baseInfo.DeActiveParam1);
		string text2 = (active ? info.baseInfo.ActiveParam2 : info.baseInfo.DeActiveParam2);
		FP fpValue;
		FP fpValue3;
		FP fpValue2;
		switch (conditionType)
		{
		case HotfixEnum.monsterAIBranchActiveConditionType.HP_PER_LESS:
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_DISTANCE_LESS:
			if (!CommonUtils.TryParseStringParamToFP(text, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(param, out fpValue3))
			{
				NovaLogger.Error($"ai branch active or deactive event param convert error，branch id:{info.baseInfo.Id}, param:{param}");
			}
			else if (fpValue3 <= fpValue)
			{
				info.actived = active;
			}
			break;
		case HotfixEnum.monsterAIBranchActiveConditionType.POSITION_DISTANCE_LESS:
		{
			if (string.IsNullOrEmpty(text))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
				break;
			}
			if (!CommonUtils.TryParseStringParamToFP(text2, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam2}");
				break;
			}
			string[] array = text.Split(',');
			FP fpValue4;
			FP fpValue5;
			if (array.Length != 2)
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(array[0], out fpValue4))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(array[1], out fpValue5))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (TSVector2.Distance(_actor.tsTransform.Position, new TSVector2(fpValue4, fpValue5)) < fpValue)
			{
				info.actived = active;
			}
			break;
		}
		case HotfixEnum.monsterAIBranchActiveConditionType.HP_PER_MORE_OR_EQUAL:
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_DISTANCE_GREATER_OR_EQU:
			if (!CommonUtils.TryParseStringParamToFP(text, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(param, out fpValue3))
			{
				NovaLogger.Error($"ai branch active or deactive event param convert error，branch id:{info.baseInfo.Id}, param:{param}");
			}
			else if (fpValue3 >= fpValue)
			{
				info.actived = active;
			}
			break;
		case HotfixEnum.monsterAIBranchActiveConditionType.POSITION_DISTANCE_GREATER_OR_EQU:
		{
			if (string.IsNullOrEmpty(text))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
				break;
			}
			if (!CommonUtils.TryParseStringParamToFP(text2, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam2}");
				break;
			}
			string[] array2 = text.Split(',');
			FP fpValue6;
			FP fpValue7;
			if (array2.Length != 2)
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(array2[0], out fpValue6))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(array2[1], out fpValue7))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (TSVector2.Distance(_actor.tsTransform.Position, new TSVector2(fpValue6, fpValue7)) >= fpValue)
			{
				info.actived = active;
			}
			break;
		}
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BASIC_STATE:
			if (string.IsNullOrEmpty(text))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (string.IsNullOrEmpty(text2))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam2}");
			}
			else if ((text + text2).Equals(param))
			{
				info.actived = active;
			}
			break;
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BUFFID:
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BUFFGROUPID:
			if (!CommonUtils.TryParseStringParamToFP(text, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (fpValue == 1)
			{
				if (param2 == _actor.Id && string.Equals(text2, param))
				{
					info.actived = active;
				}
			}
			else if (fpValue == 2 && param3 == _actor.Id && string.Equals(text2, param))
			{
				info.actived = active;
			}
			break;
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_CASTSKILLTIME:
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_GROUP_CASTSKILLTIME:
			if (!CommonUtils.TryParseStringParamToFP(text, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(param, out fpValue3))
			{
				NovaLogger.Error($"ai branch active or deactive event param convert error，branch id:{info.baseInfo.Id}, param:{param}");
			}
			else if (FP.Approximately(fpValue3, fpValue))
			{
				info.actived = active;
			}
			break;
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_TOUGHNESS_STATE:
			if (!CommonUtils.TryParseStringParamToFP(text, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (!CommonUtils.TryParseStringParamToFP(text2, out fpValue2))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
			}
			else if (fpValue == 1)
			{
				if (fpValue2 == 1 && param2 > 0)
				{
					info.actived = active;
				}
				else if (fpValue2 == 2 && param2 == 0L)
				{
					info.actived = active;
				}
			}
			else if (fpValue == 2)
			{
				if (fpValue2 == 1 && param3 > 0)
				{
					info.actived = active;
				}
				else if (fpValue2 == 2 && param3 == 0L)
				{
					info.actived = active;
				}
			}
			break;
		case HotfixEnum.monsterAIBranchActiveConditionType.TARGET_TOUGHNESS_STATECHANGE:
		{
			if (!CommonUtils.TryParseStringParamToFP(text, out fpValue))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
				break;
			}
			if (!CommonUtils.TryParseStringParamToFP(text2, out fpValue2))
			{
				NovaLogger.Error($"ai branch active or deactive condition param convert error，branch id:{info.baseInfo.Id}, param:{info.baseInfo.ActiveParam1}");
				break;
			}
			bool.TryParse(param, out var result);
			if (fpValue == 1 && param2 == _actor.Id)
			{
				if ((fpValue2 == 1) & result)
				{
					info.actived = active;
				}
				else if (fpValue2 == 2 && !result)
				{
					info.actived = active;
				}
			}
			else if (fpValue == 2 && param2 == param3)
			{
				if ((fpValue2 == 1) & result)
				{
					info.actived = active;
				}
				else if (fpValue2 == 2 && !result)
				{
					info.actived = active;
				}
			}
			break;
		}
		}
	}

	public void ExecuteFollowEvent(MonsterActionBranch branchInfo)
	{
		_forceExecuteBranchId = 0;
		ExecuteFollowEvent((HotfixEnum.monsterAIBranchFollowEventType)branchInfo.FollowEventType1, branchInfo.FollowEventParam1, branchInfo.Id);
		ExecuteFollowEvent((HotfixEnum.monsterAIBranchFollowEventType)branchInfo.FollowEventType2, branchInfo.FollowEventParam2, branchInfo.Id);
		ExecuteFollowEvent((HotfixEnum.monsterAIBranchFollowEventType)branchInfo.FollowEventType3, branchInfo.FollowEventParam3, branchInfo.Id);
	}

	protected void ExecuteFollowEvent(HotfixEnum.monsterAIBranchFollowEventType eventType, string param, int branchId)
	{
		if (eventType == HotfixEnum.monsterAIBranchFollowEventType.NONE)
		{
			return;
		}
		List<int> list = new List<int>();
		string[] array = param.Split(',');
		for (int i = 0; i < array.Length; i++)
		{
			if (!CommonUtils.TryParseStringParamToInt(array[i], out var intValue))
			{
				NovaLogger.Error($"ai branch follow event param convert error，branch id:{branchId}, param:{param}");
			}
			else
			{
				list.Add(intValue);
			}
		}
		if (list.Count > 0)
		{
			ExecuteCustomEvent(eventType, list);
		}
	}

	public void ExecuteCustomEvent(HotfixEnum.monsterAIBranchFollowEventType eventType, List<int> ids)
	{
		switch (eventType)
		{
		case HotfixEnum.monsterAIBranchFollowEventType.DEACTIVE_CERTAIN_ID_AI:
		{
			for (int num3 = 0; num3 < ids.Count; num3++)
			{
				DeActiveBranchById(ids.get_Item(num3));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.ACTIVE_CERTAIN_ID_AI:
		{
			for (int m = 0; m < ids.Count; m++)
			{
				ActiveBranchById(ids.get_Item(m));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.DEACTIVE_CERTAIN_GROUPID_AI:
		{
			for (int num = 0; num < ids.Count; num++)
			{
				DectiveBranchByGroupId(ids.get_Item(num));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.ACTIVE_CERTAIN_GROUPID_AI:
		{
			for (int k = 0; k < ids.Count; k++)
			{
				ActiveBranchByGroupId(ids.get_Item(k));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.EXECUTE_CERTAIN_ID_AI:
			_executeImmediateBranchId = ids.get_Item(0);
			break;
		case HotfixEnum.monsterAIBranchFollowEventType.CLOSE_CERTAIN_ID_AI:
		{
			for (int num2 = 0; num2 < ids.Count; num2++)
			{
				CloseBranchById(ids.get_Item(num2));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.CLOSE_CERTAIN_GROUPID_AI:
		{
			for (int n = 0; n < ids.Count; n++)
			{
				CloseBranchByGroupId(ids.get_Item(n));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.OPEN_CERTAIN_ID_AI:
		{
			for (int l = 0; l < ids.Count; l++)
			{
				OpenBranchById(ids.get_Item(l));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.OPEN_CERTAIN_GROUPID_AI:
		{
			for (int j = 0; j < ids.Count; j++)
			{
				OpenBranchByGroupId(ids.get_Item(j));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.FORCE_EXECUTE_CERTAIN_ID_AI:
			_forceExecuteBranchId = ids.get_Item(0);
			break;
		case HotfixEnum.monsterAIBranchFollowEventType.CERTAIN_ID_AI_BEGIN_CD:
		{
			for (int i = 0; i < ids.Count; i++)
			{
				BeginCDById(ids.get_Item(i));
			}
			break;
		}
		case HotfixEnum.monsterAIBranchFollowEventType.CERTAIN_ID_AI_CLEAR_CASTSKILLTIME:
			ClearBranchCastSkillTimes(ids.get_Item(0));
			break;
		case HotfixEnum.monsterAIBranchFollowEventType.CERTAIN_ID_GROUP_CLEAR_CASTSKILLTIME:
			ClearBranchCastSkillTimes(0, ids.get_Item(0));
			break;
		}
	}

	protected void ActiveBranchById(int id)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.Id == id)
			{
				if (!branchInfo.closed)
				{
					branchInfo.actived = true;
				}
				break;
			}
		}
	}

	protected void DeActiveBranchById(int id)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.Id == id)
			{
				if (!branchInfo.closed)
				{
					branchInfo.actived = false;
				}
				break;
			}
		}
	}

	protected void ActiveBranchByGroupId(int groupId)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (!branchInfo.closed && branchInfo.baseInfo.GroupId == groupId)
			{
				branchInfo.actived = true;
			}
		}
	}

	protected void DectiveBranchByGroupId(int groupId)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (!branchInfo.closed && branchInfo.baseInfo.GroupId == groupId)
			{
				branchInfo.actived = false;
			}
		}
	}

	protected void CloseBranchById(int id)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.Id == id)
			{
				branchInfo.closed = true;
				break;
			}
		}
	}

	protected void OpenBranchById(int id)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.Id == id)
			{
				branchInfo.closed = false;
				break;
			}
		}
	}

	protected void CloseBranchByGroupId(int groupId)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.GroupId == groupId)
			{
				branchInfo.closed = true;
			}
		}
	}

	protected void OpenBranchByGroupId(int groupId)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.GroupId == groupId)
			{
				branchInfo.ResetRandomAiCd();
				branchInfo.closed = false;
			}
		}
	}

	protected void BeginCDById(int id)
	{
		foreach (BranchInfo branchInfo in _branchInfos)
		{
			if (branchInfo.baseInfo.Id == id)
			{
				branchInfo.ResetAiCdExpireTime(_actor.LogicTime);
				break;
			}
		}
	}
}
