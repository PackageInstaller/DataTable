using System.Collections.Generic;
using Game.Graphics.Overdrawer;
using UnityEngine;

public class AdventureFXPlayer_Material : AdventureFXPlayer_Component
{
	public enum MaterialFXMode
	{
		Update,
		Replace,
		Override,
		Additional,
		AdditionalWithOverride
	}

	[Min(0f)]
	public float materialFXDelay;

	[Min(0f)]
	public float materialFXDuration = 1f;

	public bool materialFXLoop;

	public bool playReverseInRemain;

	[Space]
	public MaterialFXMode fxMode = MaterialFXMode.Override;

	public Material fxMaterial;

	[Tooltip("预绘制物体自身反向深度，使随后正常绘制时该物体绝不被场景几何遮挡（置顶）同时保持其自身前后顺序正常")]
	public bool enablePreReverseDepthInAdditionalMode;

	[Space]
	public string[] subParts;

	[Space]
	public MaterialFXPropertySetting[] propertySettings;

	protected RendererMaterialStackComponent _rendererMaterialStackComp;

	internal List<RendererMaterialStack> _rendererMaterialStackList = new List<RendererMaterialStack>();

	protected Overdrawable _overdrawableComp;

	protected List<OverdrawRenderer> _overdrawRendererPool;

	protected bool _materialFXPlayed;

	protected bool _materialFXDelayTriggered;

	protected int _materialID = -1;

	protected string[] _materialOverrideKeywords;

	public override bool isLoop => materialFXLoop;

	public override bool isStoped
	{
		get
		{
			if (_rendererMaterialStackComp != null && _fxPlayer.playbackTime <= materialFXDelay + materialFXDuration)
			{
				return false;
			}
			return true;
		}
	}

	public MaterialFXPropertySetting GetMaterialFXPropertySettingByName(string name)
	{
		if (propertySettings != null)
		{
			for (int i = 0; i < propertySettings.Length; i++)
			{
				MaterialFXPropertySetting materialFXPropertySetting = propertySettings[i];
				if (materialFXPropertySetting.materialPropertyName == name)
				{
					return materialFXPropertySetting;
				}
			}
		}
		return null;
	}

	public override void Initialize(AdventureFXPlayer fxPlayer)
	{
		base.Initialize(fxPlayer);
		if (propertySettings != null)
		{
			for (int i = 0; i < propertySettings.Length; i++)
			{
				MaterialFXPropertySetting materialFXPropertySetting = propertySettings[i];
				if (materialFXPropertySetting._materialPropertyID == -1 && !string.IsNullOrEmpty(materialFXPropertySetting.materialPropertyName))
				{
					materialFXPropertySetting._materialPropertyID = Shader.PropertyToID(materialFXPropertySetting.materialPropertyName);
				}
			}
		}
		if ((fxMode == MaterialFXMode.Additional || fxMode == MaterialFXMode.AdditionalWithOverride) && _overdrawableComp == null)
		{
			_overdrawableComp = gameObject.AddComponent<Overdrawable>();
			_overdrawableComp.overdrawShaderPassIndex = 0;
			_overdrawableComp.enablePreReverseDepth = enablePreReverseDepthInAdditionalMode;
			_overdrawRendererPool = new List<OverdrawRenderer>();
		}
	}

	public override void Release()
	{
		Stop();
		_rendererMaterialStackComp = null;
		_rendererMaterialStackList.Clear();
		if (_overdrawableComp != null)
		{
			foreach (OverdrawRenderer renderer in _overdrawableComp.renderers)
			{
				if (renderer.overrideMaterials != null)
				{
					RendererMaterialStack.DestroyMaterials(renderer.overrideMaterials);
					renderer.overrideMaterials = null;
				}
			}
			_overdrawableComp.renderers.Clear();
		}
		_materialFXDelayTriggered = false;
	}

