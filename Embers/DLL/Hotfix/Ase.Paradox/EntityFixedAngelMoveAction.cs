using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体固定角度位移", 0)]
[Description("在给定角度上以固定速度或加速度进行位移。")]
[Category("✫ DragonLost/Transform")]
public class EntityFixedAngelMoveAction : ActionTaskBase
{
	[Name("位移角度", 0)]
	[Description("移动方向的角度值。")]
	public BBParameter<float> moveDir;

	[Name("位移距离", 0)]
	[Description("位移的距离。")]
	public BBParameter<float> distance;

	[Name("均速模式", 0)]
	[Description("指示是否使用均速模式。")]
	public bool isUniformSpeedMode;

	[Name("移动时间", 0)]
	[Description("移动所需的时间。")]
	public BBParameter<float> moveTime;

	[Name("初速度", 0)]
	[Description("初始速度。")]
	public BBParameter<float> startSpeed;

	[Name("是否等待完成", 0)]
	[Description("指示是否等待移动完成。")]
	public bool waitUntilFinish;

	[Name("冻帧时是否冻结位移", 0)]
	[Description("冻帧时是否冻结位移。")]
	public bool IsFrozenMovementCommand;

	private EntityFixedAngelMoveComponent _entityFixedAngelMoveComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		_entityFixedAngelMoveComponent = ownerEntity.GetComponent<EntityFixedAngelMoveComponent>();
		if (_entityFixedAngelMoveComponent == null)
		{
			OnActionFail();
			return;
		}
		_entityFixedAngelMoveComponent.InitData(moveDir.value, isUniformSpeedMode, moveTime.value, distance.value, startSpeed.value, IsFrozenMovementCommand);
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		if (_entityFixedAngelMoveComponent == null)
		{
			OnActionFinish();
		}
		else if (waitUntilFinish && _entityFixedAngelMoveComponent.IsStopMove)
		{
			OnActionFinish();
		}
	}
}
