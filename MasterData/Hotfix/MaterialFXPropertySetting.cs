using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

[Serializable]
public class MaterialFXPropertySetting
{
	public enum MaterialFXPropertyType
	{
		[InspectorName("数值")]
		Float = 0,
		[InspectorName("颜色")]
		Color = 1,
		[InspectorName("本地空间坐标")]
		LocalPosition = 2,
		[InspectorName("世界空间坐标")]
		WorldPosition = 3,
		[InspectorName("世界空间方向")]
		WorldDirection = 5,
		[InspectorName("世界空间大小")]
		WorldSize = 7
	}

	public enum MaterialFXPropertyShape
	{
		[InspectorName("无")]
		None,
		[InspectorName("球型")]
		Sphere,
		[InspectorName("方型")]
		Box
	}

	internal struct OriginProperty
	{
		public Vector4 vector;

		public float value
		{
			get
			{
				return vector.x;
			}
			set
			{
				vector.x = value;
			}
		}

		public Color color
		{
			get
			{
				return vector;
			}
			set
			{
				vector = value;
			}
		}
	}

	public string materialPropertyName = "_FX_Weight";

	[FormerlySerializedAs("useMaterialPropertyColorType")]
	public MaterialFXPropertyType propertyType;

	public AnimationCurve materialPropertyCurve;

	public Gradient materialPropertyGradient;

	public bool useHDRColor;

	public float hdrExposure;

	public Transform materialPropertyTransform;

	public MaterialFXPropertyShape materialPropertyShape;

	public bool materialPropertyHoldInLoop;

	internal int _materialPropertyID = -1;

	internal List<OriginProperty> _originPropertyList;

	internal void StoreOriginProperty(AdventureFXPlayer_Material player)
	{
		if (_originPropertyList == null)
		{
			_originPropertyList = new List<OriginProperty>();
		}
		else
		{
			_originPropertyList.Clear();
		}
		if (_materialPropertyID == -1)
		{
			return;
		}
		for (int i = 0; i < player._rendererMaterialStackList.Count; i++)
		{
			RendererMaterialStack rendererMaterialStack = player._rendererMaterialStackList.get_Item(i);
			OriginProperty item = default;
			Material originMaterial = rendererMaterialStack.originMaterial;
			if (originMaterial != null)
			{
				switch (propertyType)
				{
				case MaterialFXPropertyType.Float:
					item.value = (originMaterial.HasFloat(_materialPropertyID) ? originMaterial.GetFloat(_materialPropertyID) : 0f);
					break;
				case MaterialFXPropertyType.Color:
					item.color = (originMaterial.HasColor(_materialPropertyID) ? originMaterial.GetColor(_materialPropertyID) : default(Color));
					break;
				case MaterialFXPropertyType.LocalPosition:
				case MaterialFXPropertyType.WorldPosition:
				case MaterialFXPropertyType.WorldDirection:
				case MaterialFXPropertyType.WorldSize:
					item.vector = (originMaterial.HasVector(_materialPropertyID) ? originMaterial.GetVector(_materialPropertyID) : default(Vector4));
					break;
				}
			}
			_originPropertyList.Add(item);
		}
	}

	internal void RestoreOriginProperty(AdventureFXPlayer_Material player)
	{
		if (_materialPropertyID == -1)
		{
			return;
		}
		for (int i = 0; i < player._rendererMaterialStackList.Count; i++)
		{
			RendererMaterialStack rendererMaterialStack = player._rendererMaterialStackList.get_Item(i);
			OriginProperty originProperty = _originPropertyList.get_Item(i);
			switch (propertyType)
			{
			case MaterialFXPropertyType.Float:
				rendererMaterialStack.MaterialsSetFloat(_materialPropertyID, originProperty.value, setToOriginMaterial: true);
				break;
			case MaterialFXPropertyType.Color:
				rendererMaterialStack.MaterialsSetColor(_materialPropertyID, originProperty.color, setToOriginMaterial: true);
				break;
			case MaterialFXPropertyType.LocalPosition:
			case MaterialFXPropertyType.WorldPosition:
			case MaterialFXPropertyType.WorldDirection:
			case MaterialFXPropertyType.WorldSize:
				rendererMaterialStack.MaterialsSetVector(_materialPropertyID, originProperty.vector, setToOriginMaterial: true);
				break;
			}
		}
	}

	internal void Evaluate(float t, AdventureFXPlayer_Material player)
	{
		if (_materialPropertyID == -1)
		{
			return;
		}
		float time = ((!materialPropertyHoldInLoop) ? (t - Mathf.Floor(t)) : Mathf.Clamp01(t));
		switch (propertyType)
		{
		case MaterialFXPropertyType.Float:
		{
			float value6 = materialPropertyCurve.Evaluate(time);
			player.SetMaterialPropertyFloat(_materialPropertyID, value6);
			break;
		}
		case MaterialFXPropertyType.Color:
		{
			Color value2 = materialPropertyGradient.Evaluate(time);
			if (useHDRColor)
			{
				float num = Mathf.Pow(2f, hdrExposure);
				value2.r *= num;
				value2.g *= num;
				value2.b *= num;
			}
			player.SetMaterialPropertyColor(_materialPropertyID, value2);
			break;
		}
		case MaterialFXPropertyType.LocalPosition:
		{
			Vector4 value4 = ((materialPropertyTransform != null) ? materialPropertyTransform.localPosition : default(Vector3));
			player.SetMaterialPropertyVector(_materialPropertyID, value4);
			break;
		}
		case MaterialFXPropertyType.WorldPosition:
		{
			Vector4 value3 = ((materialPropertyTransform != null) ? materialPropertyTransform.position : default(Vector3));
			player.SetMaterialPropertyVector(_materialPropertyID, value3);
			break;
		}
		case MaterialFXPropertyType.WorldDirection:
		{
			Vector4 value5 = ((materialPropertyTransform != null) ? materialPropertyTransform.forward : default(Vector3));
			player.SetMaterialPropertyVector(_materialPropertyID, value5);
			break;
		}
		case MaterialFXPropertyType.WorldSize:
		{
			Vector4 value = ((materialPropertyTransform != null) ? materialPropertyTransform.lossyScale : default(Vector3));
			value.w = (float)materialPropertyShape;
			player.SetMaterialPropertyVector(_materialPropertyID, value);
			break;
		}
		case (MaterialFXPropertyType)4:
		case (MaterialFXPropertyType)6:
			break;
		}
	}
}
