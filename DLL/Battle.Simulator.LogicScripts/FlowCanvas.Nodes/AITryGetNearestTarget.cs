using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI获取最近目标(逻辑)", 0)]
[Category("Logic/AI")]
[Description("AI尝试获取最近的可以锁定的目标")]
public class AITryGetNearestTarget : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _True;

	private FlowOutput _False;

	private int _TargetID;

	protected override void RegisterPorts()
	{
		_True = AddFlowOutput("找到目标", "true");
		_False = AddFlowOutput("无目标", "false");
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_TargetID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp))
			{
				SimEntity simEntity = null;
				List<int> allEnemy = SpawnProcessor.GetAllEnemy();
				long num = long.MaxValue;
				for (int i = 0; i < allEnemy.Count; i++)
				{
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
					if (AIProcessor.CanLockOfEntity(entityWithEntityID2))
					{
						long num2 = MovementProcessor.SqrDistance(entityWithEntityID, entityWithEntityID2);
						if (num2 < num)
						{
							simEntity = entityWithEntityID2;
							num = num2;
						}
					}
				}
				_TargetID = simEntity?.creationIndex ?? 0;
			}
			else
			{
				_TargetID = AIProcessor.TryGetAttackTarget(entityWithEntityID.creationIndex);
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_TargetID);
				if (simEntityByMultiColliders != null)
				{
					_TargetID = simEntityByMultiColliders.creationIndex;
				}
			}
			AIProcessor.ChangeTarget(entityWithEntityID, _TargetID);
			if (_TargetID != 0)
			{
				_True.Call(f);
			}
			else
			{
				_False.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("目标", "targetID", () => _TargetID);
	}
}
