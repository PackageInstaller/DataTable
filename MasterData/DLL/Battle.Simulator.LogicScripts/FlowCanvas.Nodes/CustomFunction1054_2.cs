using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[无常]得到技能三标识", 0)]
[Category("Logic/角色定制/无常")]
[Description("1054无常技能三标识用的节点")]
public class CustomFunction1054_2 : FlowControlNodeOfLogic
{
	private int _index0Count;

	private int _index1Count;

	private int _index2Count;

	private int _index3Count;

	private int _count;

	private int _typeCount;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> blackboardValueIDInput = AddValueInput<int>("黑板值ID", "blackboardValueID");
		ValueInput<int> comparisonValueInput = AddValueInput<int>("比较值", "comparisonValue");
		FlowOutput fullOut = AddFlowOutput("满", "full");
		FlowOutput noFullOut = AddFlowOutput("未满", "noFull");
		FlowOutput output = AddFlowOutput("Done", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_index0Count = 0;
			_index1Count = 0;
			_index2Count = 0;
			_index3Count = 0;
			_count = 0;
			_typeCount = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, blackboardValueIDInput.value, out var baseValue, out var _, out var _);
				uint num = (uint)baseValue;
				_index0Count = (int)(num & 0xF);
				_index1Count = (int)((num >> 4) & 0xF);
				_index2Count = (int)((num >> 8) & 0xF);
				_index3Count = (int)((num >> 12) & 0xF);
				_count = _index0Count + _index1Count + _index2Count + _index3Count;
				_typeCount = ((_index0Count > 0) ? 1 : 0) + ((_index1Count > 0) ? 1 : 0) + ((_index2Count > 0) ? 1 : 0) + ((_index3Count > 0) ? 1 : 0);
				if (_count >= comparisonValueInput.value)
				{
					fullOut.Call(f);
				}
				else
				{
					noFullOut.Call(f);
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("标记0数量", "index0Count", () => _index0Count);
		AddValueOutput("标记1数量", "index1Count", () => _index1Count);
		AddValueOutput("标记2数量", "index2Count", () => _index2Count);
		AddValueOutput("标记3数量", "index3Count", () => _index3Count);
		AddValueOutput("总数", "count", () => _count);
		AddValueOutput("种类数", "typeCount", () => _typeCount);
	}
}
