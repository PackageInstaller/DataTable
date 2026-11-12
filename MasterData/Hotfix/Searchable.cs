public class Searchable : LogicComponent
{
	public LogicEntity entity;

	public override void OnActive()
	{
		entity = Entity;
		ModuleController<AdventureModuleController>.Instance.RegisterSearchable(this);
	}

	public override void OnDeactive()
	{
		ModuleController<AdventureModuleController>.Instance?.UnRegisterSearchable(this);
	}
}
