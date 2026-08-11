using System;
using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity;

[Serializable]
public class LineMetadata
{
	[Serializable]
	private class StringDictionary : SerializedDictionary<string, string>
	{
	}

	[SerializeField]
	private StringDictionary _lineMetadata = new StringDictionary();

	internal LineMetadata(IEnumerable<LineMetadataTableEntry> lineMetadataTableEntries)
	{
		AddMetadata(lineMetadataTableEntries);
	}

	internal void AddMetadata(IEnumerable<LineMetadataTableEntry> lineMetadataTableEntries)
	{
		foreach (LineMetadataTableEntry lineMetadataTableEntry in lineMetadataTableEntries)
		{
			if (lineMetadataTableEntry.Metadata.Length != 0)
			{
				_lineMetadata.Add(lineMetadataTableEntry.ID, string.Join(" ", lineMetadataTableEntry.Metadata));
			}
		}
	}

	public IEnumerable<string> GetLineIDs()
	{
		return _lineMetadata.Keys;
	}

	public string[] GetMetadata(string lineID)
	{
		if (_lineMetadata.TryGetValue(lineID, out var value))
		{
			return value.Split(' ');
		}
		return null;
	}
}
