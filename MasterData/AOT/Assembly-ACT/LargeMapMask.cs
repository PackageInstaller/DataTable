using System.Collections.Generic;
using ACT.World;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.UI;

[ExecuteAlways]
public class LargeMapMask : LuminSerializedMonoBehaviour
{
	public enum CurveType
	{
		Power,
		AnimationCurve
	}

	public List<RawImage> renderers = new List<RawImage>();

	[OdinSerialize]
	public Dictionary<MapArea, Texture2D> MapAreaTextureDic = new Dictionary<MapArea, Texture2D>();

	public Image wholeRt;

	public Texture2D MaskTexture;

	public RenderTexture TargetRenderTexture;

	public RenderTexture TargetRenderTexture2;

	public ComputeShader computeShader;

	public int TextureSize = 1024;

	public string PropName = "_DissolveDirTex";

	[Tooltip("动画持续时间（秒）")]
	public float calculateSpeed = 2f;

	[Tooltip("曲线类型")]
	public CurveType curveType;

	[Tooltip("指数曲线的幂次（仅在曲线类型为 Power 时生效）")]
	public float calculateSpeedCurve = 2f;

	[Tooltip("自定义动画曲线（X轴: 0-1 归一化时间, Y轴: 0-1 输出值）")]
	public AnimationCurve customCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	[Range(0f, 1f)]
	public float TestValue;

	[Tooltip("归一化时间进度")]
	public float NormalizedTime;

	private float timeTemp;

	private bool firstTime;

	private CommandBuffer cmd;

	public bool IsPlaying => firstTime;

	public float Progress => NormalizedTime;

	private void OnEnable()
	{
		if (TargetRenderTexture == null)
		{
			TargetRenderTexture = new RenderTexture(TextureSize, TextureSize, 0, GraphicsFormat.R8_UNorm);
			TargetRenderTexture.enableRandomWrite = true;
			TargetRenderTexture.dimension = TextureDimension.Tex2D;
			TargetRenderTexture.volumeDepth = 1;
			TargetRenderTexture.name = "Large Map Mask";
			TargetRenderTexture.Create();
		}
		if (TargetRenderTexture2 == null)
		{
			TargetRenderTexture2 = new RenderTexture(TextureSize, TextureSize, 0, GraphicsFormat.R8_UNorm);
			TargetRenderTexture2.enableRandomWrite = true;
			TargetRenderTexture2.dimension = TextureDimension.Tex2D;
			TargetRenderTexture2.volumeDepth = 1;
			TargetRenderTexture2.name = "Large Map Mask Temp";
			TargetRenderTexture2.Create();
		}
		cmd = new CommandBuffer();
		cmd.name = "MaskCalculate";
	}

	private void PlayUnlockAnim()
	{
		TestValue = 0f;
		timeTemp = 0f;
		if (computeShader != null)
		{
			cmd.SetComputeTextureParam(computeShader, 0, "Result", TargetRenderTexture);
			cmd.SetComputeFloatParam(computeShader, "_TextureSize", TextureSize);
			cmd.SetComputeTextureParam(computeShader, 0, "_Source", MaskTexture);
			cmd.SetComputeTextureParam(computeShader, 0, "Temp", TargetRenderTexture2);
			cmd.DispatchCompute(computeShader, 0, Mathf.CeilToInt((float)TextureSize / 8f), Mathf.CeilToInt((float)TextureSize / 8f), 1);
			firstTime = true;
		}
	}

