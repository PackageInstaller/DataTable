using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("设置实体位置和朝向", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体位置和朝向, 朝向不为0的时候才会设置朝向, 不然不管")]
public class SetEntityPositionAndForward : FlowNode
{
	public List<int> _blockBuffClassIDList = new List<int> { 301, 303, 304 };

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_blockBuffClassIDList = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, _blockBuffClassIDList, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<bool> safeInput = AddValueInput<bool>("安全位置").SetDefaultAndSerializedValue(v: true);
		ValueInput<bool> checkBuffInput = AddValueInput<bool>("检查Buff").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput dontMoveOut = AddFlowOutput("无法移动");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon)
			{
				errorOut.Call(f);
			}
			else
			{
				Int3 value = forwardInput.value;
				if (value != Int3.zero)
				{
					entityWithEntityID.entityPositon.mForward = value.NormalizeTo(1000);
					entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
				}
				if (checkBuffInput.value)
				{
					bool flag = true;
					if (entityWithEntityID.hasEntityBuff && _blockBuffClassIDList.Count > 0)
					{
						for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
						{
							int item = entityWithEntityID.entityBuff.mBuffClassIDArray[i];
							if (_blockBuffClassIDList.Contains(item))
							{
								flag = false;
								break;
							}
						}
					}
					if (!flag)
					{
						dontMoveOut.Call(f);
						return;
					}
				}
				if (safeInput.value)
				{
					int groundY = 0;
					Int3 delta = positionInput.value - entityWithEntityID.entityPositon.mPosition;
					delta = PathUtilities.Move(entityWithEntityID.entityPositon.mPosition, delta, ref groundY, isUseTangentMove: false);
					if (!PathUtilities.IsOnGraph(delta + entityWithEntityID.entityPositon.mPosition))
					{
						MovementProcessor.SetPosition(entityWithEntityID, entityWithEntityID.entityPositon.mPosition);
					}
					else
					{
						MovementProcessor.ModifyPosition(entityWithEntityID, delta);
					}
				}
				else
				{
					MovementProcessor.SetPosition(entityWithEntityID, positionInput.value);
				}
				output.Call(f);
			}
		});
	}
}
