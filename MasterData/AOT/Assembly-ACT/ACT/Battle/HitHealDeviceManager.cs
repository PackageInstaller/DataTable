using System;
using System.Collections.Generic;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public sealed class HitHealDeviceManager : Singleton<HitHealDeviceManager>
{
	internal sealed class ActiveLightPoint
	{
		public readonly int OwnerId;

		public readonly IDisposable LightPoint;

		public ActiveLightPoint(int ownerId, IDisposable lightPoint)
		{
			OwnerId = ownerId;
			LightPoint = lightPoint;
		}
	}

	private const int MaxActiveLightCount = 30;

	private readonly LinkedList<ActiveLightPoint> _activeLightPoints = new LinkedList<ActiveLightPoint>();

	private PrecacheHandle _lightPointPreload;

	public void PreloadLightPointPrefab(string assetKey)
	{
		if (!string.IsNullOrEmpty(assetKey) && _lightPointPreload == null)
		{
			_lightPointPreload = PrecacheManager.Instance.Preload(assetKey, 30);
		}
	}

	public bool IsLightPointPrefabReady()
	{
		return _lightPointPreload?.IsDone ?? false;
	}

	public int ReserveSlots(int ownerId, int requestedCount)
	{
		requestedCount = Mathf.Clamp(requestedCount, 0, 30);
		int num = Mathf.Max(0, _activeLightPoints.Count + requestedCount - 30);
		LinkedListNode<ActiveLightPoint> linkedListNode = _activeLightPoints.First;
		while (num > 0 && linkedListNode != null)
		{
			LinkedListNode<ActiveLightPoint> next = linkedListNode.Next;
			if (linkedListNode.Value.OwnerId != ownerId)
			{
				linkedListNode.Value.LightPoint.Dispose();
				num--;
			}
			linkedListNode = next;
		}
		return Mathf.Min(requestedCount, 30 - _activeLightPoints.Count);
	}

	internal LinkedListNode<ActiveLightPoint> Register(int ownerId, IDisposable lightPoint)
	{
		return _activeLightPoints.AddLast(new ActiveLightPoint(ownerId, lightPoint));
	}

	internal void Unregister(LinkedListNode<ActiveLightPoint> node)
	{
		if (node?.List == _activeLightPoints)
		{
			_activeLightPoints.Remove(node);
		}
	}

	public override void UnInit()
	{
		Clear();
		ReleaseLightPointPreloads();
		base.UnInit();
	}

	private void ReleaseLightPointPreloads()
	{
		if (_lightPointPreload != null)
		{
			PrecacheManager.Instance.ReleasePreload(_lightPointPreload.AssetKey);
			_lightPointPreload = null;
		}
	}

	private void Clear()
	{
		while (_activeLightPoints.First != null)
		{
			_activeLightPoints.First.Value.LightPoint.Dispose();
		}
	}
}
