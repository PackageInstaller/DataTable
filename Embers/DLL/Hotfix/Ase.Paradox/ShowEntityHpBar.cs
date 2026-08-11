using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示/隐藏实体血条", 0)]
[Description("根据指定的参数显示或隐藏实体的血条。")]
[Category("✫ DragonLost/Entity")]
public class ShowEntityHpBar : ActionTaskBase
{
	[Name("显示/隐藏", 0)]
	[Description("指定是否显示或隐藏实体的血条。")]
	public BBParameter<bool> isShow = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		HpComponent component = ownerEntity.GetComponent<HpComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		if (isShow.value)
		{
			component.ShowHpBar();
		}
		else
		{
			component.HideHpBar();
		}
		OnActionFinish();
	}
}
