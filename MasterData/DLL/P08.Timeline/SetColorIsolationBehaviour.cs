using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Replica;

[Serializable]
public class SetColorIsolationBehaviour : PlayableBehaviour
{
	private bool bind;

	public bool useMaskTex;

	[NonSerialized]
	public Texture2D mask;

	public bool useMaskTrs;

	[NonSerialized]
	public Transform maskTrs;

	[Range(0f, 1f)]
	public float intensity;

	public Color targetColor;

	[Range(0f, 1f)]
	public float fallOffRadius;

	[Range(0f, 1f)]
	public float maskThreashold;

	[Range(-1f, 1f)]
	public float maskTransitionRange;

	public bool useCurveControl;

	public Vector2 lumaRange = new Vector2(0f, 1f);

	[Range(0.1f, 3f)]
	public float contrast = 1f;

	[NonSerialized]
	public ColorIsolationController colorIsolation;

	private bool IsTempColorIsolationController => colorIsolation.hideFlags.HasFlag(HideFlags.DontSaveInBuild);

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
		Component component = playable.GetGraph().GetResolver() as Component;
		if (colorIsolation == null && component != null && !component.gameObject.TryGetComponent<ColorIsolationController>(out colorIsolation))
		{
			colorIsolation = component.gameObject.AddComponent<ColorIsolationController>();
			colorIsolation.hideFlags |= HideFlags.DontSave;
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		base.OnGraphStop(playable);
		if ((bool)colorIsolation && IsTempColorIsolationController)
		{
			RestoreParams();
			UnityEngine.Object.DestroyImmediate(colorIsolation);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		colorIsolation.Push();
		colorIsolation.colorIsolation = true;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (!bind)
		{
			if (maskTrs == null)
			{
				maskTrs = playerData as Transform;
			}
			BindMask(colorIsolation, maskTrs, mask);
			bind = true;
		}
		SetParams(colorIsolation);
	}

	private void BindMask(ColorIsolationController colorIsolation, Transform maskTrs, Texture2D mask)
	{
		colorIsolation.ciMaskTexPosition = maskTrs;
		colorIsolation.ciMaskTex = mask;
	}

	private void SetParams(ColorIsolationController colorIsolation)
	{
		colorIsolation.ciIsUseMaskTex = useMaskTex;
		colorIsolation.ciIsSetMaskTexPosition = useMaskTrs;
		colorIsolation.ciIntensity = intensity;
		colorIsolation.ciTargetColor = targetColor;
		colorIsolation.ciFalloffRadius = fallOffRadius;
		colorIsolation.ciMaskThreshold = maskThreashold;
		colorIsolation.ciMaskTransitionRange = maskTransitionRange;
		colorIsolation.ciIsCurveControlLum = useCurveControl;
		colorIsolation.ciLumaRange = lumaRange;
		colorIsolation.ciContrast = contrast;
	}

	private void SetParams(ColorIsolationController colorIsolation, Transform maskTrs, Texture2D mask)
	{
		BindMask(colorIsolation, maskTrs, mask);
		SetParams(colorIsolation);
	}

	private void RestoreParams()
	{
		bind = false;
		if ((bool)colorIsolation && colorIsolation.colorIsolation)
		{
			colorIsolation.Pop();
			colorIsolation.Update();
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		RestoreParams();
	}
}
