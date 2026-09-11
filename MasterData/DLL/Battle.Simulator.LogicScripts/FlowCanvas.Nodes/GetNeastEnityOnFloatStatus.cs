using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]得到离目标距离最近的浮空实体ID", 0)]
[Category("Logic/角色定制/庚辰")]
[Description("得到距离最近的浮空实体ID")]
public class GetNeastEnityOnFloatStatus : FlowControlNodeOfLogic
{
	private int _minEntityID;

	protected override void RegisterPorts()
	{
		ValueInput<int> targetEntityIDInput = AddValueInput<int>("目标实体ID", "exEntityID");
		ValueInput<int> buffClassIDInput = AddValueInput<int>("排除类型(处理逻辑)ID", "classID");
		ValueInput<int> timerIDInput = AddValueInput<int>("排除计时器编号", "timerID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput noneOut = AddFlowOutput("无", "none");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_minEntityID = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(targetEntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon)
			{
				errorOut.Call(f);
			}
			else
			{
				Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
				List<int> allEnemy = SpawnProcessor.GetAllEnemy(base.graph.mSimContext);
				long num = long.MaxValue;
				for (int num2 = allEnemy.Count - 1; num2 >= 0; num2--)
				{
					if (allEnemy[num2] != targetEntityIDInput.value)
					{
						SimEntity entityWithEntityID2 = base.graph.mSimContext.GetEntityWithEntityID(allEnemy[num2]);
						if (!BuffProcessor.HasBuffOfClassID(entityWithEntityID2, buffClassIDInput.value) && (!entityWithEntityID2.hasEntityTimer || entityWithEntityID2.entityTimer.GetFirstIDByName(timerIDInput.value) == -1) && entityWithEntityID2 != null && entityWithEntityID2.hasEntityHitRecover && (entityWithEntityID2.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.FloatUp || entityWithEntityID2.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.HitAir || entityWithEntityID2.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.FloatDown))
						{
							long sqrMagnitudeLong = (entityWithEntityID2.entityPositon.mPosition - mPosition).sqrMagnitudeLong;
							if (sqrMagnitudeLong <= num)
							{
								_minEntityID = entityWithEntityID2.creationIndex;
								num = sqrMagnitudeLong;
							}
						}
					}
				}
				if (_minEntityID == 0)
				{
					noneOut.Call(f);
				}
				else
				{
					output.Call(f);
				}
			}
		});
		AddValueOutput("最近实体ID", "minEntityID", () => _minEntityID);
	}
}
