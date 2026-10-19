using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class ChangePlatTestAim : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		IExposedTable obj = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData as IExposedTable;
		obj.GetValue("Elevator", out var value);
		obj.GetValue("ElevatorLayer", out var value2);
		obj.GetValue("ElevatorLayerSwuid", out var value3);
		if (MonoECS.instance.ruleManager.SharedGetState(value3) == 0)
		{
			MonoECS.instance.ruleManager.TryGetWorldStateAsset(value, out var asset);
			(asset.stateObjectBase as InteractStandardElevator).RunElevator(value2);
		}
		else
		{
			GameUtility.OpenToolTip(286);
		}
		return UniTask.CompletedTask;
	}
}
