#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体朝给定角度匀速位移", 0)]
[Description("使指定实体朝着给定角度匀速移动一定距离。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class EntityMoveByDegAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要移动的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("角度", 0)]
	[Description("移动方向的角度。")]
	public float Angle;

	[Name("位移距离", 0)]
	[Description("移动的距离。")]
	public float Distance;

	[Name("位移时间", 0)]
	[Description("移动的持续时间。")]
	public float Timer;

	[Name("冻帧时是否冻结位移", 0)]
	[Description("冻帧时是否冻结位移。")]
	public bool IsFrozenMovementCommand;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("实体朝给定角度匀速位移错误：实体为空!");
			EndAction();
		}
		else
		{
			entity.GetComponent<NormalMoveComponent>().SetMoveParam(Timer, Distance, GetOwnerEntity().transform.rotation.eulerAngles.y + Angle, IsFrozenMovementCommand);
			EndAction();
		}
	}
}
