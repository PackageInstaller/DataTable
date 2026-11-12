using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12001;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string comboTag_B1 = "120_B1";

	private string event_Shoot = "120_B1P1";

	private const string bullet = "Bullet_12001_B1_Skill_Garland_Near";

	private const string bullet_Big_P1 = "Bullet_12001_B1P7_Skill_Garland_BigNear";

	private const string bullet_Big_P3 = "Bullet_12001_B1P7_Skill_Garland_BigMid";

	private const string bullet_Big_P1_P3 = "Bullet_12001_B1P7_Skill_Garland_BigMid_P1&3";

	private const string bullet_Big_P4 = "Bullet_12001_B1P7_Skill_Garland_BigNear";

	private const string bullet_Big_P1_P4 = "Bullet_12001_B1P7_Skill_Garland_BigNear";

	private FP radius_Inner = 5;

	private FP radius_Outer = 5;

	private FP duration = 8;

	private FP rotateSpeed_Base = 150;

	private FP rotateSpeed_Fast = 190;

	private FP baseSkillTime = 12;

	private const int perkId_1 = 1200101;

	private const int perkId_3 = 1200103;

	private const int perkId_4 = 1200104;

	private CoroutineNode corMain;

	public override FP BaseSkillTime => baseSkillTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void OnUpdate()
	{
		_actor.LookAt(_actor.tsTransform.Position + _actor.tsTransform.Forward, 0);
	}

	private IEnumerator DoMainLogic()
	{
		SkillScript_Skill skillScript_Skill = this;
		string actionTag = comboTag_B1;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		yield break;
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals(event_Shoot))
		{
			bool perk = GetPerk(1200101);
			bool perk2 = GetPerk(1200103);
			bool perk3 = GetPerk(1200104);
			string alias = "Bullet_12001_B1_Skill_Garland_Near";
			if (perk & perk2)
			{
				alias = "Bullet_12001_B1P7_Skill_Garland_BigMid_P1&3";
			}
			else if (perk & perk3)
			{
				alias = "Bullet_12001_B1P7_Skill_Garland_BigNear";
			}
			else if (perk)
			{
				alias = "Bullet_12001_B1P7_Skill_Garland_BigNear";
			}
			else if (perk2)
			{
				alias = "Bullet_12001_B1P7_Skill_Garland_BigMid";
			}
			else if (perk3)
			{
				alias = "Bullet_12001_B1P7_Skill_Garland_BigNear";
			}
			bool perk4 = GetPerk(1200103);
			SpawnGarland(alias, radius_Inner, perk4);
			if (GetPerk(1200103))
			{
				SpawnGarland(alias, radius_Inner, perk4);
			}
			if (GetPerk(1200104))
			{
				SpawnGarland(alias, radius_Inner, perk4);
				SpawnGarland(alias, radius_Inner, perk4);
			}
		}
	}

	private void SpawnGarland(string alias, FP radius, bool fast)
	{
		AdventureRotateWeapon adventureRotateWeapon = ILRuntimeAPI.ShootRotateWepon(alias, _actor, null, _actor.tsTransform.Forward);
		if (!(adventureRotateWeapon == null))
		{
			adventureRotateWeapon._radius = radius;
			adventureRotateWeapon._duration = duration;
			adventureRotateWeapon.rotateSpeed = (fast ? rotateSpeed_Fast : rotateSpeed_Base);
		}
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}
}
