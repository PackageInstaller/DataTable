using System;
using ACT.Battle;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionEnterBackRoom : NpcInteractAction
{
	public override int ActionId => NpcInteractActionIds.EnterBackRoom;

	protected override async UniTask DoAction()
	{
		MonoECS.instance.PushPause();
		await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Lounge);
		MonoECS.instance.PopPause();
		await base.DoAction();
	}
}
