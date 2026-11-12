using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Z_Dash_Roguelike : SkillAdvancedBase
{
	private readonly int summonId = 5000721;

	private readonly ComboInputBuffer.ActionKey _actionKeyA = ComboInputBuffer.ActionKey.I;

	private CoroutineNode corMain;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	private readonly AimTarget _aimTarget = new AimTarget();

	private RequestComboAttack requestComboAttack;

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
		_aimTarget?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		_actor.EnableImmuneControl();
		_actor.PauseMovementBlock();
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		bool rotateFinish = false;
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		TSVector2 dir = TSVector2.Rotate(_actor.tsTransform.Forward, 45);
		rotateFinish = false;
		_lookAtTarget.BeginLookAtByPos(_actor, _actor.tsTransform.Position + dir.normalized, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_actionKeyA, flushInputedKeys: true);
		ILRuntimeAPI.SummonMonster(_actor, 0, summonId, _actor.tsTransform.Position, dir);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		rotateFinish = false;
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		dir = TSVector2.Rotate(_actor.tsTransform.Forward, -45);
		rotateFinish = false;
		_lookAtTarget.BeginLookAtByPos(_actor, _actor.tsTransform.Position + dir.normalized, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_actionKeyA, flushInputedKeys: true);
		ILRuntimeAPI.SummonMonster(_actor, 0, summonId, _actor.tsTransform.Position, dir);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_actor.DisableImmuneControl();
		_actor.ResumeMovementBlock();
		_skill?.Clear();
	}
}
