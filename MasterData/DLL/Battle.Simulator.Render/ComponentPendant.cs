using System;
using System.Collections.Generic;
using UnityEngine;

public class ComponentPendant : CMonoBehaviour
{
	private BBHumanoid _blackboard;

	private List<IPendant> _pendants = new List<IPendant>(4);

	public override void Initialize()
	{
		base.Initialize();
		_blackboard = mAgent.Blackboard as BBHumanoid;
		if (null != _blackboard)
		{
			BBHumanoid blackboard = _blackboard;
			blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(OnActionHandler));
		}
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		List<IPendant>.Enumerator enumerator = _pendants.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Finish();
		}
		_pendants.Clear();
	}

	private void OnActionHandler(AgentAction agentAction)
	{
		List<IPendant>.Enumerator enumerator = _pendants.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.ActionHandler(agentAction);
		}
	}

	public GameObject CreatePendant<T>(string path) where T : MonoBehaviour, IPendant
	{
		GameObject obj = Asset.Instantiate(path);
		T component = obj.GetComponent<T>();
		if (null != component)
		{
			component.Initialize(mAgent);
			_pendants.Add(component);
			return obj;
		}
		Debug.LogError("Can't Find Pendant From " + path);
		return obj;
	}

	public List<IPendant> GetPendants()
	{
		return _pendants;
	}

	public void AddPendant(IPendant pendant)
	{
		if (!_pendants.Contains(pendant))
		{
			_pendants.Add(pendant);
		}
	}
}
