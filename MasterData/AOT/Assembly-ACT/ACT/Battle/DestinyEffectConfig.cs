using System;
using Bamboo.AssetField;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class DestinyEffectConfig : IDisposable
{
	public enum EffectType
	{
		BindingEffect,
		HighLight
	}

	public EffectType effectType;

	public YooAssetReference<GameObject> bindingEffectName;

	public Transform bindingRoot;

	public Renderer renderer;

	[ColorUsage(true, true)]
	public Color highLightColor;

	private AssetLoadHandle _handle;

	private MaterialPropertyBlock _propertyBlock;

	private Color? _defaultColor;

	public void EnableEffect()
	{
		switch (effectType)
		{
		case EffectType.BindingEffect:
			if (!_handle.IsValid)
			{
				_handle = AssetStationManager.BattleStation.InstantiateAsync(bindingEffectName, bindingRoot.position, bindingRoot.rotation, bindingRoot);
			}
			_handle.Completed -= AssetDisable;
			_handle.Completed += AssetEnable;
			break;
		case EffectType.HighLight:
			if (_propertyBlock == null)
			{
				_propertyBlock = new MaterialPropertyBlock();
			}
			_defaultColor = renderer.sharedMaterial.GetColor(BattleConsts.SHADER_EMISSION_COLOR);
			renderer.GetPropertyBlock(_propertyBlock);
			_propertyBlock.SetColor(BattleConsts.SHADER_EMISSION_COLOR, highLightColor);
			renderer.SetPropertyBlock(_propertyBlock);
			break;
		}
	}

	private void AssetEnable(AssetLoadHandle handle)
	{
		try
		{
			GameObject gameObject = handle.As<GameObject>();
			gameObject.SetActive(value: true);
			gameObject.transform.SetParent(bindingRoot);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.identity;
		}
		catch (Exception e)
		{
			LogConfigException("AssetEnable", e);
		}
	}

	private void AssetDisable(AssetLoadHandle handle)
	{
		try
		{
			GameObject gameObject = handle.As<GameObject>();
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(bindingRoot);
		}
		catch (Exception e)
		{
			LogConfigException("AssetDisable", e);
		}
	}

	public void DisableEffect()
	{
		try
		{
			switch (effectType)
			{
			case EffectType.BindingEffect:
				if (!_handle.IsValid)
				{
					_handle = AssetStationManager.BattleStation.InstantiateAsync(bindingEffectName, bindingRoot.position, bindingRoot.rotation, bindingRoot);
				}
				_handle.Completed += AssetDisable;
				_handle.Completed -= AssetEnable;
				break;
			case EffectType.HighLight:
				if (_defaultColor.HasValue)
				{
					if (_propertyBlock == null)
					{
						_propertyBlock = new MaterialPropertyBlock();
					}
					renderer.GetPropertyBlock(_propertyBlock);
					_propertyBlock.SetColor(BattleConsts.SHADER_EMISSION_COLOR, _defaultColor.Value);
					renderer.SetPropertyBlock(_propertyBlock);
				}
				break;
			}
		}
		catch (Exception e)
		{
			LogConfigException("DisableEffect", e);
		}
	}

	public void Dispose()
	{
		try
		{
			if (_handle.IsValid)
			{
				AssetStationManager.BattleStation.Release(_handle);
			}
		}
		catch (Exception e)
		{
			LogConfigException("Dispose", e);
		}
	}

	private void LogConfigException(string action, Exception e)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"满命特效 {action} 配置错误, effectType={effectType}");
			Debug.LogException(e);
		}
	}
}
