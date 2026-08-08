using Entitas;

[Sim]
public class EntityActionTransfiguration : IComponent, IComponentReset
{
	public int mRoleID;

	public int mAppearID;

	public void Reset(Entity entity)
	{
		mRoleID = 0;
		mAppearID = 0;
	}
}
