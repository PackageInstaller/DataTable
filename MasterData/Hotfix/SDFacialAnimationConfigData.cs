using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "SDFacialAnimationConfig", menuName = "游戏/SD角色/表情配置")]
public class SDFacialAnimationConfigData : ScriptableObject
{
	[Serializable]
	public class FacialExpressionEntry
	{
		public SDFacialExpression id;

		[Tooltip("勾选后视为手工修改，自动配置时跳过此条，不被覆盖")]
		public bool manualConfig;

		public bool useBlankFace;

		[Tooltip("如阴沉脸等整脸特殊表情；为空则用默认脸材质")]
		public Material faceMaterial;

		[Tooltip("如 face003；留空表示该表情不操作 face 的 BlendShape")]
		public string faceBlendShapeName;

		[Tooltip("如 eyebrow003；留空表示该表情不操作 eyebrow 的 BlendShape")]
		public string eyebrowBlendShapeName;

		public bool enableSpecialEye;

		public bool eyeUseMirror;

		public Material eyeMaterial;

		public bool enableBlush;

		public bool blushUseMirror;

		public Material blushMaterial;

		[Tooltip("为空则用默认嘴型材质")]
		public Material mouthMaterial;
	}

	public Material defaultFaceMaterial;

	public int faceRendererFaceSlot = 1;

	public Material defaultBlankFaceMaterial;

	public Material defaultMouthMaterial;

	public List<FacialExpressionEntry> entries = new List<FacialExpressionEntry>();

	[NonSerialized]
	private Dictionary<SDFacialExpression, FacialExpressionEntry> _lookup;

	public Dictionary<SDFacialExpression, FacialExpressionEntry> GetLookup()
	{
		if (_lookup != null)
		{
			return _lookup;
		}
		_lookup = new Dictionary<SDFacialExpression, FacialExpressionEntry>(entries.Count);
		for (int i = 0; i < entries.Count; i++)
		{
			FacialExpressionEntry facialExpressionEntry = entries.get_Item(i);
			if (facialExpressionEntry != null)
			{
				_lookup.set_Item(facialExpressionEntry.id, facialExpressionEntry);
			}
		}
		return _lookup;
	}

	public bool TryGetEntry(SDFacialExpression id, out FacialExpressionEntry entry)
	{
		return GetLookup().TryGetValue(id, out entry);
	}

	public void InvalidateLookup()
	{
		_lookup = null;
	}
}
