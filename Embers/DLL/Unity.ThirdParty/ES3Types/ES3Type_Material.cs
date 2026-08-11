using System;
using ES3Internal;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "shader", "renderQueue", "shaderKeywords", "globalIlluminationFlags", "properties" })]
public class ES3Type_Material : ES3UnityObjectType
{
	public static ES3Type Instance;

	public ES3Type_Material()
		: base(typeof(Material))
	{
		Instance = this;
	}

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		Material material = (Material)obj;
		writer.WriteProperty("name", material.name);
		writer.WriteProperty("shader", material.shader);
		writer.WriteProperty("renderQueue", material.renderQueue, ES3Type_int.Instance);
		writer.WriteProperty("shaderKeywords", material.shaderKeywords);
		writer.WriteProperty("globalIlluminationFlags", material.globalIlluminationFlags);
		Shader shader = material.shader;
		if (!(shader != null))
		{
			return;
		}
		for (int i = 0; i < shader.GetPropertyCount(); i++)
		{
			string propertyName = shader.GetPropertyName(i);
			switch (shader.GetPropertyType(i))
			{
			case ShaderPropertyType.Color:
				writer.WriteProperty(propertyName, material.GetColor(propertyName));
				break;
			case ShaderPropertyType.Float:
			case ShaderPropertyType.Range:
				writer.WriteProperty(propertyName, material.GetFloat(propertyName));
				break;
			case ShaderPropertyType.Texture:
			{
				Texture texture = material.GetTexture(propertyName);
				if (texture != null && texture.GetType() != typeof(Texture2D))
				{
					ES3Debug.LogWarning($"The texture '{propertyName}' of Material '{material.name}' will not be saved as only Textures of type Texture2D can be saved at runtime, whereas '{propertyName}' is of type '{texture.GetType()}'.");
				}
				else
				{
					writer.WriteProperty(propertyName, texture);
					writer.WriteProperty(propertyName + "_TextureOffset", material.GetTextureOffset(propertyName));
					writer.WriteProperty(propertyName + "_TextureScale", material.GetTextureScale(propertyName));
				}
				break;
			}
			case ShaderPropertyType.Vector:
				writer.WriteProperty(propertyName, material.GetVector(propertyName));
				break;
			}
		}
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		Material material = new Material(Shader.Find("Diffuse"));
		ReadUnityObject<T>(reader, material);
		return material;
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		Material material = (Material)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "name":
				material.name = reader.Read<string>(ES3Type_string.Instance);
				continue;
			case "shader":
				material.shader = reader.Read<Shader>(ES3Type_Shader.Instance);
				continue;
			case "renderQueue":
				material.renderQueue = reader.Read<int>(ES3Type_int.Instance);
				continue;
			case "shaderKeywords":
			{
				string[] array = reader.Read<string[]>();
				foreach (string keyword in array)
				{
					material.EnableKeyword(keyword);
				}
				continue;
			}
			case "globalIlluminationFlags":
				material.globalIlluminationFlags = reader.Read<MaterialGlobalIlluminationFlags>();
				continue;
			case "_MainTex_Scale":
				material.SetTextureScale("_MainTex", reader.Read<Vector2>());
				continue;
			}
			int num = -1;
			if (material.shader != null && material.HasProperty(property) && (num = material.shader.FindPropertyIndex(property)) != -1)
			{
				switch (material.shader.GetPropertyType(num))
				{
				case ShaderPropertyType.Color:
					material.SetColor(property, reader.Read<Color>());
					break;
				case ShaderPropertyType.Float:
				case ShaderPropertyType.Range:
					material.SetFloat(property, reader.Read<float>());
					break;
				case ShaderPropertyType.Texture:
					material.SetTexture(property, reader.Read<Texture>());
					break;
				case ShaderPropertyType.Vector:
					material.SetColor(property, reader.Read<Vector4>());
					break;
				}
			}
			else if (property.EndsWith("_TextureScale"))
			{
				material.SetTextureScale(property.Split(new string[1] { "_TextureScale" }, StringSplitOptions.None)[0], reader.Read<Vector2>());
			}
			else if (property.EndsWith("_TextureOffset"))
			{
				material.SetTextureOffset(property.Split(new string[1] { "_TextureOffset" }, StringSplitOptions.None)[0], reader.Read<Vector2>());
			}
			reader.Skip();
		}
	}
}
