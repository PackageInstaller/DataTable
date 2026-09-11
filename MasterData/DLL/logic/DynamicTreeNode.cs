public class DynamicTreeNode<T> where T : ISimShape
{
	public ABOX AABB;

	public VFactor MinorRandomExtension;

	public int Child1;

	public int Child2;

	public int LeafCount;

	public int ParentOrNext;

	public T UserData;

	internal bool childrenCrossed;

	public bool IsLeaf()
	{
		return Child1 == -1;
	}
}
