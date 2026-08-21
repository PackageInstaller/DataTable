using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指挥官追击逻辑", 0)]
[Category("Logic/AI")]
[Description("指挥官追击逻辑(http://wiki.in.ys4fun.com/pages/viewpage.action?pageId=33129636)")]
public class CommanderApproachLogic : FlowNode
{
	private List<int> targets = new List<int>();

	protected override void RegisterPorts()
	{
		AddFlowInput("", delegate
		{
			SimWorldState worldState = CommonProcessor.GetWorldState();
			if (worldState != null)
			{
				int difficulty = worldState.difficulty;
				ConfigHelper.GetInstance().TryGetConfig<diffculty>(difficulty, out var config);
				if (config != null)
				{
					int num = 0;
					SimEntity simEntity = null;
					Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = worldState.mRoomMembers.GetEnumerator();
					while (enumerator.MoveNext())
					{
						simEntity = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
						if (AIProcessor.CanLockOfEntity(simEntity))
						{
							num = enumerator.Current.Value.mEntityID;
							break;
						}
					}
					if (num != 0 && simEntity != null)
					{
						int a = config.A1;
						targets.Clear();
						SimPhysics.Overlap(simEntity.entityPositon.mPosition, a, targets, 2u);
						int a2 = config.A2;
						if (targets.Count <= a2)
						{
							for (int i = 0; i < worldState.mEnemys.Count; i++)
							{
								SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(worldState.mEnemys[i]);
								if (AIProcessor.CanLockOfEntity(entityWithEntityID) && !entityWithEntityID.hasEntityHitRecover && entityWithEntityID.entityBlackboard.var.enemyType == EnemyType.MonsterNormal)
								{
									AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, out var baseValue, out var _, out var _);
									if (baseValue <= 1)
									{
										AIProcessor.ChangeTarget(entityWithEntityID, simEntity.creationIndex);
										AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, 2L, 0L, 0L);
										base.mSimContext.GetSimInterface().mCommanderCommandEvent?.Invoke(entityWithEntityID.creationIndex, AICommanderEventType.Approach);
										break;
									}
								}
							}
						}
					}
				}
			}
		});
	}
}
