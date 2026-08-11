using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体位移", 0)]
[Description("使实体沿指定方向移动一定距离，可以选择固定朝向或动态朝向。")]
[Category("✫ DragonLost/Transform")]
public class EntityMovementAction : ActionTaskBase
{
	[Name("位移距离", 0)]
	[Description("实体要移动的距离。")]
	public BBParameter<float> distance;

	[Name("均速模式", 0)]
	[Description("指示是否使用均速模式进行移动。")]
	public bool isUniformSpeedMode;

	[Name("固定朝向", 0)]
	[Description("指示是否在移动过程中保持固定的朝向。")]
	public bool lockDirect;

	[Name("移动时间", 0)]
	[Description("实体移动的持续时间。")]
	public BBParameter<float> moveTime;

	[Name("初速度", 0)]
	[Description("实体的初始速度。")]
	public BBParameter<float> startSpeed;

	[Name("是否等待完成", 0)]
	[Description("指示是否等待移动完成。")]
	public bool waitUntilFinish;

	[Name("冻帧时是否冻结位移", 0)]
	[Description("冻帧时是否冻结位移。")]
	public bool IsFrozenMovementCommand;

	[Name("是否打开碰撞取消位移", 0)]
	[Description("指示是否在碰撞检测到障碍物时取消移动。")]
	public bool isSkillMoveCancel;

	[Name("检测半径", 0)]
	[ShowIf("isSkillMoveCancel", 1)]
	public float CheckRadius;

	[ShowIf("isSkillMoveCancel", 1)]
	[Name("检测距离", 0)]
	[Description("用于检测碰撞的距离。")]
	public BBParameter<float> checkDistance = new BBParameter<float>(2f);

	private EntitySelfDegMoveComponent _moveComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		_moveComponent = ownerEntity.GetComponent<EntitySelfDegMoveComponent>();
		if (_moveComponent == null)
		{
			OnActionFail();
			return;
		}
		_moveComponent.InitData(lockDirect, isUniformSpeedMode, moveTime.value, distance.value, startSpeed.value, IsFrozenMovementCommand, isSkillMoveCancel, checkDistance.value, CheckRadius);
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		if (_moveComponent == null)
		{
			OnActionFinish();
		}
		else if (waitUntilFinish && _moveComponent.IsStopMove)
		{
			OnActionFinish();
		}
	}
}
