#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class ActionScript_Device : MonsterActionBase
{
	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Operate1_S1;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", ChangeTempValueByBossRushLv);
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", ChangeTempValueByBossRushLv);
	}

	private IEnumerator Operate1_S1()
	{
		while (true)
		{
			yield return null;
		}
	}

	private void ChangeTempValueByBossRushLv(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (!string.Equals(adventureActorCustomEvent.eventName, "HaSaNaBossRushLvUp"))
		{
			return;
		}
		object sender = adventureActorCustomEvent.sender;
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(_actor.attrTempleteID);
		if (monsterValueTempleteAdjust == null)
		{
			NovaLogger.Error($"找不到怪物模板校正数据，ID：{_actor.attrTempleteID}");
		}
		else if (sender is MonsterAdventureActor monsterAdventureActor)
		{
			long num = (long)monsterValueTempleteAdjust.TemplateId * 1000L + 10 + monsterAdventureActor.BattleLevel;
			MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(num);
			if (monsterValueTemplete == null)
			{
				NovaLogger.Error($"templeteInfo config not exist, attrId:{num}, BattleLevel:{monsterAdventureActor.BattleLevel}");
				return;
			}
			_actor.attributeList.SetOriginLongValue(HotfixEnum.effectAttributeType.MAXHP, monsterValueTemplete.Hp, FDP.One);
			_actor.attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.ATK, monsterValueTemplete.Atk, FDP.One);
			_actor.attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, monsterValueTemplete.Def, FDP.One);
		}
	}
}
