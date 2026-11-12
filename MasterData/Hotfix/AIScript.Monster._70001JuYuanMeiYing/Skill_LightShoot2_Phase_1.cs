using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_LightShoot2_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage2_Skill08_1";

	private string key_Base2 = "Stage2_Skill08_2";

	private string evt_CastSkill = "evt_Wave";

	private string areaEffect_Warning = "Area_70001_Skill08";

	private string areaEffect_Boom = "Area_70001_Skill08_Boom";

	private List<string> BulletList = new List<string> { "Bullet_70001_Skill08_Tide_1", "Bullet_70001_Skill08_Tide_2", "Bullet_70001_Skill08_Tide_3" };

	private List<TSVector2> UpBulletPos = new List<TSVector2>
	{
		new TSVector2(-7.5, 0),
		new TSVector2(0, 0),
		new TSVector2(7.5, 0)
	};

	private List<TSVector2> WavePosStart = new List<TSVector2>();

	private List<TSVector2> WavePosEnd = new List<TSVector2>();

	private TSVector2 center = new TSVector2(0, -6);

	private TSVector2 edge_up = new TSVector2(0, 0);

	private TSVector2 edge_down = new TSVector2(0, -12);

	private TSVector2 edge_left = new TSVector2(-12, -6);

	private TSVector2 edge_right = new TSVector2(12, -6);

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1);
		yield return WaitFrame(20);
		StartCor(Warn());
		StartCor(Wave());
		yield return WaitFrame(42);
		CancelAttack();
		yield return WaitFrame(82);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Warn()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		long AreaName = PlayAreaEffect(areaEffect_Warning, entityPosition);
		yield return WaitTime(2.25);
		TSVector2 sourcePosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
		TSVector2 position = GetAreaEffect(AreaName).tsTransform.Position;
		PlayLinkEffect("fx_m70001_loop_skill08_line", useCustomSource: true, null, sourcePosition, 4, null, position, 0);
		PlayAreaEffect(areaEffect_Boom, position);
	}

	protected IEnumerator Wave()
	{
		LogicEntity Player = GetCurrentPlayer();
		int NextShootPosx = 0;
		int NextShootPosy = 0;
		for (int i = 0; i < 3; i++)
		{
			if (i == 0)
			{
				TSVector2 entityPosition = GetEntityPosition(Player);
				TSVector2 tSVector = UpBulletPos.get_Item(0);
				FP fP = Distance(entityPosition, tSVector);
				for (int j = 0; j < UpBulletPos.Count; j++)
				{
					if (Distance(entityPosition, UpBulletPos.get_Item(j)) <= fP)
					{
						tSVector = UpBulletPos.get_Item(j);
						fP = Distance(entityPosition, UpBulletPos.get_Item(j));
					}
				}
				TSVector2 shootDir = new TSVector2(tSVector.x, -12) - tSVector;
				ILRuntimeAPI.ShootByDirection(BulletList.get_Item(i), _actor, default, shootDir, tSVector, 0);
			}
			if (i == 1)
			{
				TSVector2 entityPosition2 = GetEntityPosition(Player);
				int num = ((entityPosition2.x < 0) ? (-12) : 12);
				int num2 = ((entityPosition2.y < -6) ? (-9) : (-3));
				int num3 = ((entityPosition2.x > 0) ? (-12) : 12);
				int num4 = ((entityPosition2.y > -6) ? (-9) : (-3));
				NextShootPosx = num3;
				NextShootPosy = num4;
				TSVector2 tSVector2 = new TSVector2(num, num2);
				TSVector2 shootDir2 = new TSVector2(-num, num2) - tSVector2;
				ILRuntimeAPI.ShootByDirection(BulletList.get_Item(i), _actor, default, shootDir2, tSVector2, 0);
			}
			if (i == 2)
			{
				TSVector2 tSVector3 = new TSVector2(NextShootPosx, NextShootPosy);
				TSVector2 shootDir3 = new TSVector2(-NextShootPosx, NextShootPosy) - tSVector3;
				ILRuntimeAPI.ShootByDirection(BulletList.get_Item(i), _actor, default, shootDir3, tSVector3, 0);
			}
			yield return WaitFrame(30);
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_CastSkill))
		{
			DispatchCustomEvent(evt_CastSkill, isSelfEvent: false);
		}
	}
}
