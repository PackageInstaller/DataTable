using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverRecoverParams : IObserverParams, IReference
{
	protected BaseEntity doctorEntity;

	protected BaseEntity cureEntity;

	protected int recover;

	protected int skillId;

	public BaseEntity DoctorEntity => doctorEntity;

	public BaseEntity CureEntity => cureEntity;

	public int Recover => recover;

	public int SkillId => skillId;

	public BaseEntity Trigger => cureEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.Recover;

	public void Init(BaseEntity doctorEntity, BaseEntity cureEntity, int recover, int skillId)
	{
		this.doctorEntity = doctorEntity;
		this.cureEntity = cureEntity;
		this.recover = recover;
		this.skillId = skillId;
	}

	public void Clear()
	{
		doctorEntity = null;
		cureEntity = null;
		recover = 0;
		skillId = 0;
	}

	public IObserverParams Copy()
	{
		ObserverRecoverParams observerRecoverParams = ReferencePool.Acquire<ObserverRecoverParams>();
		observerRecoverParams.doctorEntity = doctorEntity;
		observerRecoverParams.cureEntity = cureEntity;
		observerRecoverParams.recover = recover;
		observerRecoverParams.skillId = skillId;
		return observerRecoverParams;
	}
}
