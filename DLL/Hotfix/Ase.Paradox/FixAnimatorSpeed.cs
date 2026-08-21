using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("改变动画的播放速度", 0)]
[Category("✫ DragonLost/Animator")]
public class FixAnimatorSpeed : ActionTaskBase
{
	[Name("修改的实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("新的动画速度", 0)]
	public BBParameter<float> newSpeed;

	[Name("是否随行为树还原", 0)]
	public bool onTreeEndReduction;

	private AnimatorComponent animator;

	private float speed;

	private BaseEntity entity;

	protected override void OnExecute()
	{
		base.OnExecute();
		entity = GetEntity(entityId.value, isSyncEntity: false);
		animator = entity?.GetComponent<AnimatorComponent>();
		if (animator == null)
		{
			EndAction();
			return;
		}
		if (onTreeEndReduction)
		{
			speed = animator.AnimatorFixSpeed;
		}
		animator.SetAnimatorFixSpeed(newSpeed.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (onTreeEndReduction && entity != null)
		{
			entity?.GetComponent<AnimatorComponent>()?.SetAnimatorFixSpeed();
		}
	}
}
