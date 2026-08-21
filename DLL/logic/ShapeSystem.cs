using Entitas;

public class ShapeSystem : IInitializeSystem, ISystem, IExecuteSystem, ITearDownSystem
{
	private SimContext mSimContext;

	private DynamicTree<ISimShape> mDynamicTree;

	public ShapeSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
		SimPhysics.sAABBTree = (mDynamicTree = mSimContext.sEntityAABBTree.mDynamicTree);
	}

	public void Execute()
	{
		mDynamicTree.Update();
	}

	public void TearDown()
	{
	}
}