	protected void Play_Internal()
	{
		if (!(_rendererMaterialStackComp != null))
		{
			return;
		}
		if (fxMode == MaterialFXMode.Additional || fxMode == MaterialFXMode.AdditionalWithOverride)
		{
			bool flag = fxMode == MaterialFXMode.AdditionalWithOverride;
			if (flag && _materialOverrideKeywords == null)
			{
				_materialOverrideKeywords = fxMaterial.shaderKeywords;
			}
			for (int i = 0; i < _rendererMaterialStackList.Count; i++)
			{
				RendererMaterialStack rendererMaterialStack = _rendererMaterialStackList.get_Item(i);
				Material[] overrideMaterials = rendererMaterialStack.CreateMaterial(fxMaterial, flag, _materialOverrideKeywords);
				OverdrawRenderer item = GenerateOverdrawRenderer(rendererMaterialStack.renderer, overrideMaterials);
				_overdrawableComp.renderers.Add(item);
			}
			EvaluateMaterialProperty(0f);
			_materialFXPlayed = true;
		}
		else if (fxMode == MaterialFXMode.Update)
		{
			if (propertySettings != null)
			{
				for (int j = 0; j < propertySettings.Length; j++)
				{
					propertySettings[j].StoreOriginProperty(this);
				}
			}
			EvaluateMaterialProperty(0f);
			_materialFXPlayed = true;
		}
		else if (fxMaterial != null)
		{
			bool flag2 = fxMode == MaterialFXMode.Override;
			if (flag2 && _materialOverrideKeywords == null)
			{
				_materialOverrideKeywords = fxMaterial.shaderKeywords;
			}
			_materialID = PushMaterial(fxMaterial, flag2, _materialOverrideKeywords);
			EvaluateMaterialProperty(0f);
			_materialFXPlayed = true;
		}
	}

	public override void Stop()
	{
		if (!(_rendererMaterialStackComp != null) || !_materialFXPlayed)
		{
			return;
		}
		if (fxMode == MaterialFXMode.Additional || fxMode == MaterialFXMode.AdditionalWithOverride)
		{
			for (int num = _rendererMaterialStackList.Count - 1; num >= 0; num--)
			{
				RendererMaterialStack rendererMaterialStack = _rendererMaterialStackList.get_Item(num);
				OverdrawRenderer overdrawRenderer = _overdrawableComp.renderers.get_Item(num);
				rendererMaterialStack.ReleaseMaterials(overdrawRenderer.overrideMaterials);
				ReleaseOverdrawRenderer(overdrawRenderer);
				_overdrawableComp.renderers.RemoveAt(num);
			}
		}
		else if (fxMode == MaterialFXMode.Update)
		{
			if (propertySettings != null)
			{
				for (int i = 0; i < propertySettings.Length; i++)
				{
					propertySettings[i].RestoreOriginProperty(this);
				}
			}
		}
		else
		{
			RemoveMaterial(fxMaterial);
		}
		_materialFXPlayed = false;
		_materialID = -1;
	}

	public override void UpdatePlayback(float dt)
	{
		if (!(_rendererMaterialStackComp != null))
		{
			return;
		}
		if (materialFXDelay > float.Epsilon && !_materialFXDelayTriggered && !_materialFXPlayed && _fxPlayer.playbackTime >= materialFXDelay)
		{
			Play_Internal();
			_materialFXDelayTriggered = true;
		}
		else if (!materialFXLoop && _materialFXPlayed && _fxPlayer.playbackTime >= materialFXDelay + materialFXDuration)
		{
			Stop();
		}
		else if (_materialFXPlayed)
		{
			float t = 0f;
			if (materialFXDuration > 0f)
			{
				t = (_fxPlayer.playbackTime - materialFXDelay) / materialFXDuration;
			}
			EvaluateMaterialProperty(t);
		}
	}

