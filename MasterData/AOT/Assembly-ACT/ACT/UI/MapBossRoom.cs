using System.Collections.Generic;
using ACT.Model;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MapBossRoom : MonoBehaviour
{
	private static class Ids
	{
		public static readonly int rectId = Shader.PropertyToID("_SoftMask_Rect");

		public static readonly int scopeId = Shader.PropertyToID("_Scope");

		public static readonly int useSoftMaskId = Shader.PropertyToID("_UseSoftMask");

		public static readonly int softMaskTexture = Shader.PropertyToID("_SoftMaskTexture");
	}

	public int enterRecordUid;

	public int unlockFogId;

	public GameObject unlockRoot;

	public GameObject lockRoot;

	public Animation animation;

	public List<ParticleSystem> particleSystems;

	private void Awake()
	{
		if (!(GetComponentInParent<SoftMask>() == null))
		{
			_ = particleSystems;
		}
	}

	public void LargeMapInit()
	{
		bool flag = Model<MapModel>.Interface.UnlockFogHasUnlock(unlockFogId);
		gameObject.SetActive(flag);
		if (flag)
		{
			UpdateUnlockState();
		}
	}

	public void MinimapInit(Vector2 pos, float scale)
	{
		RectTransform rectTransform = (RectTransform)transform;
		rectTransform.anchoredPosition = pos;
		rectTransform.localScale = Vector3.one * scale;
		bool flag = Model<MapModel>.Interface.UnlockFogHasUnlock(unlockFogId);
		gameObject.SetActive(flag);
		if (flag)
		{
			UpdateUnlockState();
		}
	}

	public void MinimapOnFogUnlock()
	{
		bool active = Model<MapModel>.Interface.UnlockFogHasUnlock(unlockFogId);
		gameObject.SetActive(active);
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
		animation.Play("Unlock");
	}
}
