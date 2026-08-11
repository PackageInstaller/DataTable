#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("移动到目标点【寻路】", 0)]
[Description("使用寻路组件移动实体到指定目标点。")]
[Category("✫ DragonLost/Transform")]
public class MoveByPathfinding : ActionTaskBase
{
	private PathfindingComponent pathfindingComponent;

	[Name("执行者Id", 0)]
	[Description("要执行移动操作的实体的ID。")]
	public BBParameter<int> AgentId;

	[Name("最大执行时间", 0)]
	[Description("移动到目标点的最大执行时间。")]
	public BBParameter<float> ExecuteTime;

	[Name("结束距离", 0)]
	[SliderField(0.001f, 100f)]
	[Description("允许的距离目标点的最小距离，小于此距离时任务将视为完成。")]
	public BBParameter<float> remainingDistance = 1f;

	[RequiredField]
	[Name("目标坐标", 0)]
	[Description("要移动到的目标坐标点。")]
	public BBParameter<Vector3> targetPoint;

	[Name("等待移动完成", 0)]
	[Description("是否等待移动完成后再结束任务。")]
	public bool waitUntilFinish;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(AgentId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("移动到目标点【寻路】错误：实体为空!");
			OnActionFail();
			return;
		}
		pathfindingComponent = entity.GetComponent<PathfindingComponent>();
		if (pathfindingComponent == null)
		{
			OnActionFail();
			return;
		}
		pathfindingComponent.MoveToTarget(targetPoint.value, ExecuteTime.value, remainingDistance.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"移动到目标点【寻路】 targetPoint {targetPoint.value}  ExecuteTime  {ExecuteTime.value} " + $"remainingDistance  {remainingDistance.value}", ownerEntity);
		}
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		if (waitUntilFinish && pathfindingComponent != null)
		{
			if (!pathfindingComponent.IsMoving)
			{
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance.WriteAuthorityEntityId("移动到目标点【寻路】 结束", ownerEntity);
				}
				pathfindingComponent.NavMeshStop();
				OnActionFinish();
			}
		}
		else if (pathfindingComponent == null)
		{
			OnActionFail();
		}
	}
}
