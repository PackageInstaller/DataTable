using Entitas;

public static class ContextsExtensions
{
	public static SimEntity GetEntityWithEntityID(this SimContext context, int mID)
	{
		return ((PrimaryEntityIndex<SimEntity, int>)context.GetEntityIndex("EntityID")).GetEntity(mID);
	}
}
