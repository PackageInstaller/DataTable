using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class EntityBoneComponent : BaseComponent
{
	private new Transform transform;

	private Dictionary<string, BoneData> pointDic = new Dictionary<string, BoneData>();

	public void RegisterBonePointData(Transform tsm, Dictionary<string, BoneData> pointData)
	{
		transform = tsm;
		pointDic.Clear();
		foreach (KeyValuePair<string, BoneData> pointDatum in pointData)
		{
			pointDic.Add(GetBoneKey(pointDatum.Key), pointDatum.Value);
		}
	}

	public void GetAllBonesName(in List<string> bonesNames)
	{
		foreach (KeyValuePair<string, BoneData> item in pointDic)
		{
			bonesNames.Add(item.Key);
		}
	}

	public List<string> GetAllBonesNameWithTransformAlloc(Transform bone)
	{
		List<string> list = new List<string>();
		foreach (KeyValuePair<string, BoneData> item in pointDic)
		{
			if (item.Value.bone == bone)
			{
				list.Add(item.Key);
			}
		}
		return list;
	}

	private string GetBoneKey(string boneKey)
	{
		return boneKey;
	}

	public Transform GetBoneRoot(string boneKey)
	{
		boneKey = GetBoneKey(boneKey);
		if (pointDic.ContainsKey(boneKey))
		{
			return pointDic[boneKey].bone;
		}
		return null;
	}

	public bool TryGetBoneRoot(string boneKey, out Transform bone)
	{
		bone = null;
		boneKey = GetBoneKey(boneKey);
		if (pointDic.ContainsKey(boneKey))
		{
			bone = pointDic[boneKey].bone;
			return true;
		}
		return false;
	}

	public Vector3 GetBonePosition(string boneKey)
	{
		if (string.IsNullOrEmpty(boneKey))
		{
			return Vector3.zero;
		}
		boneKey = GetBoneKey(boneKey);
		if (pointDic.ContainsKey(boneKey))
		{
			return pointDic[boneKey].bone?.position ?? Vector3.zero;
		}
		return Vector3.zero;
	}

	public Vector3 GetBoneLocalPosition(string boneKey)
	{
		boneKey = GetBoneKey(boneKey);
		if (pointDic.ContainsKey(boneKey))
		{
			return pointDic[boneKey].bone.localPosition;
		}
		return Vector3.zero;
	}

	public void ChangeBoneActiveState(string boneKey, bool active)
	{
		boneKey = GetBoneKey(boneKey);
		Transform boneRoot = GetBoneRoot(boneKey);
		if (boneRoot != null)
		{
			boneRoot.gameObject.SetActive(active);
		}
	}
}
