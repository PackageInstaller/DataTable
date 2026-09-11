using System.Collections.Generic;
using UnityEngine;

public class VariableTickMgr : MonoBehaviour
{
	private List<IVariableTickable> tickList;

	private List<VariableTickData> tickData;

	public void Add(IVariableTickable tickable)
	{
		tickList.Add(tickable);
	}

	public void Remove(IVariableTickable tickable)
	{
		tickList.Remove(tickable);
	}

	private void Start()
	{
	}

	private void Update()
	{
	}
}
