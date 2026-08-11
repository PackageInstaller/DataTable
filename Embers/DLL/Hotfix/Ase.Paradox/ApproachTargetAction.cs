#define ENABLE_LOG
using System;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("向目标移动", 0)]
[Description("使指定实体向目标移动，并根据设置进行偏移。")]
[Category("✫ DragonLost/Transform")]
public class ApproachTargetAction : ActionTaskBase
{
	private BaseEntity _agentEntity;

	private float _clock;

	private float _maxExecuteTime;

	private BaseEntity _targetEntity;

	private float _time = 0.2f;

	[Name("执行者Id", 0)]
	[Description("要执行移动操作的实体的Id。")]
	public BBParameter<int> AgentId;

	[Name("最大执行时间", 0)]
	[Description("执行移动操作的最大持续时间。")]
	public BBParameter<float> ExecuteTime;

	[Name("是否偏移", 0)]
	[Description("是否根据偏移角度进行移动。")]
	public BBParameter<bool> isOpenOffset;

	[Tooltip("要向其移动的目标实体的Id。")]
	[Name("目标Id", 0)]
	[Description("要向其移动的目标实体的Id。")]
	public BBParameter<int> TargetId;

	[SliderField(0.001f, 100f)]
	[Description("实体与目标之间的最大距离，当实体接近此距离时，停止移动。")]
	[Name("结束目标距离", 0)]
	public BBParameter<float> MaxEndDistance;

	[Name("偏移角度", 0)]
	[ShowIf("isOpenOffset", true)]
	[Description("偏移角度，用于计算偏移位置。")]
	public BBParameter<float> offsetAngle;

	[Name("偏移距离", 0)]
	[ShowIf("isOpenOffset", true)]
	[Description("偏移距离，用于计算偏移位置。")]
	public BBParameter<float> offsetDistance;

	private Vector3 offsetDirect;

	protected override void OnExecute()
	{
		base.OnExecute();
		_agentEntity = GetEntity(AgentId.value, isSyncEntity: false);
		_targetEntity = GetEntity(TargetId.value, isSyncEntity: true);
		if (_agentEntity == null || _targetEntity == null)
		{
			LogActionError("接近目标错误:实体为空!");
			EndAction();
			return;
		}
		_maxExecuteTime = ExecuteTime.value;
		_clock = _time;
		if (isOpenOffset.value)
		{
			offsetDirect = new Vector3(Mathf.Cos(MathF.PI / 180f * offsetAngle.value), 0f, Mathf.Sin(MathF.PI / 180f * offsetAngle.value)) * offsetDistance.value;
		}
		else
		{
			offsetDirect = Vector3.zero;
		}
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		_agentEntity?.GetComponent<PathfindingComponent>()?.NavMeshStop();
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (_agentEntity == null || _targetEntity == null || _targetEntity.transform == null)
		{
			LogActionError("接近目标错误:实体为空!");
			EndAction();
			return;
		}
		_clock += base.ownerSystem.elapsedTime;
		if (_clock >= _time)
		{
			_agentEntity.GetComponent<PathfindingComponent>()?.MoveToTarget(_targetEntity.transform.position + _targetEntity.transform.rotation * offsetDirect, ExecuteTime.value, MaxEndDistance.value);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"向目标移动   _targetEntity.transform.position {_targetEntity.transform.position} " + $"offsetDirect {offsetDirect}  ExecuteTime {ExecuteTime.value} MaxEndDistance {MaxEndDistance.value} ", ownerEntity);
			}
			_clock = 0f;
		}
		_maxExecuteTime -= base.ownerSystem.deltaTime;
		if (_maxExecuteTime <= 0f)
		{
			_agentEntity.GetComponent<PathfindingComponent>().NavMeshStop();
			EndAction();
		}
		if (!_agentEntity.GetComponent<PathfindingComponent>().IsMoving)
		{
			EndAction();
		}
	}
}
