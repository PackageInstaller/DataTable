using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverSkillCanelParams : IObserverParams, IReference
{
	protected BaseEntity entity;

	public int SkillId;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.SkillCancel;

	public BaseEntity Trigger => entity;

	public void Init(int skillId, BaseEntity entity)
	{
		SkillId = skillId;
		this.entity = entity;
	}

	public void Clear()
	{
		entity = null;
	}

	public IObserverParams Copy()
	{
		ObserverSkillCanelParams observerSkillCanelParams = ReferencePool.Acquire<ObserverSkillCanelParams>();
		observerSkillCanelParams.entity = entity;
		observerSkillCanelParams.SkillId = SkillId;
		return observerSkillCanelParams;
	}
}
