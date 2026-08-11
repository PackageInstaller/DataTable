using System.Collections.Generic;
using Cysharp.Text;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class EntityDynamicAbnormalMaterialComponent : BaseComponent
{
	private Dictionary<string, List<Material>> _cacheMaterialsDic;

	private Dictionary<List<string>, bool> _boneIsEmptyAbnormalDic;

	private List<SkinnedMeshRenderer> _rendererList;

	private const int ABNORMAL_MAT_IDX = 1;

	private bool _isSkinMeshMaterialsCached;

	private void CacheSkinMeshMaterials()
	{
		EntityBoneComponent component = mBaseEntity.GetComponent<EntityBoneComponent>();
		List<string> bonesNames = CollectionPool<List<string>, string>.Get();
		List<Material> list = CollectionPool<List<Material>, Material>.Get();
		component.GetAllBonesName(in bonesNames);
		string value = ZString.Format("{0}", base.Entity.EntityId);
		for (int i = 0; i < bonesNames.Count; i++)
		{
			string text = bonesNames[i];
			Transform boneRoot = component.GetBoneRoot(text);
			if (boneRoot == null || !boneRoot.TryGetComponent<SkinnedMeshRenderer>(out var component2))
			{
				continue;
			}
			List<Material> list2 = new List<Material>();
			component2.GetMaterials(list2);
			_cacheMaterialsDic.TryAdd(text, list2);
			if (_rendererList.Contains(component2))
			{
				continue;
			}
			for (int num = list2.Count - 1; num >= 1; num--)
			{
				if (!list2[num].name.Contains(value))
				{
					_boneIsEmptyAbnormalDic.TryAdd(component.GetAllBonesNameWithTransformAlloc(boneRoot), value: true);
					break;
				}
			}
			_rendererList.Add(component2);
		}
		for (int j = 0; j < _rendererList.Count; j++)
		{
			SkinnedMeshRenderer skinnedMeshRenderer = _rendererList[j];
			skinnedMeshRenderer.GetMaterials(list);
			for (int num2 = list.Count - 1; num2 >= 1; num2--)
			{
				if (!list[num2].name.Contains(value))
				{
					list.RemoveAt(num2);
				}
			}
			skinnedMeshRenderer.materials = list.ToArray();
			list.Clear();
		}
		CollectionPool<List<Material>, Material>.Release(list);
		CollectionPool<List<string>, string>.Release(bonesNames);
		_isSkinMeshMaterialsCached = true;
	}

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_cacheMaterialsDic = new Dictionary<string, List<Material>>();
		_boneIsEmptyAbnormalDic = new Dictionary<List<string>, bool>();
		_rendererList = new List<SkinnedMeshRenderer>();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		CacheSkinMeshMaterials();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_rendererList.Clear();
		_rendererList = null;
		foreach (KeyValuePair<List<string>, bool> item in _boneIsEmptyAbnormalDic)
		{
			item.Key.Clear();
		}
		_boneIsEmptyAbnormalDic.Clear();
		_boneIsEmptyAbnormalDic = null;
		foreach (KeyValuePair<string, List<Material>> item2 in _cacheMaterialsDic)
		{
			Transform boneRoot = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(item2.Key);
			if (boneRoot != null && boneRoot.TryGetComponent<SkinnedMeshRenderer>(out var component))
			{
				component.materials = item2.Value.ToArray();
				item2.Value.Clear();
			}
		}
		_cacheMaterialsDic.Clear();
		_cacheMaterialsDic = null;
		_isSkinMeshMaterialsCached = false;
	}

	public override void OnEntityReborn()
	{
		base.OnEntityReborn();
		if (!_isSkinMeshMaterialsCached)
		{
			return;
		}
		string value = ZString.Format("{0}", base.Entity.EntityId);
		List<Material> list = CollectionPool<List<Material>, Material>.Get();
		for (int i = 0; i < _rendererList.Count; i++)
		{
			SkinnedMeshRenderer skinnedMeshRenderer = _rendererList[i];
			skinnedMeshRenderer.GetMaterials(list);
			for (int num = list.Count - 1; num >= 1; num--)
			{
				if (!list[num].name.Contains(value))
				{
					list.RemoveAt(num);
				}
			}
			skinnedMeshRenderer.materials = list.ToArray();
			list.Clear();
		}
		list.Clear();
		CollectionPool<List<Material>, Material>.Release(list);
	}

	public bool TryRemoveAbnormalMat(string pointName, string matName)
	{
		if (IsBoneEmptyAbnormal(pointName))
		{
			return false;
		}
		Transform boneRoot = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(pointName);
		if (boneRoot == null)
		{
			return false;
		}
		if (!boneRoot.TryGetComponent<SkinnedMeshRenderer>(out var component))
		{
			return false;
		}
		List<Material> list = CollectionPool<List<Material>, Material>.Get();
		component.GetMaterials(list);
		if (list.Count <= 1)
		{
			CollectionPool<List<Material>, Material>.Release(list);
			return false;
		}
		bool result = false;
		string name = _cacheMaterialsDic[pointName][1].name;
		if (name.Equals(matName) || name.Contains(matName))
		{
			list.RemoveAt(1);
			result = true;
		}
		component.materials = list.ToArray();
		SetBoneEmptyAbnormal(pointName, state: true);
		CollectionPool<List<Material>, Material>.Release(list);
		return result;
	}

	public bool IsBoneEmptyAbnormal(string key)
	{
		foreach (KeyValuePair<List<string>, bool> item in _boneIsEmptyAbnormalDic)
		{
			if (item.Key.Contains(key))
			{
				return item.Value;
			}
		}
		return false;
	}

	public void SetBoneEmptyAbnormal(string key, bool state)
	{
		foreach (KeyValuePair<List<string>, bool> item in _boneIsEmptyAbnormalDic)
		{
			if (item.Key.Contains(key))
			{
				_boneIsEmptyAbnormalDic[item.Key] = state;
				break;
			}
		}
	}

	public int GetWrapperMaterialIndex(string pointName, in List<Material> rendererMats, int materialIndex)
	{
		int num = materialIndex;
		bool flag = IsBoneEmptyAbnormal(pointName);
		if ((num == 1) & flag)
		{
			rendererMats.Insert(1, _cacheMaterialsDic[pointName][1]);
			SetBoneEmptyAbnormal(pointName, state: false);
		}
		else if ((num > 1) & flag)
		{
			num--;
		}
		return num;
	}

	public bool RecalculateAbnormalMat(string pointName, in List<Material> allMat, int matIndex)
	{
		if (matIndex == 1 && IsBoneEmptyAbnormal(pointName))
		{
			SkinnedMeshRenderer component = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(pointName).GetComponent<SkinnedMeshRenderer>();
			List<Material> list = _cacheMaterialsDic[pointName];
			if (list.Count <= 1)
			{
				return false;
			}
			if (allMat.Count <= 1)
			{
				allMat.Add(list[1]);
			}
			else
			{
				allMat.Insert(1, list[1]);
			}
			component.materials = allMat.ToArray();
			SetBoneEmptyAbnormal(pointName, state: false);
			return true;
		}
		return false;
	}
}
