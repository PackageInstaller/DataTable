using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("SwitchAI玩法", 0)]
[Category("Logic/AI")]
[Description("使用的黑板变量，变量名为【角色ID+00088】\n输入的实体ID无效时，走error")]
public class SwitchAIPlayMethod : FlowNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	private int mWantedVarName;

	private ValueInput<int> mEntityID;

	private int AIPlayMethod;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_portCount);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		FlowOutput[] cases = new FlowOutput[_portCount];
		for (int i = 0; i < cases.Length; i++)
		{
			cases[i] = AddFlowOutput(i.ToString());
		}
		mEntityID = AddValueInput<int>("实体ID", "entityID");
		FlowOutput weekMonsterOut = AddFlowOutput("99", "weekMonster");
		FlowOutput defaultCase = AddFlowOutput("Default");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("AI玩法", () => AIPlayMethod);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				mWantedVarName = entityWithEntityID.entityConfig.mId * 100000 + 88;
				if (entityWithEntityID.hasEntityBlackboard)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName, out var baseValue, out var _, out var _);
					AIPlayMethod = (int)baseValue;
					if (baseValue == 99)
					{
						weekMonsterOut.Call(f);
					}
					else
					{
						long num = baseValue;
						f.Call((num >= 0 && num < cases.Length) ? cases[num] : defaultCase);
					}
				}
				else
				{
					errorOut.Call(f);
				}
			}
		});
	}
}
