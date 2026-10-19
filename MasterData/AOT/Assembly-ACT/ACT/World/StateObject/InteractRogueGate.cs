using System.Collections.Generic;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractRogueGate : InteractObject
{
	[OdinSerialize]
	public List<GameObject> _gates = new List<GameObject>();

	private RogueGateData _data;

	private int _getdataIndex;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is RogueGateData data)
		{
			_data = data;
			base.InitStateObject(stateId);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_RoomStateChange, RoomStateChange);
			CheckOpenGate();
		}
	}

	private void RoomStateChange(BaseEventContent content)
	{
		CheckOpenGate();
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId != 1)
		{
			return;
		}
		base.HandleEnterInteract();
		RepeatedField<RogueRoomType> repeatedField = Model<RogueNewModel>.Interface.Info?.GameInfo?.RoomInfo?.NextRoomTypes;
		if (repeatedField != null && _getdataIndex >= 0 && _getdataIndex < repeatedField.Count)
		{
			Transform interactTipTransform = GetInteractTipTransform();
			if (interactTipTransform == null)
			{
				interactTipTransform = transform;
			}
			RogueGateBubbleEvent evt = Singleton<EventManager>.instance.GetEvt<RogueGateBubbleEvent>();
			evt.GateId = swid;
			evt.Target = interactTipTransform;
			evt.RoomType = repeatedField[_getdataIndex];
			evt.WorldOffset = new Vector3(0f, 3f, 0f);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueOpenGateBubble, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 1)
		{
			base.HandleExitInteract();
			DispatchCloseBubbleEvent();
		}
	}

	private void DispatchCloseBubbleEvent()
	{
		RogueGateBubbleEvent evt = Singleton<EventManager>.instance.GetEvt<RogueGateBubbleEvent>();
		evt.GateId = swid;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueCloseGateBubble, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void CheckOpenGate()
	{
		int gateIndex = _data.gateIndex;
		if (Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.NextRoomTypes.Count > 1)
		{
			if ((gateIndex == 0 || gateIndex == 2) && Model<RogueNewModel>.Interface.CurrentRoomState == RogueNewModel.RogueRoomState.RoomOver)
			{
				if (gateIndex == 0)
				{
					_getdataIndex = 0;
				}
				if (gateIndex == 2)
				{
					_getdataIndex = 1;
				}
				EnterState(1);
			}
		}
		else if (gateIndex == 1 && Model<RogueNewModel>.Interface.CurrentRoomState == RogueNewModel.RogueRoomState.RoomOver)
		{
			_getdataIndex = 0;
			EnterState(1);
		}
	}

	private void SpawnGate()
	{
		_ = _data.gateIndex;
		RogueRoomType index = Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.NextRoomTypes[_getdataIndex];
		Object.Instantiate(_gates[(int)index], transform);
	}

	public override void ReleaseStateObject()
	{
		DispatchCloseBubbleEvent();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_RoomStateChange, RoomStateChange);
		base.ReleaseStateObject();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
		if (toStateId == 1)
		{
			SpawnGate();
		}
		if (toStateId == 2)
		{
			Model<RogueNewModel>.Interface.InteractSendRogueEnterNextRoom(_getdataIndex);
		}
	}
}
