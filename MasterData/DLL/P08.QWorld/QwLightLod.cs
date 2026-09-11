using QwStreaming;
using UnityEngine;

public class QwLightLod : QwLodBase
{
	public static float entityNearDistance;

	private static StreamingCacheGameObject _npcShadowCache;

	public override void Init()
	{
		entityNearDistance = 12f;
		_npcShadowCache = new StreamingCacheGameObject();
		_npcShadowCache.Init(Streaming.GetModelInfo("Char/Shadow"), new StreamingCacheGameObject.CacheSettings
		{
			startClearTimeLeft = 5f,
			perObjectClearTimeLeft = 2f,
			noObjectUnloadTimeLeft = -1f
		});
	}

	public override void Shutdown()
	{
		_npcShadowCache.Dispose();
		_npcShadowCache = null;
	}

	public static void Update()
	{
		if (!QwLodMgr.inited)
		{
			return;
		}
		foreach (IQwLodObject lodObject in QwLodMgr.lodObjects)
		{
			ref QwLodData lodData = ref lodObject.GetLodData();
			if (lodObject is QWorldMapEntity entity)
			{
				UpdateEntityLod(entity, ref lodData);
			}
		}
	}

	public override void OnRemoveLodObject(IQwLodObject lodObject)
	{
		lodObject.GetLodData();
	}

	private static void UpdateEntityLod(QWorldMapEntity entity, ref QwLodData lodData)
	{
		if (lodData.renderers == null || lodData.renderers.Count == 0)
		{
			return;
		}
		_ = entityNearDistance;
		if (!lodData.distanceDirty)
		{
			return;
		}
		bool flag = lodData.distance <= entityNearDistance;
		if (flag != lodData.lastDistance <= entityNearDistance)
		{
			lodData.passController.SwitchOutlinePass(flag);
			if (entity.IsPlayer())
			{
				lodData.passController.SwitchShadowCasterPass(entity.IsPlayer());
			}
			else if (entity.IsNpc())
			{
				lodData.passController.SwitchShadowCasterPass(flag);
			}
			else
			{
				lodData.passController.SwitchShadowCasterPass(state: false);
			}
			if (entity.IsNpc())
			{
				lodData.passController.SwitchFaceShadowPass(flag);
				lodData.passController.SwitchHairShadowPass(flag);
			}
		}
	}

	private static void SwitchNpcShadow(QWorldMapEntity entity, ref QwLodData lodData, bool enabled)
	{
		if (enabled && lodData.npcShadow == null)
		{
			lodData.npcShadow = _npcShadowCache.Take().transform;
			float num = lodData.boundSphereRadius * 1f;
			lodData.npcShadow.localScale = new Vector3(num, 1f, num);
			lodData.npcShadow.SetParent(entity.transform);
			lodData.npcShadow.localPosition = new Vector3(0f, 0.05f, 0f);
		}
		else if (!enabled && lodData.npcShadow != null)
		{
			_npcShadowCache.Return(lodData.npcShadow.gameObject);
			lodData.npcShadow = null;
		}
	}
}
