using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Danmu2_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Book_Skill03_Bullet";

	private string fbxEnergy = "fx_m70001_base_skill10_02_follow";

	private string bulletDanmu = "Bullet_70001_Book_Skill03";

	private long Effect01;

	protected override void OnSkillDisable()
	{
		StopEffect(Effect01);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		StopEffect(Effect01);
	}

	protected override IEnumerator DoMainLogic()
	{
		long Effect01 = PlayEffect(fbxEnergy, 1f, 1, _actor.tsTransform.Position);
		yield return WaitTime(1.5);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 normalized = (logicEntity.tsTransform.Position - _actor.tsTransform.Position).normalized;
		string bulletAlias = bulletDanmu;
		AdventureActor actor = _actor;
		FP positionY = 1;
		ILRuntimeAPI.ShootByDirection(bulletAlias, actor, default, normalized, default, positionY);
		StopEffect(Effect01);
		yield return WaitTime(0.5);
	}
}
