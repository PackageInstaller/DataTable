using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public sealed class SerializationPair
{
	public string _json;

	public GraphByteData graphByteData;

	public List<UnityEngine.Object> _references;

	public SerializationPair()
	{
		_references = new List<UnityEngine.Object>();
		graphByteData = new GraphByteData();
	}
}
