using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("随机角色(阵营)(逻辑)", 0)]
[Category("Logic/Entity")]
[Description("随机得到指定阵营的角色;\n仅实现了 player、enemy 阵营;\n玩家阵营单机模式下随机角色,联机模式下都是本地玩家")]
public class RandomEntity : FlowControlNode
{
	private ValueInput<RoleType> _campInput;

	private FlowOutput _out;

	private FlowOutput _error;

	private int _entityID;

	protected override void RegisterPorts()
	{
		_campInput = AddValueInput<RoleType>("阵营", "camp");
		_out = AddFlowOutput("Out", "output");
		_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			_entityID = 0;
			RoleType value = _campInput.GetValue();
			switch (value)
			{
			case RoleType.Player:
				_entityID = RandomPlayer();
				break;
			case RoleType.Enemy:
				_entityID = RandomEnemy();
				break;
			default:
				_entityID = 0;
				Debug.LogError("=====>>>>> 【随机角色(阵营)】节点使用了未实现的阵营:" + value);
				break;
			}
			if (base.mSimContext.GetEntityWithEntityID(_entityID) != null)
			{
				_out.Call(f);
			}
			else
			{
				_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityID);
	}

	private int RandomEnemy()
	{
		List<int> mEnemys = base.mSimContext.sEntityWorldState.status.mEnemys;
		if (mEnemys.Count == 0)
		{
			return 0;
		}
		int index = (int)DRandom.Random((uint)mEnemys.Count);
		return mEnemys[index];
	}

	private int RandomPlayer()
	{
		int result = 0;
		Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
		int num = 0;
		foreach (RemoteMember value in mRoomMembers.Values)
		{
			if (base.mSimContext.GetEntityWithEntityID(value.mEntityID) != null)
			{
				num++;
			}
		}
		uint num2 = DRandom.Random((uint)mRoomMembers.Count);
		num = 0;
		foreach (RemoteMember value2 in mRoomMembers.Values)
		{
			if (base.mSimContext.GetEntityWithEntityID(value2.mEntityID) != null)
			{
				if (num == num2)
				{
					result = value2.mEntityID;
					break;
				}
				num++;
			}
		}
		return result;
	}
}
