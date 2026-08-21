using System.Collections.Generic;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class BattleMsg : IReference
{
	private Dictionary<string, object> msgData;

	public void OnInit()
	{
		if (msgData == null)
		{
			msgData = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		}
	}

	public void AddMsgData(string key, object value)
	{
		msgData.Add(key, value);
	}

	public Dictionary<string, object> GenerateData()
	{
		return msgData;
	}

	public void Clear()
	{
		if (msgData != null)
		{
			CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(msgData);
			msgData = null;
		}
	}
}