	public override void UpdatePlaybackInRemain(float dt)
	{
		if (playReverseInRemain && _rendererMaterialStackComp != null && _materialFXPlayed)
		{
			float t = 0f;
			if (_fxPlayer.remainTime > 0f)
			{
				t = _fxPlayer.remainTimer / _fxPlayer.remainTime;
			}
			EvaluateMaterialProperty(t);
		}
	}

	public override void OnBind(GameObject owner)
	{
		if (!owner.TryGetComponent<RendererMaterialStackComponent>(out _rendererMaterialStackComp))
		{
			_rendererMaterialStackComp = owner.AddComponent<RendererMaterialStackComponent>();
			_rendererMaterialStackComp.InitRendererMaterialStacks(includeInactive: false, includeMeshRenderer: true, includeSkinnedMeshRenderer: true, includeParticleSystemRenderer: false);
		}
		if (_rendererMaterialStackComp != null)
		{
			if (subParts != null && subParts.Length != 0)
			{
				CustomModelLODGroup component = owner.GetComponent<CustomModelLODGroup>();
				for (int i = 0; i < subParts.Length; i++)
				{
					Transform transform = _rendererMaterialStackComp.transform.Find(subParts[i]);
					if (!(transform != null))
					{
						continue;
					}
					RendererMaterialStack rendererMaterialStack = _rendererMaterialStackComp.GetRendererMaterialStack(transform.gameObject);
					if (rendererMaterialStack != null)
					{
						_rendererMaterialStackList.Add(rendererMaterialStack);
					}
					if (!(component != null))
					{
						continue;
					}
					Renderer renderer = component.FindLowLevelModelRendererFromHighLevelModelRenderer(transform.gameObject);
					if (renderer != null)
					{
						rendererMaterialStack = _rendererMaterialStackComp.GetRendererMaterialStack(renderer.gameObject);
						if (rendererMaterialStack != null)
						{
							_rendererMaterialStackList.Add(rendererMaterialStack);
						}
					}
				}
			}
			else
			{
				_rendererMaterialStackList.AddRange(_rendererMaterialStackComp.rendererMaterialStacks);
			}
		}
		if (materialFXDelay <= float.Epsilon)
		{
			Play_Internal();
		}
	}

	protected void EvaluateMaterialProperty(float t)
	{
		if (propertySettings != null)
		{
			for (int i = 0; i < propertySettings.Length; i++)
			{
				propertySettings[i].Evaluate(t, this);
			}
			if (fxMaterial != null)
			{
				UpdateSpecialMaterialProperties(fxMaterial);
			}
		}
	}

	protected void UpdateSpecialMaterialProperties(Material material)
	{
		if (material.HasFloat(GlobalShaderPropertyName.ObejctHeightMinID) || material.HasFloat(GlobalShaderPropertyName.ObjectHeightMaxID))
		{
			Bounds rendererEncapsulateBounds = _rendererMaterialStackComp.GetRendererEncapsulateBounds();
			SetMaterialPropertyFloat(GlobalShaderPropertyName.ObejctHeightMinID, rendererEncapsulateBounds.min.y);
			SetMaterialPropertyFloat(GlobalShaderPropertyName.ObjectHeightMaxID, rendererEncapsulateBounds.max.y);
		}
	}

	internal int PushMaterial(Material material, bool overrideMode = false, string[] overrideKeywords = null)
	{
		int result = 0;
		for (int i = 0; i < _rendererMaterialStackList.Count; i++)
		{
			result = _rendererMaterialStackList.get_Item(i).PushMaterial(material, overrideMode, overrideKeywords);
		}
		return result;
	}

	internal void RemoveMaterial(Material material)
	{
		for (int i = 0; i < _rendererMaterialStackList.Count; i++)
		{
			_rendererMaterialStackList.get_Item(i).RemoveMaterial(material);
		}
	}

