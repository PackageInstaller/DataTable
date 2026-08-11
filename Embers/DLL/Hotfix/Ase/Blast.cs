#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class Blast : MonoBehaviour
{
	private struct BlastCollider
	{
		public Collider collider;

		public float distance;
	}

	public bool upgrade;

	public BlastParameter blastParameter;

	private Mesh _combineMesh;

	private bool canClick = true;

	protected void OnDestroy()
	{
		if (base.gameObject.TryGetComponent<MeshCollider>(out var component))
		{
			component.sharedMesh = null;
		}
		if (_combineMesh != null)
		{
			UnityEngine.Object.Destroy(_combineMesh);
			_combineMesh = null;
		}
	}

	public void SetBlastParameter(BlastParameter parameter)
	{
		blastParameter = parameter;
	}

	public async Task SetupCollider()
	{
		if (!(UnityEngine.Object)(object)base.gameObject.GetComponent<MeshCollider>())
		{
			Mesh sharedMesh = CombineMeshes();
			MeshCollider obj = base.gameObject.AddComponent<MeshCollider>();
			obj.convex = true;
			obj.sharedMesh = sharedMesh;
		}
	}

	private Mesh CombineMeshes()
	{
		List<CombineInstance> list = CollectionPool<List<CombineInstance>, CombineInstance>.Get();
		List<MeshFilter> list2 = CollectionPool<List<MeshFilter>, MeshFilter>.Get();
		base.gameObject.GetComponentsInChildren(list2);
		for (int i = 0; i < list2.Count; i++)
		{
			MeshFilter meshFilter = list2[i];
			if (!meshFilter.GetComponent<Gem>() && !meshFilter.gameObject.transform.parent.GetComponent<Gem>() && ValidateMesh(meshFilter.sharedMesh))
			{
				Matrix4x4 localToWorldMatrix = meshFilter.transform.localToWorldMatrix;
				localToWorldMatrix.m00 = 1f;
				localToWorldMatrix.m11 = 1f;
				localToWorldMatrix.m22 = 1f;
				localToWorldMatrix.m03 -= meshFilter.transform.position.x;
				localToWorldMatrix.m13 -= meshFilter.transform.position.y;
				localToWorldMatrix.m23 -= meshFilter.transform.position.z;
				CombineInstance item = new CombineInstance
				{
					mesh = meshFilter.sharedMesh,
					transform = localToWorldMatrix
				};
				list.Add(item);
			}
		}
		if (_combineMesh != null)
		{
			UnityEngine.Object.Destroy(_combineMesh);
		}
		_combineMesh = new Mesh
		{
			hideFlags = HideFlags.HideAndDontSave
		};
		_combineMesh.CombineMeshes(list.ToArray(), mergeSubMeshes: true);
		_combineMesh.Optimize();
		CollectionPool<List<CombineInstance>, CombineInstance>.Release(list);
		CollectionPool<List<MeshFilter>, MeshFilter>.Release(list2);
		return _combineMesh;
	}

	private bool ValidateMesh(Mesh mesh)
	{
		if (mesh.vertices == null || mesh.vertices.Length == 0)
		{
			Log.Error($"Mesh {mesh} does not have any vertices");
			return false;
		}
		if (mesh.uv == null || mesh.uv.Length == 0)
		{
			Log.Error($"Mesh {mesh} does not have any uvs");
			return false;
		}
		return true;
	}

	public void Beat(Vector3 worldPosition)
	{
		if (canClick)
		{
			StartCoroutine(Show(worldPosition));
		}
	}

	private IEnumerator Show(Vector3 worldPosition)
	{
		canClick = false;
		Vector3 effectPos = worldPosition;
		Collider[] colliders = Physics.OverlapSphere(worldPosition, 100f);
		worldPosition = OffsetPosition(worldPosition, colliders);
		int count = UnityEngine.Random.Range(2, 5);
		List<BlastCollider> blastColliders = MinDistanceBlast(worldPosition, count, colliders);
		Blast blast = ((Component)(object)blastColliders?.First().collider).GetComponent<Blast>();
		if (blast != null)
		{
			Gem gem = blast.GetComponentInChildren<Gem>();
			if (!(gem != null))
			{
				yield break;
			}
			bool flag = false;
			foreach (BlastCollider item in blastColliders)
			{
				Gem componentInChildren = ((Component)(object)item.collider).GetComponent<Blast>().GetComponentInChildren<Gem>();
				if (componentInChildren != null && componentInChildren.Rarity >= 4 && componentInChildren.GemMode == GemMode.Normal)
				{
					flag = true;
					break;
				}
			}
			if (blastColliders.Count == 1 && blast.upgrade && gem != null)
			{
				gem.PlayUpgrade();
				yield return new WaitForSeconds(gem.awaitTime);
				blast.BlastGravel(worldPosition);
				yield return new WaitForSeconds(gem.awaitTime);
				canClick = true;
				yield break;
			}
			if (flag)
			{
				PlayEffects(blastParameter.GoldBlast, effectPos, blastParameter.GoldblastTime);
				yield return new WaitForSeconds(0.3f);
				PlayEffects(blastParameter.GoldDelayBlastEffect, effectPos, blastParameter.GoldDelayBlastEffectTime);
				yield return new WaitForSeconds(0.5f);
				PlayEffects(blastParameter.GoldBlastEffect, effectPos, blastParameter.GoldBlastEffectTime);
			}
			else
			{
				PlayEffects(blastParameter.blast, effectPos, blastParameter.blastTime);
			}
			foreach (BlastCollider item2 in blastColliders)
			{
				if (!((UnityEngine.Object)(object)item2.collider == null))
				{
					Blast component = ((Component)(object)item2.collider).GetComponent<Blast>();
					if ((bool)component)
					{
						component.SetBlastParameter(blastParameter);
						component.BlastGravel(worldPosition);
					}
				}
			}
			yield return new WaitForSeconds(blastParameter.touchTime);
			canClick = true;
		}
		else
		{
			yield return new WaitForSeconds(blastParameter.touchTime);
			canClick = true;
		}
	}

	private void PlayEffects(GameObject gameObject, Vector3 vector3, float time)
	{
		try
		{
			UnityEngine.Object.Destroy(UnityEngine.Object.Instantiate(gameObject, vector3, default(Quaternion)), time);
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	private Vector3 OffsetPosition(Vector3 triggerPos, Collider[] colliders)
	{
		if (colliders == null || colliders.Length == 0)
		{
			return triggerPos;
		}
		float y = colliders[0].bounds.center.y;
		foreach (Collider val in colliders)
		{
			if ((bool)((Component)(object)val).GetComponent<Blast>() && val.bounds.center.y > y)
			{
				y = val.bounds.center.y;
			}
		}
		return new Vector3(triggerPos.x, y, triggerPos.z);
	}

	private void BlastGravel(Vector3 position)
	{
		UnityEngine.Object.Destroy((UnityEngine.Object)(object)base.gameObject.GetComponent<MeshCollider>());
		Blast[] componentsInChildren = base.gameObject.GetComponentsInChildren<Blast>();
		if (componentsInChildren != null && componentsInChildren.Length > 1)
		{
			for (int i = 1; i < componentsInChildren.Length; i++)
			{
				Blast obj = componentsInChildren[i];
				obj.SetBlastParameter(blastParameter);
				obj.BlastGravel(position);
			}
			return;
		}
		if (upgrade && !(UnityEngine.Object)(object)base.gameObject.GetComponent<MeshCollider>())
		{
			SetupCollider();
			return;
		}
		MeshFilter[] componentsInChildren2 = base.gameObject.GetComponentsInChildren<MeshFilter>();
		for (int num = componentsInChildren2.Length - 1; num >= 0; num--)
		{
			MeshFilter meshFilter = componentsInChildren2[num];
			Gravel component = meshFilter.GetComponent<Gravel>();
			Gem component2 = meshFilter.GetComponent<Gem>();
			if (!component2 && !component)
			{
				UnityEngine.Object.Destroy(meshFilter.gameObject);
			}
			MeshCollider val = meshFilter.gameObject.AddComponent<MeshCollider>();
			if ((UnityEngine.Object)(object)val != null)
			{
				val.convex = true;
			}
			Rigidbody val2 = meshFilter.gameObject.AddComponent<Rigidbody>();
			if ((bool)component2)
			{
				if (component2.GemMode == GemMode.StoneUpgrade)
				{
					component2.PlayUpgrade(blastParameter.gemDrag, blastParameter.power, position, blastParameter.radius, blastParameter.upwards);
				}
				if ((UnityEngine.Object)(object)val2 != null)
				{
					val2.drag = blastParameter.gemDrag;
				}
				if (!component2.isShow)
				{
					component2.isShow = true;
					component2.GemGet();
				}
			}
			else if ((UnityEngine.Object)(object)val2 != null)
			{
				val2.AddExplosionForce(blastParameter.power, position, blastParameter.radius, blastParameter.upwards);
			}
			if ((bool)component)
			{
				component.StartVanish(blastParameter.curve);
			}
		}
	}

	private List<BlastCollider> MinDistanceBlast(Vector3 triggerPos, int count, Collider[] colliders)
	{
		count = Mathf.Min(count, colliders.Length);
		if (count <= 0)
		{
			return null;
		}
		Collider val = null;
		List<BlastCollider> list = new List<BlastCollider>();
		foreach (Collider val2 in colliders)
		{
			if (!(UnityEngine.Object)(object)val2)
			{
				continue;
			}
			Blast component = ((Component)(object)val2).GetComponent<Blast>();
			if (!component)
			{
				continue;
			}
			float sqrMagnitude = (val2.ClosestPoint(triggerPos) - triggerPos).sqrMagnitude;
			BlastCollider blastCollider = new BlastCollider
			{
				collider = val2,
				distance = sqrMagnitude
			};
			if (component.upgrade)
			{
				list.Clear();
				list.Add(blastCollider);
				return list;
			}
			if (list.Count < count)
			{
				list.Add(blastCollider);
			}
			else
			{
				BlastCollider blastCollider2 = list[0];
				int index = 0;
				for (int j = 0; j < list.Count; j++)
				{
					BlastCollider blastCollider3 = list[j];
					if (blastCollider3.distance > blastCollider2.distance)
					{
						blastCollider2 = blastCollider3;
						index = j;
					}
				}
				if (blastCollider.distance < blastCollider2.distance)
				{
					list[index] = blastCollider;
				}
			}
			if ((UnityEngine.Object)(object)val == null || val.bounds.center.y < val2.bounds.center.y)
			{
				val = val2;
			}
		}
		BlastCollider blastCollider4 = list[0];
		int index2 = 0;
		for (int k = 0; k < list.Count; k++)
		{
			BlastCollider blastCollider5 = list[k];
			if ((UnityEngine.Object)(object)val == (UnityEngine.Object)(object)blastCollider5.collider)
			{
				return list;
			}
			if (blastCollider5.distance > blastCollider4.distance)
			{
				blastCollider4 = blastCollider5;
				index2 = k;
			}
		}
		list[index2] = new BlastCollider
		{
			collider = val
		};
		return list;
	}
}
