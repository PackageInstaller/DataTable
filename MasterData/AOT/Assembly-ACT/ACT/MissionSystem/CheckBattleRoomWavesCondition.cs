using ACT.Battle;
using ACT.World.Asset;
using ACT.World.StateObject;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class CheckBattleRoomWavesCondition : MissionCondition
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
		CheckBattleRoomWavesConditionParam checkBattleRoomWavesConditionParam = Param as CheckBattleRoomWavesConditionParam;
		if (!StateWorldAsset.TryGetWorldAssetBySwid(checkBattleRoomWavesConditionParam.battleRoomId, out var stateWorldAsset))
		{
			return false;
		}
		if (!(stateWorldAsset.stateObjectBase is InteractBattleRoom { Wave: var wave }))
		{
			return false;
		}
		return checkBattleRoomWavesConditionParam.comparer switch
		{
			ACT.Battle.Condition.Greater => wave > checkBattleRoomWavesConditionParam.waves, 
			ACT.Battle.Condition.Less => wave < checkBattleRoomWavesConditionParam.waves, 
			ACT.Battle.Condition.Equal => wave == checkBattleRoomWavesConditionParam.waves, 
			ACT.Battle.Condition.GreaterAndEqual => wave >= checkBattleRoomWavesConditionParam.waves, 
			ACT.Battle.Condition.LessAndEqual => wave <= checkBattleRoomWavesConditionParam.waves, 
			_ => false, 
		};
	}
}
