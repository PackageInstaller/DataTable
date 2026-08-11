using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverHitParams : IObserverParams, IReference
{
	protected BaseEntity hitEntity;

	protected BaseEntity attackEntity;

	protected int skillId;

	protected int bulletId;

	protected int damageValue;

	protected bool isStruckDown;

	protected bool isCrit;

	protected BaseWeaknessData weaknessData;

	protected HitColliderVariableData hitColliderVariableData;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.Hit;

	public BaseEntity Trigger => hitEntity;

	public BaseEntity HitEntity => hitEntity;

	public BaseEntity AttackEntity => attackEntity;

	public int SkillId => skillId;

	public int BulletId => bulletId;

	public int DamageValue => damageValue;

	public bool IsStruckDown => isStruckDown;

	public bool IsCrit => isCrit;

	public BaseWeaknessData WeaknessData => weaknessData;

	public HitColliderVariableData HitColliderVariableData => hitColliderVariableData;

	public void Init(BaseEntity hitEntity, BaseEntity attackEntity, int skillId, int bulletId, int damageValue, bool isStruckDown, BaseWeaknessData weaknessData, HitColliderVariableData hitColliderVariableData, bool isCrit)
	{
		this.hitEntity = hitEntity;
		this.attackEntity = attackEntity;
		this.skillId = skillId;
		this.bulletId = bulletId;
		this.damageValue = damageValue;
		this.isStruckDown = isStruckDown;
		this.weaknessData = weaknessData;
		this.hitColliderVariableData = hitColliderVariableData;
		this.isCrit = isCrit;
	}

	public void Clear()
	{
		hitEntity = null;
		attackEntity = null;
		skillId = 0;
		damageValue = 0;
		isStruckDown = false;
		weaknessData = null;
		hitColliderVariableData = null;
		isCrit = false;
	}

	public IObserverParams Copy()
	{
		ObserverHitParams observerHitParams = ReferencePool.Acquire<ObserverHitParams>();
		observerHitParams.hitEntity = hitEntity;
		observerHitParams.attackEntity = attackEntity;
		observerHitParams.skillId = skillId;
		observerHitParams.damageValue = damageValue;
		observerHitParams.isStruckDown = isStruckDown;
		observerHitParams.weaknessData = weaknessData;
		observerHitParams.hitColliderVariableData = hitColliderVariableData;
		observerHitParams.isCrit = isCrit;
		return observerHitParams;
	}
}
