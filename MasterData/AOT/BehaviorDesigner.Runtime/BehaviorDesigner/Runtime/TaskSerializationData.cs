using System;
using System.Collections.Generic;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public class TaskSerializationData
{
	[SerializeField]
	public List<string> types = new List<string>();

	[SerializeField]
	public List<int> parentIndex = new List<int>();

	[SerializeField]
	public List<int> startIndex = new List<int>();

	[SerializeField]
	public List<int> variableStartIndex = new List<int>();

	[SerializeField]
	public string JSONSerialization;

	[SerializeField]
	public FieldSerializationData fieldSerializationData = new FieldSerializationData();

	[SerializeField]
	public string Version;
}
