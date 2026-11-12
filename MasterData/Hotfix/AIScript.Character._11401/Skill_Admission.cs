using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11401;

public class Skill_Admission : SkillAdvancedBase
{
	private const ComboInputBuffer.ActionKey _actionKey = ComboInputBuffer.ActionKey.H;

	private readonly FP backDistance = 6;

	private FP dashSpeed = 30;

	private readonly FP duration = 0.3;

	private readonly FP distance = 0.01;

	private CoroutineNode corMain;

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
	}

	private IEnumerator DoMainLogic()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0f));
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		if (duration > 0f && distance > 0f)
		{
			_actor.Dodge(tSVector, distance, duration, null, null, comboWithAttack: true);
		}
		BeginAttack(ComboInputBuffer.ActionKey.H, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, () =>
		{
			_skill?.Clear();
		}, () =>
		{
			_skill?.Clear();
		});
	}

	private bool SearchValidPoint(ref TSVector2 desPos)
	{
		desPos = _actor.tsTransform.Position - backDistance * _actor.tsTransform.Forward;
		if (_actor.QueryPositionReachable(desPos))
		{
			return true;
		}
		return false;
	}
}
