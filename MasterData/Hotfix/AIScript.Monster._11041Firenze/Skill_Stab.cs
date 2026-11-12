using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Stab : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyStart = ComboInputBuffer.ActionKey.E;

	private readonly ComboInputBuffer.ActionKey _actionKeyAttack;

	private readonly FP loopTime = 0;

	private CoroutineNode corMain;

	private CoroutineNode corSkill;

	private LookAtTarget _lookAtTarget = new LookAtTarget();

	private readonly AimTarget _aimTarget = new AimTarget();

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		_aimTarget?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_aimTarget.Aim(_actor, activedPlayerActor.GetComponent<AdventureActor>());
		RequestComboAttack requestComboAttack = BeginAttack(_actionKeyStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(loopTime));
		_aimTarget.Cancel();
		requestComboAttack = BeginAttack(_actionKeyAttack);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_skill?.Clear();
	}
}
