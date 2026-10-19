using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public class AtmospherePreintegral : MonoBehaviour
{
	public ComputeShader AtmosphereCS;

	public Vector2 Resolution;

	public Light MainLight;

	[ColorUsage(true, true)]
	public Color sunColor = new Color(10f, 10f, 10f, 1f);

	[ColorUsage(true, true)]
	public Color moonColor = new Color(1f, 1f, 1f, 1f);

	private RenderTexture RT;

	private RenderTexture skyRT;

	public void Calculate()
	{
		if (AtmosphereCS != null)
		{
			if (RT != null)
			{
				RT.Release();
			}
			RenderTextureDescriptor desc = new RenderTextureDescriptor((int)Resolution.x, (int)Resolution.y, RenderTextureFormat.ARGBFloat, 0, 0);
			desc.dimension = TextureDimension.Tex2D;
			desc.volumeDepth = 1;
			desc.enableRandomWrite = true;
			desc.useMipMap = false;
			RT = new RenderTexture(desc);
			RT.wrapMode = TextureWrapMode.Clamp;
			int kernelIndex = AtmosphereCS.FindKernel("PreIntegralAtmosphere");
			int kernelIndex2 = AtmosphereCS.FindKernel("SkyLutCalculate");
			RT.Create();
			AtmosphereCS.SetFloat("_temporalRefresh", 0f);
			AtmosphereCS.SetVector("_TargetResolution", new Vector4(desc.width, desc.height, 0f, 0f));
			AtmosphereCS.SetTexture(kernelIndex, "_atmosphereLUT", RT);
			AtmosphereCS.SetTexture(kernelIndex2, "_PreCompute_LUT", RT);
			AtmosphereCS.Dispatch(kernelIndex, Mathf.CeilToInt(Resolution.x / 8f), Mathf.CeilToInt(Resolution.y / 8f), 1);
			RenderTexture.active = RT;
			Texture2D texture2D = new Texture2D(RT.width, RT.height, TextureFormat.RGBAFloat, mipChain: false);
			texture2D.ReadPixels(new Rect(0f, 0f, RT.width, RT.height), 0, 0);
			texture2D.Apply();
			RenderTexture.active = null;
			Shader.SetGlobalTexture("_PreCompute_LUT", RT);
			byte[] bytes = texture2D.EncodeToEXR(Texture2D.EXRFlags.OutputAsFloat);
			File.WriteAllBytes(Application.dataPath + "/Atmosphere.exr", bytes);
			Debug.LogError("结束，保存至" + Application.dataPath + "/Atmosphere.exr");
		}
	}

	public void updateSkyRT()
	{
		RenderTextureDescriptor desc = new RenderTextureDescriptor((int)Resolution.x, (int)Resolution.y, RenderTextureFormat.ARGBFloat, 0, 0);
		desc.dimension = TextureDimension.Tex2D;
		desc.volumeDepth = 1;
		desc.enableRandomWrite = true;
		desc.useMipMap = false;
		skyRT = new RenderTexture(desc);
		skyRT.wrapModeU = TextureWrapMode.Repeat;
		skyRT.wrapModeV = TextureWrapMode.Clamp;
		skyRT.Create();
	}

	private void Update()
	{
		if (AtmosphereCS != null)
		{
			int kernelIndex = AtmosphereCS.FindKernel("SkyLutCalculate");
			AtmosphereCS.SetVector("_TargetResolution", new Vector4(skyRT.width, skyRT.height, 0f, 0f));
			AtmosphereCS.SetTexture(kernelIndex, "_skyLUT", skyRT);
			AtmosphereCS.SetVector("_sunColor", sunColor);
			AtmosphereCS.SetVector("_moonColor", moonColor);
			Vector4 val = -MainLight.transform.forward;
			val.w = Camera.main.transform.position.y;
			AtmosphereCS.SetVector("_SunLightDir", val);
			AtmosphereCS.Dispatch(kernelIndex, Mathf.CeilToInt(Resolution.x / 8f), Mathf.CeilToInt(Resolution.y / 8f), 1);
			Shader.SetGlobalTexture("_Atmosphere", skyRT);
		}
	}
}
