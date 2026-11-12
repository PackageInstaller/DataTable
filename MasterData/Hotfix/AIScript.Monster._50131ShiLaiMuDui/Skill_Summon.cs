#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50131ShiLaiMuDui;

public class Skill_Summon : SkillSimpleBase
{
	private readonly int SummonActorID = 9999904;

	private readonly int SummonGroupID = 9999904;

	private TSVector2 RelativePoint01 = new TSVector2(2, 0);

	private TSVector2 RelativePoint02 = new TSVector2(1, 1);

	private TSVector2 RelativePoint03 = new TSVector2(0, 2);

	private TSVector2 SpawnDirection;

	private TSVector2 Origin;

	private TSVector2 Forward;

	private TSVector2 SpawnPosition01;

	private TSVector2 SpawnPosition02;

	private TSVector2 SpawnPosition03;

	private int SummonCounstA;

	private int SummonCounstB;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SpawnDirection = GetForward();
		Origin = GetPosition();
		Forward = GetForward();
		SpawnPosition01 = TransLocalPosToWorldPos(Origin, Forward, RelativePoint01);
		SpawnPosition02 = TransLocalPosToWorldPos(Origin, Forward, RelativePoint02);
		SpawnPosition03 = TransLocalPosToWorldPos(Origin, Forward, RelativePoint03);
		SummonMonster(SummonActorID, SummonGroupID, SpawnPosition01, SpawnDirection);
		SummonMonster(SummonActorID, SummonGroupID, SpawnPosition02, SpawnDirection);
		SummonMonster(SummonActorID, SummonGroupID, SpawnPosition03, SpawnDirection);
		yield return WaitTime(2);
		SummonCounstA = GetMonsterSummonNum(_actor, 9999904);
		SummonCounstB = GetMonsterSummonNum(_actor, 9999904, iAlive: false);
		NovaLogger.Debug("本次召唤,检测到存活的怪物数量为:" + SummonCounstA + ",死亡的怪物数量为:" + SummonCounstB);
		yield return WaitTime(1);
	}
}
