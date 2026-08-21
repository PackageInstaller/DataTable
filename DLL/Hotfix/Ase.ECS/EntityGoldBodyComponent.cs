using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class EntityGoldBodyComponent : BaseComponent
{
	private Dictionary<Material, List<GoldBodyShaderDataBase>> _oriVariableDict = new Dictionary<Material, List<GoldBodyShaderDataBase>>();

	private List<GoldBodyData> _applyingDatas = new List<GoldBodyData>();

	private List<GoldBodyData> _disappearingDatas = new List<GoldBodyData>();

	private float _disTimer;

	private const string StrEdge = "_GoldOrEdge";

	private const string StrLightSize = "_GoldLightSize";

	public override void OnInit(object data)
	{
		base.OnInit(data);
		GetMatsAndInit();
	}

	private void GetMatsAndInit()
	{
		_oriVariableDict.Clear();
		Renderer[] array = mBaseEntity.GetEntityObject()?.GetComponentsInChildren<Renderer>();
		if (array == null)
		{
			return;
		}
		List<Material> list = new List<Material>();
		Renderer[] array2 = array;
		foreach (Renderer obj in array2)
		{
			list.Clear();
			obj.GetMaterials(list);
			foreach (Material item in list)
			{
				if (item.shader.name.Equals("KIIF/NPR_Advanced"))
				{
					_oriVariableDict.Add(item, GoldBodyShaderDataBase.CreateOriginalDatas(item));
				}
			}
		}
		list = null;
	}

	public void AddGoldBodyData(int attackPower, int weaknessLevel)
	{
		if (_applyingDatas.Count > 0)
		{
			if (_applyingDatas[0].AttackPower > attackPower)
			{
				return;
			}
			if (_disappearingDatas.Count > 0)
			{
				_disappearingDatas[0].OnDispose();
				_disappearingDatas.Clear();
			}
			_applyingDatas[0].OnDispose();
			_applyingDatas.Clear();
		}
		_applyingDatas.Add(GoldBodyData.Create(attackPower, mBaseEntity));
		ApplyData(_applyingDatas[0], attackPower, GetWeaknessLevelColor(weaknessLevel));
	}

	private Color GetWeaknessLevelColor(int weaknessLevel)
	{
		return weaknessLevel switch
		{
			0 => Color.white, 
			1 => Color.white, 
			2 => Color.yellow, 
			_ => Color.red, 
		};
	}

	private void ApplyData(GoldBodyData data, int attackPower, Color flashColor)
	{
		foreach (Material key in _oriVariableDict.Keys)
		{
			ApplyColorDataByName(key, "_GoldLightColor", flashColor);
			ApplyFloatDataByName(key, "_GoldOrEdge", GetEdgeFloat(data, attackPower));
			ApplyFloatDataByName(key, "_GoldLightSize", GetLightSizeFloat(data, attackPower));
		}
	}

	private void ApplyColorDataByName(Material material, string name, Color value)
	{
		GoldBodyShaderColorData goldBodyShaderColorData = GoldBodyShaderColorData.Create(material, name, value);
		goldBodyShaderColorData.ApplyValue();
		goldBodyShaderColorData.OnDispose();
	}

	private void ApplyFloatDataByName(Material material, string name, float value)
	{
		GoldBodyShaderFloatData goldBodyShaderFloatData = GoldBodyShaderFloatData.Create(material, name, value);
		goldBodyShaderFloatData.ApplyValue();
		goldBodyShaderFloatData.OnDispose();
	}

	private float GetEdgeFloat(GoldBodyData data, int attackPower)
	{
		attackPower = ((attackPower >= 0) ? attackPower : 0);
		attackPower = ((attackPower > 10) ? 10 : attackPower);
		return (float)((attackPower > 0) ? 1 : 0) * data.GoldBodyOriData + (float)((attackPower - 1 >= 0) ? (attackPower - 1) : 0) * data.GoldBodyDelta;
	}

	private float GetLightSizeFloat(GoldBodyData data, int attackPower)
	{
		return data.GoldBodySize;
	}

	private void Reverting(float deltaTime)
	{
		_disTimer += deltaTime;
		if (_disTimer >= _disappearingDatas[0].GoldDisappearTime)
		{
			_disappearingDatas[0].OnDispose();
			_disappearingDatas.Clear();
			RevertData();
			return;
		}
		foreach (KeyValuePair<Material, List<GoldBodyShaderDataBase>> item in _oriVariableDict)
		{
			GoldBodyShaderFloatData goldBodyShaderFloatData = null;
			GoldBodyShaderFloatData goldBodyShaderFloatData2 = null;
			foreach (GoldBodyShaderDataBase item2 in item.Value)
			{
				if (item2.Name.Equals("_GoldOrEdge"))
				{
					goldBodyShaderFloatData = (GoldBodyShaderFloatData)item2;
				}
				else if (item2.Name.Equals("_GoldLightSize"))
				{
					goldBodyShaderFloatData2 = (GoldBodyShaderFloatData)item2;
				}
				if (goldBodyShaderFloatData != null && goldBodyShaderFloatData2 != null)
				{
					break;
				}
			}
			if (goldBodyShaderFloatData != null)
			{
				ApplyFloatDataByName(item.Key, "_GoldOrEdge", Mathf.Lerp(goldBodyShaderFloatData.Material.GetFloat("_GoldOrEdge"), goldBodyShaderFloatData.GetValue(), deltaTime / (_disappearingDatas[0].GoldDisappearTime - _disTimer)));
			}
			if (goldBodyShaderFloatData2 != null)
			{
				ApplyFloatDataByName(item.Key, "_GoldLightSize", Mathf.Lerp(goldBodyShaderFloatData2.Material.GetFloat("_GoldLightSize"), goldBodyShaderFloatData2.GetValue(), deltaTime / (_disappearingDatas[0].GoldDisappearTime - _disTimer)));
			}
		}
	}

	private void RevertData()
	{
		foreach (List<GoldBodyShaderDataBase> value in _oriVariableDict.Values)
		{
			foreach (GoldBodyShaderDataBase item in value)
			{
				item.ApplyValue();
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		deltaTime = 0.033f;
		if (_applyingDatas.Count <= 0 && _disappearingDatas.Count <= 0)
		{
			return;
		}
		if (_applyingDatas.Count <= 0)
		{
			if (_disappearingDatas.Count > 0)
			{
				Reverting(deltaTime);
			}
		}
		else if (_applyingDatas[0].IsEnd)
		{
			if (_disappearingDatas.Count > 0)
			{
				_disappearingDatas[0].OnDispose();
				_disappearingDatas.Clear();
			}
			_disappearingDatas.Add(_applyingDatas[0]);
			_applyingDatas.Clear();
			_disTimer = 0f;
		}
		else
		{
			_applyingDatas[0].OnUpdate(deltaTime);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		RevertData();
		foreach (List<GoldBodyShaderDataBase> value in _oriVariableDict.Values)
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i]?.OnDispose();
			}
		}
		_oriVariableDict.Clear();
		for (int j = 0; j < _applyingDatas.Count; j++)
		{
			_applyingDatas[j]?.OnDispose();
		}
		_applyingDatas.Clear();
		for (int k = 0; k < _disappearingDatas.Count; k++)
		{
			_disappearingDatas[k]?.OnDispose();
		}
		_disappearingDatas.Clear();
	}
}
