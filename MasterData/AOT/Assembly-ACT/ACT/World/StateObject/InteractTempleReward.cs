using System;
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
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractTempleReward")]
public class InteractTempleReward : StateObjectBase
{
	public InteractEntry entry;

	[FormerlySerializedAs("LeaveEntry")]
	public InteractEntry leaveEntry;

	private Animator m_animator;

	private AssetLoadHandle m_Handle;

	protected bool m_isOption;

	protected bool m_isInInteract;

	private int m_BehaveId;

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 2;
		}
		return false;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 1)
		{
			entry.HandleEnter();
			leaveEntry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 1)
		{
			entry.HandleExit();
			leaveEntry.HandleExit();
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 1)
		{
			entry.HandleUninit();
			leaveEntry.HandleUninit();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 1 && entryIndex == 0)
		{
			entry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
		if (currentStateId == 1 && entryIndex == 2)
		{
			leaveEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is TempleRewardPointData templeRewardPointData)
		{
			m_isInInteract = false;
			m_isOption = false;
			ResetEntryInteractType(entry, InteractType.Button);
			ResetEntryInteractType(leaveEntry, InteractType.Button);
			InteractEntry interactEntry = entry;
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(1, 0);
			InteractEntry interactEntry2 = leaveEntry;
			interactEntry2.onInteract = (Action<Entity>)Delegate.Combine(interactEntry2.onInteract, new Action<Entity>(LeaveTemple));
			leaveEntry.BindInteractObjectBase(this);
			leaveEntry.BindData(compStateObject.StateWorldAssetData);
			leaveEntry.BindInteractState(1, 2);
			m_Handle = AssetStationManager.BattleStation.Instantiate(templeRewardPointData.modelAssetID, transform);
			m_Handle.AsGameObject().TryGetComponent<Animator>(out m_animator);
			m_animator?.SetInteger("state", stateId);
			base.InitStateObject(stateId);
		}
	}

	public void OnInteract(Entity eb)
	{
		if (!m_isInInteract)
		{
			m_isInInteract = true;
			int curChallengeTempleId = Model<TempleModel>.Interface.CurChallengeTempleId;
			int area = RuntimeConfigs.data.instanceDungeons[curChallengeTempleId].area;
			TempleData templeData = Model<TempleModel>.Interface.GetTempleData(curChallengeTempleId);
			if (templeData != null && templeData.isComplate)
			{
				GameUtility.OpenToolTip(1091);
				m_isInInteract = false;
			}
			else if (currentStateId == 1)
			{
				OnConfirm(area);
			}
		}
	}

	private void OnConfirm(int areaId)
	{
		if (!m_isOption)
		{
			m_isOption = true;
			G.service.CompleteTempleStage((RepeatedField<UniversalItem> t) =>
			{
				UpdateFirstAreaCompleteEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateFirstAreaCompleteEvt>();
				evt.index = 0;
				evt.AreaId = areaId;
				evt.isComplete = true;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.TempleFirstTargetRefresh, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				UpdateAreaRewardEvt evt2 = Singleton<EventManager>.instance.GetEvt<UpdateAreaRewardEvt>();
				evt2.AreaId = areaId;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaRewardState, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.WorldSuccess, null);
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(t)).Forget();
			});
		}
	}

	private void LeaveTemple(Entity eb)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				G.service.LeaveTemple((bool t) =>
				{
					Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
				});
			},
			texts = new string[1] { "离开神庙吗？" }
		});
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	protected override void HandleInitState(int stateId)
	{
		m_animator?.SetInteger("state", stateId);
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		m_animator?.SetInteger("state", toStateId);
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}
}
