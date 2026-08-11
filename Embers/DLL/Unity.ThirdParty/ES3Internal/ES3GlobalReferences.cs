using UnityEngine;

namespace ES3Internal;

public class ES3GlobalReferences : ScriptableObject
{
	public static ES3GlobalReferences Instance => null;

	public Object Get(long id)
	{
		return null;
	}

	public long GetOrAdd(Object obj)
	{
		return -1L;
	}

	public void RemoveInvalidKeys()
	{
	}
}
