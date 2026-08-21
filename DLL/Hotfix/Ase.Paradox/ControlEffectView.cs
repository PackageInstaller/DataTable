using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("控制实体挂载特效显示或隐藏", 0)]
[Category("✫ DragonLost/Effect")]
[Description("是否显示所有特效，如果是就显示实体身上特效类型为FOLLOW_ENTITY或FOLLOW_BONE的特效，否则反之。")]
public class ControlEffectView : ActionTaskBase
{
	[Name("是否显示所有特效", 0)]
	[Description("是否显示所有特效，如果是就显示实体身上特效类型为FOLLOW_ENTITY或FOLLOW_BONE的特效，否则反之。")]
	public bool ShowEffectView;

	[Name("是否跟随行为树结束还原", 0)]
	[Description("指在行为树结束时是否还原")]
	public bool followTreeDispose;

	protected override async void OnExecute()
	{
		base.OnExecute();
		EffectControlComponent component = ownerEntity.GetComponent<EffectControlComponent>();
		if (component == null)
		{
			OnActionFinish();
			return;
		}
		if (ShowEffectView)
		{
			component.ShowAllEffect();
		}
		else
		{
			component.HideAllEffect();
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && followTreeDispose)
		{
			if (ShowEffectView)
			{
				ownerEntity?.GetComponent<EffectControlComponent>()?.HideAllEffect();
			}
			else
			{
				ownerEntity?.GetComponent<EffectControlComponent>()?.ShowAllEffect();
			}
		}
	}
}
