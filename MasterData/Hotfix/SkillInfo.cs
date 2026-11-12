using System.Collections;
using TrueSync;
using UnityEngine;

public class SkillInfo
{
	private readonly AdventureActor _actor;

	private readonly SpecialAttributeList specialAttributeList;

	private readonly AttributeList attributeList;

	public ActionKey actionKey;

	public readonly int skillId;

	public bool canUseAssitSkill;

	public bool beginResume;

	public bool resuming;

	public bool lockStateChange;

	private CoroutineNode _lockingCountdownCoroutine;

	private bool _locking;

	public FP currentUseInterval;

	public FP totalUseInterval;

	private int _currentSectionAmount;

	public int originalTotalSectionAmount;

	public int totalSectionAmount;

	public FP originalSectionResumeTime;

	public FP sectionResumeTime;

	public FP currentResumeTime;

	public FP sectionResumeTimePercentAmend;

	public FP sectionResumeTimeAmend;

	public FP useTimeHint;

	public FP currentUseTimeHint;

	public bool isAssistSkill { get; private set; }

	public bool locking
	{
		get
		{
			return _locking;
		}
		set
		{
			_locking = value;
			if (_locking)
			{
				_lockingCountdownCoroutine = _actor.StartLogicCoroutine(LockingCountdown());
			}
			else if (_lockingCountdownCoroutine != null)
			{
				_actor.StopLogicCoroutine(_lockingCountdownCoroutine);
				_lockingCountdownCoroutine = null;
			}
			lockStateChange = true;
		}
	}

	public int currentSectionAmount
	{
		get
		{
			return _currentSectionAmount;
		}
		set
		{
			_currentSectionAmount = value;
			int num = _currentSectionAmount;
			if (num == 0 || num == 1)
			{
				AdventureActorSkillHaveSectionAmountEvent adventureActorSkillHaveSectionAmountEvent = AdventureActorSkillHaveSectionAmountEvent.Generate();
				adventureActorSkillHaveSectionAmountEvent.actorId = _actor.dataID;
				adventureActorSkillHaveSectionAmountEvent.skillId = skillId;
				adventureActorSkillHaveSectionAmountEvent.haveSectionAmount = _currentSectionAmount == 1;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorSkillHaveSectionAmountEvent);
			}
		}
	}

	public FDP currentEnergy
	{
		get
		{
			return specialAttributeList?.GetAttributeValue(HotfixEnum.specialAttributeType.ENERGY) ?? FDP.Zero;
		}
		set
		{
			if (!(currentEnergy == value))
			{
				specialAttributeList.SetAttributeValue(attributeList, HotfixEnum.specialAttributeType.ENERGY, HotfixEnum.parameterType.BASE_VALUE, value);
			}
		}
	}

	public FDP totalEnergy => attributeList?.GetAttributeValue(HotfixEnum.effectAttributeType.ENERGY_MAX) ?? FDP.Zero;

	public SkillInfo(AdventureActor actor, ActionKey actionKey, int skillId, int totalUseInterval, int sectionAmount, int sectionResumeTime, int useTimeHint, int energy)
	{
		_actor = actor;
		_locking = false;
		this.actionKey = actionKey;
		this.skillId = skillId;
		this.totalUseInterval = FP.FromMyriad(totalUseInterval);
		if (sectionAmount == 0)
		{
			sectionAmount = 1;
		}
		currentSectionAmount = (totalSectionAmount = (originalTotalSectionAmount = sectionAmount));
		originalSectionResumeTime = FP.FromMyriad(sectionResumeTime);
		sectionResumeTimePercentAmend = 100;
		sectionResumeTimeAmend = 0;
		this.sectionResumeTime = originalSectionResumeTime;
		this.useTimeHint = (currentUseTimeHint = FP.FromMyriad(useTimeHint));
		currentEnergy = FDP.Zero;
		specialAttributeList = _actor.specialAttributeList;
		attributeList = _actor.attributeList;
		if (energy > 0)
		{
			attributeList?.SetOriginIntValue(HotfixEnum.effectAttributeType.ENERGY_MAX, (int)(long)FP.FromMyriad(energy), FDP.One);
		}
		isAssistSkill = ((PlayerAdventureActor)_actor).isAssist && actionKey == ActionKey.B;
		canUseAssitSkill = ((PlayerAdventureActor)_actor).isAssistAIFinish;
	}

	private IEnumerator LockingCountdown()
	{
		FP lockingTime = AdventureModuleController.Config.Skill_Locking_Time;
		while (true)
		{
			lockingTime -= _actor.LogicDeltaTime;
			if (lockingTime <= 0)
			{
				break;
			}
			yield return null;
		}
		_locking = false;
		int num = skillId;
		Debug.LogWarning("触发技能cd锁定时长上限，自动解锁，请检查！skillId:" + num);
	}
}
