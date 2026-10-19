using System;

namespace UnityEngine.Rendering.Universal;

public static class PostProcessUtils
{
	private static class ShaderConstants
	{
		public static readonly int _Grain_Texture = Shader.PropertyToID("_Grain_Texture");

		public static readonly int _Grain_Params = Shader.PropertyToID("_Grain_Params");

		public static readonly int _Grain_TilingParams = Shader.PropertyToID("_Grain_TilingParams");

		public static readonly int _BlueNoise_Texture = Shader.PropertyToID("_BlueNoise_Texture");

		public static readonly int _Dithering_Params = Shader.PropertyToID("_Dithering_Params");

		public static readonly int _SourceSize = Shader.PropertyToID("_SourceSize");
	}

	public static int ConfigureDithering(PostProcessData data, int index, int cameraPixelWidth, int cameraPixelHeight, Material material)
	{
		Texture2D[] blueNoise16LTex = data.textures.blueNoise16LTex;
		if (blueNoise16LTex == null || blueNoise16LTex.Length == 0)
		{
			return 0;
		}
		if (++index >= blueNoise16LTex.Length)
		{
			index = 0;
		}
		float value = Random.value;
		float value2 = Random.value;
		Texture2D texture2D = blueNoise16LTex[index];
		Shader.SetGlobalTexture(ShaderConstants._BlueNoise_Texture, texture2D);
		material.SetVector(ShaderConstants._Dithering_Params, new Vector4((float)cameraPixelWidth / (float)texture2D.width, (float)cameraPixelHeight / (float)texture2D.height, value, value2));
		return index;
	}

	[Obsolete("This method is obsolete. Use ConfigureFilmGrain override that takes camera pixel width and height instead.")]
	public static void ConfigureFilmGrain(PostProcessData data, FilmGrain settings, Camera camera, Material material)
	{
		ConfigureFilmGrain(data, settings, camera.pixelWidth, camera.pixelHeight, material);
	}

	public static void ConfigureFilmGrain(PostProcessData data, FilmGrain settings, int cameraPixelWidth, int cameraPixelHeight, Material material)
	{
		Texture value = settings.texture.value;
		if (settings.type.value == FilmGrainLookup.Custom)
		{
			float value2 = Random.value;
			float value3 = Random.value;
			Vector4 value4 = ((value == null) ? Vector4.zero : new Vector4((float)cameraPixelWidth / (float)value.width, (float)cameraPixelHeight / (float)value.height, value2, value3));
			material.SetTexture(ShaderConstants._Grain_Texture, value);
			material.SetVector(ShaderConstants._Grain_Params, new Vector2(settings.intensity.value * 4f, settings.response.value));
			material.SetVector(ShaderConstants._Grain_TilingParams, value4);
		}
	}

	internal static void SetSourceSize(CommandBuffer cmd, RenderTextureDescriptor desc)
	{
		float num = desc.width;
		float num2 = desc.height;
		cmd.SetGlobalVector(ShaderConstants._SourceSize, new Vector4(num, num2, 1f / num, 1f / num2));
	}
}
