using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class RendererBlockControl : MonoBehaviour
{
	public enum PropertyType
	{
		Float,
		Vector,
		Color
	}

	[SerializeReference]
	public List<RendererBlockContorlData.ShaderProperty> shaderProperties = new List<RendererBlockContorlData.ShaderProperty>();

	public Renderer[] LocalRenderers;

	public FaceDirect[] FaceDirects;

	private MaterialPropertyBlock propertyBlock;

	private List<RendererBlockContorlData.ShaderProperty> removeList = new List<RendererBlockContorlData.ShaderProperty>();

	private bool m_ClearBlock;

	private void OnEnable()
	{
		if (propertyBlock == null)
		{
			propertyBlock = new MaterialPropertyBlock();
		}
		if (FaceDirects == null)
		{
			return;
		}
		FaceDirect[] faceDirects = FaceDirects;
		foreach (FaceDirect faceDirect in faceDirects)
		{
			if (faceDirect != null)
			{
				faceDirect.setControl(this);
			}
		}
	}

	private void GetRendererInChild()
	{
		LocalRenderers = GetComponentsInChildren<Renderer>(includeInactive: true);
		FaceDirects = GetComponentsInChildren<FaceDirect>(includeInactive: true);
	}

	private void Update()
	{
	}

	private void LateUpdate()
	{
		if (LocalRenderers != null)
		{
			Renderer[] localRenderers = LocalRenderers;
			foreach (Renderer renderer in localRenderers)
			{
				if (!(renderer == null))
				{
					propertyBlock.Clear();
					renderer.GetPropertyBlock(propertyBlock);
					ApplyShaderProperties(propertyBlock);
					renderer.SetPropertyBlock(propertyBlock);
				}
			}
		}
		foreach (RendererBlockContorlData.ShaderProperty shaderProperty in shaderProperties)
		{
			shaderProperty?.setDirt(isDirt: false);
		}
		m_ClearBlock = false;
	}

	private void OnDisable()
	{
		if (FaceDirects == null)
		{
			return;
		}
		FaceDirect[] faceDirects = FaceDirects;
		foreach (FaceDirect faceDirect in faceDirects)
		{
			if (faceDirect != null)
			{
				faceDirect.removeControl();
			}
		}
	}

	private void ApplyShaderProperties(MaterialPropertyBlock block)
	{
		foreach (RendererBlockContorlData.ShaderProperty shaderProperty in shaderProperties)
		{
			if (shaderProperty != null)
			{
				switch (shaderProperty.type)
				{
				default:
					block.SetFloat(shaderProperty.name, shaderProperty.floatValue);
					break;
				case PropertyType.Vector:
					block.SetVector(shaderProperty.name, shaderProperty.vectorValue);
					break;
				case PropertyType.Color:
					block.SetColor(shaderProperty.name, shaderProperty.colorValue);
					break;
				}
			}
		}
	}

	public bool GetProperty(string propertyName, out RendererBlockContorlData.ShaderProperty prop)
	{
		foreach (RendererBlockContorlData.ShaderProperty shaderProperty in shaderProperties)
		{
			if (shaderProperty.name == propertyName)
			{
				prop = shaderProperty;
				return true;
			}
		}
		prop = null;
		return false;
	}

	public bool GetProperty(string propertyName, out RendererBlockContorlData.ShaderProperty prop, PropertyType type)
	{
		foreach (RendererBlockContorlData.ShaderProperty shaderProperty4 in shaderProperties)
		{
			if (shaderProperty4.name == propertyName)
			{
				prop = shaderProperty4;
				return true;
			}
		}
		switch (type)
		{
		case PropertyType.Float:
		{
			RendererBlockContorlData.ShaderProperty shaderProperty3 = new RendererBlockContorlData.ShaderProperty(propertyName, PropertyType.Float);
			prop = shaderProperty3;
			shaderProperties.Add(prop);
			break;
		}
		case PropertyType.Vector:
		{
			RendererBlockContorlData.ShaderProperty shaderProperty2 = new RendererBlockContorlData.ShaderProperty(propertyName, PropertyType.Vector);
			prop = shaderProperty2;
			shaderProperties.Add(prop);
			break;
		}
		case PropertyType.Color:
		{
			RendererBlockContorlData.ShaderProperty shaderProperty = new RendererBlockContorlData.ShaderProperty(propertyName, PropertyType.Color);
			prop = shaderProperty;
			shaderProperties.Add(prop);
			break;
		}
		default:
			prop = null;
			break;
		}
		return false;
	}

	public RendererBlockContorlData.ShaderProperty GetProperty(string propertyName)
	{
		foreach (RendererBlockContorlData.ShaderProperty shaderProperty in shaderProperties)
		{
			if (shaderProperty.name == propertyName)
			{
				return shaderProperty;
			}
		}
		return null;
	}

	public RendererBlockContorlData.ShaderProperty GetProperty(string propertyName, PropertyType type)
	{
		foreach (RendererBlockContorlData.ShaderProperty shaderProperty4 in shaderProperties)
		{
			if (shaderProperty4.name == propertyName)
			{
				return shaderProperty4;
			}
		}
		switch (type)
		{
		case PropertyType.Float:
		{
			RendererBlockContorlData.ShaderProperty shaderProperty3 = new RendererBlockContorlData.ShaderProperty(propertyName, PropertyType.Float);
			shaderProperties.Add(shaderProperty3);
			return shaderProperty3;
		}
		case PropertyType.Vector:
		{
			RendererBlockContorlData.ShaderProperty shaderProperty2 = new RendererBlockContorlData.ShaderProperty(propertyName, PropertyType.Vector);
			shaderProperties.Add(shaderProperty2);
			return shaderProperty2;
		}
		case PropertyType.Color:
		{
			RendererBlockContorlData.ShaderProperty shaderProperty = new RendererBlockContorlData.ShaderProperty(propertyName, PropertyType.Color);
			shaderProperties.Add(shaderProperty);
			return shaderProperty;
		}
		default:
			return null;
		}
	}

	public void RemoveProperty(RendererBlockContorlData.ShaderProperty prop)
	{
		if (prop != null)
		{
			shaderProperties.Remove(prop);
			m_ClearBlock = true;
			propertyBlock.Clear();
		}
	}

	public void RemoveProperty(string propertyName)
	{
		if (GetProperty(propertyName, out var prop))
		{
			RemoveProperty(prop);
		}
	}
}
