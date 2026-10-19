using ACT.Battle.Configs;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class OpenTempleView : InteractAction
{
	[Header("要开启的神庙ID")]
	public int id;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEMPLEENTRANCE, new TempleEntranceViewData
		{
			templeId = id
		});
		G.service.UnlockTemple(id, (bool t) =>
		{
			Model<TempleModel>.Interface.OnTempleUnlocked(id);
		});
		return UniTask.CompletedTask;
	}
}
