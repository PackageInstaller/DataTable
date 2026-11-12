using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Wave2 : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _Wave2Start = ComboInputBuffer.ActionKey.C;

	private readonly ComboInputBuffer.ActionKey _Wave2End = ComboInputBuffer.ActionKey.B;

	private readonly FP Wave2loopTime = 0;

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
		BeginAttack(_Wave2Start, flushInputedKeys: true);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Wave2loopTime));
		_aimTarget.Cancel();
		RequestComboAttack requestComboAttack = BeginAttack(_Wave2End);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_skill?.Clear();
	}
}
