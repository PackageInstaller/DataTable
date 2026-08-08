namespace Qworld.Runtime.SceneDither;

public class MortonTreeLeafNode
{
	private MortonLinkedSetList m_DataList;

	public MortonLinkedSetList Datas => m_DataList;

	public IMortonTreeObject Insert(IMortonTreeObject obj)
	{
		if (m_DataList == null)
		{
			m_DataList = MortonLinkedSetList.GetList();
		}
		m_DataList.AddLast(obj);
		return obj;
	}

	public bool Contains(IMortonTreeObject item)
	{
		if (m_DataList != null && m_DataList.Contains(item))
		{
			return true;
		}
		return false;
	}

	public bool Remove(IMortonTreeObject item)
	{
		m_DataList.Remove(item);
		return true;
	}
}
