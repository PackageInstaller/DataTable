using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverReleaseSkillParams : IObserverParams, IReference
{
	protected BaseEntity releaseEntity;

	protected HeroSkillData skillData;

	protected HeroSkillTypeEnum releaseSkillType;

	protected SkillExecuteState executeState;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.ReleaseSkill;

	public BaseEntity Trigger => releaseEntity;

	public BaseEntity ReleaseEntity => releaseEntity;

	public HeroSkillData SkillData => skillData;

	public HeroSkillTypeEnum ReleaseSkillType => releaseSkillType;

	public int SkillId => skillData.Id;

	public SkillExecuteState ExecuteState => executeState;

	public void Init(BaseEntity releaseEntity, SkillExecuteState executeState, HeroSkillData skillData, HeroSkillTypeEnum releaseSkillType)
	{
		this.releaseEntity = releaseEntity;
		this.executeState = executeState;
		this.skillData = skillData;
		this.releaseSkillType = releaseSkillType;
	}

	public void Clear()
	{
		releaseEntity = null;
		executeState = SkillExecuteState.None;
		skillData = null;
		releaseSkillType = HeroSkillTypeEnum.None;
	}

	public IObserverParams Copy()
	{
		ObserverReleaseSkillParams observerReleaseSkillParams = ReferencePool.Acquire<ObserverReleaseSkillParams>();
		observerReleaseSkillParams.releaseEntity = releaseEntity;
		observerReleaseSkillParams.executeState = executeState;
		observerReleaseSkillParams.skillData = skillData;
		observerReleaseSkillParams.releaseSkillType = releaseSkillType;
		return observerReleaseSkillParams;
	}
}
