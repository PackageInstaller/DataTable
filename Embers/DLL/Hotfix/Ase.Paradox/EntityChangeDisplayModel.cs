using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改显示模型", 0)]
[Category("✫ DragonLost/Entity")]
[Description("修改显示模型。")]
public class EntityChangeDisplayModel : ActionTaskBase
{
	[Name("模型key", 0)]
	[Description("要修改的模型的关键字")]
	public BBParameter<string> boneKey;

	[Name("行为树结束是否重置", 0)]
	[Description("指示在行为树结束时是否重置显示模型")]
	public bool isRestore;

	private EntityViewComponent component;

	protected override void OnExecute()
	{
		base.OnExecute();
		component = ownerEntity.GetComponent<EntityViewComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		component.ChangeDisplayModel(boneKey.value);
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (component != null && isRestore)
		{
			component.ResetDisplayModel();
		}
	}
}
