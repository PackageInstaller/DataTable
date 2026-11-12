using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Laser2_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Stage2_Skill11";

	private string evt_CastSkill = "evt_Laser";

	private List<Tuple<TSVector2, TSVector2>> shootPoints = new List<Tuple<TSVector2, TSVector2>>
	{
		new Tuple<TSVector2, TSVector2>(new TSVector2(-8, 0), new TSVector2(-8, -12)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(12, -3), new TSVector2(-12, -3)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(0, -12), new TSVector2(0, 0)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(8, 0), new TSVector2(8, -12)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(-12, -9), new TSVector2(12, -9)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(8, -12), new TSVector2(8, 0)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(0, 0), new TSVector2(0, -12)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(-12, -3), new TSVector2(12, -3)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(-8, -12), new TSVector2(-8, 0)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(12, -9), new TSVector2(-12, -9))
	};

	private List<Tuple<string, string, string>> shootBullets = new List<Tuple<string, string, string>>
	{
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop", "Bullet_70001_Skill11_Laser_8m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop", "Bullet_70001_Skill11_Laser_6m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop", "Bullet_70001_Skill11_Laser_8m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop", "Bullet_70001_Skill11_Laser_8m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop", "Bullet_70001_Skill11_Laser_6m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop", "Bullet_70001_Skill11_Laser_8m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop", "Bullet_70001_Skill11_Laser_8m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop", "Bullet_70001_Skill11_Laser_6m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop", "Bullet_70001_Skill11_Laser_8m"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop", "Bullet_70001_Skill11_Laser_6m")
	};

	private List<Tuple<TSVector2, TSVector2>> shootPoints2 = new List<Tuple<TSVector2, TSVector2>>
	{
		new Tuple<TSVector2, TSVector2>(new TSVector2(-8, 0), new TSVector2(-8, -12)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(12, -3), new TSVector2(-12, -3)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(0, -12), new TSVector2(0, 0)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(8, 0), new TSVector2(8, -12)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(-12, -9), new TSVector2(12, -9)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(8, -12), new TSVector2(8, 0)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(0, 0), new TSVector2(0, -12)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(-12, -3), new TSVector2(12, -3)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(-8, -12), new TSVector2(-8, 0)),
		new Tuple<TSVector2, TSVector2>(new TSVector2(12, -9), new TSVector2(-12, -9))
	};

	private List<Tuple<string, string, string>> shootBullets2 = new List<Tuple<string, string, string>>
	{
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop_Slow", "Bullet_70001_Skill11_Laser_8m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop_Slow", "Bullet_70001_Skill11_Laser_6m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop_Slow", "Bullet_70001_Skill11_Laser_8m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop_Slow", "Bullet_70001_Skill11_Laser_8m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop_Slow", "Bullet_70001_Skill11_Laser_6m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop_Slow", "Bullet_70001_Skill11_Laser_8m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop_Slow", "Bullet_70001_Skill11_Laser_8m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop_Slow", "Bullet_70001_Skill11_Laser_6m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_8m_Start", "Bullet_70001_Skill11_Ball_8m_Loop_Slow", "Bullet_70001_Skill11_Laser_8m_Slow"),
		new Tuple<string, string, string>("Bullet_70001_Skill11_Ball_6m_Start", "Bullet_70001_Skill11_Ball_6m_Loop_Slow", "Bullet_70001_Skill11_Laser_6m_Slow")
	};

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base);
		yield return WaitFrame(53);
		StartCor(ShootLoop());
		yield return WaitFrame(180);
		CancelAttack();
		StartCor(ShootAll());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator ShootLoop()
	{
		if (GetMonsterTagValue(_actor, 1) == "Lv1" || GetMonsterTagValue(_actor, 1) == "Lv2" || GetMonsterTagValue(_actor, 1) == "Lv3")
		{
			for (int i = 0; i < 4; i++)
			{
				TSVector2 from = shootPoints2.get_Item(i).Item1;
				TSVector2 to = shootPoints2.get_Item(i).Item2;
				TSVector2 dir = (to - from).normalized;
				string item = shootBullets2.get_Item(i).Item1;
				string Bullet02 = shootBullets2.get_Item(i).Item2;
				string Bullet3 = shootBullets2.get_Item(i).Item3;
				ILRuntimeAPI.ShootByDirection(item, _actor, default, dir, from, 0.5, to);
				yield return WaitFrame(15);
				ILRuntimeAPI.ShootByDirection(Bullet02, _actor, default, dir, from, 0.5, to);
				ILRuntimeAPI.ShootByDirection(Bullet3, _actor, default, dir, from, 0.5, to);
				yield return WaitFrame(15);
			}
		}
		else
		{
			for (int i = 0; i < 6; i++)
			{
				TSVector2 dir = shootPoints.get_Item(i).Item1;
				TSVector2 to = shootPoints.get_Item(i).Item2;
				TSVector2 from = (to - dir).normalized;
				string item2 = shootBullets.get_Item(i).Item1;
				string Bullet3 = shootBullets.get_Item(i).Item2;
				string Bullet02 = shootBullets.get_Item(i).Item3;
				ILRuntimeAPI.ShootByDirection(item2, _actor, default, from, dir, 0.5, to);
				yield return WaitFrame(15);
				ILRuntimeAPI.ShootByDirection(Bullet3, _actor, default, from, dir, 0.5, to);
				ILRuntimeAPI.ShootByDirection(Bullet02, _actor, default, from, dir, 0.5, to);
				yield return WaitFrame(15);
			}
		}
	}

	protected IEnumerator ShootAll()
	{
		if (GetMonsterTagValue(_actor, 1) == "Lv1" || GetMonsterTagValue(_actor, 1) == "Lv2" || GetMonsterTagValue(_actor, 1) == "Lv3")
		{
			for (int i = 4; i < 7; i++)
			{
				TSVector2 item = shootPoints2.get_Item(i).Item1;
				TSVector2 item2 = shootPoints2.get_Item(i).Item2;
				TSVector2 normalized = (item2 - item).normalized;
				string item3 = shootBullets2.get_Item(i).Item1;
				AdventureActor actor = _actor;
				TSVector2 targetPosition = item2;
				ILRuntimeAPI.ShootByDirection(item3, actor, default, normalized, item, 0.5, targetPosition);
			}
			yield return WaitFrame(15);
			for (int j = 4; j < 7; j++)
			{
				TSVector2 item4 = shootPoints2.get_Item(j).Item1;
				TSVector2 item5 = shootPoints2.get_Item(j).Item2;
				TSVector2 normalized2 = (item5 - item4).normalized;
				string item6 = shootBullets2.get_Item(j).Item2;
				string item7 = shootBullets2.get_Item(j).Item3;
				AdventureActor actor2 = _actor;
				TSVector2 targetPosition = item5;
				ILRuntimeAPI.ShootByDirection(item6, actor2, default, normalized2, item4, 0.5, targetPosition);
				AdventureActor actor3 = _actor;
				targetPosition = item5;
				ILRuntimeAPI.ShootByDirection(item7, actor3, default, normalized2, item4, 0.5, targetPosition);
			}
		}
		else
		{
			for (int k = 6; k < 10; k++)
			{
				TSVector2 item8 = shootPoints.get_Item(k).Item1;
				TSVector2 item9 = shootPoints.get_Item(k).Item2;
				TSVector2 normalized3 = (item9 - item8).normalized;
				string item10 = shootBullets.get_Item(k).Item1;
				AdventureActor actor4 = _actor;
				TSVector2 targetPosition = item9;
				ILRuntimeAPI.ShootByDirection(item10, actor4, default, normalized3, item8, 0.5, targetPosition);
			}
			yield return WaitFrame(15);
			for (int l = 6; l < 10; l++)
			{
				TSVector2 item11 = shootPoints.get_Item(l).Item1;
				TSVector2 item12 = shootPoints.get_Item(l).Item2;
				TSVector2 normalized4 = (item12 - item11).normalized;
				string item13 = shootBullets.get_Item(l).Item2;
				string item14 = shootBullets.get_Item(l).Item3;
				AdventureActor actor5 = _actor;
				TSVector2 targetPosition = item12;
				ILRuntimeAPI.ShootByDirection(item13, actor5, default, normalized4, item11, 0.5, targetPosition);
				AdventureActor actor6 = _actor;
				targetPosition = item12;
				ILRuntimeAPI.ShootByDirection(item14, actor6, default, normalized4, item11, 0.5, targetPosition);
			}
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
