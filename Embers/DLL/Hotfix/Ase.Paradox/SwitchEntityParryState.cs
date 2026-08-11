using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("开启格挡", 0)]
[Description("根据设置开启或关闭实体的格挡状态，并选择是否在行为树结束时还原状态。")]
[Category("✫ DragonLost/Entity")]
public class SwitchEntityParryState : ActionTaskBase
{
	[Name("开启", 0)]
	[Description("指定是否开启格挡状态。")]
	public BBParameter<bool> Open;

	[Name("随行为树结束还原", 0)]
	[Description("指定是否在行为树结束时还原格挡状态。")]
	public bool Refresh;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<ParryComponent>()?.SwitchState(Open.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && Refresh)
		{
			ownerEntity?.GetComponent<ParryComponent>()?.SwitchState(!Open.value);
		}
	}
}
