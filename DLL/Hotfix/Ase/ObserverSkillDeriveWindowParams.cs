using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverSkillDeriveWindowParams : IObserverParams, IReference
{
	protected BaseEntity deriveEntity;

	protected HeroSkillTypeEnum skillTypeEnum;

	protected HeroSkillData skillData;

	protected HeroSkillData deriveSkillData;

	protected bool isDerive;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.SkillDeriveWindow;

	public BaseEntity DeriveEntity => deriveEntity;

	public BaseEntity Trigger => DeriveEntity;

	public HeroSkillTypeEnum SkillTypeEnum => skillTypeEnum;

	public HeroSkillData SkillData => skillData;

	public HeroSkillData DeriveSkillData => deriveSkillData;

	public bool IsDervie => isDerive;

	public void Init(BaseEntity deriveEntity, HeroSkillTypeEnum skillTypeEnum, HeroSkillData skillData, HeroSkillData deriveSkillData, bool isDerive)
	{
		this.deriveEntity = deriveEntity;
		this.skillTypeEnum = skillTypeEnum;
		this.skillData = skillData;
		this.deriveSkillData = deriveSkillData;
		this.isDerive = isDerive;
	}

	public void Clear()
	{
		deriveEntity = null;
		skillTypeEnum = HeroSkillTypeEnum.None;
		skillData = null;
		deriveSkillData = null;
		isDerive = false;
	}

	public IObserverParams Copy()
	{
		ObserverSkillDeriveWindowParams observerSkillDeriveWindowParams = ReferencePool.Acquire<ObserverSkillDeriveWindowParams>();
		observerSkillDeriveWindowParams.deriveEntity = deriveEntity;
		observerSkillDeriveWindowParams.skillTypeEnum = skillTypeEnum;
		observerSkillDeriveWindowParams.skillData = skillData;
		observerSkillDeriveWindowParams.deriveSkillData = deriveSkillData;
		observerSkillDeriveWindowParams.isDerive = isDerive;
		return observerSkillDeriveWindowParams;
	}
}
