using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public class PostProcessData : ScriptableObject
{
	[Serializable]
	[ReloadGroup]
	public sealed class ShaderResources
	{
		[Reload("Shaders/PostProcessing/GaussianDepthOfField.shader", ReloadAttribute.Package.Root)]
		public Shader gaussianDepthOfFieldPS;

		[Reload("Shaders/PostProcessing/GaussianDepthOfField.compute", ReloadAttribute.Package.Root)]
		[SerializeField]
		public ComputeShader gaussianDepthOfFieldCS;

		[Reload("Shaders/PostProcessing/BokehDepthOfField.shader", ReloadAttribute.Package.Root)]
		public Shader bokehDepthOfFieldPS;

		[Reload("Shaders/PostProcessing/CameraMotionBlur.shader", ReloadAttribute.Package.Root)]
		public Shader cameraMotionBlurPS;

		[Reload("Shaders/PostProcessing/PaniniProjection.shader", ReloadAttribute.Package.Root)]
		public Shader paniniProjectionPS;

		[Reload("Shaders/PostProcessing/LutBuilderHdr.shader", ReloadAttribute.Package.Root)]
		public Shader lutBuilderHdrPS;

		[Reload("Shaders/PostProcessing/ScalingSetup.shader", ReloadAttribute.Package.Root)]
		public Shader scalingSetupPS;

		[Reload("Shaders/PostProcessing/UberPost.shader", ReloadAttribute.Package.Root)]
		public Shader uberPostPS;

		[Reload("Shaders/PostProcessing/FinalPost.shader", ReloadAttribute.Package.Root)]
		public Shader finalPostPassPS;

		[Reload("Shaders/PostProcessing/TAABlend.shader", ReloadAttribute.Package.Root)]
		public Shader taaShader;

		[Reload("Shaders/PostProcessing/TemporalDepthOfFieldComposite.shader", ReloadAttribute.Package.Root)]
		public Shader temporalDepthOfFieldCompositePS;

		[Reload("Shaders/PostProcessing/TemporalDepthOfField.compute", ReloadAttribute.Package.Root)]
		[SerializeField]
		public ComputeShader temporalDepthOfFieldCS;

		[Reload("Shaders/ACT/ComputeShader/MotionBlur.compute", ReloadAttribute.Package.Root)]
		[SerializeField]
		public ComputeShader motionBlurShader;

		[Reload("Shaders/ACT/ComputeShader/AutoExposureCS.compute", ReloadAttribute.Package.Root)]
		[SerializeField]
		public ComputeShader AutoEVCS;

		[SerializeField]
		[Reload("Shaders/ACT/ComputeShader/Bloom.compute", ReloadAttribute.Package.Root)]
		public ComputeShader bloomCS;

		[Reload("Shaders/PostProcessing/Bloom.shader", ReloadAttribute.Package.Root)]
		public Shader bloomPS;
	}

	[Serializable]
	[ReloadGroup]
	public sealed class TextureResources
	{
		[Reload("Textures/BlueNoise16/L/LDR_LLL1_{0}.png", 0, 32, ReloadAttribute.Package.Root)]
		public Texture2D[] blueNoise16LTex;
	}

	public ShaderResources shaders;

	public TextureResources textures;
}
