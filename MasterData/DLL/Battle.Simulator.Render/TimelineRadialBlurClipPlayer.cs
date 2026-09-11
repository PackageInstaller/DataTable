using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class TimelineRadialBlurClipPlayer : CommonSimpleTimelineClipPlayer<RadialBlurClip>
{
	private List<BuffCameraRadialBlurEffect> m_buffCameraRadialBlurEffectList = new List<BuffCameraRadialBlurEffect>();

	public NAgent Agent;

	public AttachPointSetup AttachPointSetup;

	public CameraExtension CameraExtension;

	public void AddBuffCameraRadialBlurEffect(int buffID, float radialBlurScale)
	{
		BuffCameraRadialBlurEffect buffCameraRadialBlurEffect = FrameObjectPool<BuffCameraRadialBlurEffect>.Claim();
		buffCameraRadialBlurEffect.BuffID = buffID;
		buffCameraRadialBlurEffect.RadialBlurScale = radialBlurScale;
		m_buffCameraRadialBlurEffectList.Add(buffCameraRadialBlurEffect);
	}

	public void RemoveBuffCameraRadialBlurEffect(int buffID)
	{
		for (int i = 0; i < m_buffCameraRadialBlurEffectList.Count; i++)
		{
			if (m_buffCameraRadialBlurEffectList[i].BuffID == buffID)
			{
				BuffCameraRadialBlurEffect obj = m_buffCameraRadialBlurEffectList[i];
				m_buffCameraRadialBlurEffectList.RemoveAt(i);
				FrameObjectPool<BuffCameraRadialBlurEffect>.Release(obj);
				ResetCameraRadialBlurParams();
				break;
			}
		}
	}

	public void ClearBuffCameraAbberationList()
	{
		for (int i = 0; i < m_buffCameraRadialBlurEffectList.Count; i++)
		{
			FrameObjectPool<BuffCameraRadialBlurEffect>.Release(m_buffCameraRadialBlurEffectList[i]);
		}
		m_buffCameraRadialBlurEffectList.Clear();
		ResetCameraRadialBlurParams();
	}

	public void UpdateBuffCameraRadialBlurEffect(int buffID, float radialBlurScale)
	{
		BuffCameraRadialBlurEffect buffCameraRadialBlurEffectByBuffID = GetBuffCameraRadialBlurEffectByBuffID(buffID);
		if (buffCameraRadialBlurEffectByBuffID != null)
		{
			buffCameraRadialBlurEffectByBuffID.RadialBlurScale = radialBlurScale;
		}
	}

	public BuffCameraRadialBlurEffect GetBuffCameraRadialBlurEffectByBuffID(int buffID)
	{
		for (int i = 0; i < m_buffCameraRadialBlurEffectList.Count; i++)
		{
			if (m_buffCameraRadialBlurEffectList[i].BuffID == buffID)
			{
				return m_buffCameraRadialBlurEffectList[i];
			}
		}
		return null;
	}

	public BuffCameraRadialBlurEffect GetLastestBuffCameraRadialBlurEffect()
	{
		if (m_buffCameraRadialBlurEffectList.Count <= 0)
		{
			return null;
		}
		return m_buffCameraRadialBlurEffectList[m_buffCameraRadialBlurEffectList.Count - 1];
	}

	public bool HasBuffCameraRadialBlurEffect()
	{
		return m_buffCameraRadialBlurEffectList.Count > 0;
	}

	public void ResetCameraRadialBlurParams()
	{
		CameraExtension.radialBlurScale = 0f;
		CameraExtension.radialBlurRange = 1f;
		CameraExtension.radialBlurSoft = 1f;
		CameraExtension.isRadialOutward = false;
		CameraExtension.radialWarpLerp = 0f;
		CameraExtension.radialWarpScale = 0f;
		CameraExtension.radialWarpDensity = 0f;
		CameraExtension.radialAbberationIntensity = 0f;
		CameraExtension.radialBlurCenterTransform = Vector2.zero;
		CameraExtension.radialBlurTarget = null;
		CameraExtension.isUseRadialCenterTransform = false;
		CameraExtension.radialDither = false;
	}

	public bool IsPlay()
	{
		return Agent.IsLocalPlayer;
	}

	protected override void _Initialize(List<RadialBlurClip> clips)
	{
	}

	protected override void _EnterNodes(List<RadialBlurClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager == null || CameraExtension == null)
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlay() || clipsInThisFrame[i].BotherOthers)
			{
				buffManager.runningRadialBlurClip[clipsInThisFrame[i].Key] = clipsInThisFrame[i];
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<RadialBlurClip> clipsInThisFrame, float normalized)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager == null || CameraExtension == null)
		{
			return;
		}
		RadialBlurClip radialBlurClip = buffManager.UpdateRadialBlur();
		RadialBlurClip radialBlurClip2 = null;
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (radialBlurClip == null)
			{
				break;
			}
			if (radialBlurClip.Key == clipsInThisFrame[i].Key)
			{
				radialBlurClip2 = clipsInThisFrame[i];
				break;
			}
		}
		if (radialBlurClip2 == null)
		{
			return;
		}
		float time = (normalized - radialBlurClip2.NormalizedBegin) / (radialBlurClip2.NormalizedEnd - radialBlurClip2.NormalizedBegin);
		AnimationCurve scaleCurve = radialBlurClip2.ScaleCurve;
		AnimationCurve rangeCurve = radialBlurClip2.RangeCurve;
		AnimationCurve softCurve = radialBlurClip2.SoftCurve;
		bool isOutward = radialBlurClip2.IsOutward;
		AnimationCurve warpLerp = radialBlurClip2.WarpLerp;
		AnimationCurve warpScale = radialBlurClip2.WarpScale;
		AnimationCurve warpDensity = radialBlurClip2.WarpDensity;
		AnimationCurve abberationIntensity = radialBlurClip2.AbberationIntensity;
		Vector2 centerTransform = radialBlurClip2.CenterTransform;
		bool isUseCenterTransform = radialBlurClip2.IsUseCenterTransform;
		bool radialDither = radialBlurClip2.RadialDither;
		float radialBlurScale = scaleCurve.Evaluate(time);
		float radialBlurRange = rangeCurve?.Evaluate(time) ?? 1f;
		float radialBlurSoft = softCurve?.Evaluate(time) ?? 1f;
		float radialWarpLerp = warpLerp?.Evaluate(time) ?? 0f;
		float radialWarpScale = warpScale?.Evaluate(time) ?? 0f;
		float radialWarpDensity = warpDensity?.Evaluate(time) ?? 0f;
		float radialAbberationIntensity = abberationIntensity?.Evaluate(time) ?? 0f;
		CameraExtension.radialBlurScale = radialBlurScale;
		CameraExtension.radialBlurRange = radialBlurRange;
		CameraExtension.radialBlurSoft = radialBlurSoft;
		CameraExtension.isRadialOutward = isOutward;
		CameraExtension.radialWarpLerp = radialWarpLerp;
		CameraExtension.radialWarpScale = radialWarpScale;
		CameraExtension.radialWarpDensity = radialWarpDensity;
		CameraExtension.radialAbberationIntensity = radialAbberationIntensity;
		CameraExtension.radialBlurCenterTransform = centerTransform;
		CameraExtension.isUseRadialCenterTransform = isUseCenterTransform;
		CameraExtension.radialDither = radialDither;
		if (!(CameraExtension.radialBlurTarget == null))
		{
			return;
		}
		if (AttachPointSetup != null)
		{
			Transform attachPoint = AttachPointSetup.GetAttachPoint(radialBlurClip2.CenterPath);
			if (attachPoint == null)
			{
				CameraExtension.radialBlurTarget = base.Transform;
			}
			else
			{
				CameraExtension.radialBlurTarget = attachPoint;
			}
		}
		else
		{
			CameraExtension.radialBlurTarget = base.Transform;
		}
	}

	protected override void _ExitNodes(List<RadialBlurClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager != null && !(CameraExtension == null))
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				buffManager.runningRadialBlurClip.Remove(clipsInThisFrame[i].Key);
			}
			if (buffManager.UpdateRadialBlur() == null)
			{
				ResetCameraRadialBlurParams();
			}
		}
	}

	protected override void _Shutdown()
	{
		if (IsPlay())
		{
			ResetCameraRadialBlurParams();
			ClearBuffCameraAbberationList();
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
		if (IsPlay())
		{
			ResetCameraRadialBlurParams();
		}
	}

	public override void Update(float normalized)
	{
		base.Update(normalized);
		HasBuffCameraRadialBlurEffect();
	}

	public override void UpdateWithoutTimeScale(float realTimeDalta)
	{
		if (HasBuffCameraRadialBlurEffect())
		{
			BuffCameraRadialBlurEffect lastestBuffCameraRadialBlurEffect = GetLastestBuffCameraRadialBlurEffect();
			if (lastestBuffCameraRadialBlurEffect != null)
			{
				CameraExtension.radialBlurScale = lastestBuffCameraRadialBlurEffect.RadialBlurScale;
			}
		}
		base.UpdateWithoutTimeScale(realTimeDalta);
	}
}
