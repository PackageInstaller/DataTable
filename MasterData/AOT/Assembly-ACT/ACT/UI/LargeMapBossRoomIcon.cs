using ACT.Model;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class LargeMapBossRoomIcon : LargeMapIcon
{
	public int worldBossId;

	public int enterRecordUid;

	public int unlockFogId;

	public GameObject unlockRoot;

	public GameObject lockRoot;

	[SerializeField]
	private Animation _animation;

	public void Init()
	{
		bool flag = Model<MapModel>.Interface.UnlockFogHasUnlock(unlockFogId);
		gameObject.SetActive(flag);
		if (flag)
		{
			UpdateUnlockState();
		}
	}

	private void UpdateUnlockState()
	{
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(enterRecordUid);
		if (worldStateAssetDataBySGOID.stateId == -2)
		{
			unlockRoot.SetActive(value: true);
			lockRoot.SetActive(value: false);
		}
		else if (worldStateAssetDataBySGOID.stateId == 0)
		{
			unlockRoot.SetActive(value: false);
			lockRoot.SetActive(value: true);
		}
	}

	public void PlayUnlockAnimation()
	{
		_animation.Play("Unlock");
	}

	public int GetWorldBossId()
	{
		return worldBossId;
	}

	public int GetEnterRecordUid()
	{
		return enterRecordUid;
	}
}
