using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("判断是否正在播放该动画", 0)]
[Category("✫ DragonLost/Entity")]
[Description("检查指定实体是否正在播放指定动画。")]
public class CheckAnimatorName : ConditionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要检查的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("获取哪一层的动画", 0)]
	[Description("要检查的动画所在的层级索引。")]
	public BBParameter<int> LayerIndex = 0;

	[Name("比对的动画名称", 0)]
	[Description("要比对的动画的名称。")]
	public BBParameter<string> AnimatorName;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			return false;
		}
		AnimatorComponent component = entity.GetComponent<AnimatorComponent>();
		if (component == null)
		{
			return false;
		}
		bool flag = component.GetStateHash(LayerIndex.value) == Animator.StringToHash(AnimatorName.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"判断是否正在播放该动画  result = {flag}", ownerEntity);
		}
		return flag;
	}
}
