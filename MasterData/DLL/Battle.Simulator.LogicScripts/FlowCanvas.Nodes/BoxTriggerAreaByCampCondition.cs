using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("矩形触发区域(阵营)", 0)]
[Category("Logic/Trigger")]
[Description("判断指定阵营是否进入到这个区域中，单人触发仅对player阵营有效，触发所需数量对player阵营以外有效")]
public class BoxTriggerAreaByCampCondition : FlowNode
{
	private List<int> collisions = new List<int>();

	private HashSet<int> mEntityIDs = new HashSet<int>(new IntComparer());

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小");
		ValueInput<RoleType> roleCampVar = AddValueInput<RoleType>("阵营").SetDefaultAndSerializedValue(RoleType.Player);
		ValueInput<int> countInput = AddValueInput<int>("触发所需数量").SetDefaultAndSerializedValue(1);
		ValueInput<bool> singleTriggerInput = AddValueInput<bool>("单人触发").SetDefaultAndSerializedValue(v: true);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			collisions.Clear();
			uint roleCamp = 0u;
			RoleCampProcessor.Set(ref roleCamp, (uint)roleCampVar.value);
			SimPhysics.OverlapBox(positionInput.value, forwardInput.value, Int3.zero, sizeInput.value, collisions, roleCamp);
			mEntityIDs.Clear();
			for (int i = 0; i < collisions.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
				if (simEntityByMultiColliders != null)
				{
					mEntityIDs.Add(simEntityByMultiColliders.creationIndex);
				}
			}
			if (roleCampVar.value == RoleType.Player)
			{
				if (singleTriggerInput.value)
				{
					if (mEntityIDs.Count > 0)
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
					Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
					int num = 0;
					while (enumerator.MoveNext())
					{
						int mEntityID = enumerator.Current.Value.mEntityID;
						if (base.mSimContext.GetEntityWithEntityID(mEntityID) != null)
						{
							num++;
						}
					}
					if (mEntityIDs.Count >= num)
					{
						trueOut.Call(f);
					}
					else
					{
						falseOut.Call(f);
					}
				}
			}
			else if (collisions.Count >= countInput.value)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
