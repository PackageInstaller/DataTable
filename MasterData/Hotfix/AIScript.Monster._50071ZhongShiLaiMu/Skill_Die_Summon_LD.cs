#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50071ZhongShiLaiMu;

public class Skill_Die_Summon_LD : SkillSimpleBase
{
	private List<string> NoSummonTag = new List<string> { "Infinity", "VampireSurvivor" };

	private readonly List<string> SummonBulletList = new List<string> { "SummonBullet_Common_water", "SummonBullet_Common_earth", "SummonBullet_Common_fire", "SummonBullet_Common_light", "SummonBullet_Common_dark", "SummonBullet_Common_winds", "SummonBullet_Common_nothing" };

	private readonly List<string> DeathFx = new List<string> { "fx_50071_base_die", "fx_50071_base_die_earth", "fx_50071_base_die_fire", "fx_50071_base_die_light", "fx_50071_base_die_dark", "fx_50071_base_die_wind", "fx_50071_base_die_common" };

	private string SummonBulletAlias;

	private readonly bool SummonAlignshoot;

	private readonly int SummonAlignShootDelay;

	private readonly int SummonBulletCount = 2;

	private readonly FP SummonDuration = 0.08;

	private TSVector2 SummonShootPOS;

	private FP SummonShootPOSY = 0;

	private TSVector2 SummonMultishootDirection;

	private FP SummonBulletDirectionOffset = 0;

	private readonly FP SummonAngle = 90;

	private readonly FP SummonR = 3;

	private readonly FP SummonIR = 1;

	private List<LogicEntity> ClearEntities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		ClearEntities.Clear();
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("中史莱姆,技能结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return StartCor(SummonLSlim());
		ClearEntities.Add(_actor);
		ClearActors(ClearEntities);
	}

	protected IEnumerator SummonLSlim()
	{
		SummonShootPOS = GetPosition();
		SummonMultishootDirection = SummonShootPOS - new TSVector2(0, 0);
		int num = (int)(long)GetLogicTagFpValue(_actor, "slimeType");
		if (num >= 0)
		{
			switch (num)
			{
			case 0:
				SummonBulletAlias = SummonBulletList.get_Item(0);
				PlayEffect(DeathFx.get_Item(0), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				NovaLogger.Debug("中史莱姆,使用水");
				break;
			case 1:
				SummonBulletAlias = SummonBulletList.get_Item(2);
				PlayEffect(DeathFx.get_Item(2), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			case 2:
				SummonBulletAlias = SummonBulletList.get_Item(5);
				PlayEffect(DeathFx.get_Item(5), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			case 3:
				SummonBulletAlias = SummonBulletList.get_Item(1);
				PlayEffect(DeathFx.get_Item(1), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			case 4:
				SummonBulletAlias = SummonBulletList.get_Item(3);
				PlayEffect(DeathFx.get_Item(3), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			case 5:
				SummonBulletAlias = SummonBulletList.get_Item(4);
				PlayEffect(DeathFx.get_Item(4), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			case 6:
				SummonBulletAlias = SummonBulletList.get_Item(6);
				PlayEffect(DeathFx.get_Item(6), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			default:
				SummonBulletAlias = SummonBulletList.get_Item(0);
				PlayEffect(DeathFx.get_Item(0), 1f, default, SummonShootPOS, GetRotation(), 1f, actorScale: true);
				break;
			}
		}
		else
		{
			NovaLogger.Debug("中史莱姆没有出生BUFF标签，死亡技能中断");
			InterruptSkill();
			yield return null;
		}
		if (!NoSummonCondition())
		{
			FanMultipleShoot(SummonBulletAlias, AdventureWeapon.MultipleShootStyle.FromLeftToRight, SummonAlignshoot, SummonAlignShootDelay, SummonBulletCount, SummonDuration, SummonShootPOS, SummonShootPOSY, SummonMultishootDirection, SummonBulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, SummonAngle, SummonR, SummonIR);
			yield return WaitTime(1.2);
		}
	}

	private bool NoSummonCondition()
	{
		bool result = false;
		string monsterTagValue = GetMonsterTagValue(_actor, 2);
		if (NoSummonTag.Contains(monsterTagValue))
		{
			NovaLogger.Debug("中史莱姆.特殊需求.无召唤行为");
			result = true;
		}
		return result;
	}
}
