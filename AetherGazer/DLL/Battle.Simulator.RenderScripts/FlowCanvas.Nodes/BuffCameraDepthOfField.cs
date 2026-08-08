using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("Buff相机景深", 0)]
[Category("Render/Buff/Buff特效/相机景深")]
[Description("Buff相机景深")]
public class BuffCameraDepthOfField : FlowNode
{
	private CameraExtension CameraExtension;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (CameraExtension != null)
		{
			CameraExtension.dofType = DepthOfFieldType.Disabled;
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
		ValueInput<DepthOfFieldType> depthOfFieldTypeInput = AddValueInput<DepthOfFieldType>("景深类型");
		ValueInput<float> depthOfFieldNearInput = AddValueInput<float>("dofNear");
		ValueInput<float> depthOfFieldFarInput = AddValueInput<float>("dofFar");
		ValueInput<float> depthOfFieldScaleInput = AddValueInput<float>("dofScale(0-1)");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				CameraDepthOfFieldClip cameraDepthOfFieldClip = buffManager.GetCameraDepthOfFieldClip();
				cameraDepthOfFieldClip.mDepthOfFieldType = depthOfFieldTypeInput.value;
				cameraDepthOfFieldClip.mDepthOfFieldNear = depthOfFieldNearInput.value;
				cameraDepthOfFieldClip.mDepthOfFieldFar = depthOfFieldFarInput.value;
				cameraDepthOfFieldClip.Key = buffIDInput.value;
				cameraDepthOfFieldClip.Length = 1f;
				cameraDepthOfFieldClip.NormalizedBegin = 0f;
				cameraDepthOfFieldClip.NormalizedEnd = 1f;
				cameraDepthOfFieldClip.mPriority = priorityInput.value;
				cameraDepthOfFieldClip.mBotherOthers = botherOthersInput.value;
				buffManager.runningCameraDepthOfFieldClip[cameraDepthOfFieldClip.Key] = cameraDepthOfFieldClip;
				cameraDepthOfFieldClip = buffManager.UpdateCameraDepthOfField();
				if (cameraDepthOfFieldClip == null)
				{
					CameraExtension.dofType = DepthOfFieldType.Disabled;
				}
				else
				{
					CameraExtension.dofType = cameraDepthOfFieldClip.mDepthOfFieldType;
					CameraExtension.dofNear = cameraDepthOfFieldClip.mDepthOfFieldNear;
					CameraExtension.dofFar = cameraDepthOfFieldClip.mDepthOfFieldFar;
					CameraExtension.dofScale = depthOfFieldScaleInput.value;
				}
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				CameraDepthOfFieldClip cameraDepthOfFieldClip = buffManager.UpdateCameraDepthOfField();
				if (cameraDepthOfFieldClip == null)
				{
					errorOut.Call(f);
				}
				else
				{
					if (cameraDepthOfFieldClip.Key == buffIDInput.value && CameraExtension != null)
					{
						CameraExtension.dofType = cameraDepthOfFieldClip.mDepthOfFieldType;
						CameraExtension.dofNear = cameraDepthOfFieldClip.mDepthOfFieldNear;
						CameraExtension.dofFar = cameraDepthOfFieldClip.mDepthOfFieldFar;
						CameraExtension.dofScale = depthOfFieldScaleInput.value;
					}
					output.Call(f);
				}
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				if (!buffManager.runningCameraDepthOfFieldClip.TryGetValue(buffIDInput.value, out var value))
				{
					errorOut.Call(f);
				}
				else
				{
					buffManager.runningCameraDepthOfFieldClip.Remove(buffIDInput.value);
					if (value == null)
					{
						errorOut.Call(f);
					}
					else
					{
						buffManager.ReturnCameraDepthOfFieldClip(value);
						value = buffManager.UpdateCameraDepthOfField();
						if (value == null)
						{
							CameraExtension.dofType = DepthOfFieldType.Disabled;
						}
						else
						{
							CameraExtension.dofType = value.mDepthOfFieldType;
							CameraExtension.dofNear = value.mDepthOfFieldNear;
							CameraExtension.dofFar = value.mDepthOfFieldFar;
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
	}
}
