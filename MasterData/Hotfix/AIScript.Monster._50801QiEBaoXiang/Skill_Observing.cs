using System.Collections;
using TrueSync;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Skill_Observing : SkillSimpleBase
{
	private static readonly FP ObserveTime = 3;

	private static readonly FP ObserveDistance = 4;

	private FP ObserveTimeCount;

	private long Emoji;

	private bool IsHurt;

	protected override void OnSkillEnable()
	{
		ObserveTimeCount = ObserveTime;
		IsHurt = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (!(GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) < ObserveDistance))
		{
			Emoji = PlayEffect("Observe_Emoji");
			yield return WaitTime(2);
			while (((ObserveTimeCount >= 0) & !IsHurt) && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) >= ObserveDistance)
			{
				ObserveTimeCount -= (FP)0.1;
				yield return WaitTime(0.1);
			}
			StopWaitLookAt();
			StopEffect(Emoji);
			yield return WaitTime(0.5);
		}
	}

	private void OnHpChanged(IEvent evt)
	{
		IsHurt = true;
	}
}
