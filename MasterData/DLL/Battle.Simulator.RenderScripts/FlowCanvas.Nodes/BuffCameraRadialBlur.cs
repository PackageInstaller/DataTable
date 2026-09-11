using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("Buff径向模糊", 0)]
[Category("Render/Buff/Buff特效/径向模糊")]
[Description("Buff径向模糊")]
public class BuffCameraRadialBlur : FlowNode
{
	private CameraExtension CameraExtension;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (CameraExtension != null)
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
			CameraExtension = null;
		}
	}

	private CameraExtension GetExtend()
	{
		if (CameraExtension == null)
		{
			CameraExtension = Camera.main.transform.GetComponent<CameraExtension>();
		}
		return CameraExtension;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("影响其他人的相机");
		ValueInput<AnimationCurve> radialBlurScaleInput = AddValueInput<AnimationCurve>("强度");
		ValueInput<AnimationCurve> radialBlurRangeCurveInput = AddValueInput<AnimationCurve>("范围");
		ValueInput<AnimationCurve> radialBlurSoftCurveInput = AddValueInput<AnimationCurve>("软硬程度");
		ValueInput<bool> radialBlurIsOutwardInput = AddValueInput<bool>("是否反向").SetDefaultAndSerializedValue(v: false);
		ValueInput<AnimationCurve> radialBlurWarpLerpInput = AddValueInput<AnimationCurve>("扭曲程度");
		ValueInput<AnimationCurve> radialBlurWarpScaleInput = AddValueInput<AnimationCurve>("扭曲强度/扭曲循环");
		ValueInput<AnimationCurve> radialBlurWarpDensityInput = AddValueInput<AnimationCurve>("扭曲密度");
		ValueInput<AnimationCurve> radialBlurAbberationIntensityInput = AddValueInput<AnimationCurve>("色散强度");
		ValueInput<Vector2> radialBlurCenterTransformInput = AddValueInput<Vector2>("屏幕坐标");
		ValueInput<float> normalizeInput = AddValueInput<float>("更新进度(0-1)");
		ValueInput<int> targetIDInput = AddValueInput<int>("目标ID");
		ValueInput<string> targetPathInput = AddValueInput<string>("目标挂点路径");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				RadialBlurClip cameraRadialBlurClip = buffManager.GetCameraRadialBlurClip();
				cameraRadialBlurClip.ScaleCurve = radialBlurScaleInput.value;
				cameraRadialBlurClip.RangeCurve = radialBlurRangeCurveInput.value;
				cameraRadialBlurClip.SoftCurve = radialBlurSoftCurveInput.value;
				cameraRadialBlurClip.IsOutward = radialBlurIsOutwardInput.value;
				cameraRadialBlurClip.WarpLerp = radialBlurWarpLerpInput.value;
				cameraRadialBlurClip.WarpScale = radialBlurWarpScaleInput.value;
				cameraRadialBlurClip.WarpDensity = radialBlurWarpDensityInput.value;
				cameraRadialBlurClip.AbberationIntensity = radialBlurAbberationIntensityInput.value;
				cameraRadialBlurClip.CenterTransform = radialBlurCenterTransformInput.value;
				cameraRadialBlurClip.Length = 1f;
				cameraRadialBlurClip.NormalizedBegin = 0f;
				cameraRadialBlurClip.NormalizedEnd = 1f;
				cameraRadialBlurClip.Priority = priorityInput.value;
				cameraRadialBlurClip.BotherOthers = botherOthersInput.value;
				cameraRadialBlurClip.Key = buffIDInput.value;
				cameraRadialBlurClip.CenterPath = targetPathInput.value;
				buffManager.runningRadialBlurClip[cameraRadialBlurClip.Key] = cameraRadialBlurClip;
				int key = cameraRadialBlurClip.Key;
				cameraRadialBlurClip = buffManager.UpdateRadialBlur();
				if (cameraRadialBlurClip == null)
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
				}
				else if (cameraRadialBlurClip.Key == key)
				{
					UpdateRadialBlur(cameraRadialBlurClip, 0f);
				}
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				RadialBlurClip radialBlurClip = buffManager.UpdateRadialBlur();
				if (radialBlurClip == null)
				{
					errorOut.Call(f);
				}
				else if (radialBlurClip.Key == buffIDInput.value)
				{
					UpdateRadialBlur(radialBlurClip, normalizeInput.value);
				}
				else
				{
					output.Call(f);
				}
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				if (!buffManager.runningRadialBlurClip.TryGetValue(buffIDInput.value, out var value))
				{
					errorOut.Call(f);
				}
				else
				{
					buffManager.runningRadialBlurClip.Remove(buffIDInput.value);
					if (value == null)
					{
						errorOut.Call(f);
					}
					else
					{
						buffManager.ReturnCameraRadialBlurClip(value);
						value = buffManager.UpdateRadialBlur();
						if (value == null)
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
						}
						output.Call(f);
					}
				}
			}
		});
		BuffManager CheckValid(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
				return null;
			}
			NAgent agent = agentManager.GetAgent(entityIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
				return null;
			}
			if (GetExtend() == null)
			{
				errorOut.Call(f);
				return null;
			}
			if (!agent.IsLocalPlayer && !botherOthersInput.value)
			{
				output.Call(f);
				return null;
			}
			BuffManager buffManager = BuffManager.GetBuffManager();
			if (buffManager == null)
			{
				errorOut.Call(f);
				return null;
			}
			return buffManager;
		}
		void UpdateRadialBlur(RadialBlurClip clip, float time)
		{
			AnimationCurve scaleCurve = clip.ScaleCurve;
			AnimationCurve rangeCurve = clip.RangeCurve;
			AnimationCurve softCurve = clip.SoftCurve;
			bool isOutward = clip.IsOutward;
			AnimationCurve warpLerp = clip.WarpLerp;
			AnimationCurve warpScale = clip.WarpScale;
			AnimationCurve warpDensity = clip.WarpDensity;
			AnimationCurve abberationIntensity = clip.AbberationIntensity;
			Vector2 centerTransform = clip.CenterTransform;
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
			AgentManager agentManager = AgentManager.GetAgentManager();
			NAgent agent = agentManager.GetAgent(targetIDInput.value);
			if (agent == null)
			{
				agent = agentManager.GetAgent(entityIDInput.value);
			}
			if (string.IsNullOrEmpty(targetPathInput.value))
			{
				CameraExtension.radialBlurTarget = agent.transform;
			}
			else if (agent.AttachPointSetup != null)
			{
				Transform attachPoint = agent.AttachPointSetup.GetAttachPoint(clip.CenterPath);
				if (attachPoint == null)
				{
					CameraExtension.radialBlurTarget = agent.transform;
				}
				else
				{
					CameraExtension.radialBlurTarget = attachPoint;
				}
			}
		}
	}
}
