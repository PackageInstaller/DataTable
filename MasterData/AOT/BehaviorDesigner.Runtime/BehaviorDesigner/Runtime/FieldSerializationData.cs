using System;
using System.Collections.Generic;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public class FieldSerializationData
{
	[SerializeField]
	public List<string> typeName = new List<string>();

	[SerializeField]
	public List<int> fieldNameHash = new List<int>();

	[SerializeField]
	public List<int> startIndex = new List<int>();

	[SerializeField]
	public List<int> dataPosition = new List<int>();

	[SerializeField]
	public List<UnityEngine.Object> unityObjects = new List<UnityEngine.Object>();

	[SerializeField]
	public List<byte> byteData = new List<byte>();

	public byte[] byteDataArray;
}
