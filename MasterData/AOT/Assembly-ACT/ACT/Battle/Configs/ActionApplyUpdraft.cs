using System;
using System.Collections.Generic;
using Bamboo.ECS;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("施加Updraft", "Action", new string[] { "apply", "updraft", "move", "movement", "position", "velocity" })]
public class ActionApplyUpdraft : ConfigAction
{
	public Vector3 forceDir = Vector3.up;

	public float force = 600f;

	private bool worldSpaceForceDir = true;

	private bool useDynamicRegion;

	public float width = 2f;

	public float depth = 2f;

	public float height = 10f;

	public float bottomOffset;

	public YooAssetReference regionVfxRef;

	public YooAssetReference topVfxRef;

	private const int UpdraftLayer = 17;

	private const string ChildObjectName = "BulletUpdraft";

	public override void Do(ActionMemory memory)
	{
		Transform rootTransform = memory.target.entity.GetRootTransform();
		if ((object)rootTransform != null)
		{
			ReleaseExistingUpdraft(rootTransform);
			GameObject gameObject = new GameObject("BulletUpdraft");
			gameObject.layer = 17;
			gameObject.transform.SetParent(rootTransform, worldPositionStays: false);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.identity;
			gameObject.transform.localScale = Vector3.one;
			gameObject.AddComponent<BoxCollider>().isTrigger = true;
			Vector3 boxSize = new Vector3(width, height, depth);
			Vector3 boxCenter = new Vector3(0f, bottomOffset + height * 0.5f, 0f);
			UpdraftRegion updraftRegion = gameObject.AddComponent<UpdraftRegion>();
			updraftRegion.Init(forceDir, force, boxCenter, boxSize, useDynamicRegion, new Vector2(2f, 10f), !worldSpaceForceDir);
			AttachVfx(updraftRegion, gameObject.transform, regionVfxRef, topVfxRef);
		}
	}

	private static void AttachVfx(UpdraftRegion region, Transform parent, YooAssetReference regionRef, YooAssetReference topRef)
	{
		if (region == null || parent == null)
		{
			return;
		}
		InstanceHandle instanceHandle = null;
		InstanceHandle instanceHandle2 = null;
		if (regionRef != null && !string.IsNullOrEmpty(regionRef.GUID))
		{
			instanceHandle = PrecacheManager.Instance.GetInstanceHandle(regionRef.GUID);
			BindVfx(instanceHandle, parent, region, (GameObject go) =>
			{
				if (!(region == null) && !region.IsReleased)
				{
					region.dynamicRegionVfx = go.transform;
					region.OnVfxAttached();
				}
			});
		}
		if (topRef != null && !string.IsNullOrEmpty(topRef.GUID))
		{
			instanceHandle2 = PrecacheManager.Instance.GetInstanceHandle(topRef.GUID);
			BindVfx(instanceHandle2, parent, region, (GameObject go) =>
			{
				if (!(region == null) && !region.IsReleased)
				{
					region.dynamicTopVfx = go.transform;
					go.SetActive(value: false);
					region.OnVfxAttached();
				}
			});
		}
		region.AttachVfxHandles(instanceHandle, instanceHandle2);
	}

	private static void BindVfx(InstanceHandle handle, Transform parent, UpdraftRegion region, Action<GameObject> onReady)
	{
		if (handle == null)
		{
			return;
		}
		if (handle.IsDone && handle.Result != null)
		{
			if (!(region == null) && !region.IsReleased && !(parent == null))
			{
				AttachToParent(handle.Result, parent);
				onReady?.Invoke(handle.Result);
			}
			return;
		}
		handle.Completed += (InstanceHandle h) =>
		{
			if (!(h.Result == null) && !(region == null) && !region.IsReleased)
			{
				if (parent == null)
				{
					PrecacheManager.Instance.ReleaseInstanceHandle(h);
				}
				else
				{
					AttachToParent(h.Result, parent);
					onReady?.Invoke(h.Result);
				}
			}
		};
	}

	private static void AttachToParent(GameObject go, Transform parent)
	{
		Transform transform = go.transform;
		transform.SetParent(parent, worldPositionStays: false);
		transform.localPosition = Vector3.zero;
		transform.localRotation = Quaternion.identity;
		transform.localScale = Vector3.one;
		if (!go.activeSelf)
		{
			go.SetActive(value: true);
		}
	}

	private static void ReleaseExistingUpdraft(Transform rootTrans)
	{
		Transform transform = rootTrans.Find("BulletUpdraft");
		if (!(transform == null))
		{
			if (transform.TryGetComponent<UpdraftRegion>(out var component))
			{
				component.ReleaseRuntimeAttachment();
			}
			transform.gameObject.SetActive(value: false);
			transform.SetParent(null, worldPositionStays: false);
			UnityEngine.Object.Destroy(transform.gameObject);
		}
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		if (regionVfxRef != null)
		{
			addlist.Add(regionVfxRef);
		}
		if (topVfxRef != null)
		{
			addlist.Add(topVfxRef);
		}
	}
}
