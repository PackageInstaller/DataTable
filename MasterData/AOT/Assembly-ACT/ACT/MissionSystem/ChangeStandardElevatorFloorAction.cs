using System.Threading;
using ACT.Battle;
using ACT.World.Asset;
using ACT.World.StateObject;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class ChangeStandardElevatorFloorAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		ChangeStandardElevatorFloorActionParam changeStandardElevatorFloorActionParam = Param as ChangeStandardElevatorFloorActionParam;
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(changeStandardElevatorFloorActionParam.swid, out var asset);
		if (asset != null && asset.data is StandardElevatorData standardElevatorData)
		{
			StateWorldUid lockFlag = standardElevatorData.layers[changeStandardElevatorFloorActionParam.floor].lockFlag;
			if (MonoECS.instance.ruleManager.SharedGetState(lockFlag) == 0)
			{
				(asset.stateObjectBase as InteractStandardElevator)?.RunElevator(changeStandardElevatorFloorActionParam.floor);
			}
		}
		return UniTask.CompletedTask;
	}
}
