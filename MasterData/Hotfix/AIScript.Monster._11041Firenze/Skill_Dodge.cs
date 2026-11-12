using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Dodge : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _DodgeStart = ComboInputBuffer.ActionKey.L;

	private ComboInputBuffer.ActionKey _DodgeEnd;

	private FP cutloopTime = 0;

	private CoroutineNode corMain;

	private CoroutineNode corSkill;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

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
		_actor.EnableImmuneControl();
		_actor.PauseMovementBlock();
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, 0, 3600, () =>
		{
		});
		RequestComboAttack requestComboAttack = BeginAttack(_DodgeStart);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_actor.DisableImmuneControl();
		_actor.ResumeMovementBlock();
		_skill?.Clear();
	}
}
