using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Serializable]
[Name("初始化玩家位置和朝向", 0)]
[Category("Logic/PosAndRot")]
[Description("初始化实体位置和朝向,传进来的是一个列表")]
public class InitPlayersPosAndRot : FlowNode
{
	public void AppearAction(SimEntity entity)
	{
		int appear = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entity.ENTITY_CONFIG_ID).Appear;
		AIProcessor.AIStartAttack(entity.creationIndex, entity.entityPositon.mPosition + entity.entityPositon.mForward, appear);
	}

	protected override void RegisterPorts()
	{
		ValueInput<List<int>> unitList = AddValueInput<List<int>>("角色列表");
		ValueInput<List<Int3>> spawnPoints = AddValueInput<List<Int3>>("位置");
		ValueInput<List<Int3>> spawnForward = AddValueInput<List<Int3>>("朝向");
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("in", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			if (CommonProcessor.IsSinglePlayerGameMode(base.mSimContext))
			{
				int localPlayerID = SpawnProcessor.GetLocalPlayerID();
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(localPlayerID);
				entityWithEntityID.entityPositon.mPosition = spawnPoints.value[0];
				entityWithEntityID.entityPositon.mForward = spawnForward.value[0];
				SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
				AppearAction(entityWithEntityID);
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
				int num = 1;
				while (enumerator.MoveNext() && num < unitList.value.Count)
				{
					int mEntityID = enumerator.Current.Value.mEntityID;
					if (mEntityID != localPlayerID)
					{
						entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
						if (entityWithEntityID != null)
						{
							if (entityWithEntityID.hasEntityPositon)
							{
								entityWithEntityID.entityPositon.mPosition = spawnPoints.value[num];
								entityWithEntityID.entityPositon.mForward = spawnForward.value[num];
								num++;
								AppearAction(entityWithEntityID);
							}
							SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
						}
					}
				}
			}
			else
			{
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator2 = mRoomMembers.GetEnumerator();
				int num2 = 0;
				while (enumerator2.MoveNext() && num2 < unitList.value.Count)
				{
					int mEntityID2 = enumerator2.Current.Value.mEntityID;
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mEntityID2);
					if (entityWithEntityID2 != null)
					{
						if (entityWithEntityID2.hasEntityRemotePlayer)
						{
							SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID2.entityRemotePlayer.mLocalEntityID);
							if (entityWithEntityID3 != null)
							{
								entityWithEntityID3.entityPositon.mPosition = spawnPoints.value[0];
								entityWithEntityID3.entityPositon.mForward = spawnForward.value[0];
							}
						}
						if (entityWithEntityID2.hasEntityPositon)
						{
							entityWithEntityID2.entityPositon.mPosition = spawnPoints.value[num2];
							entityWithEntityID2.entityPositon.mForward = spawnForward.value[num2];
							num2++;
							AppearAction(entityWithEntityID2);
						}
						SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID2);
					}
				}
			}
			output.Call(f);
		});
	}
}
