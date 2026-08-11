namespace System.Collections;

[Serializable]
public abstract class ReadOnlyCollectionBase : ICollection, IEnumerable
{
	private ArrayList _list;

	protected ArrayList InnerList
	{
		get
		{
			if (_list == null)
			{
				_list = new ArrayList();
			}
			return _list;
		}
	}

	public virtual int Count => InnerList.Count;

	bool ICollection.IsSynchronized => InnerList.IsSynchronized;

	object ICollection.SyncRoot => InnerList.SyncRoot;

	void ICollection.CopyTo(Array array, int index)
	{
		InnerList.CopyTo(array, index);
	}

	public virtual IEnumerator GetEnumerator()
	{
		return InnerList.GetEnumerator();
	}
}
