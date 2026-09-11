using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("设置实体位置(安全版)(考虑Buff)", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体位置,但是不要用于每帧调用")]
public class SetEntityPositionWithMoveCheckBuff : FlowControlNodeOfLogic
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
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置", "position");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput dontMoveOut = AddFlowOutput("无法移动", "hasBuff");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon)
			{
				errorOut.Call(f);
			}
			else
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
				}
				else
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
					output.Call(f);
				}
			}
		});
	}
}
