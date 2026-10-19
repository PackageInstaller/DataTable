using ACT.Battle;
using ACT.Battle.Configs;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class UnlockHiddenRoom : InteractAction
{
	public int stateId;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		HiddenRoomData obj = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData as HiddenRoomData;
		int stateWorldAssetUid = obj.stateWorldAssetUid;
		int lightHouseId = obj.lightHouseId;
		_ = obj.unlockFogId;
		int num = MonoECS.instance.ruleManager.SharedGetState(stateWorldAssetUid);
		int num2 = MonoECS.instance.ruleManager.SharedGetState(lightHouseId);
		if (num == 0 && num2 == -2)
		{
			stateObjectBase.NetEnterState(stateId).Forget();
		}
		return UniTask.CompletedTask;
	}
}
