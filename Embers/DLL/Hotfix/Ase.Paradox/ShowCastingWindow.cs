using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示Casting窗口", 0)]
[Description("在场景中显示指定路径的 Casting 窗口。显示的路径配置在Hero表中CastingPath字段里")]
[Category("✫ DragonLost/Scene")]
public class ShowCastingWindow : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		WorldBase world = ownerEntity.GetWorld();
		if (ownerEntity.Id == world.ActorId)
		{
			world.GetSystem<ParadoxTimelineSystem>().ShowCasting();
		}
		EndAction();
	}
}
