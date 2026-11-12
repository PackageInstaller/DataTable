using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Dash_Cut : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey _actionKeyStart = ComboInputBuffer.ActionKey.H;

	private readonly ComboInputBuffer.ActionKey _actionKeyA = ComboInputBuffer.ActionKey.K;

	private readonly ComboInputBuffer.ActionKey _actionKeyB;

	private readonly FP loopTime = 0;

	private readonly FP distance = 0.25;

	private CoroutineNode corMain;

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
		bool rotateFinish = false;
		LogicEntity target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
		{
			rotateFinish = true;
		});
		while (!rotateFinish)
		{
			yield return null;
		}
		RequestComboAttack requestComboAttack = BeginAttack(_actionKeyStart, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		requestComboAttack = BeginAttack(_actionKeyB);
		TSVector2 desPos = default;
		SearchValidPoint(ref desPos);
		_actor.Teleport(desPos);
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
		requestComboAttack = BeginAttack(_actionKeyA, flushInputedKeys: true);
		while (!requestComboAttack.isAnticipationEnd)
		{
			yield return null;
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(loopTime));
		requestComboAttack = BeginAttack(_actionKeyB);
		while (!requestComboAttack.isComboFinish)
		{
			yield return null;
		}
		_skill?.Clear();
	}

	private bool SearchValidPoint(ref TSVector2 desPos)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		desPos = activedPlayerActor.tsTransform.Position - distance * activedPlayerActor.tsTransform.Forward;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = TrueSyncExtensions.RandomPointInsideFan(activedPlayerActor.tsTransform.Position, 0.25, 0.5, 180, 360);
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		desPos = activedPlayerActor.tsTransform.Position;
		return true;
	}
}
