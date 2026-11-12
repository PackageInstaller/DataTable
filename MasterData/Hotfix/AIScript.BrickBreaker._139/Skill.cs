using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.BrickBreaker._139;

public class Skill : SkillSimpleBase
{
	private bool _castWithFullSoul = true;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "BO_Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCustomEvent("AreaEffect");
		if (_castWithFullSoul)
		{
			ConsumeAllSouls();
			PlayUltra2Area();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public void OnUpdate()
	{
	}

	private void ShootIceEdgeFan()
	{
		TSVector2 paddleOrigin = GetPaddleOrigin();
		int num = 4;
		FP fP = ((num > 1) ? (Config.fanAngle_Skill / (num - 1)) : ((FP)0));
		FP fP2 = -Config.fanAngle_Skill / 2;
		for (int i = 0; i < num; i++)
		{
			TSVector2 shootDir = TSVector2.Rotate(TSVector2.up, fP2 + fP * i);
			ILRuntimeAPI.ShootByDirection("Bullet_13901_Sup_P21_l90_BO", _actor, 0, shootDir, paddleOrigin, Config.bulletPositionY);
		}
	}

	private void PlayUltra2Area()
	{
		TSVector2 forwardBrickOrMonsterPos = GetForwardBrickOrMonsterPos();
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13901_Ultra_Weapon_BO", forwardBrickOrMonsterPos);
	}

	private void ConsumeAllSouls()
	{
		_actor.buffComponent.RemoveBuffByBuffId(13900001);
	}

	private TSVector2 GetPaddleOrigin()
	{
		PaddleCollider currentPaddleCollider = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider;
		if (!(currentPaddleCollider != null))
		{
			return _actor.tsTransform.Position;
		}
		return currentPaddleCollider.tsTransform.Position;
	}

	private TSVector2 GetForwardBrickOrMonsterPos()
	{
		TSVector2 origin = _actor.tsTransform.Position;
		TSVector2 direction = TSVector2.up;
		int layerMask = 65792;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var hitInfo, Config.forwardDetectDistance, layerMask))
		{
			return hitInfo.point;
		}
		return origin + direction * 20;
	}
}
