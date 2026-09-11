using QwStreaming;
using UnityEngine;

public class QwModelLod : QwLodBase
{
	public static float preStreamDistance;

	public static float cullDistance;

	public static float syncDistance;

	public override void Init()
	{
		preStreamDistance = 1f;
		cullDistance = 30f;
		syncDistance = 4f;
	}

	public override void Shutdown()
	{
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

	private static void UpdateEntityLod(QWorldMapEntity entity, ref QwLodData lodData)
	{
		if (!lodData.visibilityDirty && !lodData.distanceDirty)
		{
			return;
		}
		if (lodData.distanceDirty)
		{
			float num = cullDistance;
			if (entity.cullMode == CullMode.Disable)
			{
				num = 1.06110957E+09f;
			}
			if (lodData.loaded && lodData.distance > num)
			{
				entity.RequestUnload();
				QwLodMgr.UpdateLodDataModel(entity, ref lodData);
			}
			else if (!lodData.loaded && !entity.isLoadRequested && lodData.distance <= num + preStreamDistance)
			{
				if (lodData.distance <= num)
				{
					if (lodData.distance <= syncDistance)
					{
						entity.RequestLoad(StreamingLoadMode.Immediate);
					}
					else
					{
						entity.RequestLoad(StreamingLoadMode.Default);
					}
					QwLodMgr.UpdateLodDataModel(entity, ref lodData);
				}
				else if (!(lodData.lastDistance <= num + preStreamDistance))
				{
					entity.RequestModelPreload();
				}
			}
		}
		if ((!lodData.visibilityDirty && !lodData.modelDirty) || !lodData.loaded)
		{
			return;
		}
		foreach (Renderer renderer in lodData.renderers)
		{
			renderer.enabled = lodData.visible;
		}
		entity.SetHudDisplay(lodData.visible ? 1 : 0);
	}
}
