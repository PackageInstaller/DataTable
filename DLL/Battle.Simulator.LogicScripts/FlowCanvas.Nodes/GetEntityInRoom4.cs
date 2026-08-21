using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理房间内的玩家(神系)", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历处理房间内的玩家, AI也算; \ncount 就是符合条件的合计数量，每次调用也可以放心使用")]
public class GetEntityInRoom4 : FlowControlNodeOfLogic
{
	private ValueInput<int> _WithoutEntityIDInput;

	private ValueInput<bool> _includeHpZoreInput;

	private ValueInput<RaceType> _raceTypeInput;

	private List<int> list;

	private int res;

	private int count;

	protected override void RegisterPorts()
	{
		_WithoutEntityIDInput = AddValueInput<int>("排除实体ID", "withoutID").SetDefaultAndSerializedValue(-1);
		_includeHpZoreInput = AddValueInput<bool>("包含血量为0的实体", "includeHpZore").SetDefaultAndSerializedValue(v: false);
		_raceTypeInput = AddValueInput<RaceType>("神系", "raceType");
		AddValueOutput("实体ID", "entityID", () => res);
		AddValueOutput("数量", "count", () => count);
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		AddFlowInput("", delegate(Flow f)
		{
			res = 0;
			count = 0;
			list = FrameListPool<int>.Claim();
			int value = _WithoutEntityIDInput.GetValue();
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				res = enumerator.Current.Value.mEntityID;
				if (res != value)
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(res);
					if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.hasEntityBlackboard && (entityWithEntityID.entityBlackboard.var.mHP > 0 || _includeHpZoreInput.value) && ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.entityConfig.mId, out var config) && config.RaceID == (int)_raceTypeInput.value)
					{
						list.Add(entityWithEntityID.creationIndex);
						count++;
					}
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				res = list[i];
				doOut.Call(f);
			}
			f.Call(doneOut);
			FrameListPool<int>.Release(list);
		});
	}
}
