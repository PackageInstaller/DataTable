using Bamboo.ECS;

namespace ACT.DebugGUI;

public class EntityHitAndAbilityBoxWindow : DebugGUIWindow
{
	public Entity eb;

	public EntityHitAndAbilityBoxWindow(Entity eb)
	{
		this.eb = eb;
	}

	protected override void OnUpdate()
	{
		if (eb.GetRoot() == null)
		{
			DebugWindowManager.instance.RemoveEntityHitBoxAbWindow(eb);
		}
		else
		{
			base.OnUpdate();
		}
	}
}
