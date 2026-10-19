using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Timeline;

public class ToAttachPoint : MonoBehaviour
{
	[HideInInspector]
	public int id;

	public string attachPoint;

	private List<GameObject> childerns;

	private void Start()
	{
		childerns = new List<GameObject>();
		if (MonoECS.instance.mainEntity.GetMono().TryGetAttachPoint(attachPoint, out var attackPoint))
		{
			for (int num = transform.childCount - 1; num >= 0; num--)
			{
				Transform child = transform.GetChild(num);
				childerns.Add(child.gameObject);
				child.parent = attackPoint.transform;
				child.localPosition = Vector3.zero;
				child.localRotation = Quaternion.identity;
			}
		}
	}

	private void OnDestroy()
	{
		if (childerns != null)
		{
			for (int num = childerns.Count - 1; num >= 0; num--)
			{
				Object.Destroy(childerns[num]);
			}
		}
	}
}
