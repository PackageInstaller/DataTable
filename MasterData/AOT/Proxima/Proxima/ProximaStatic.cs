using System;
using System.Collections.Generic;
using UnityEngine;

namespace Proxima;

public class ProximaStatic : ScriptableObject
{
	[Serializable]
	public struct StaticFile
	{
		public string Path;

		public byte[] Bytes;

		public long LastModified;
	}

	public List<StaticFile> Files;
}
