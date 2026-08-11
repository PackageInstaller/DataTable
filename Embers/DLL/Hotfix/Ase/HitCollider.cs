using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using PrimitiveDetection;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public class HitCollider : SerializedMonoBehaviour
{
	public Dictionary<string, HitColliderEditorSetting> settingDict = new Dictionary<string, HitColliderEditorSetting>();

	private Dictionary<string, BasePrimitive> _primitives = new Dictionary<string, BasePrimitive>();

	private BasePrimitive GetPrimitive(VolumeData volumeData, out bool res)
	{
		res = false;
		if (!CheckPrimitiveType(volumeData.primitiveEnum, out var pType))
		{
			return null;
		}
		BasePrimitive basePrimitive = (BasePrimitive)ReferencePool.Acquire(pType);
		PrimitiveInfo info = default(PrimitiveInfo);
		if (!GetInfo(ref info, volumeData))
		{
			return null;
		}
		basePrimitive.OnInit(info, out var _);
		res = true;
		return basePrimitive;
	}

	private void ReUpdate()
	{
		Dictionary<string, HitColliderEditorSetting>.Enumerator enumerator = settingDict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator.Current.Value == null)
			{
				continue;
			}
			VolumeData volumeData = VolumeData.Create(enumerator.Current.Value);
			if (!_primitives.TryGetValue(enumerator.Current.Key, out var value))
			{
				if (enumerator.Current.Value.primitiveEnum == PrimitiveEnum.NONE)
				{
					volumeData?.OnDispose();
					continue;
				}
				_primitives.Add(enumerator.Current.Key, GetPrimitive(volumeData, out var _));
				volumeData?.OnDispose();
			}
			else if (enumerator.Current.Value.primitiveEnum != value.PrimitiveType)
			{
				value?.OnDispose();
				if (enumerator.Current.Value.primitiveEnum == PrimitiveEnum.NONE)
				{
					_primitives.Remove(enumerator.Current.Key);
					volumeData?.OnDispose();
				}
				else
				{
					_primitives.Add(enumerator.Current.Key, GetPrimitive(volumeData, out var _));
					volumeData?.OnDispose();
				}
			}
			else
			{
				PrimitiveInfo info = default(PrimitiveInfo);
				if (!GetInfo(ref info, volumeData))
				{
					volumeData?.OnDispose();
					continue;
				}
				value.OnInit(info, out var _);
				volumeData?.OnDispose();
			}
		}
		enumerator.Dispose();
	}

	private bool GetInfo(ref PrimitiveInfo info, VolumeData volumeData)
	{
		if (!CheckPrimitiveType(volumeData.primitiveEnum, out var _))
		{
			return false;
		}
		info = new PrimitiveInfo
		{
			Type = volumeData.primitiveEnum,
			Center = ((Component)this).transform.position + ((Component)this).transform.rotation * volumeData.offset,
			Quaternion = Quaternion.Euler(volumeData.eulerOffset) * ((Component)this).transform.rotation
		};
		if (!InitPrimitiveInfo(ref info, volumeData.primitiveParam))
		{
			return false;
		}
		info.showInfo = new PrimitiveShowInfo
		{
			isDrawShow = volumeData.isShow,
			drawColor = volumeData.color
		};
		return true;
	}

	private void UpdatePri()
	{
		Dictionary<string, BasePrimitive>.Enumerator enumerator = _primitives.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.OnDispose();
		}
		enumerator.Dispose();
		_primitives.Clear();
		ReUpdate();
	}

	private bool CheckPrimitiveType(PrimitiveEnum primitiveEnum, out Type pType)
	{
		switch (primitiveEnum)
		{
		case PrimitiveEnum.NONE:
			pType = null;
			return false;
		case PrimitiveEnum.BoxPrimitive:
			pType = typeof(BoxPrimitive);
			return true;
		case PrimitiveEnum.CapsulePrimitive:
			pType = typeof(CapsulePrimitive);
			return true;
		case PrimitiveEnum.SpherePrimitive:
			pType = typeof(SpherePrimitive);
			return true;
		default:
			pType = null;
			return false;
		}
	}

	private bool InitPrimitiveInfo(ref PrimitiveInfo info, List<float> param)
	{
		switch (info.Type)
		{
		case PrimitiveEnum.NONE:
			return false;
		case PrimitiveEnum.BoxPrimitive:
			if (param.Count < 3)
			{
				return false;
			}
			info.BoxSize = new Vector3(param[0], param[1], param[2]);
			return true;
		case PrimitiveEnum.CapsulePrimitive:
			if (param.Count < 2)
			{
				return false;
			}
			info.Radius = param[0];
			info.Height = param[1];
			return true;
		case PrimitiveEnum.SpherePrimitive:
			if (param.Count < 1)
			{
				return false;
			}
			info.Radius = param[0];
			return true;
		default:
			return false;
		}
	}
}
