using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private List<int> RotateList = new List<int> { -90, 180, 180, 90, 0, -90 };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 220);
		if (GetBuffNum(_actor, 503010000) >= 6)
		{
			List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
			for (int i = 0; i < targetByTeammateIndex.Count; i++)
			{
				LogicEntity target = targetByTeammateIndex.get_Item(i);
				AddBuffToTarget(target, 503010001);
			}
		}
		else if (GetPlaceHolderPosition("MaoDaSquareScene") != new TSVector2(0, 0))
		{
			DoSpawnNuji02();
			DoSpawnNuji02();
		}
		else
		{
			DoSpawnNuji01();
			DoSpawnNuji01();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoSpawnNuji01()
	{
		int buffNum = GetBuffNum(_actor, 503010000);
		TSVector2 tSVector = new TSVector2(0, 15);
		List<int> list = new List<int> { 60, 30, -30, -120, -180, -270 };
		TSVector2 spawnPosition = RotateTo(tSVector, list.get_Item(buffNum));
		int num = RotateList.get_Item(buffNum);
		TSVector2 spawnDirection = RotateTo(tSVector, num);
		SummonTeammate(1, spawnPosition, spawnDirection);
		AddBuffToTarget(_actor, 503010000);
	}

	protected void DoSpawnNuji02()
	{
		int buffNum = GetBuffNum(_actor, 503010000);
		List<int> list = new List<int> { 12, -12, -12, 12, -5, 5 };
		List<int> list2 = new List<int> { 9, -9, -3, 3, 15, -15 };
		TSVector2 tSVector = new TSVector2(list.get_Item(buffNum), list2.get_Item(buffNum));
		List<int> list3 = new List<int> { 145, 145, 165, 165, 162, 162 };
		TSVector2 spawnDirection = RotateTo(tSVector, list3.get_Item(buffNum));
		SummonTeammate(1, tSVector, spawnDirection);
		AddBuffToTarget(_actor, 503010000);
	}
}