	private void Update()
	{
		if (!firstTime)
		{
			return;
		}
		timeTemp += Time.deltaTime;
		NormalizedTime = Mathf.Clamp01(timeTemp / calculateSpeed);
		TestValue = EvaluateCurve(NormalizedTime);
		cmd.SetComputeFloatParam(computeShader, "TestValue", Mathf.Clamp01(TestValue));
		cmd.SetComputeTextureParam(computeShader, 1, "Result", TargetRenderTexture);
		cmd.SetComputeTextureParam(computeShader, 1, "_Source", MaskTexture);
		cmd.SetComputeTextureParam(computeShader, 1, "Temp", TargetRenderTexture2);
		cmd.DispatchCompute(computeShader, 1, Mathf.CeilToInt((float)TextureSize / 8f), Mathf.CeilToInt((float)TextureSize / 8f), 1);
		if (TestValue >= 1f)
		{
			firstTime = false;
			OnAnimationComplete();
		}
		foreach (RawImage renderer in renderers)
		{
			if (renderer != null && renderer.material != null)
			{
				renderer.material.SetTexture(PropName, TargetRenderTexture);
			}
		}
		Graphics.ExecuteCommandBuffer(cmd);
		cmd.Clear();
	}

	private float EvaluateCurve(float normalizedTime)
	{
		switch (curveType)
		{
		case CurveType.Power:
			return Mathf.Pow(normalizedTime, calculateSpeedCurve);
		case CurveType.AnimationCurve:
			if (customCurve != null && customCurve.length > 0)
			{
				return Mathf.Clamp01(customCurve.Evaluate(normalizedTime));
			}
			return normalizedTime;
		default:
			return normalizedTime;
		}
	}

	protected virtual void OnAnimationComplete()
	{
	}

	private void OnDisable()
	{
		if (TargetRenderTexture != null)
		{
			TargetRenderTexture.Release();
			TargetRenderTexture = null;
		}
		if (TargetRenderTexture2 != null)
		{
			TargetRenderTexture2.Release();
			TargetRenderTexture2 = null;
		}
		firstTime = false;
		if (cmd != null)
		{
			cmd.Release();
			cmd = null;
		}
	}

	public void Play()
	{
		PlayUnlockAnim();
	}

	public void Play(float duration)
	{
		calculateSpeed = duration;
		PlayUnlockAnim();
	}

	public void Play(float duration, AnimationCurve curve)
	{
		calculateSpeed = duration;
		curveType = CurveType.AnimationCurve;
		customCurve = curve;
		PlayUnlockAnim();
	}

	public void Stop()
	{
		firstTime = false;
	}

	public void SetMaskTexture(MapArea area, bool isUnlock)
	{
		if (MapAreaTextureDic.TryGetValue(area, out var value))
		{
			MaskTexture = value;
			if (computeShader != null)
			{
				cmd.SetComputeTextureParam(computeShader, 0, "Result", TargetRenderTexture);
				cmd.SetComputeFloatParam(computeShader, "_TextureSize", TextureSize);
				cmd.SetComputeTextureParam(computeShader, 0, "_Source", MaskTexture);
				cmd.SetComputeTextureParam(computeShader, 0, "Temp", TargetRenderTexture2);
				cmd.DispatchCompute(computeShader, 0, Mathf.CeilToInt((float)TextureSize / 8f), Mathf.CeilToInt((float)TextureSize / 8f), 1);
			}
			SetProgress(isUnlock ? 1 : 0);
		}
	}

	public void SetMaskTexture(Texture2D texture)
	{
		MaskTexture = texture;
	}

	public void SetMaskTextureAndPlay(Texture2D texture)
	{
		MaskTexture = texture;
		PlayUnlockAnim();
	}

	public void SetMaskTextureAndPlay(Texture2D texture, float duration)
	{
		MaskTexture = texture;
		calculateSpeed = duration;
		PlayUnlockAnim();
	}

	public void SetMaskTextureAndPlay(Texture2D texture, float duration, AnimationCurve curve)
	{
		MaskTexture = texture;
		calculateSpeed = duration;
		curveType = CurveType.AnimationCurve;
		customCurve = curve;
		PlayUnlockAnim();
	}

	public Texture2D GetMaskTexture()
	{
		return MaskTexture;
	}

	public void Reset()
	{
		TestValue = 0f;
		NormalizedTime = 0f;
		timeTemp = 0f;
		firstTime = false;
	}

