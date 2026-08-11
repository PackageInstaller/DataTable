using System.Collections.Generic;
using UnityEngine;

public class UnityObjectType : MonoBehaviour
{
	public List<Object> objs;

	private void Start()
	{
		if (!ES3.KeyExists("this"))
		{
			ES3.Save("this", this);
		}
		else
		{
			ES3.LoadInto("this", this);
		}
		foreach (Object obj in objs)
		{
			Debug.Log(obj);
		}
	}
}
