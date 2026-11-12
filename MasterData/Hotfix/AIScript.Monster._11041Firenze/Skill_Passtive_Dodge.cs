using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Passtive_Dodge : SkillAdvancedBase
{
	private int aiId;

	private int skillCD;

	private int lostCtrTime;

	private int notLostCtrTime;

	private CoroutineNode corMain;

	private FP lostControllerTime;

	private FP controllableTime;

	private FP cd;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		_actor.EnableLogicUpdate();
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
	}

	private IEnumerator DoMainLogic()
	{
		cd = skillCD;
		while (true)
		{
			if (cd <= 0)
			{
				cd = skillCD;
				lostControllerTime = 0;
				controllableTime = 0;
			}
			else if (_actor.isLostControl)
			{
				controllableTime = 0;
				lostControllerTime += _actor.LogicDeltaTime;
				if (lostControllerTime > lostCtrTime)
				{
					_actor.InterruptForceControl();
					AdventureCustomHandleAiBranchEvent adventureCustomHandleAiBranchEvent = AdventureCustomHandleAiBranchEvent.Generate();
					adventureCustomHandleAiBranchEvent.target = _actor;
					adventureCustomHandleAiBranchEvent.eventType = HotfixEnum.monsterAIBranchFollowEventType.EXECUTE_CERTAIN_ID_AI;
					adventureCustomHandleAiBranchEvent.ids = new List<int> { aiId };
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureCustomHandleAiBranchEvent);
				}
			}
			else
			{
				controllableTime += _actor.LogicDeltaTime;
				if (controllableTime > notLostCtrTime)
				{
					lostControllerTime = 0;
				}
			}
			cd -= _actor.LogicDeltaTime;
			yield return null;
		}
	}
}
