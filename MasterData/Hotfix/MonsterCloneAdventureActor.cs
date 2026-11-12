public class MonsterCloneAdventureActor : AdventureActor
{
	public bool isFree { get; set; }

	public MonsterSpawnerInfo spawnerInfo { get; protected set; }

	public MonsterAdventureActor summoner { get; set; }

	public int TeamId { get; set; }

	protected override void OnInit()
	{
		attributeList.Init();
		actorInfo = AddOrGetLogicComponent<ActorInfo>();
		actorHealthInfo = AddOrGetLogicComponent<ActorHealthInfo>();
		actorElementInfo = AddOrGetLogicComponent<ActorElementInfo>();
		spawnerInfo = AddOrGetLogicComponent<MonsterSpawnerInfo>();
		shootBehaviour = AddOrGetLogicComponent<ShootBehaviour>();
		actorSearchTargetInfo = AddOrGetLogicComponent<ActorSearchTarget>();
		actorSearchTargetInfo.InitializeSearchTarget();
		actorSkillManage = AddOrGetLogicComponent<ActorSkillManage>();
		hitBox = HitBox.Setup(gameObject, this, this);
		gameObject.layer = 8;
	}

	public void SetAttr(MonsterAdventureActor master)
	{
		isFree = false;
		spawnerInfo.level = master.spawnerInfo.level;
		attrTempleteID = master.attrTempleteID;
		dataID = master.dataID;
		attributeList.CopyValueFrom(master.attributeList);
		actorInfo.factionID = master.actorInfo.factionID;
		actorElementInfo.elementType = master.actorElementInfo.elementType;
		monsterTarget = master.monsterTarget;
		comboGroup = master.comboGroup;
		TeamId = master.monsterInfo.teamId;
		summoner = master;
		actorSearchTargetInfo.IsShowRng = master.actorSearchTargetInfo.IsShowRng;
		actorSearchTargetInfo.visionRange = master.actorSearchTargetInfo.visionRange;
		actorSearchTargetInfo.visionDeg = master.actorSearchTargetInfo.visionDeg;
		actorSearchTargetInfo.hearRange = master.actorSearchTargetInfo.hearRange;
		actorSearchTargetInfo.monsterSearchRange = master.actorSearchTargetInfo.monsterSearchRange;
		actorSearchTargetInfo.actorRadius = master.actorSearchTargetInfo.actorRadius;
		actorSearchTargetInfo.InitAlertRngComponent();
		actorSearchTargetInfo.EnableHearingLogic();
		actorSearchTargetInfo.EnableVisionLogic();
		actorScaleInfo = AddOrGetLogicComponent<ActorScaleInfo>();
		actorScaleInfo.modelScale = master.actorScaleInfo.modelScale;
		actorScaleInfo.colliderScale = master.actorScaleInfo.colliderScale;
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
		actorSearchTargetInfo.ReleaseSearchTarget();
	}

	protected override void OnLogicUpdateEnabled()
	{
	}

	protected override void OnLogicUpdate()
	{
		actorSkillManage?.LogicUpdate(LogicDeltaTime);
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
