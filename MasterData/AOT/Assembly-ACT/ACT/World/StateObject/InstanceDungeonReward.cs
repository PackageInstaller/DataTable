using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InstanceDungeonReward")]
public class InstanceDungeonReward : InteractObject
{
	private const int ClosedState = 0;

	private const int OpenState = 1;

	private static readonly int State = Animator.StringToHash("state");

	public Animator animator;

	private AssetLoadHandle m_Handle;

	protected bool m_isOption;

	protected bool m_isInInteract;

	private static bool CanInteract(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 1;
		}
		return true;
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (CanInteract(currentStateId) && entryIndex == 0)
		{
			base.Interact(entryIndex, eb, interactSource);
		}
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is TempleRewardPointData)
		{
			m_isInInteract = false;
			m_isOption = false;
			base.InitStateObject(stateId);
			InteractEntry interactEntry = GetState(1).interactEntries[0];
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
		}
	}

	public void OnInteract(Entity eb)
	{
		if (currentStateId != 1 || m_isInInteract)
		{
			return;
		}
		m_isInInteract = true;
		if (MonoECS.instance.sceneStatus == SceneStatus.Temple)
		{
			int templeId = Model<TempleModel>.Interface.CurChallengeTempleId;
			int areaId = RuntimeConfigs.data.instanceDungeons[templeId].area;
			TempleData curChallengeTempleData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
			if (curChallengeTempleData != null && curChallengeTempleData.isComplate)
			{
				G.service.CompleteTempleStage((RepeatedField<UniversalItem> t) =>
				{
					AddAreaStartCountEvt evt = Singleton<EventManager>.instance.GetEvt<AddAreaStartCountEvt>();
					evt.AreaId = areaId;
					evt.AddStarCount = Model<TempleModel>.Interface.CurrentReveiveRobot.Count;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaStarCount, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
					UpdateAreaRewardEvt evt2 = Singleton<EventManager>.instance.GetEvt<UpdateAreaRewardEvt>();
					evt2.AreaId = areaId;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaRewardState, evt2);
					Singleton<EventManager>.instance.ReleaseEvt(evt2);
					Model<TempleModel>.Interface.UpdateData(areaId, templeId, complete: true);
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.WorldSuccess, null);
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(t));
				});
				m_isInInteract = false;
			}
			else if (currentStateId == 1)
			{
				OnConfirm(areaId, templeId);
			}
		}
		else if (G.localPlayer.Profile.SceneStatus == SceneStatus.Raid)
		{
			if (Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid())
			{
				Model<RaidModel>.Interface.RaidSettlement();
			}
			else
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			}
		}
	}

	private void OnConfirm(int areaId, int templeId)
	{
		if (!m_isOption)
		{
			m_isOption = true;
			MonoScrollBagComponent.Param param = new MonoScrollBagComponent.Param
			{
				allItems = 
				{
					items = new List<Item>()
				}
			};
			G.service.CompleteTempleStage((RepeatedField<UniversalItem> t) =>
			{
				AddAreaStartCountEvt evt = Singleton<EventManager>.instance.GetEvt<AddAreaStartCountEvt>();
				evt.AreaId = areaId;
				evt.AddStarCount = Model<TempleModel>.Interface.CurrentReveiveRobot.Count;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaStarCount, evt);
				UpdateFirstAreaCompleteEvt evt2 = Singleton<EventManager>.instance.GetEvt<UpdateFirstAreaCompleteEvt>();
				evt2.index = 0;
				evt2.AreaId = areaId;
				evt2.isComplete = true;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.TempleFirstTargetRefresh, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
				UpdateAreaRewardEvt evt3 = Singleton<EventManager>.instance.GetEvt<UpdateAreaRewardEvt>();
				evt3.AreaId = areaId;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaRewardState, evt3);
				Singleton<EventManager>.instance.ReleaseEvt(evt3);
				Model<TempleModel>.Interface.UpdateData(areaId, templeId, complete: true);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.WorldSuccess, null);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(t));
			});
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
	}

	public override void ReleaseStateObject()
	{
		InteractEntry interactEntry = GetState(1).interactEntries[0];
		interactEntry.onInteract = (Action<Entity>)Delegate.Remove(interactEntry.onInteract, new Action<Entity>(OnInteract));
		base.ReleaseStateObject();
	}
}
