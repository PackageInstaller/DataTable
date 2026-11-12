using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_LightShoot2_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Book_Skill05_Wave";

	private string fbx_Energy = "fx_m70001_loop_skill08_tide_start_3m_book";

	private string bullet_tide = "Bullet_70001_Book_Skill05_Tide";

	private long Effect01;

	protected override void OnSkillDisable()
	{
		StopEffect(Effect01);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		AimAtTarget(logicEntity, 270);
		Skill_Summon_LightShoot2_Phase_1 skill_Summon_LightShoot2_Phase_ = this;
		Skill_Summon_LightShoot2_Phase_1 skill_Summon_LightShoot2_Phase_2 = this;
		string fxAlias = fbx_Energy;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Summon_LightShoot2_Phase_.Effect01 = skill_Summon_LightShoot2_Phase_2.PlayEffect(fxAlias, 1f, default, position, rotation);
		yield return WaitTime(1);
		TSVector2 normalized = (TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4)) - _actor.tsTransform.Position).normalized;
		ILRuntimeAPI.ShootByDirection(bullet_tide, _actor, default, normalized);
		StopEffect(Effect01);
		CancelAim();
		yield return WaitTime(1);
	}
}
