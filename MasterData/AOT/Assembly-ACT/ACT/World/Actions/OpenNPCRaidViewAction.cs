using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class OpenNPCRaidViewAction : InteractAction
{
	public int TypeId = 1;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_NPCRAID, TypeId);
	}
}
