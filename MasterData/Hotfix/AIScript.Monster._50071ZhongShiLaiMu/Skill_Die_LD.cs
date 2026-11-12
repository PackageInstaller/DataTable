#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50071ZhongShiLaiMu;

public class Skill_Die_LD : SkillSimpleBase
{
	private string tag1 = "Hard";

	private LogicEntity master;

	private readonly string mSlimeCountTag = "mSlimeCount";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly int _actionIndex;

	private readonly string SummonBulletAlias = "SummonBullet_DaShiLaiMuOnly";

	private List<LogicEntity> ClearEntities = new List<LogicEntity>();

	private List<LogicEntity> SummonList = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		ClearEntities.Clear();
		SummonList.Clear();
	}

	protected override void OnSkillDisable()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction != null && targetsByFaction.Count > 0)
		{
			foreach (LogicEntity item in targetsByFaction)
			{
				if (GetLogicTagToggleValue(item, "isMaster"))
				{
					master = item;
				}
			}
		}
		int num = (int)(long)GetLogicTagFpValue(master, mSlimeCountTag);
		SetLogicTagFpValue(master, mSlimeCountTag, num += 1);
		NovaLogger.Debug("中史莱姆.分裂.死亡修改标签");
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(DeathAction());
		yield return StartCor(SummonLSlim());
		ClearEntities.Add(_actor);
		ClearActors(ClearEntities);
	}

	protected IEnumerator DeathAction()
	{
		BeginAttack(_actionIndex, _actionKeys, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		SendDeclareDeadEvent();
		yield return WaitTime(0.15);
		SetHideModelEnable();
	}

	protected IEnumerator SummonLSlim()
	{
		TSVector2 position = GetPosition();
		TSVector2 multiShootDirection = position - TSVector2.zero;
		FP angle = ((!(Distance(position, GetEntityPositionObsoleted(master)) < 5)) ? ((FP)200) : ((FP)90));
		if ((_actor as MonsterAdventureActor).monsterInfo.Tag1 == tag1)
		{
			FanMultipleShoot(SummonBulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0.08, position, 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 3, 1);
			yield return WaitTime(1.2);
		}
	}
}
