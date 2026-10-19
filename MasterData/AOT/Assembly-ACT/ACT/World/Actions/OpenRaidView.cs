using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class OpenRaidView : InteractAction
{
	[Header("要开启RaidEntranceData表ID")]
	public int id;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
		{
			RaidEntranceId = id
		});
		return UniTask.CompletedTask;
	}
}
