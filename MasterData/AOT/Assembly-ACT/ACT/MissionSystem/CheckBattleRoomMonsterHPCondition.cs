using ACT.Battle;
using ACT.World.Asset;
using ACT.World.StateObject;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.MissionSystem;

public class CheckBattleRoomMonsterHPCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	private bool CheckCondition()
	{
		CheckBattleRoomMonsterHPConditionParam checkBattleRoomMonsterHPConditionParam = Param as CheckBattleRoomMonsterHPConditionParam;
		if (!StateWorldAsset.TryGetWorldAssetBySwid(checkBattleRoomMonsterHPConditionParam.battleRoomId, out var stateWorldAsset))
		{
			return false;
		}
		if (!(stateWorldAsset.stateObjectBase is InteractBattleRoom interactBattleRoom))
		{
			return false;
		}
		if (!interactBattleRoom.TryGetMonsterHpPercent(out var hpPercent))
		{
			return false;
		}
		int num = Mathf.RoundToInt(hpPercent * 100f);
		return checkBattleRoomMonsterHPConditionParam.comparer switch
		{
			ACT.Battle.Condition.Greater => num > checkBattleRoomMonsterHPConditionParam.hpPercent, 
			ACT.Battle.Condition.Less => num < checkBattleRoomMonsterHPConditionParam.hpPercent, 
			ACT.Battle.Condition.Equal => num == checkBattleRoomMonsterHPConditionParam.hpPercent, 
			ACT.Battle.Condition.GreaterAndEqual => num >= checkBattleRoomMonsterHPConditionParam.hpPercent, 
			ACT.Battle.Condition.LessAndEqual => num <= checkBattleRoomMonsterHPConditionParam.hpPercent, 
			_ => false, 
		};
	}
}
