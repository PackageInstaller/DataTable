using Bamboo.ECS;

namespace ACT.DebugGUI;

public class EntityBehaveWindow : DebugGUIWindow
{
	public Entity eb;

	public override string Name { get; }

	public EntityBehaveWindow(Entity eb)
	{
		this.eb = eb;
		Name = eb.GetRoot().name;
	}

	protected override void OnUpdate()
	{
		if (eb.GetRoot() == null)
		{
			Close();
		}
		else
		{
			base.OnUpdate();
		}
	}
}
