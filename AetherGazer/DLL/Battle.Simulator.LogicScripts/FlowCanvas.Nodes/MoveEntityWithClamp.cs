using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("限制指定实体可移动区域(矩形)", 0)]
[Category("Logic/PosAndRot")]
[Description("限制指定实体可移动区域,处理限定实体只能在某个区域内活动")]
public class MoveEntityWithClamp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<bool> isCircleInput = AddValueInput<bool>("是否使用圆形");
		ValueInput<Int3> centerInput = AddValueInput<Int3>("中心");
		ValueInput<int> XLengthInput = AddValueInput<int>("X向长度");
		ValueInput<int> ZLengthInput = AddValueInput<int>("Z向长度");
		ValueInput<int> RangeInput = AddValueInput<int>("范围(圆形)");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("add", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (entityWithEntityID.hasEntityMoveClamp)
				{
					entityWithEntityID.ReplaceEntityMoveClamp(isCircleInput.value, centerInput.value, ZLengthInput.value / 2, XLengthInput.value / 2, RangeInput.value);
				}
				else
				{
					entityWithEntityID.AddEntityMoveClamp(isCircleInput.value, centerInput.value, ZLengthInput.value / 2, XLengthInput.value / 2, RangeInput.value);
				}
				output.Call(f);
			}
		});
		AddFlowInput("remove", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (entityWithEntityID.hasEntityMoveClamp)
				{
					entityWithEntityID.RemoveEntityMoveClamp();
				}
				output.Call(f);
			}
		});
	}
}