	public void SetProgress(float progress)
	{
		progress = Mathf.Clamp01(progress);
		NormalizedTime = progress;
		TestValue = EvaluateCurve(progress);
		timeTemp = progress * calculateSpeed;
		if (!(computeShader != null) || cmd == null)
		{
			return;
		}
		cmd.SetComputeFloatParam(computeShader, "TestValue", Mathf.Clamp01(TestValue));
		cmd.SetComputeFloatParam(computeShader, "_TextureSize", TextureSize);
		cmd.SetComputeTextureParam(computeShader, 1, "Result", TargetRenderTexture);
		cmd.SetComputeTextureParam(computeShader, 1, "_Source", MaskTexture);
		cmd.SetComputeTextureParam(computeShader, 1, "Temp", TargetRenderTexture2);
		cmd.DispatchCompute(computeShader, 1, Mathf.CeilToInt((float)TextureSize / 8f), Mathf.CeilToInt((float)TextureSize / 8f), 1);
		foreach (RawImage renderer in renderers)
		{
			if (renderer != null && renderer.material != null)
			{
				renderer.material.SetTexture(PropName, TargetRenderTexture);
			}
		}
		Graphics.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		foreach (RawImage renderer2 in renderers)
		{
			if (renderer2 != null && renderer2.material != null)
			{
				wholeRt.useRedChannelHitTest = true;
				wholeRt.redChannelHitTestMinimumThreshold = 0.5f;
				wholeRt.redChannelInvert = true;
				wholeRt.color = new Color(1f, 1f, 1f, 0f);
				RenderTexture rt = renderer2.material.GetTexture(PropName) as RenderTexture;
				wholeRt.redChannelMaskTexture = ToTexture2D(rt);
			}
		}
	}

	public void MaskInit()
	{
		if (computeShader != null && cmd != null)
		{
			cmd.SetComputeTextureParam(computeShader, 2, "Result", TargetRenderTexture);
			cmd.DispatchCompute(computeShader, 2, Mathf.CeilToInt((float)TextureSize / 8f), Mathf.CeilToInt((float)TextureSize / 8f), 1);
			Graphics.ExecuteCommandBuffer(cmd);
			cmd.Clear();
		}
	}

	private Texture2D ToTexture2D(RenderTexture rt)
	{
		if (rt == null)
		{
			return null;
		}
		Texture2D texture2D = new Texture2D(rt.width, rt.height, TextureFormat.RGBA32, mipChain: false);
		RenderTexture active = RenderTexture.active;
		RenderTexture.active = rt;
		texture2D.ReadPixels(new Rect(0f, 0f, rt.width, rt.height), 0, 0);
		texture2D.Apply();
		RenderTexture.active = active;
		return texture2D;
	}

	public void SetLinearCurve()
	{
		curveType = CurveType.AnimationCurve;
		customCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);
	}

	public void SetEaseInOutCurve()
	{
		curveType = CurveType.AnimationCurve;
		customCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);
	}

	public void SetEaseInCurve()
	{
		curveType = CurveType.AnimationCurve;
		customCurve = new AnimationCurve(new Keyframe(0f, 0f, 0f, 0f), new Keyframe(1f, 1f, 2f, 0f));
	}

	public void SetEaseOutCurve()
	{
		curveType = CurveType.AnimationCurve;
		customCurve = new AnimationCurve(new Keyframe(0f, 0f, 0f, 2f), new Keyframe(1f, 1f, 0f, 0f));
	}

	public void SetElasticCurve()
	{
		curveType = CurveType.AnimationCurve;
		customCurve = new AnimationCurve(new Keyframe(0f, 0f, 0f, 0f), new Keyframe(0.6f, 1.1f, 2f, 0f), new Keyframe(0.8f, 0.95f, 0f, 0f), new Keyframe(1f, 1f, 0f, 0f));
	}
}
