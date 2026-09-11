using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("判断受击状态(ID)", 0)]
[Category("Logic/Attribute")]
[Description("判断当前受击状态是哪一个")]
public class SwitchHitStatusByEntityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("EntityID");
		FlowOutput outputNone = AddFlowOutput("无");
		FlowOutput outputHitReocver = AddFlowOutput("普通受击");
		FlowOutput outputFloatUp = AddFlowOutput("击飞");
		FlowOutput outputHitAir = AddFlowOutput("空中受击");
		FlowOutput outputFloatDown = AddFlowOutput("降落");
		FlowOutput outputHitFloor = AddFlowOutput("着地");
		FlowOutput outputGetUp = AddFlowOutput("起身");
		FlowOutput outputUnknow = AddFlowOutput("未知受击类型", "unknow");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!entityWithEntityID.hasEntityHitRecover)
			{
				outputNone.Call(f);
			}
			else
			{
				switch (entityWithEntityID.entityHitRecover.mHitRecoverStatus)
				{
				case E_HitRecoverStatus.None:
					outputNone.Call(f);
					break;
				case E_HitRecoverStatus.HitReocver:
					outputHitReocver.Call(f);
					break;
				case E_HitRecoverStatus.FloatUp:
					outputFloatUp.Call(f);
					break;
				case E_HitRecoverStatus.HitAir:
					outputHitAir.Call(f);
					break;
				case E_HitRecoverStatus.FloatDown:
					outputFloatDown.Call(f);
					break;
				case E_HitRecoverStatus.HitFloor:
					outputHitFloor.Call(f);
					break;
				case E_HitRecoverStatus.GetUp:
					outputGetUp.Call(f);
					break;
				default:
					Debug.Log("未知受击状态类型");
					outputUnknow.Call(f);
					break;
				}
			}
		});
	}
}
