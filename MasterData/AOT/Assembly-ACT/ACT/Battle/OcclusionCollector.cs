using System.Collections;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class OcclusionCollector : MonoBehaviour
{
	public Transform target;

	public LayerMask layerMask;

	private RaycastHit[] hits = new RaycastHit[5];

	private IEnumerator Start()
	{
		yield return new WaitUntil(() => MonoECS.instance.localPlayer != null);
		target = MonoECS.instance.localPlayer.battleEntity.GetRootTransform();
	}

	private void Update()
	{
		if (target == null)
		{
			return;
		}
		List<Collider> list = CameraOcclusionManager.StartCollectOcclusion();
		Vector3 vector = transform.position - target.transform.position;
		int num = Physics.RaycastNonAlloc(target.transform.position, vector.normalized, hits, vector.magnitude, layerMask);
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				list.Add(hits[i].collider);
			}
		}
		CameraOcclusionManager.EndCollectOcclusion();
	}
}
