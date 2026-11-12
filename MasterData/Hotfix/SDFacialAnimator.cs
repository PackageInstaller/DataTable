using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class SDFacialAnimator : MonoBehaviour
{
	public SkinnedMeshRenderer faceRenderer;

	public SkinnedMeshRenderer blankFaceRenderer;

	public SkinnedMeshRenderer eyebrowRenderer;

	public SkinnedMeshRenderer specialEyeRenderer;

	public SkinnedMeshRenderer specialEyeMirrorRenderer;

	public SkinnedMeshRenderer blushRenderer;

	public SkinnedMeshRenderer blushMirrorRenderer;

	public SkinnedMeshRenderer mouthRenderer;

	public SDFacialAnimationConfigData configData;

	private Material _defaultFaceMaterial;

	private Material _defaultBlankFaceMaterial;

	private Material _defaultMouthMaterial;

	private bool _defaultMaterialsSnapshotted;

	private int _faceBlinkIndex = -1;

	private readonly List<Material> _materialBuffer = new List<Material>();

	private bool _inited;

	private SDFacialExpression _currentExpression;

	private const string kFaceNodeName = "face";

	private const string kBlankFaceNodeName = "Face_Blank";

	private const string kEyebrowNodeName = "eyebrow";

	private const string kSpecialEyeNodeName = "eye";

	private const string kSpecialEyeMirrorNodeName = "eye_mirror";

	private const string kRougeNodeName = "rouge";

	private const string kRougeMirrorNodeName = "rouge_mirror";

	private const string kMouthNodeName = "mouth";

	private const string kBlinkBlendShapeName = "face000";

	private const float kBlendShapeWeight = 100f;

	public SDFacialExpression currentExpression => _currentExpression;

	private int FaceMaterialSlot
	{
		get
		{
			if (!(configData != null))
			{
				return 1;
			}
			return configData.faceRendererFaceSlot;
		}
	}

	private void Awake()
	{
		Init();
	}

	public void Init()
	{
		if (!_inited)
		{
			_inited = true;
			SnapshotDefaultMaterials();
			_faceBlinkIndex = ((faceRenderer != null && faceRenderer.sharedMesh != null) ? faceRenderer.sharedMesh.GetBlendShapeIndex("face000") : (-1));
			SetExpression(SDFacialExpression.Normal);
		}
	}

	private void ResolveNodes()
	{
		Transform transform = base.transform.Find("face");
		faceRenderer = ((transform != null) ? transform.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform2 = base.transform.Find("Face_Blank");
		blankFaceRenderer = ((transform2 != null) ? transform2.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform3 = base.transform.Find("eyebrow");
		eyebrowRenderer = ((transform3 != null) ? transform3.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform4 = base.transform.Find("eye");
		specialEyeRenderer = ((transform4 != null) ? transform4.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform5 = base.transform.Find("eye_mirror");
		specialEyeMirrorRenderer = ((transform5 != null) ? transform5.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform6 = base.transform.Find("rouge");
		blushRenderer = ((transform6 != null) ? transform6.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform7 = base.transform.Find("rouge_mirror");
		blushMirrorRenderer = ((transform7 != null) ? transform7.GetComponent<SkinnedMeshRenderer>() : null);
		Transform transform8 = base.transform.Find("mouth");
		mouthRenderer = ((transform8 != null) ? transform8.GetComponent<SkinnedMeshRenderer>() : null);
	}

	private void SnapshotDefaultMaterials()
	{
		if (configData != null && configData.defaultFaceMaterial != null)
		{
			_defaultFaceMaterial = configData.defaultFaceMaterial;
		}
		else if (!_defaultMaterialsSnapshotted)
		{
			_defaultFaceMaterial = GetMaterialSlot(faceRenderer, FaceMaterialSlot);
		}
		if (configData != null && configData.defaultBlankFaceMaterial != null)
		{
			_defaultBlankFaceMaterial = configData.defaultBlankFaceMaterial;
		}
		else if (!_defaultMaterialsSnapshotted && blankFaceRenderer != null)
		{
			_defaultBlankFaceMaterial = blankFaceRenderer.sharedMaterial;
		}
		if (configData != null && configData.defaultMouthMaterial != null)
		{
			_defaultMouthMaterial = configData.defaultMouthMaterial;
		}
		else if (!_defaultMaterialsSnapshotted && mouthRenderer != null)
		{
			_defaultMouthMaterial = mouthRenderer.sharedMaterial;
		}
		_defaultMaterialsSnapshotted = true;
	}

	public void SetExpression(SDFacialExpression id)
	{
		if (configData == null)
		{
			Debug.LogError("[SDFacialAnimator] \"" + name + "\"未配置 config，无法切换表情");
			return;
		}
		if (!_inited)
		{
			Init();
		}
		ResetExpression();
		switch (id)
		{
		case SDFacialExpression.None:
			_currentExpression = id;
			return;
		case SDFacialExpression.TimelineBaseNormalFace:
			SetMouth(show: false, null);
			_currentExpression = id;
			return;
		case SDFacialExpression.TimelineBaseBlankFace:
			SetBlankFace(useBlank: true);
			SetMouth(show: false, null);
			_currentExpression = id;
			return;
		}
		if (!configData.TryGetEntry(id, out var entry) || entry == null)
		{
			Debug.LogWarning($"[SDFacialAnimator] \"{name}\"配置中找不到表情 {id}，回落到 Normal");
			if (id != SDFacialExpression.Normal && configData.TryGetEntry(SDFacialExpression.Normal, out entry) && entry != null)
			{
				ApplyExpressionEntry(entry);
			}
			_currentExpression = SDFacialExpression.Normal;
		}
		else
		{
			ApplyExpressionEntry(entry);
			_currentExpression = id;
		}
	}

	private void ApplyExpressionEntry(SDFacialAnimationConfigData.FacialExpressionEntry entry)
	{
		SetBlankFace(entry.useBlankFace);
		if (entry.faceMaterial != null)
		{
			SetFaceMaterial(entry.faceMaterial);
		}
		ApplyBlendShape(entry);
		SetSpecialEye(entry);
		SetBlush(entry);
		SetMouth(show: true, entry.mouthMaterial);
	}

	private void ResetExpression()
	{
		SetBlankFace(useBlank: false);
		SetFaceMaterial(null);
		ZeroBlendShapes(faceRenderer, _faceBlinkIndex);
		ZeroBlendShapes(eyebrowRenderer, -1);
		SetPlane(specialEyeRenderer, enable: false, null);
		SetPlane(specialEyeMirrorRenderer, enable: false, null);
		SetPlane(blushRenderer, enable: false, null);
		SetPlane(blushMirrorRenderer, enable: false, null);
		SetMouth(show: true, null);
	}

	public void SetExpressionWeight(float weight01)
	{
		if (!_inited)
		{
			Init();
		}
		if (!(configData == null) && configData.TryGetEntry(_currentExpression, out var entry) && entry != null)
		{
			float weight2 = Mathf.Clamp01(weight01) * 100f;
			SetBlendShapeWeight(faceRenderer, entry.faceBlendShapeName, weight2);
			SetBlendShapeWeight(eyebrowRenderer, entry.eyebrowBlendShapeName, weight2);
		}
	}

	private void ZeroBlendShapes(SkinnedMeshRenderer renderer, int skipIndex)
	{
		if (renderer == null || renderer.sharedMesh == null)
		{
			return;
		}
		int blendShapeCount = renderer.sharedMesh.blendShapeCount;
		for (int i = 0; i < blendShapeCount; i++)
		{
			if (i != skipIndex)
			{
				renderer.SetBlendShapeWeight(i, 0f);
			}
		}
	}

	private void ApplyBlendShape(SDFacialAnimationConfigData.FacialExpressionEntry entry)
	{
		SetBlendShapeWeight(faceRenderer, entry.faceBlendShapeName, 100f);
		SetBlendShapeWeight(eyebrowRenderer, entry.eyebrowBlendShapeName, 100f);
	}

	private void SetBlankFace(bool useBlank)
	{
		if (blankFaceRenderer != null)
		{
			blankFaceRenderer.gameObject.SetActive(useBlank);
		}
		if (faceRenderer != null)
		{
			faceRenderer.gameObject.SetActive(!useBlank);
		}
	}

	private void SetFaceMaterial(Material mat)
	{
		SetMaterialSlot(faceRenderer, FaceMaterialSlot, (mat != null) ? mat : _defaultFaceMaterial);
		if (blankFaceRenderer != null)
		{
			blankFaceRenderer.sharedMaterial = ((mat != null) ? mat : _defaultBlankFaceMaterial);
		}
	}

	private void SetSpecialEye(SDFacialAnimationConfigData.FacialExpressionEntry entry)
	{
		if (!entry.enableSpecialEye)
		{
			SetPlane(specialEyeRenderer, enable: false, null);
			SetPlane(specialEyeMirrorRenderer, enable: false, null);
		}
		else if (entry.eyeUseMirror)
		{
			SetPlane(specialEyeRenderer, enable: false, null);
			SetPlane(specialEyeMirrorRenderer, enable: true, entry.eyeMaterial);
		}
		else
		{
			SetPlane(specialEyeRenderer, enable: true, entry.eyeMaterial);
			SetPlane(specialEyeMirrorRenderer, enable: false, null);
		}
	}

	private void SetBlush(SDFacialAnimationConfigData.FacialExpressionEntry entry)
	{
		if (!entry.enableBlush)
		{
			SetPlane(blushRenderer, enable: false, null);
			SetPlane(blushMirrorRenderer, enable: false, null);
		}
		else if (entry.blushUseMirror)
		{
			SetPlane(blushRenderer, enable: false, null);
			SetPlane(blushMirrorRenderer, enable: true, entry.blushMaterial);
		}
		else
		{
			SetPlane(blushRenderer, enable: true, entry.blushMaterial);
			SetPlane(blushMirrorRenderer, enable: false, null);
		}
	}

	private void SetMouth(bool show, Material mat)
	{
		if (!(mouthRenderer == null))
		{
			mouthRenderer.gameObject.SetActive(show);
			if (show)
			{
				mouthRenderer.sharedMaterial = ((mat != null) ? mat : _defaultMouthMaterial);
			}
		}
	}

	private void SetBlendShapeWeight(SkinnedMeshRenderer renderer, string shapeName, float weight)
	{
		if (!(renderer == null) && !(renderer.sharedMesh == null) && !string.IsNullOrEmpty(shapeName))
		{
			int blendShapeIndex = renderer.sharedMesh.GetBlendShapeIndex(shapeName);
			if (blendShapeIndex >= 0)
			{
				renderer.SetBlendShapeWeight(blendShapeIndex, weight);
			}
		}
	}

	private void SetPlane(SkinnedMeshRenderer renderer, bool enable, Material mat)
	{
		if (!(renderer == null))
		{
			renderer.gameObject.SetActive(enable);
			if (enable && mat != null)
			{
				renderer.sharedMaterial = mat;
			}
		}
	}

	private Material GetMaterialSlot(SkinnedMeshRenderer renderer, int slot)
	{
		if (renderer == null)
		{
			return null;
		}
		renderer.GetSharedMaterials(_materialBuffer);
		if (slot < 0 || slot >= _materialBuffer.Count)
		{
			return null;
		}
		return _materialBuffer.get_Item(slot);
	}

	private void SetMaterialSlot(SkinnedMeshRenderer renderer, int slot, Material mat)
	{
		if (!(renderer == null))
		{
			renderer.GetSharedMaterials(_materialBuffer);
			if (slot >= 0 && slot < _materialBuffer.Count && !(_materialBuffer.get_Item(slot) == mat))
			{
				_materialBuffer.set_Item(slot, mat);
				renderer.SetSharedMaterials(_materialBuffer);
			}
		}
	}

	public void SetBlink(float weight01)
	{
		if (!_inited)
		{
			Init();
		}
		if (!(faceRenderer == null) && _faceBlinkIndex >= 0)
		{
			float value = Mathf.Clamp01(weight01) * 100f;
			faceRenderer.SetBlendShapeWeight(_faceBlinkIndex, value);
		}
	}
}
