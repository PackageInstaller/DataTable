using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据一个值设置玩家位置和朝向", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体位置和朝向,传进来的是一个列表")]
public class SetPlayersPositionAndForwardAccordingToFirst : FlowNode
{
	public Int3 lcoalPos1;

	public Int3 forward1;

	public Int3 lcoalPos2;

	public Int3 forward2;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(lcoalPos1.x);
		writer.Write(lcoalPos1.y);
		writer.Write(lcoalPos1.z);
		writer.Write(forward1.x);
		writer.Write(forward1.y);
		writer.Write(forward1.z);
		writer.Write(lcoalPos2.x);
		writer.Write(lcoalPos2.y);
		writer.Write(lcoalPos2.z);
		writer.Write(forward2.x);
		writer.Write(forward2.y);
		writer.Write(forward2.z);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		lcoalPos1 = new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
		forward1 = new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
		lcoalPos2 = new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
		forward2 = new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
	}

	protected override void RegisterPorts()
	{
		ValueInput<Int3> spawnPoints = AddValueInput<Int3>("位置");
		ValueInput<Int3> spawnForward = AddValueInput<Int3>("朝向");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			Int3 value = spawnPoints.value;
			Int3 value2 = spawnForward.value;
			int num = 0;
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID != null)
				{
					Int3 zero = Int3.zero;
					Int3 zero2 = Int3.zero;
					switch (num)
					{
					case 0:
						zero = value;
						zero2 = value2;
						break;
					case 1:
						zero = IntMath.Transform(lcoalPos1, value2, value);
						zero2 = value2.RotateYWithLength(forward1.y);
						break;
					default:
						zero = IntMath.Transform(lcoalPos2, value2, value);
						zero2 = value2.RotateYWithLength(forward2.y);
						break;
					}
					num++;
					if (entityWithEntityID.hasEntityPositon)
					{
						entityWithEntityID.entityPositon.mPosition = zero;
						entityWithEntityID.entityPositon.mForward = zero2;
					}
					SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
				}
			}
			output.Call(f);
		});
	}
}
