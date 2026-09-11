using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取队友实体ID", 0)]
[Category("Logic/PosAndRot")]
[Description("获取队友实体ID, 如果队友已经死掉了或者没有队友, 走error")]
public class GetTeammateEntityID : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<bool> indexInput = AddValueInput<bool>("第一个");
		int resultID = 0;
		AddValueOutput("实体ID", () => resultID);
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			int localPlayerID = SpawnProcessor.GetLocalPlayerID();
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
			bool flag = indexInput.value;
			resultID = 0;
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				if (mEntityID != localPlayerID)
				{
					if (flag)
					{
						if (base.mSimContext.GetEntityWithEntityID(mEntityID) != null)
						{
							resultID = mEntityID;
						}
						break;
					}
					flag = true;
				}
			}
			if (resultID != 0)
			{
				output.Call(f);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
