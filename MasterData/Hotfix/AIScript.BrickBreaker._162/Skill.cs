using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.BrickBreaker._162;

public class Skill : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(821620101);
		if (buffNumByID > 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(821620101);
			Singleton<BrickBreakerManager>.Instance.EnhanceAllEnergyBalls(buffNumByID, "Actor/Character/16201/BreakOut/Combo/AreaEffect_162_LeiDianZhongJian_Fall_Skil_Main_BO");
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Area");
		PlayUltra2Area();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public void OnUpdate()
	{
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
	}

	private void PlayUltra2Area()
	{
		TSVector2 forwardBrickOrMonsterPos = GetForwardBrickOrMonsterPos();
		ILRuntimeAPI.PlayAreaEffect(_actor, "Actor/Character/16201/BreakOut/Combo/AreaEffect_162_LeiDianZhongJian_Fall_Skil_Main_BO2", forwardBrickOrMonsterPos);
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
