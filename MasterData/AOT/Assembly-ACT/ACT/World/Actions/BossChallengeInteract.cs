using ACT.Battle.Configs;
using ACT.Core;
using ACT.UI;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class BossChallengeInteract : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		BossChallengeData bossChallengeData = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData as BossChallengeData;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
		{
			RaidEntranceId = RuntimeConfigs.data.worldBossMonsters[bossChallengeData.bossPoint].worldBossRaidId
		});
		return UniTask.CompletedTask;
	}
}
