using System.IO;
using UnityEngine;
using UnityEngine.Rendering;

public class PreIntegralCS : MonoBehaviour
{
	private struct TestBuffer
	{
		public float testValue;
	}

	public ComputeShader PreIntegralShader;

	public int TargetResolution = 1024;

	public Texture2D SourceHDRMap;

	public int MipCount;

	public void Begin()
	{
		int kernelIndex = PreIntegralShader.FindKernel("PreIntegral");
		RenderTexture renderTexture = new RenderTexture(new RenderTextureDescriptor
		{
			height = TargetResolution,
			width = TargetResolution,
			dimension = TextureDimension.Tex2D,
			colorFormat = RenderTextureFormat.ARGBFloat,
			msaaSamples = 1,
			volumeDepth = 1,
			depthBufferBits = 0,
			enableRandomWrite = true,
			useMipMap = false
		});
		renderTexture.Create();
		TestBuffer[] array = new TestBuffer[1];
		array[0].testValue = 0f;
		ComputeBuffer computeBuffer = new ComputeBuffer(1, 4);
		computeBuffer.SetData(array);
		PreIntegralShader.SetBuffer(kernelIndex, "buffer", computeBuffer);
		PreIntegralShader.SetTexture(kernelIndex, "Result", renderTexture);
		PreIntegralShader.SetVector("TargetResolution", new Vector4(TargetResolution, TargetResolution, 0f, 0f));
		PreIntegralShader.Dispatch(kernelIndex, Mathf.CeilToInt((float)TargetResolution / 8f), Mathf.CeilToInt((float)TargetResolution / 8f), 1);
		Shader.SetGlobalTexture("_PreIntegralBRDF", renderTexture);
		computeBuffer.GetData(array);
		RenderTexture.active = renderTexture;
		Texture2D texture2D = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGBAFloat, mipChain: false);
		texture2D.ReadPixels(new Rect(0f, 0f, renderTexture.width, renderTexture.height), 0, 0);
		texture2D.Apply();
		RenderTexture.active = null;
		byte[] bytes = texture2D.EncodeToEXR(Texture2D.EXRFlags.OutputAsFloat);
		File.WriteAllBytes(Application.dataPath + "/PreIntegral.exr", bytes);
		Debug.LogError("结束，保存至" + Application.dataPath + "/PreIntegral.exr");
	}

	public void HDRPreFillter()
	{
		int kernelIndex = PreIntegralShader.FindKernel("PreFillterHDR");
		RenderTextureDescriptor desc = new RenderTextureDescriptor
		{
			height = SourceHDRMap.height,
			width = SourceHDRMap.width,
			dimension = TextureDimension.Tex2D,
			colorFormat = RenderTextureFormat.ARGBFloat,
			msaaSamples = 1,
			volumeDepth = 1,
			depthBufferBits = 0,
			enableRandomWrite = true,
			useMipMap = false
		};
		for (int i = 0; i < MipCount; i++)
		{
			float val = (float)(i + 1) / (float)MipCount;
			desc.width /= 2;
			desc.height /= 2;
			RenderTexture renderTexture = new RenderTexture(desc);
			renderTexture.Create();
			TestBuffer[] array = new TestBuffer[1];
			array[0].testValue = 0f;
			ComputeBuffer computeBuffer = new ComputeBuffer(1, 4);
			computeBuffer.SetData(array);
			PreIntegralShader.SetBuffer(kernelIndex, "buffer", computeBuffer);
			PreIntegralShader.SetFloat("_Roughness", val);
			PreIntegralShader.SetTexture(kernelIndex, "_Source", SourceHDRMap);
			PreIntegralShader.SetTexture(kernelIndex, "Result", renderTexture);
			PreIntegralShader.SetVector("TargetResolution", new Vector4(desc.width, desc.height, 0f, 0f));
			PreIntegralShader.Dispatch(kernelIndex, Mathf.CeilToInt((float)desc.width / 8f), Mathf.CeilToInt((float)desc.height / 8f), 1);
			computeBuffer.GetData(array);
			RenderTexture.active = renderTexture;
			Texture2D texture2D = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.RGBAFloat, mipChain: false);
			texture2D.ReadPixels(new Rect(0f, 0f, renderTexture.width, renderTexture.height), 0, 0);
			texture2D.Apply();
			RenderTexture.active = null;
			byte[] bytes = texture2D.EncodeToEXR(Texture2D.EXRFlags.OutputAsFloat);
			File.WriteAllBytes(Application.dataPath + "/PreIntegralHDR" + i + ".exr", bytes);
			Debug.LogError("结束，保存至" + Application.dataPath + "/PreIntegralHDR" + i + ".exr");
			renderTexture.Release();
			renderTexture = null;
		}
	}
}
