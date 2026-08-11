using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverSkillBreakWindowParams : IObserverParams, IReference
{
	protected BaseEntity breakEntity;

	protected HeroSkillTypeEnum skillTypeEnum;

	protected List<HeroSkillTypeEnum> breakSkillEnums;

	public bool isOpenWindow;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.SkillBreakWindow;

	public BaseEntity BreakEntity => breakEntity;

	public BaseEntity Trigger => breakEntity;

	public HeroSkillTypeEnum SkillTypeEnum => skillTypeEnum;

	public void Init(BaseEntity breakEntity, HeroSkillTypeEnum skillTypeEnum, List<HeroSkillTypeEnum> breakSkillEnums, bool isOpenWindow)
	{
		this.breakEntity = breakEntity;
		this.skillTypeEnum = skillTypeEnum;
		this.breakSkillEnums = breakSkillEnums;
		this.isOpenWindow = isOpenWindow;
	}

	public void Clear()
	{
		breakEntity = null;
		skillTypeEnum = HeroSkillTypeEnum.None;
		breakSkillEnums = null;
		isOpenWindow = false;
	}

	public IObserverParams Copy()
	{
		ObserverSkillBreakWindowParams observerSkillBreakWindowParams = ReferencePool.Acquire<ObserverSkillBreakWindowParams>();
		observerSkillBreakWindowParams.breakEntity = breakEntity;
		observerSkillBreakWindowParams.skillTypeEnum = skillTypeEnum;
		observerSkillBreakWindowParams.breakSkillEnums = breakSkillEnums;
		observerSkillBreakWindowParams.isOpenWindow = isOpenWindow;
		return observerSkillBreakWindowParams;
	}
}
