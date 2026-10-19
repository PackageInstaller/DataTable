using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using Runtime.Model;

namespace ACT.World.StateObject;

public class InteractRogueChest : InteractObject
{
	private RogueChestData _chestData;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is RogueChestData chestData)
		{
			_chestData = chestData;
			Model<RogueNewModel>.Interface.RegisterRogueChest(this);
			base.InitStateObject(stateId);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_RoomStateChange, RoomStateChange);
			CheckChestState();
		}
	}

	private void RoomStateChange(BaseEventContent content)
	{
		CheckChestState();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
		if (toStateId != 2)
		{
			return;
		}
		List<StateChangeInfo> list = new List<StateChangeInfo>();
		foreach (StateWorldUid connectReward in _chestData.connectRewards)
		{
			list.Add(new StateChangeInfo
			{
				uid = connectReward.value,
				stateId = 1
			});
		}
		if (Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType != RogueRoomType.Cion)
		{
			MonoECS.instance.ruleManager.SharedChangeStates(list.ToArray());
		}
		else
		{
			Model<RogueNewModel>.Interface.SendRogueCoinReward(null);
			string rogueItemDropPath = RuntimeConfigs.data.game.rogueItemDropPath;
			for (int i = 0; i < 15; i++)
			{
				Singleton<DropItemManager>.instance.SpawnDropEffect(97, 0u, (_chestData.dropTrans != null) ? _chestData.dropTrans.position : transform.position, 0u, StateObjectType.None, rogueItemDropPath);
			}
		}
		Model<RogueNewModel>.Interface.RogueRoomOver();
	}

	private void CheckChestState()
	{
		if (Model<RogueNewModel>.Interface.HasRoomReward() && Model<RogueNewModel>.Interface.CurrentRoomState == RogueNewModel.RogueRoomState.ChallengeEnd)
		{
			EnterState(1);
		}
	}

	public override void ReleaseStateObject()
	{
		if (Model<RogueNewModel>.HasInstance())
		{
			Model<RogueNewModel>.Interface.UnregisterRogueChest(this);
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_RoomStateChange, RoomStateChange);
		base.ReleaseStateObject();
	}
}
