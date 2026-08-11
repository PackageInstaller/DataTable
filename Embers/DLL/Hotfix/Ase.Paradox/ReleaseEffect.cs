#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("回收特效实体", 0)]
[Description("回收特效实体。")]
[Category("✫ DragonLost/Effect")]
public class ReleaseEffect : ActionTaskBase
{
	[Name("特效实体ID", 0)]
	[Description("要设置的特效实体的ID")]
	public BBParameter<int> effectId;

	protected override void OnExecute()
	{
		base.OnExecute();
		EffectEntity effectEntity = (EffectEntity)GetEntity(effectId.value, isSyncEntity: false);
		if (effectEntity == null)
		{
			LogActionError("回收特效实体错误：特效实体为空!");
			EndAction();
		}
		else
		{
			effectEntity.SetTimeDelayDispose(dispose: true);
			effectEntity.SetDuration(0f);
			EndAction();
		}
	}
}
