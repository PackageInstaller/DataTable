using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("开始交互", 0)]
[Description("启动交互操作，用于多人交互场景。")]
[Category("✫ DragonLost/Interactive")]
public class StartInteractiveAction : ActionTaskBase
{
	public BBParameter<HeroSkillTypeEnum> SkillType;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetComponent<HeroInteractiveComponent>().StartInteractive(SkillType.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("开始交互 ", ownerEntity);
		}
		OnActionFinish();
	}
}
