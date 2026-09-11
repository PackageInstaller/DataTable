using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("Buff暗角", 0)]
[Category("Render/Buff/Buff特效/暗角")]
[Description("Buff暗角")]
public class BuffCameraDarkCorner : FlowNode
{
	private CameraExtension m_cameraExtension;

	private ValueInput<int> entityIDInput;

	private CameraExtension GetExtend()
	{
		if (m_cameraExtension == null)
		{
			m_cameraExtension = Camera.main.transform.GetComponent<CameraExtension>();
		}
		return m_cameraExtension;
	}

	public void ResetCameraVignetteParams()
	{
		GetExtend();
		m_cameraExtension.vignetteColor = Color.black;
		m_cameraExtension.vignetteStrength = 0f;
		m_cameraExtension.vignetteSoft = 0.2f;
		m_cameraExtension.vignetteBounded = false;
		m_cameraExtension.vignetteTransform = Vector2.one * 0.5f;
		m_cameraExtension.vignetteTarget = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ResetCameraVignetteParams();
	}

	protected override void RegisterPorts()
	{
		entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<Color> colorInput = AddValueInput<Color>("颜色").SetDefaultAndSerializedValue(Color.black);
		ValueInput<AnimationCurve> strengthCurveInput = AddValueInput<AnimationCurve>("强度");
		ValueInput<AnimationCurve> softCurveInput = AddValueInput<AnimationCurve>("软硬程度");
		ValueInput<bool> boundedInput = AddValueInput<bool>("开启正方比").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> isUseScreenPosInput = AddValueInput<bool>("是否使用屏幕坐标").SetDefaultAndSerializedValue(v: true);
		ValueInput<string> transPathInput = AddValueInput<string>("焦点-Transform路径").SetDefaultAndSerializedValue("");
		ValueInput<Vector2> screenPosInput = AddValueInput<Vector2>("屏幕坐标").SetDefaultAndSerializedValue(Vector2.one * 0.5f);
		ValueInput<float> normalizeInput = AddValueInput<float>("更新进度(0-1)");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				DarkCornerClip cameraDarkCornerClip = buffManager.GetCameraDarkCornerClip();
				cameraDarkCornerClip.color = colorInput.value;
				cameraDarkCornerClip.strengthCurve = strengthCurveInput.value;
				if (cameraDarkCornerClip.strengthCurve == null)
				{
					cameraDarkCornerClip.strengthCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 0f));
				}
				cameraDarkCornerClip.softCurve = softCurveInput.value;
				if (cameraDarkCornerClip.softCurve == null)
				{
					cameraDarkCornerClip.softCurve = new AnimationCurve(new Keyframe(0f, 0.2f), new Keyframe(1f, 0.2f));
				}
				cameraDarkCornerClip.bounded = boundedInput.value;
				cameraDarkCornerClip.isUseScreenPos = isUseScreenPosInput.value;
				cameraDarkCornerClip.transPath = transPathInput.value;
				cameraDarkCornerClip.screenPos = screenPosInput.value;
				cameraDarkCornerClip.priority = priorityInput.value;
				cameraDarkCornerClip.Key = buffIDInput.value;
				cameraDarkCornerClip.Length = 1f;
				cameraDarkCornerClip.NormalizedBegin = 0f;
				cameraDarkCornerClip.NormalizedEnd = 1f;
				buffManager.runningDarkCornerClip[cameraDarkCornerClip.Key] = cameraDarkCornerClip;
				int key = cameraDarkCornerClip.Key;
				cameraDarkCornerClip = buffManager.UpdateDarkCorner();
				if (cameraDarkCornerClip == null)
				{
					ResetCameraVignetteParams();
				}
				else if (cameraDarkCornerClip.Key == key)
				{
					UpdateDarkCorner(cameraDarkCornerClip, 0f);
				}
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				DarkCornerClip darkCornerClip = buffManager.UpdateDarkCorner();
				if (darkCornerClip == null)
				{
					errorOut.Call(f);
				}
				else if (darkCornerClip.Key == buffIDInput.value)
				{
					UpdateDarkCorner(darkCornerClip, normalizeInput.value);
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
				if (!buffManager.runningDarkCornerClip.TryGetValue(buffIDInput.value, out var value))
				{
					errorOut.Call(f);
				}
				else
				{
					buffManager.runningDarkCornerClip.Remove(buffIDInput.value);
					if (value == null)
					{
						errorOut.Call(f);
					}
					else
					{
						buffManager.ReturnCameraDarkCornerClip(value);
						value = buffManager.UpdateDarkCorner();
						if (value == null)
						{
							ResetCameraVignetteParams();
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
			if (!agent.IsLocalPlayer)
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
	}

	private void UpdateDarkCorner(DarkCornerClip clip, float timeRate)
	{
		GetExtend();
		float vignetteStrength = clip.strengthCurve.Evaluate(timeRate);
		float vignetteSoft = clip.softCurve.Evaluate(timeRate);
		m_cameraExtension.vignetteColor = clip.color;
		m_cameraExtension.vignetteStrength = vignetteStrength;
		m_cameraExtension.vignetteSoft = vignetteSoft;
		m_cameraExtension.vignetteBounded = clip.bounded;
		NAgent agent = AgentManager.GetAgentManager().GetAgent(entityIDInput.value);
		if (!clip.isUseScreenPos)
		{
			if (agent.AttachPointSetup != null && agent != null)
			{
				Transform attachPoint = agent.AttachPointSetup.GetAttachPoint(clip.transPath);
				if (attachPoint == null)
				{
					m_cameraExtension.vignetteTarget = agent.Transform;
				}
				else
				{
					m_cameraExtension.vignetteTarget = attachPoint;
				}
			}
		}
		else
		{
			m_cameraExtension.vignetteTransform = clip.screenPos;
		}
	}
}
