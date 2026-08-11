using System;
using ES3Internal;
using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "filterMode", "anisoLevel", "wrapMode", "mipMapBias", "rawTextureData" })]
[Preserve]
public class ES3Type_Texture2D : ES3UnityObjectType
{
	public static ES3Type Instance;

	public ES3Type_Texture2D()
		: base(typeof(Texture2D))
	{
		Instance = this;
	}

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		Texture2D texture2D = (Texture2D)obj;
		if (!IsReadable(texture2D))
		{
			ES3Debug.LogWarning("Easy Save cannot save the pixels or properties of this Texture because it is not read/write enabled, so Easy Save will store it by reference instead. To save the pixel data, check the 'Read/Write Enabled' checkbox in the Texture's import settings. Clicking this warning will take you to the Texture, assuming it is not generated at runtime.", texture2D);
			return;
		}
		writer.WriteProperty("width", texture2D.width, ES3Type_int.Instance);
		writer.WriteProperty("height", texture2D.height, ES3Type_int.Instance);
		writer.WriteProperty("format", texture2D.format);
		writer.WriteProperty("mipmapCount", texture2D.mipmapCount, ES3Type_int.Instance);
		writer.WriteProperty("filterMode", texture2D.filterMode);
		writer.WriteProperty("anisoLevel", texture2D.anisoLevel, ES3Type_int.Instance);
		writer.WriteProperty("wrapMode", texture2D.wrapMode);
		writer.WriteProperty("mipMapBias", texture2D.mipMapBias, ES3Type_float.Instance);
		writer.WriteProperty("rawTextureData", texture2D.GetRawTextureData(), ES3Type_byteArray.Instance);
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		if (obj == null)
		{
			return;
		}
		if (obj.GetType() == typeof(RenderTexture))
		{
			ES3Type_RenderTexture.Instance.ReadInto<T>(reader, obj);
			return;
		}
		Texture2D texture2D = (Texture2D)obj;
		if (!IsReadable(texture2D))
		{
			ES3Debug.LogWarning("Easy Save cannot load the properties or pixels for this Texture because it is not read/write enabled, so it will be loaded by reference. To load the properties and pixels for this Texture, check the 'Read/Write Enabled' checkbox in its Import Settings.", texture2D);
		}
		foreach (string property in reader.Properties)
		{
			if (!IsReadable(texture2D))
			{
				reader.Skip();
				continue;
			}
			switch (property)
			{
			case "filterMode":
				texture2D.filterMode = reader.Read<FilterMode>();
				break;
			case "anisoLevel":
				texture2D.anisoLevel = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "wrapMode":
				texture2D.wrapMode = reader.Read<TextureWrapMode>();
				break;
			case "mipMapBias":
				texture2D.mipMapBias = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "rawTextureData":
				if (!IsReadable(texture2D))
				{
					ES3Debug.LogWarning("Easy Save cannot load the pixels of this Texture because it is not read/write enabled, so Easy Save will ignore the pixel data. To load the pixel data, check the 'Read/Write Enabled' checkbox in the Texture's import settings. Clicking this warning will take you to the Texture, assuming it is not generated at runtime.", texture2D);
					reader.Skip();
					break;
				}
				try
				{
					texture2D.LoadRawTextureData(reader.Read<byte[]>(ES3Type_byteArray.Instance));
					texture2D.Apply();
				}
				catch (Exception ex)
				{
					ES3Debug.LogError("Easy Save encountered an error when trying to load this Texture, please see the end of this messasge for the error. This is most likely because the Texture format of the instance we are loading into is different to the Texture we saved.\n" + ex.ToString(), texture2D);
				}
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		Texture2D texture2D = new Texture2D(reader.Read<int>(ES3Type_int.Instance), reader.ReadProperty<int>(ES3Type_int.Instance), reader.ReadProperty<TextureFormat>(), reader.ReadProperty<int>(ES3Type_int.Instance) > 1);
		ReadObject<T>(reader, texture2D);
		return texture2D;
	}

	protected bool IsReadable(Texture2D instance)
	{
		if (instance != null)
		{
			return instance.isReadable;
		}
		return false;
	}
}
