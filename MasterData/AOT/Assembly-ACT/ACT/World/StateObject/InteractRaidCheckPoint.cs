using System;
using ACT.Battle;
using ACT.Game;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractRaidCheckPoint")]
public class InteractRaidCheckPoint : StateObjectBase
{
	public InteractEntry entry;

	private Animator m_animator;

	private int m_BehaveId;

	private AssetLoadHandle m_Handle;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is RaidCheckPointData raidCheckPointData)
		{
			ResetEntryInteractType(entry, raidCheckPointData.interactType);
			InteractEntry interactEntry = entry;
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(1, 0);
			m_Handle = AssetStationManager.BattleStation.Instantiate(raidCheckPointData.modelAssetID, transform);
			m_Handle.Completed += (AssetLoadHandle x) =>
			{
				m_Handle.AsGameObject().TryGetComponent<Animator>(out m_animator);
				m_animator?.SetInteger("state", stateId);
			};
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	public virtual void OnInteract(Entity eb)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (G.localPlayer.Profile.SceneInfos[(int)MonoECS.instance.sceneStatus].CheckPosUid != compStateObject.StateWorldAssetData.stateWorldAssetUid)
		{
			MonoECS.instance.checkPointManager.SetCheckPoint(compStateObject.StateWorldAssetData.stateWorldAssetUid);
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		entry.HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 1)
		{
			entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 1)
		{
			entry.HandleExit();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		m_animator?.SetInteger("state", stateId);
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		m_animator?.SetInteger("state", toStateId);
	}

	protected override void HandleUninitState(int stateId)
	{
		if (currentStateId == 1)
		{
			entry.HandleUninit();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return stateId == 1;
	}
}
