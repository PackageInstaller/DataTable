using System;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World.StateObject;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public abstract class StateWorldAssetData : IDataToBake, IGetSpawnPos, IGetTeleportPos, IPrecache
{
	public enum LoadTiming
	{
		OnSceneLoad,
		AfterSceneLoad
	}

	public static readonly int InvalidID = int.MinValue;

	public static readonly int OneWayDoor = 26;

	public static readonly int BlockInteract = 21;

	public TransformParent transformParent;

	[SerializeField]
	internal int stateWorldAssetUid;

	[SerializeField]
	[HideInInspector]
	internal Vector3 initPos;

	[SerializeField]
	[HideInInspector]
	internal Quaternion initRotate;

	[SerializeField]
	internal bool useScale;

	[SerializeField]
	[HideInInspector]
	internal Vector3 initScale;

	public TheOtherWorldModel.TheOtherWorldOwnerShip theOtherWorldOwnerShip;

	public bool dontResetState;

	public int stateObjectType = 1;

	public int trapType;

	public int defenceTowerType;

	public bool showOnMap = true;

	public int iconDataId;

	public MapArea mapArea;

	public MapSubArea mapSubArea;

	public int mapLayer;

	public virtual bool isStatic => true;

	public abstract YooAssetReference addressAssetID { get; }

	public abstract ServiceSaveTag serviceSaveTag { get; }

	public bool serviceSave => serviceSaveTag != ServiceSaveTag.NotSave;

	public int stateId
	{
		get
		{
			if (serviceSave)
			{
				if (!CoreUtils.TryGetServiceSaveStateId(Singleton<GameManager>.instance.worldManager.ActiveWorldId, stateWorldAssetUid, out var result))
				{
					return initialStateId;
				}
				return result;
			}
			return initialStateId;
		}
	}

	public MapLayer MapLayer => (MapLayer)mapLayer;

	public abstract int initialStateId { get; }

	public virtual int resetStateId => initialStateId;

	public virtual LoadTiming loadTiming => LoadTiming.OnSceneLoad;

	public virtual bool IsWaitInit => false;

	public static bool IsValidID(int id)
	{
		return id != InvalidID;
	}

	public virtual Vector3 GetSpawnPos()
	{
		return initPos;
	}

	public virtual Vector3 GetTeleportPos()
	{
		return initPos;
	}

	public virtual Occupy GetOccupy(int stateId = 0)
	{
		return new Occupy(initPos);
	}

	public virtual (StateWorldAsset, UniTask) OnLoad(CancellationToken syncInit)
	{
		return StateWorldAsset.Load<StateWorldAsset>(this, syncInit);
	}

	public virtual void OnRelease()
	{
		StateWorldAsset.Release<StateWorldAsset>(this);
	}

	public override string ToString()
	{
		return $"[{stateWorldAssetUid}]{serviceSaveTag}";
	}

	public virtual void Bake(object assetComp)
	{
	}

	public virtual void OnStateObjectCreate(StateObjectBase stateObject)
	{
	}

	public virtual bool IsServiceSaveState(int stateId)
	{
		return serviceSave;
	}

	public virtual bool IsSyncCharacterInfo(int stateId)
	{
		return true;
	}

	public virtual bool GetMapLayer(out int layer)
	{
		layer = mapLayer;
		return true;
	}

	public virtual UniTask CollectPrecacheAsync(PrecacheCollector collector, CancellationToken ct = default(CancellationToken))
	{
		return UniTask.CompletedTask;
	}
}
