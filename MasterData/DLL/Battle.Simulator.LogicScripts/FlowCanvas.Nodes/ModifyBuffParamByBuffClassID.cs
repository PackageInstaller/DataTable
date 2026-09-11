using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改Buff参数(类型(处理逻辑)ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("修改buff参数(ID), 下标从0开始, 乘法操作的参数是百分比")]
public class ModifyBuffParamByBuffClassID : FlowNode
{
	private int _index = -1;

	private ValueInput<int> m_buffClassID;

	private ValueInput<OperationMethod> m_opInput;

	private ValueInput<SimVar> m_valueInput;

	private ValueInput<int> m_indexInput;

	private FlowOutput m_out;

	private ValueInput<int> m_entityIDInput;

	public SimVar ModifyParam(SimVar simVar, OperationMethod operationMethod, SimVar value)
	{
		switch (operationMethod)
		{
		case OperationMethod.Add:
			simVar = (int)simVar + (int)value;
			break;
		case OperationMethod.Divide:
			simVar = (int)simVar / (int)value;
			break;
		case OperationMethod.Multiply:
			simVar = (int)simVar * (int)value;
			simVar = (int)simVar / 100;
			break;
		case OperationMethod.Set:
			simVar = value;
			break;
		case OperationMethod.Subtract:
			simVar = (int)simVar - (int)value;
			break;
		}
		return simVar;
	}

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		m_buffClassID = AddValueInput<int>("类型(处理逻辑)ID", "BuffClassID");
		m_opInput = AddValueInput<OperationMethod>("操作", "OperationMethod");
		m_valueInput = AddValueInput<SimVar>("值", "value");
		m_indexInput = AddValueInput<int>("Buff参数下标(0-3)", "buffParamIndex");
		m_out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_index = -1;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				int num = -1;
				int value = m_buffClassID.GetValue();
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == value && !entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]))
					{
						num = i;
						break;
					}
				}
				if (num >= 0)
				{
					BuffParams value2 = entityWithEntityID.entityBuff.mBuffParamsArray[num];
					switch (m_indexInput.GetValue())
					{
					case 0:
						value2.v1 = ModifyParam(value2.v1, m_opInput.GetValue(), m_valueInput.GetValue());
						break;
					case 1:
						value2.v2 = ModifyParam(value2.v2, m_opInput.GetValue(), m_valueInput.GetValue());
						break;
					case 2:
						value2.v3 = ModifyParam(value2.v3, m_opInput.GetValue(), m_valueInput.GetValue());
						break;
					case 3:
						value2.v4 = ModifyParam(value2.v4, m_opInput.GetValue(), m_valueInput.GetValue());
						break;
					}
					entityWithEntityID.entityBuff.mBuffParamsArray[num] = value2;
					_index = num;
				}
			}
			f.Call(m_out);
		});
		AddValueOutput("数组下标", "listIndex", () => _index);
	}
}
