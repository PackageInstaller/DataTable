using System;
using System.Collections.Generic;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public class VariableSerializationData
{
	[SerializeField]
	public List<int> variableStartIndex = new List<int>();

	[SerializeField]
	public string JSONSerialization = "";

	[SerializeField]
	public FieldSerializationData fieldSerializationData = new FieldSerializationData();
}
