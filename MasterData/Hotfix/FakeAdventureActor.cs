using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class FakeAdventureActor : AdventureActor
{
	protected override void OnInit()
	{
		attributeList.Init();
		actorInfo = AddOrGetLogicComponent<ActorInfo>();
		actorHealthInfo = AddOrGetLogicComponent<ActorHealthInfo>();
		actorElementInfo = AddOrGetLogicComponent<ActorElementInfo>();
		actorSkillManage = AddOrGetLogicComponent<ActorSkillManage>();
		hitBox = HitBox.Setup(gameObject, this, this);
		gameObject.layer = 8;
	}

	public void SetAttrInfo(int templeteId, long attributeId, int factionID = 6)
	{
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(templeteId);
		if (monsterValueTempleteAdjust == null)
		{
			Debug.LogError($"Fake Actor, MonsterValueTempleteAdjust Config Not Exist, Id:{templeteId}");
			return;
		}
		MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(attributeId);
		if (monsterValueTemplete == null)
		{
			Debug.LogError($"Fake Actor, MonsterValueTemplete Config Not Exist, Id:{attributeId}");
			return;
		}
		actorHealthInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, FDP.One);
		actorInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, FDP.One);
		actorElementInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, FDP.One);
		actorInfo.factionID = factionID;
	}

	public void ClearBindSkill()
	{
		actorSkillManage?.DestroyAllPassiveSkill();
	}

	protected override void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
	}

	protected override void OnDeactive()
	{
		DisableLogicUpdate();
	}

	protected override void OnLogicUpdate()
	{
		actorSkillManage?.LogicUpdate(LogicDeltaTime);
	}

	protected override void OnLogicUpdateEnabled()
	{
	}

	protected override void OnLogicUpdateDisabled()
	{
	}

	protected override void OnLogicUpdatePaused()
	{
	}

	protected override void OnLogicUpdateResumed()
	{
	}

	protected override void OnLogicTimeScaleChanged()
	{
	}
}
