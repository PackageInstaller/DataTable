#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50131ShiLaiMuDui;

public class Skill_Die_Summon_LD : SkillSimpleBase
{
	private static readonly List<string> SummonBulletList = new List<string> { "SummonBullet_Common_water", "SummonBullet_Common_earth", "SummonBullet_Common_fire", "SummonBullet_Common_light", "SummonBullet_Common_dark", "SummonBullet_Common_winds", "SummonBullet_Common_nothing" };

	private static readonly List<string> DeathFx = new List<string> { "fx_50071_base_die", "fx_50071_base_die_earth", "fx_50071_base_die_fire", "fx_50071_base_die_light", "fx_50071_base_die_dark", "fx_50071_base_die_wind", "fx_50071_base_die_common" };

	private static readonly int ActionIndex = 0;

	private static readonly string ActionKey = "Summon";

	private string SummonBulletAlias;

	private readonly bool SummonAlignshoot;

	private readonly int SummonAlignShootDelay;

	private readonly int SummonBulletCount = 3;

	private readonly FP SummonDuration = 0;

	private TSVector2 SummonShootPOS;

	private FP SummonShootPOSY = 1.85;

	private TSVector2 SummonMultishootDirection;

	private FP SummonBulletDirectionOffset = 0;

	private readonly FP SummonAngle = 360;

	private readonly FP SummonR = 4;

	private readonly FP SummonIR = 1;

	private List<LogicEntity> ClearEntities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		ClearEntities.Clear();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		NovaLogger.Debug("史莱姆堆技能开始");
		BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return StartCor(SummonLSlim());
	}

	protected IEnumerator SummonLSlim()
	{
		SummonShootPOS = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.6, 0));
		SummonMultishootDirection = SummonShootPOS - new TSVector2(0, 0);
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 500710000);
		if (buffFromTarget != null && buffFromTarget.Count > 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 500710000:
				SummonBulletAlias = SummonBulletList.get_Item(0);
				break;
			case 500710001:
				SummonBulletAlias = SummonBulletList.get_Item(2);
				break;
			case 500710002:
				SummonBulletAlias = SummonBulletList.get_Item(5);
				break;
			case 500710003:
				SummonBulletAlias = SummonBulletList.get_Item(1);
				break;
			case 500710004:
				SummonBulletAlias = SummonBulletList.get_Item(3);
				break;
			case 500710005:
				SummonBulletAlias = SummonBulletList.get_Item(4);
				break;
			case 500710006:
				SummonBulletAlias = SummonBulletList.get_Item(6);
				break;
			default:
				SummonBulletAlias = SummonBulletList.get_Item(0);
				break;
			}
		}
		else
		{
			InterruptSkill();
			yield return null;
		}
		yield return WaitTime(0.9);
		FanMultipleShoot(SummonBulletAlias, AdventureWeapon.MultipleShootStyle.FromLeftToRight, SummonAlignshoot, SummonAlignShootDelay, SummonBulletCount, SummonDuration, SummonShootPOS, SummonShootPOSY, default, SummonBulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, SummonAngle, SummonR, SummonIR);
		yield return WaitShootStatus();
	}
}
