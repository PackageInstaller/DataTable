using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using UnityEngine;

[Serializable]
public class FlowScriptCategory : ScriptableObject
{
	public List<Graph> logicGraphs = new List<Graph>();

	public List<Graph> renderGraphs = new List<Graph>();
}
