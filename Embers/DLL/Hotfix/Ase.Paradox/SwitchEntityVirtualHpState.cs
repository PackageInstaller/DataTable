using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("开启虚血", 0)]
[Description("根据设置开启或关闭实体的虚血状态，并选择是否在行为树结束时还原状态。")]
[Category("✫ DragonLost/Entity")]
public class SwitchEntityVirtualHpState : ActionTaskBase
{
	[Name("开启", 0)]
	[Description("指定是否开启虚血状态。")]
	public BBParameter<bool> Open;

	[Name("随行为树结束还原", 0)]
	[Description("指定是否在行为树结束时还原虚血状态。")]
	public bool Refresh;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<HpComponent>().SwitchState(Open.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && Refresh)
		{
			ownerEntity.GetComponent<HpComponent>()?.SwitchState(!Open.value);
		}
	}
}
