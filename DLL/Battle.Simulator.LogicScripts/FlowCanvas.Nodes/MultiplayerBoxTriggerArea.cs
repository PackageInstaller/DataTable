using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("多人矩形触发区域", 0)]
[Category("Logic/Trigger")]
[Description("多人矩形触发区域")]
public class MultiplayerBoxTriggerArea : FlowNode
{
	private List<int> collisions = new List<int>();

	private HashSet<int> mEntityIDs = new HashSet<int>(new IntComparer());

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小");
		ValueInput<bool> singleTriggerInput = AddValueInput<bool>("单人触发").SetDefaultAndSerializedValue(v: true);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		int n = 0;
		AddValueOutput("", () => n);
		AddFlowInput("In", delegate(Flow f)
		{
			collisions.Clear();
			uint roleCamp = 0u;
			RoleCampProcessor.Set(ref roleCamp, 1u);
			SimPhysics.OverlapBox(positionInput.value, forwardInput.value, Int3.zero, sizeInput.value, collisions, roleCamp);
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			mEntityIDs.Clear();
			for (int i = 0; i < collisions.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
				if (simEntityByMultiColliders != null)
				{
					mEntityIDs.Add(simEntityByMultiColliders.creationIndex);
				}
			}
			n = mEntityIDs.Count;
			if (singleTriggerInput.value)
			{
				if (n > 0)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
			else
			{
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
				int num = 0;
				while (enumerator.MoveNext())
				{
					int mEntityID = enumerator.Current.Value.mEntityID;
					if (base.mSimContext.GetEntityWithEntityID(mEntityID) != null)
					{
						num++;
					}
				}
				if (collisions.Count >= num)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
