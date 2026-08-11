using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"width", "height", "dimension", "graphicsFormat", "useMipMap", "vrUsage", "memorylessMode", "format", "stencilFormat", "autoGenerateMips",
	"volumeDepth", "antiAliasing", "bindTextureMS", "enableRandomWrite", "useDynamicScale", "isPowerOfTwo", "depth", "descriptor", "masterTextureLimit", "anisotropicFiltering",
	"wrapMode", "wrapModeU", "wrapModeV", "wrapModeW", "filterMode", "anisoLevel", "mipMapBias", "imageContentsHash", "streamingTextureForceLoadAll", "streamingTextureDiscardUnusedMips",
	"allowThreadedTextureCreation", "name"
})]
public class ES3Type_RenderTexture : ES3ObjectType
{
	public static ES3Type Instance;

	public ES3Type_RenderTexture()
		: base(typeof(RenderTexture))
	{
		Instance = this;
	}

	protected override void WriteObject(object obj, ES3Writer writer)
	{
		RenderTexture renderTexture = (RenderTexture)obj;
		writer.WriteProperty("descriptor", renderTexture.descriptor);
		writer.WriteProperty("antiAliasing", renderTexture.antiAliasing, ES3Type_int.Instance);
		writer.WriteProperty("isPowerOfTwo", renderTexture.isPowerOfTwo, ES3Type_bool.Instance);
		writer.WriteProperty("anisotropicFiltering", Texture.anisotropicFiltering);
		writer.WriteProperty("wrapMode", renderTexture.wrapMode);
		writer.WriteProperty("wrapModeU", renderTexture.wrapModeU);
		writer.WriteProperty("wrapModeV", renderTexture.wrapModeV);
		writer.WriteProperty("wrapModeW", renderTexture.wrapModeW);
		writer.WriteProperty("filterMode", renderTexture.filterMode);
		writer.WriteProperty("anisoLevel", renderTexture.anisoLevel, ES3Type_int.Instance);
		writer.WriteProperty("mipMapBias", renderTexture.mipMapBias, ES3Type_float.Instance);
		writer.WriteProperty("streamingTextureForceLoadAll", Texture.streamingTextureForceLoadAll, ES3Type_bool.Instance);
		writer.WriteProperty("streamingTextureDiscardUnusedMips", Texture.streamingTextureDiscardUnusedMips, ES3Type_bool.Instance);
		writer.WriteProperty("allowThreadedTextureCreation", Texture.allowThreadedTextureCreation, ES3Type_bool.Instance);
	}

	protected override void ReadObject<T>(ES3Reader reader, object obj)
	{
		RenderTexture renderTexture = (RenderTexture)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "width":
				renderTexture.width = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "height":
				renderTexture.height = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "dimension":
				renderTexture.dimension = reader.Read<TextureDimension>();
				break;
			case "useMipMap":
				renderTexture.useMipMap = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "memorylessMode":
				renderTexture.memorylessMode = reader.Read<RenderTextureMemoryless>();
				break;
			case "format":
				renderTexture.format = reader.Read<RenderTextureFormat>();
				break;
			case "autoGenerateMips":
				renderTexture.autoGenerateMips = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "volumeDepth":
				renderTexture.volumeDepth = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "antiAliasing":
				renderTexture.antiAliasing = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "enableRandomWrite":
				renderTexture.enableRandomWrite = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "isPowerOfTwo":
				renderTexture.isPowerOfTwo = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "depth":
				renderTexture.depth = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "descriptor":
				renderTexture.descriptor = reader.Read<RenderTextureDescriptor>();
				break;
			case "anisotropicFiltering":
				Texture.anisotropicFiltering = reader.Read<AnisotropicFiltering>();
				break;
			case "wrapMode":
				renderTexture.wrapMode = reader.Read<TextureWrapMode>();
				break;
			case "wrapModeU":
				renderTexture.wrapModeU = reader.Read<TextureWrapMode>();
				break;
			case "wrapModeV":
				renderTexture.wrapModeV = reader.Read<TextureWrapMode>();
				break;
			case "wrapModeW":
				renderTexture.wrapModeW = reader.Read<TextureWrapMode>();
				break;
			case "filterMode":
				renderTexture.filterMode = reader.Read<FilterMode>();
				break;
			case "anisoLevel":
				renderTexture.anisoLevel = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "mipMapBias":
				renderTexture.mipMapBias = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "name":
				renderTexture.name = reader.Read<string>(ES3Type_string.Instance);
				break;
			case "vrUsage":
				renderTexture.vrUsage = reader.Read<VRTextureUsage>();
				break;
			case "graphicsFormat":
				renderTexture.graphicsFormat = reader.Read<GraphicsFormat>();
				break;
			case "stencilFormat":
				renderTexture.stencilFormat = reader.Read<GraphicsFormat>();
				break;
			case "bindTextureMS":
				renderTexture.bindTextureMS = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "useDynamicScale":
				renderTexture.useDynamicScale = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "streamingTextureForceLoadAll":
				Texture.streamingTextureForceLoadAll = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "streamingTextureDiscardUnusedMips":
				Texture.streamingTextureDiscardUnusedMips = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "allowThreadedTextureCreation":
				Texture.allowThreadedTextureCreation = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}

	protected override object ReadObject<T>(ES3Reader reader)
	{
		RenderTexture renderTexture = new RenderTexture(reader.ReadProperty<RenderTextureDescriptor>());
		ReadObject<T>(reader, renderTexture);
		return renderTexture;
	}
}
