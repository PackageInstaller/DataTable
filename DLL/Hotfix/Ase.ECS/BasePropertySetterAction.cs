namespace Ase.ECS;

public class BasePropertySetterAction : BasePropertyAction
{
	protected override void OnExecute()
	{
		base.OnExecute();
		if (!targetEntity.HasProperty(propertyKey.value))
		{
			EndAction(success: false);
		}
	}
}
