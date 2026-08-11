using System;
using UnityEngine;

namespace Ase;

public class ObstacleWallTool : MonoBehaviour
{
	public Vector2 Size = new Vector2(1f, 10f);

	public float BareSize = 0.5f;

	public float OutAddSize = 0.5f;

	public bool OutAddDir;

	public Transform PathParent;

	public bool IsClose;

	public void CreateFenceWall()
	{
		if (PathParent == null)
		{
			return;
		}
		Transform transform = base.transform.Find("ObstacleWall");
		if (transform != null)
		{
			UnityEngine.Object.DestroyImmediate(transform.gameObject);
		}
		GameObject parent = new GameObject("ObstacleWall");
		parent.transform.localPosition = Vector3.zero;
		parent.transform.localScale = Vector3.one;
		TraversePath(delegate(Transform trans1, Transform trans2)
		{
			CreateWall(trans1, trans2, delegate(GameObject go)
			{
				go.transform.parent = parent.transform;
			});
		});
		parent.transform.parent = base.transform;
	}

	private void CreateWall(Transform pos1, Transform pos2, Action<GameObject> onCreate)
	{
		GameObject gameObject = new GameObject(pos1.name + "->" + pos2.name);
		float num = Vector3.Distance(pos1.position, pos2.position);
		BoxCollider val = gameObject.AddComponent<BoxCollider>();
		val.size = Vector3.one;
		val.center = Vector3.zero;
		gameObject.transform.parent = base.transform;
		gameObject.transform.localScale = new Vector3(num + BareSize, Size.y, Size.x + OutAddSize);
		gameObject.transform.position = pos1.position + (pos2.position - pos1.position).normalized * (num * 0.5f);
		Vector3 normalized = (Quaternion.Euler(0f, OutAddDir ? 90 : (-90), 0f) * (pos2.position - pos1.position)).normalized;
		gameObject.transform.position += normalized * OutAddSize * 0.5f;
		float num2 = Mathf.Asin((pos1.position.z - pos2.position.z) / num) * 57.29578f;
		float num3 = ((!(pos1.position.x - pos2.position.x > 0f)) ? 1 : (-1));
		gameObject.transform.rotation = Quaternion.Euler(new Vector3(0f, num2 * num3, 0f));
		onCreate?.Invoke(gameObject);
		Vector3[] boxColliderVertexPositions = GetBoxColliderVertexPositions(val);
		for (int i = 0; i < boxColliderVertexPositions.Length; i++)
		{
			boxColliderVertexPositions[i] -= gameObject.transform.position;
		}
	}

	private Vector3[] GetBoxColliderVertexPositions(BoxCollider boxcollider)
	{
		return new Vector3[8]
		{
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(boxcollider.size.x, 0f - boxcollider.size.y, boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(0f - boxcollider.size.x, 0f - boxcollider.size.y, boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(0f - boxcollider.size.x, 0f - boxcollider.size.y, 0f - boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(boxcollider.size.x, 0f - boxcollider.size.y, 0f - boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(boxcollider.size.x, boxcollider.size.y, boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(0f - boxcollider.size.x, boxcollider.size.y, boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(0f - boxcollider.size.x, boxcollider.size.y, 0f - boxcollider.size.z) * 0.5f),
			((Component)(object)boxcollider).transform.TransformPoint(boxcollider.center + new Vector3(boxcollider.size.x, boxcollider.size.y, 0f - boxcollider.size.z) * 0.5f)
		};
	}

	private void TraversePath(Action<Transform, Transform> onTraverse)
	{
		int childCount = PathParent.childCount;
		if (childCount <= 2)
		{
			return;
		}
		for (int i = 0; i < childCount; i++)
		{
			Transform child = PathParent.GetChild(i);
			Transform transform = null;
			if (i == childCount - 1)
			{
				if (!IsClose)
				{
					break;
				}
				transform = PathParent.GetChild(0);
			}
			else
			{
				transform = PathParent.GetChild(i + 1);
			}
			onTraverse?.Invoke(child, transform);
		}
	}
}
