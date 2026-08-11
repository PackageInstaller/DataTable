using System.Collections.Generic;
using Cysharp.Text;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class EntityPointMaterialComponent : BaseComponent
{
	private Queue<ChangeEntityMaterial> _materialStructs;

	private Dictionary<string, Material> _materialCacheDic;

	private List<ChangeShaderParam> _shaderStructs;

	private List<ModifyShaderParam> _modifyShaderStructs;

	private List<ChangeShaderParam> _waitRemoveShaderStructs;

	private int _materialRuntimeIdSeed;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_materialStructs = new Queue<ChangeEntityMaterial>();
		_materialCacheDic = new Dictionary<string, Material>(10);
		_shaderStructs = new List<ChangeShaderParam>();
		_modifyShaderStructs = new List<ModifyShaderParam>();
		_waitRemoveShaderStructs = new List<ChangeShaderParam>();
	}

	public int SetEntityMaterial(Material mat, string pointName, int materialIndex, ChangeEntityMaterialType materialType, bool isMultiplePoint, List<string> pointListName, int changeMatUniqueId, List<ShaderPropertyInfo> inheriteParams = null)
	{
		ChangeEntityMaterial changeEntityMaterial = ReferencePool.Acquire<ChangeEntityMaterial>();
		int num = 0;
		num = (((materialType != ChangeEntityMaterialType.SET && materialType != ChangeEntityMaterialType.SUB) || changeMatUniqueId <= 0) ? ((materialType != ChangeEntityMaterialType.SUB) ? GenerateMaterialRuntimeId() : 0) : changeMatUniqueId);
		changeEntityMaterial.material = mat;
		changeEntityMaterial.pointName = pointName;
		changeEntityMaterial.materialIndex = materialIndex;
		changeEntityMaterial.materialType = materialType;
		changeEntityMaterial.inheriteParams = inheriteParams;
		changeEntityMaterial.isMultiplePoint = isMultiplePoint;
		changeEntityMaterial.materialRuntimeId = num;
		changeEntityMaterial.ChangeMatUniqueId = changeMatUniqueId;
		if (pointListName != null)
		{
			changeEntityMaterial.pointListName = CollectionPool<List<string>, string>.Get();
			for (int i = 0; i < pointListName.Count; i++)
			{
				changeEntityMaterial.pointListName.Add(pointListName[i]);
			}
		}
		_materialStructs.Enqueue(changeEntityMaterial);
		return num;
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		CheckWaitRemoveShaderList();
		if (_materialStructs.Count != 0)
		{
			ChangeEntityMaterial(_materialStructs.Dequeue());
		}
		if (_shaderStructs.Count != 0)
		{
			for (int i = 0; i < _shaderStructs.Count; i++)
			{
				ExecuteDissolve(deltaTime, _shaderStructs[i]);
			}
		}
		if (_modifyShaderStructs.Count != 0)
		{
			for (int j = 0; j < _modifyShaderStructs.Count; j++)
			{
				ExecuteModifyShader(_modifyShaderStructs[j]);
				ReferencePool.Release(_modifyShaderStructs[j]);
			}
			_modifyShaderStructs.Clear();
		}
	}

	private void ChangeEntityMaterial(ChangeEntityMaterial material)
	{
		if (material.isMultiplePoint)
		{
			for (int i = 0; i < material.pointListName.Count; i++)
			{
				ExecuteChangeMatCommand(material, material.pointListName[i]);
			}
		}
		else
		{
			ExecuteChangeMatCommand(material, material.pointName);
		}
		ReferencePool.Release(material);
	}

	private int GenerateMaterialRuntimeId()
	{
		_materialRuntimeIdSeed++;
		if (_materialRuntimeIdSeed <= 0)
		{
			_materialRuntimeIdSeed = 1;
		}
		return _materialRuntimeIdSeed;
	}

	private static string GetMaterialCacheKey(int materialRuntimeId, string pointName)
	{
		return ZString.Format("{0}_{1}", materialRuntimeId, pointName);
	}

	private void SetMaterialCache(int materialRuntimeId, string pointName, Material material)
	{
		if (materialRuntimeId > 0 && !string.IsNullOrEmpty(pointName) && !(material == null))
		{
			string materialCacheKey = GetMaterialCacheKey(materialRuntimeId, pointName);
			if (_materialCacheDic.ContainsKey(materialCacheKey))
			{
				_materialCacheDic[materialCacheKey] = material;
			}
			else
			{
				_materialCacheDic.Add(materialCacheKey, material);
			}
		}
	}

	private bool TryGetMaterialCache(int materialRuntimeId, string pointName, out Material material)
	{
		string materialCacheKey = GetMaterialCacheKey(materialRuntimeId, pointName);
		return _materialCacheDic.TryGetValue(materialCacheKey, out material);
	}

	private void RemoveMaterialCache(int materialRuntimeId, string pointName, Material material)
	{
		if (materialRuntimeId <= 0 || string.IsNullOrEmpty(pointName) || material == null)
		{
			return;
		}
		string materialCacheKey = GetMaterialCacheKey(materialRuntimeId, pointName);
		if (_materialCacheDic.TryGetValue(materialCacheKey, out var value) && value == material)
		{
			_materialCacheDic.Remove(materialCacheKey);
			return;
		}
		string text = null;
		foreach (KeyValuePair<string, Material> item in _materialCacheDic)
		{
			if (item.Value == material)
			{
				text = item.Key;
				break;
			}
		}
		if (text != null)
		{
			_materialCacheDic.Remove(text);
		}
	}

	private void ExecuteChangeMatCommand(ChangeEntityMaterial material, string pointName)
	{
		Transform boneRoot = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(pointName);
		if (boneRoot == null)
		{
			return;
		}
		List<Material> rendererMats = CollectionPool<List<Material>, Material>.Get();
		if (!boneRoot.TryGetComponent<SkinnedMeshRenderer>(out var component))
		{
			CollectionPool<List<Material>, Material>.Release(rendererMats);
			return;
		}
		component.GetMaterials(rendererMats);
		int num = mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>()?.GetWrapperMaterialIndex(pointName, in rendererMats, material.materialIndex) ?? material.materialIndex;
		if (rendererMats.Count <= num && (material.materialType == ChangeEntityMaterialType.SET || material.materialType == ChangeEntityMaterialType.INHERITE))
		{
			CollectionPool<List<Material>, Material>.Release(rendererMats);
			return;
		}
		switch (material.materialType)
		{
		case ChangeEntityMaterialType.SET:
		{
			Material material3 = null;
			if (material.ChangeMatUniqueId > 0)
			{
				TryGetMaterialCache(material.ChangeMatUniqueId, pointName, out material3);
			}
			else
			{
				material3 = rendererMats[num];
			}
			material3.shader = material.material.shader;
			material3.CopyMatchingPropertiesFromMaterial(material.material);
			SetMaterialCache(material.materialRuntimeId, pointName, rendererMats[num]);
			break;
		}
		case ChangeEntityMaterialType.CREATE:
			rendererMats.Add(material.material);
			component.materials = rendererMats.ToArray();
			SetMaterialCache(material.materialRuntimeId, pointName, component.materials[component.materials.Length - 1]);
			break;
		case ChangeEntityMaterialType.SUB:
		{
			Material material4 = null;
			if (material.ChangeMatUniqueId > 0)
			{
				TryGetMaterialCache(material.ChangeMatUniqueId, pointName, out material4);
				if (rendererMats.Contains(material4))
				{
					rendererMats.Remove(material4);
				}
				component.materials = rendererMats.ToArray();
			}
			else if (rendererMats.Count > 1 && rendererMats.Count >= num + 1)
			{
				material4 = rendererMats[num];
				rendererMats.RemoveAt(num);
				component.materials = rendererMats.ToArray();
			}
			RemoveMaterialCache(material.materialRuntimeId, pointName, material4);
			break;
		}
		case ChangeEntityMaterialType.INHERITE:
		{
			Material material2;
			if (material.ChangeMatUniqueId > 0)
			{
				TryGetMaterialCache(material.ChangeMatUniqueId, pointName, out material2);
			}
			else
			{
				material2 = rendererMats[num];
			}
			Dictionary<ShaderPropertyInfo, object> materialPropertyDatas = GetMaterialPropertyDatas(material2, material.inheriteParams);
			material2.shader = material.material.shader;
			material2.CopyMatchingPropertiesFromMaterial(material.material);
			ApplyCopiedProperties(material2, materialPropertyDatas);
			SetMaterialCache(material.materialRuntimeId, pointName, material2);
			break;
		}
		}
		CollectionPool<List<Material>, Material>.Release(rendererMats);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ReleaseMaterialCommands();
		_materialStructs = null;
		_materialCacheDic.Clear();
		_materialCacheDic = null;
		ReleaseShaderCommands(_shaderStructs);
		_shaderStructs = null;
		ReleaseModifyShaderCommands();
		_modifyShaderStructs = null;
		_waitRemoveShaderStructs.Clear();
		_waitRemoveShaderStructs = null;
	}

	private void ReleaseMaterialCommands()
	{
		if (_materialStructs != null)
		{
			while (_materialStructs.Count > 0)
			{
				ReferencePool.Release(_materialStructs.Dequeue());
			}
		}
	}

	private static void ReleaseShaderCommands(List<ChangeShaderParam> shaderCommands)
	{
		if (shaderCommands != null)
		{
			for (int i = 0; i < shaderCommands.Count; i++)
			{
				ReferencePool.Release(shaderCommands[i]);
			}
			shaderCommands.Clear();
		}
	}

	private void ReleaseModifyShaderCommands()
	{
		if (_modifyShaderStructs != null)
		{
			for (int i = 0; i < _modifyShaderStructs.Count; i++)
			{
				ReferencePool.Release(_modifyShaderStructs[i]);
			}
			_modifyShaderStructs.Clear();
		}
	}

	private Dictionary<ShaderPropertyInfo, object> GetMaterialPropertyDatas(Material material, List<ShaderPropertyInfo> shaderParams)
	{
		if (shaderParams == null)
		{
			return null;
		}
		Dictionary<ShaderPropertyInfo, object> dictionary = new Dictionary<ShaderPropertyInfo, object>();
		foreach (ShaderPropertyInfo shaderParam in shaderParams)
		{
			if (material.HasProperty(shaderParam.GetName()))
			{
				switch (shaderParam.type)
				{
				case ShaderPropertyInfo.Type.Color:
					dictionary[shaderParam] = material.GetColor(shaderParam.GetName());
					break;
				case ShaderPropertyInfo.Type.Texture:
					dictionary[shaderParam] = material.GetTexture(shaderParam.GetName());
					break;
				case ShaderPropertyInfo.Type.Float:
					dictionary[shaderParam] = material.GetFloat(shaderParam.GetName());
					break;
				case ShaderPropertyInfo.Type.Range:
					dictionary[shaderParam] = material.GetFloat(shaderParam.GetName());
					break;
				case ShaderPropertyInfo.Type.Vector:
					dictionary[shaderParam] = material.GetVector(shaderParam.GetName());
					break;
				case ShaderPropertyInfo.Type.Int:
					dictionary[shaderParam] = material.GetInt(shaderParam.GetName());
					break;
				}
			}
		}
		return dictionary;
	}

	private void ApplyCopiedProperties(Material material, Dictionary<ShaderPropertyInfo, object> copiedProperties)
	{
		foreach (KeyValuePair<ShaderPropertyInfo, object> copiedProperty in copiedProperties)
		{
			ShaderPropertyInfo key = copiedProperty.Key;
			object value = copiedProperty.Value;
			if (material.HasProperty(key.GetName()))
			{
				switch (key.type)
				{
				case ShaderPropertyInfo.Type.Color:
					material.SetColor(key.GetName(), (Color)value);
					break;
				case ShaderPropertyInfo.Type.Texture:
					material.SetTexture(key.GetName(), (Texture)value);
					break;
				case ShaderPropertyInfo.Type.Float:
					material.SetFloat(key.GetName(), (float)value);
					break;
				case ShaderPropertyInfo.Type.Range:
					material.SetFloat(key.GetName(), (float)value);
					break;
				case ShaderPropertyInfo.Type.Vector:
					material.SetVector(key.GetName(), (Vector4)value);
					break;
				case ShaderPropertyInfo.Type.Int:
					material.SetInt(key.GetName(), (int)value);
					break;
				}
			}
		}
	}

	private bool GetAllRendererMat(string pointName, in List<Material> materials)
	{
		materials.Clear();
		Transform boneRoot = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot(pointName);
		if (boneRoot == null)
		{
			return false;
		}
		if (!boneRoot.TryGetComponent<SkinnedMeshRenderer>(out var component))
		{
			return false;
		}
		component.GetMaterials(materials);
		return true;
	}

	public void SetShaderParam(string pointName, int matIndex, float executeTime, string variableName, float tarValue, bool isEffectEnd)
	{
		ChangeShaderParam changeShaderParam = ReferencePool.Acquire<ChangeShaderParam>();
		List<Material> materials = CollectionPool<List<Material>, Material>.Get();
		if (!GetAllRendererMat(pointName, in materials))
		{
			CollectionPool<List<Material>, Material>.Release(materials);
			ReferencePool.Release(changeShaderParam);
			return;
		}
		mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>()?.RecalculateAbnormalMat(pointName, in materials, matIndex);
		if (matIndex >= materials.Count)
		{
			CollectionPool<List<Material>, Material>.Release(materials);
			ReferencePool.Release(changeShaderParam);
			return;
		}
		Material material = materials[matIndex];
		CollectionPool<List<Material>, Material>.Release(materials);
		if (!material.HasFloat(variableName))
		{
			ReferencePool.Release(changeShaderParam);
			return;
		}
		for (int i = 0; i < _shaderStructs.Count; i++)
		{
			ChangeShaderParam changeShaderParam2 = _shaderStructs[i];
			if (changeShaderParam2._currentDissolveMaterial == material && changeShaderParam2._currentVariableName == variableName)
			{
				_waitRemoveShaderStructs.Add(changeShaderParam2);
				break;
			}
		}
		changeShaderParam._currentDissolveMaterial = material;
		changeShaderParam._executeTime = executeTime;
		changeShaderParam._currentVariableName = variableName;
		changeShaderParam._currentValue = changeShaderParam._currentDissolveMaterial.GetFloat(changeShaderParam._currentVariableName);
		changeShaderParam._targetValue = tarValue;
		changeShaderParam._isEndShader = isEffectEnd;
		changeShaderParam._boneName = pointName;
		_shaderStructs.Add(changeShaderParam);
	}

	public void SetShaderParamByMaterialRuntimeId(string pointName, int materialRuntimeId, float executeTime, string variableName, float tarValue, bool isEffectEnd)
	{
		ChangeShaderParam changeShaderParam = ReferencePool.Acquire<ChangeShaderParam>();
		for (int i = 0; i < _shaderStructs.Count; i++)
		{
			ChangeShaderParam changeShaderParam2 = _shaderStructs[i];
			if (changeShaderParam2._useMaterialRuntimeId && changeShaderParam2._materialRuntimeId == materialRuntimeId && changeShaderParam2._boneName == pointName && changeShaderParam2._currentVariableName == variableName)
			{
				_waitRemoveShaderStructs.Add(changeShaderParam2);
				break;
			}
		}
		changeShaderParam._executeTime = executeTime;
		changeShaderParam._currentVariableName = variableName;
		changeShaderParam._targetValue = tarValue;
		changeShaderParam._isEndShader = isEffectEnd;
		changeShaderParam._boneName = pointName;
		changeShaderParam._useMaterialRuntimeId = true;
		changeShaderParam._materialRuntimeId = materialRuntimeId;
		_shaderStructs.Add(changeShaderParam);
	}

	public void SetShaderParam(string pointName, int matIndex, string variableName, float value, bool isEffectEnd)
	{
		ModifyShaderParam modifyShaderParam = ReferencePool.Acquire<ModifyShaderParam>();
		modifyShaderParam.operation = ShaderOperationType.SET;
		modifyShaderParam.pointName = pointName;
		modifyShaderParam.matIndex = matIndex;
		modifyShaderParam.variableName = variableName;
		modifyShaderParam.value = value;
		modifyShaderParam.isEffectEnd = isEffectEnd;
		_modifyShaderStructs.Add(modifyShaderParam);
	}

	public void SetShaderParamByMaterialRuntimeId(string pointName, int materialRuntimeId, string variableName, float value, bool isEffectEnd)
	{
		ModifyShaderParam modifyShaderParam = ReferencePool.Acquire<ModifyShaderParam>();
		modifyShaderParam.operation = ShaderOperationType.SET;
		modifyShaderParam.pointName = pointName;
		modifyShaderParam.materialRuntimeId = materialRuntimeId;
		modifyShaderParam.variableName = variableName;
		modifyShaderParam.value = value;
		modifyShaderParam.isEffectEnd = isEffectEnd;
		modifyShaderParam.useMaterialRuntimeId = true;
		_modifyShaderStructs.Add(modifyShaderParam);
	}

	public void AddShaderParam(string pointName, int matIndex, string variableName, float value, bool isEffectEnd)
	{
		ModifyShaderParam modifyShaderParam = ReferencePool.Acquire<ModifyShaderParam>();
		modifyShaderParam.operation = ShaderOperationType.ADD;
		modifyShaderParam.pointName = pointName;
		modifyShaderParam.matIndex = matIndex;
		modifyShaderParam.variableName = variableName;
		modifyShaderParam.value = value;
		modifyShaderParam.isEffectEnd = isEffectEnd;
		_modifyShaderStructs.Add(modifyShaderParam);
	}

	public void AddShaderParamByMaterialRuntimeId(string pointName, int materialRuntimeId, string variableName, float value, bool isEffectEnd)
	{
		ModifyShaderParam modifyShaderParam = ReferencePool.Acquire<ModifyShaderParam>();
		modifyShaderParam.operation = ShaderOperationType.ADD;
		modifyShaderParam.pointName = pointName;
		modifyShaderParam.materialRuntimeId = materialRuntimeId;
		modifyShaderParam.variableName = variableName;
		modifyShaderParam.value = value;
		modifyShaderParam.isEffectEnd = isEffectEnd;
		modifyShaderParam.useMaterialRuntimeId = true;
		_modifyShaderStructs.Add(modifyShaderParam);
	}

	private void ExecuteModifyShader(ModifyShaderParam param)
	{
		if (param == null)
		{
			return;
		}
		if (param.operation == ShaderOperationType.SET)
		{
			if (param.useMaterialRuntimeId)
			{
				SetShaderParamByMaterialRuntimeId(param);
			}
			else
			{
				SetShaderParam(param);
			}
		}
		else if (param.operation == ShaderOperationType.ADD)
		{
			if (param.useMaterialRuntimeId)
			{
				AddShaderParamByMaterialRuntimeId(param);
			}
			else
			{
				AddShaderParam(param);
			}
		}
	}

	private void SetShaderParam(ModifyShaderParam param)
	{
		List<Material> materials = CollectionPool<List<Material>, Material>.Get();
		if (!GetAllRendererMat(param.pointName, in materials))
		{
			CollectionPool<List<Material>, Material>.Release(materials);
			return;
		}
		EntityDynamicAbnormalMaterialComponent component = mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>();
		component?.RecalculateAbnormalMat(param.pointName, in materials, param.matIndex);
		if (param.matIndex >= materials.Count)
		{
			CollectionPool<List<Material>, Material>.Release(materials);
			return;
		}
		Material material = materials[param.matIndex];
		CollectionPool<List<Material>, Material>.Release(materials);
		if (!param.isEffectEnd || component == null || !component.TryRemoveAbnormalMat(param.pointName, material.name))
		{
			material.SetFloat(param.variableName, param.value);
		}
	}

	private void SetShaderParamByMaterialRuntimeId(ModifyShaderParam param)
	{
		if (TryGetMaterialCache(param.materialRuntimeId, param.pointName, out var material))
		{
			EntityDynamicAbnormalMaterialComponent component = mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>();
			if (!param.isEffectEnd || component == null || !component.TryRemoveAbnormalMat(param.pointName, material.name))
			{
				material.SetFloat(param.variableName, param.value);
			}
		}
	}

	private void AddShaderParam(ModifyShaderParam param)
	{
		List<Material> materials = CollectionPool<List<Material>, Material>.Get();
		if (!GetAllRendererMat(param.pointName, in materials))
		{
			CollectionPool<List<Material>, Material>.Release(materials);
			return;
		}
		EntityDynamicAbnormalMaterialComponent component = mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>();
		component?.RecalculateAbnormalMat(param.pointName, in materials, param.matIndex);
		if (param.matIndex >= materials.Count)
		{
			CollectionPool<List<Material>, Material>.Release(materials);
			return;
		}
		Material material = materials[param.matIndex];
		CollectionPool<List<Material>, Material>.Release(materials);
		if (!param.isEffectEnd || component == null || !component.TryRemoveAbnormalMat(param.pointName, material.name))
		{
			float num = material.GetFloat(param.variableName);
			material.SetFloat(param.variableName, num + param.value);
		}
	}

	private void AddShaderParamByMaterialRuntimeId(ModifyShaderParam param)
	{
		if (TryGetMaterialCache(param.materialRuntimeId, param.pointName, out var material))
		{
			EntityDynamicAbnormalMaterialComponent component = mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>();
			if (!param.isEffectEnd || component == null || !component.TryRemoveAbnormalMat(param.pointName, material.name))
			{
				float num = material.GetFloat(param.variableName);
				material.SetFloat(param.variableName, num + param.value);
			}
		}
	}

	private void CheckWaitRemoveShaderList()
	{
		for (int i = 0; i < _waitRemoveShaderStructs.Count; i++)
		{
			ChangeShaderParam changeShaderParam = _waitRemoveShaderStructs[i];
			if (_shaderStructs.Remove(changeShaderParam))
			{
				ReferencePool.Release(changeShaderParam);
			}
		}
		_waitRemoveShaderStructs.Clear();
	}

	private void RemoveShaderCommand(ChangeShaderParam shaderCommand)
	{
		_shaderStructs.Remove(shaderCommand);
		if (shaderCommand._isEndShader && !shaderCommand._useMaterialRuntimeId)
		{
			mBaseEntity.GetComponent<EntityDynamicAbnormalMaterialComponent>()?.TryRemoveAbnormalMat(shaderCommand._boneName, shaderCommand._currentDissolveMaterial.name);
		}
		ReferencePool.Release(shaderCommand);
	}

	private void ExecuteDissolve(float deltaTime, ChangeShaderParam shaderCommand)
	{
		if (shaderCommand._useMaterialRuntimeId)
		{
			if (!TryGetMaterialCache(shaderCommand._materialRuntimeId, shaderCommand._boneName, out var material))
			{
				RemoveShaderCommand(shaderCommand);
				return;
			}
			shaderCommand._currentDissolveMaterial = material;
			if (!shaderCommand._currentDissolveMaterial.HasFloat(shaderCommand._currentVariableName))
			{
				RemoveShaderCommand(shaderCommand);
				return;
			}
			if (!shaderCommand._isRuntimeMaterialInitialized)
			{
				for (int i = 0; i < _shaderStructs.Count; i++)
				{
					ChangeShaderParam changeShaderParam = _shaderStructs[i];
					if (changeShaderParam != shaderCommand && changeShaderParam._currentDissolveMaterial == material && changeShaderParam._currentVariableName == shaderCommand._currentVariableName)
					{
						_waitRemoveShaderStructs.Add(changeShaderParam);
						break;
					}
				}
				shaderCommand._currentValue = shaderCommand._currentDissolveMaterial.GetFloat(shaderCommand._currentVariableName);
				shaderCommand._isRuntimeMaterialInitialized = true;
			}
		}
		if (shaderCommand._executeTime == 0f || shaderCommand._targetValue == shaderCommand._currentValue)
		{
			shaderCommand._currentDissolveMaterial.SetFloat(shaderCommand._currentVariableName, shaderCommand._targetValue);
			RemoveShaderCommand(shaderCommand);
			return;
		}
		if (!shaderCommand._currentDissolveMaterial.HasFloat(shaderCommand._currentVariableName))
		{
			RemoveShaderCommand(shaderCommand);
			return;
		}
		shaderCommand._delta = (shaderCommand._targetValue - shaderCommand._currentValue) / (shaderCommand._executeTime / deltaTime);
		float num = shaderCommand._currentDissolveMaterial.GetFloat(shaderCommand._currentVariableName);
		num += shaderCommand._delta;
		if (shaderCommand._delta < 0f)
		{
			shaderCommand._currentDissolveMaterial.SetFloat(shaderCommand._currentVariableName, Mathf.Max(num, 0f));
			if (num <= shaderCommand._targetValue)
			{
				RemoveShaderCommand(shaderCommand);
			}
		}
		if (shaderCommand._delta > 0f)
		{
			shaderCommand._currentDissolveMaterial.SetFloat(shaderCommand._currentVariableName, Mathf.Min(num, 1f));
			if (num >= shaderCommand._targetValue)
			{
				RemoveShaderCommand(shaderCommand);
			}
		}
	}
}
