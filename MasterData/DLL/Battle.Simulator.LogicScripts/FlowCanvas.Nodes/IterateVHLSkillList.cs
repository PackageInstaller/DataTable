using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]遍历战术技能槽(逻辑)", 0)]
[Category("Logic/Config")]
[Description("根据起止遍历战术技能槽，-1时完全遍历。仅AI玩法可用")]
[Color("ffffff")]
public class IterateVHLSkillList : FlowNode
{
	private ValueInput<int> vInStart;

	private ValueInput<int> vInEnd;

	private ValueInput<int> vInStep;

	private int vSkillId;

	private int vIndex;

	private FlowOutput fDo;

	private FlowOutput fDone;

	protected override void RegisterPorts()
	{
		vInStart = AddValueInput<int>("Begin");
		vInEnd = AddValueInput<int>("End").SetDefaultAndSerializedValue(-1);
		vInStep = AddValueInput<int>("Step").SetDefaultAndSerializedValue(1);
		AddValueOutput("技能Id", () => vSkillId);
		AddValueOutput("下标", () => vIndex);
		fDo = AddFlowOutput("Do");
		fDone = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			List<int> mVHLSkill = CommonProcessor.GetWorldState().mVHLSkill;
			if (mVHLSkill == null || mVHLSkill.Count == 0)
			{
				vSkillId = 0;
				vIndex = 0;
				fDone.Call(f);
			}
			else
			{
				vIndex = vInStart.value;
				int num = vInEnd.value;
				int value = vInStep.value;
				if (vIndex >= mVHLSkill.Count)
				{
					vIndex = 0;
					vSkillId = 0;
					fDone.Call(f);
				}
				else
				{
					if (num < 0 || num > mVHLSkill.Count)
					{
						num = mVHLSkill.Count;
					}
					while (vIndex < num)
					{
						vSkillId = mVHLSkill[vIndex];
						fDo.Call(f);
						vIndex += value;
					}
					fDone.Call(f);
				}
			}
		});
	}
}
