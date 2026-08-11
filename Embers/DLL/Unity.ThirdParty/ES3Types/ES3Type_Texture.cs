using System;
using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "filterMode", "anisoLevel", "wrapMode", "mipMapBias", "rawTextureData" })]
public class ES3Type_Texture : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Texture()
		: base(typeof(Texture))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		if (obj.GetType() == typeof(Texture2D))
		{
			ES3Type_Texture2D.Instance.Write(obj, writer);
			return;
		}
		throw new NotSupportedException("Textures of type " + obj.GetType()?.ToString() + " are not currently supported.");
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		if (obj.GetType() == typeof(Texture2D))
		{
			ES3Type_Texture2D.Instance.ReadInto<T>(reader, obj);
			return;
		}
		throw new NotSupportedException("Textures of type " + obj.GetType()?.ToString() + " are not currently supported.");
	}

	public override object Read<T>(ES3Reader reader)
	{
		return ES3Type_Texture2D.Instance.Read<T>(reader);
	}
}
