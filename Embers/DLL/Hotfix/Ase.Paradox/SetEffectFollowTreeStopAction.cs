using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置特效跟随行为树销毁状态", 0)]
[Description("设置特效是否跟随行为树销毁状态。")]
[Category("✫ DragonLost/Effect")]
public class SetEffectFollowTreeStopAction : ActionTaskBase
{
	[Name("特效实体ID", 0)]
	[Description("要设置的特效实体的ID")]
	public BBParameter<int> EffectEntityId;

	[Name("是否跟随销毁", 0)]
	[Description("指示特效是否跟随行为树销毁")]
	public BBParameter<bool> IsFollowDestroy;

	protected override void OnExecute()
	{
		base.OnExecute();
		EffectEntity effectEntity = (EffectEntity)GetEntity(EffectEntityId.value, isSyncEntity: false);
		if (effectEntity == null)
		{
			EndAction();
			return;
		}
		effectEntity.EffectData.FollowTreeStop = IsFollowDestroy.value;
		EndAction();
	}
}
