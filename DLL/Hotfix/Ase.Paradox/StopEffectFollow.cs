using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("取消特效跟随", 0)]
[Category("✫ DragonLost/Effect")]
[Description("停止特效跟随其父节点的运动。")]
public class StopEffectFollow : ActionTaskBase
{
	[RequiredField]
	[Name("特效Id", 0)]
	[Description("要取消跟随的特效的ID。")]
	public BBParameter<int> effectId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(effectId.value, isSyncEntity: false);
		if (entity != null)
		{
			entity.GetComponent<FollowParentEntityTransformComponent>()?.StopFollow();
			OnActionFinish();
		}
		else
		{
			OnActionFail();
		}
	}
}
