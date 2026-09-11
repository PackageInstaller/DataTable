using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]战术技能事件(逻辑)", 0)]
[Category("Logic")]
[Description("基于人工AI输入事件，仅AI玩法可用")]
public class VHLSkillEvent : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<int> vInSlot;

	private ValueInput<int> vInSkillId;

	private ValueInput<bool> vInLocal;

	private FlowOutput fOut;

	private int vEntityId;

	private int vKey;

	private int vSkillId;

	private int vSlot;

	private int delayFrame;

	protected override void RegisterPorts()
	{
		vInLocal = AddValueInput<bool>("本地玩家").SetDefaultAndSerializedValue(v: true);
		vInSlot = AddValueInput<int>("监听技能槽").SetDefaultAndSerializedValue(-1);
		vInSkillId = AddValueInput<int>("监听Id").SetDefaultAndSerializedValue(-1);
		fOut = AddFlowOutput("Out");
		AddValueOutput("实体ID", () => vEntityId);
		AddValueOutput("Key Code", () => vKey);
		AddValueOutput("战术技能Id", () => vSkillId);
		AddValueOutput("槽位", () => vSlot);
	}

	private void HandleInput(int entId, int key)
	{
		int num = 16;
		if (key < num || (vInLocal.value && entId != CommonProcessor.GetWorldState().mLocalPlayerID) || (vInSlot.value != -1 && vInSlot.value + num != key))
		{
			return;
		}
		if (vInSkillId.value == -1)
		{
			List<int> mVHLSkill = CommonProcessor.GetWorldState().mVHLSkill;
			int num2 = key - num;
			if (mVHLSkill.Count > num2)
			{
				vSkillId = mVHLSkill[num2];
			}
			vSkillId = 0;
			CallOutput(entId, key);
			return;
		}
		List<int> mVHLSkill2 = CommonProcessor.GetWorldState().mVHLSkill;
		if (vInSlot.value == -1 && mVHLSkill2.Contains(vInSkillId.value))
		{
			vSkillId = vInSkillId.value;
			CallOutput(entId, key);
		}
		else if (vInSlot.value != -1 && mVHLSkill2.Count > vInSlot.value && mVHLSkill2[vInSlot.value] == vInSkillId.value)
		{
			vSkillId = vInSkillId.value;
			CallOutput(entId, key);
		}
	}

	private void CallOutput(int entId, int key)
	{
		vEntityId = entId;
		vKey = key;
		vSlot = key - 16;
		Flow f = new Flow
		{
			returnData = returnData,
			userData = base.mSimContext.GetEntityWithEntityID(entId)
		};
		fOut.Call(f);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mManualAIInputEvent = (Action<int, int>)Delegate.Combine(simInterface.mManualAIInputEvent, new Action<int, int>(HandleInput));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mManualAIInputEvent = (Action<int, int>)Delegate.Remove(simInterface.mManualAIInputEvent, new Action<int, int>(HandleInput));
	}
}