	internal void SetMaterialPropertyFloat(int nameID, float value)
	{
		if (fxMode == MaterialFXMode.Additional || fxMode == MaterialFXMode.AdditionalWithOverride)
		{
			for (int i = 0; i < _overdrawableComp.renderers.Count; i++)
			{
				Material[] overrideMaterials = _overdrawableComp.renderers.get_Item(i).overrideMaterials;
				for (int j = 0; j < overrideMaterials.Length; j++)
				{
					overrideMaterials[j].SetFloat(nameID, value);
				}
			}
			return;
		}
		bool setToOriginMaterial = fxMode == MaterialFXMode.Update;
		for (int k = 0; k < _rendererMaterialStackList.Count; k++)
		{
			RendererMaterialStack rendererMaterialStack = _rendererMaterialStackList.get_Item(k);
			if (fxMode == MaterialFXMode.Update || rendererMaterialStack.currentMaterialID == _materialID)
			{
				rendererMaterialStack.MaterialsSetFloat(nameID, value, setToOriginMaterial);
			}
		}
	}

	internal void SetMaterialPropertyColor(int nameID, Color value)
	{
		if (fxMode == MaterialFXMode.Additional || fxMode == MaterialFXMode.AdditionalWithOverride)
		{
			for (int i = 0; i < _overdrawableComp.renderers.Count; i++)
			{
				Material[] overrideMaterials = _overdrawableComp.renderers.get_Item(i).overrideMaterials;
				for (int j = 0; j < overrideMaterials.Length; j++)
				{
					overrideMaterials[j].SetColor(nameID, value);
				}
			}
			return;
		}
		bool setToOriginMaterial = fxMode == MaterialFXMode.Update;
		for (int k = 0; k < _rendererMaterialStackList.Count; k++)
		{
			RendererMaterialStack rendererMaterialStack = _rendererMaterialStackList.get_Item(k);
			if (fxMode == MaterialFXMode.Update || rendererMaterialStack.currentMaterialID == _materialID)
			{
				rendererMaterialStack.MaterialsSetColor(nameID, value, setToOriginMaterial);
			}
		}
	}

	internal void SetMaterialPropertyVector(int nameID, Vector4 value)
	{
		if (fxMode == MaterialFXMode.Additional || fxMode == MaterialFXMode.AdditionalWithOverride)
		{
			for (int i = 0; i < _overdrawableComp.renderers.Count; i++)
			{
				Material[] overrideMaterials = _overdrawableComp.renderers.get_Item(i).overrideMaterials;
				for (int j = 0; j < overrideMaterials.Length; j++)
				{
					overrideMaterials[j].SetVector(nameID, value);
				}
			}
			return;
		}
		bool setToOriginMaterial = fxMode == MaterialFXMode.Update;
		for (int k = 0; k < _rendererMaterialStackList.Count; k++)
		{
			RendererMaterialStack rendererMaterialStack = _rendererMaterialStackList.get_Item(k);
			if (fxMode == MaterialFXMode.Update || rendererMaterialStack.currentMaterialID == _materialID)
			{
				rendererMaterialStack.MaterialsSetVector(nameID, value, setToOriginMaterial);
			}
		}
	}

	protected OverdrawRenderer GenerateOverdrawRenderer(Renderer renderer, Material[] overrideMaterials)
	{
		if (_overdrawRendererPool.Count > 0)
		{
			OverdrawRenderer overdrawRenderer = _overdrawRendererPool.get_Item(0);
			_overdrawRendererPool.RemoveAt(0);
			overdrawRenderer.renderer = renderer;
			overdrawRenderer.submeshCount = overrideMaterials.Length;
			overdrawRenderer.overrideMaterials = overrideMaterials;
			return overdrawRenderer;
		}
		return new OverdrawRenderer(renderer, overrideMaterials.Length)
		{
			overrideMaterials = overrideMaterials
		};
	}

	protected void ReleaseOverdrawRenderer(OverdrawRenderer renderer)
	{
		renderer.Clear();
		_overdrawRendererPool.Add(renderer);
	}
}
