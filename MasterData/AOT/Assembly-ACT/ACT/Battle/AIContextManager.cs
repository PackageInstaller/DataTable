using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public class AIContextManager
{
	private Dictionary<int, List<BattleInteractableObject>> m_Contexts = new Dictionary<int, List<BattleInteractableObject>>();

	public void Register(BattleInteractableObject aiContext)
	{
		int[] contextTypes = aiContext.contextTypes;
		foreach (int key in contextTypes)
		{
			if (!m_Contexts.ContainsKey(key))
			{
				m_Contexts[key] = new List<BattleInteractableObject>();
			}
			m_Contexts[key].Add(aiContext);
		}
	}

	public void UnRegister(BattleInteractableObject aiContext)
	{
		int[] contextTypes = aiContext.contextTypes;
		foreach (int key in contextTypes)
		{
			if (m_Contexts.ContainsKey(key))
			{
				m_Contexts[key].Remove(aiContext);
			}
		}
	}

	public BattleInteractableObject FindClosedContext(int typeIndex, Vector3 position)
	{
		if (m_Contexts.TryGetValue(typeIndex, out var value) && value.Count > 0)
		{
			value.Sort((BattleInteractableObject x, BattleInteractableObject y) => (Vector3.Magnitude(x.transform.position - position) > Vector3.Magnitude(y.transform.position - position)) ? 1 : 0);
			return value[0];
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("场景中找不到 " + GameLoader.meta.configContextTypes.contextTypes[typeIndex] + " context");
		}
		return null;
	}

	public bool FindCloseContextsNonAlloc(int typeIndex, Vector3 position, List<BattleInteractableObject> orderedResults)
	{
		if (m_Contexts.TryGetValue(typeIndex, out var value) && value.Count > 0)
		{
			m_Contexts[typeIndex].Sort((BattleInteractableObject x, BattleInteractableObject y) => (Vector3.Magnitude(x.transform.position - position) > Vector3.Magnitude(y.transform.position - position)) ? 1 : 0);
			orderedResults.AddRange(m_Contexts[typeIndex]);
			return true;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("场景中找不到 " + GameLoader.meta.configContextTypes.contextTypes[typeIndex] + " context");
		}
		return false;
	}

	public BattleInteractableObject FindContext(int typeIndex)
	{
		if (m_Contexts.TryGetValue(typeIndex, out var value) && value.Count > 0)
		{
			return m_Contexts[typeIndex][0];
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("场景中找不到 " + GameLoader.meta.configContextTypes.contextTypes[typeIndex] + " context");
		}
		return null;
	}

	public void Reset()
	{
	}
}
