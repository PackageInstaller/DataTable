using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public sealed class NpcAreaDirectoryConfig
{
	public int MapAreaID;

	public List<NpcDirectoryNode> Directories = new List<NpcDirectoryNode>();

	public List<NpcDirectoryNode> GetOrCreateDirectories()
	{
		if (Directories == null)
		{
			Directories = new List<NpcDirectoryNode>();
		}
		return Directories;
	}

	public bool HasDirectoryData()
	{
		return GetOrCreateDirectories().Count > 0;
	}

	public NpcDirectoryNode GetOrCreateDirectory(string groupPath)
	{
		GetOrCreateDirectories();
		if (string.IsNullOrEmpty(groupPath))
		{
			groupPath = "异常分组";
		}
		List<NpcDirectoryNode> orCreateDirectories = GetOrCreateDirectories();
		NpcDirectoryNode npcDirectoryNode = null;
		string[] array = groupPath.Split('/');
		foreach (string text in array)
		{
			if (!string.IsNullOrEmpty(text))
			{
				string segment = text.Trim();
				npcDirectoryNode = orCreateDirectories.Find((NpcDirectoryNode x) => x.Name == segment);
				if (npcDirectoryNode == null)
				{
					npcDirectoryNode = new NpcDirectoryNode
					{
						Name = segment
					};
					orCreateDirectories.Add(npcDirectoryNode);
				}
				orCreateDirectories = npcDirectoryNode.GetOrCreateDirectories();
			}
		}
		if (npcDirectoryNode != null)
		{
			return npcDirectoryNode;
		}
		npcDirectoryNode = GetOrCreateDirectories().Find((NpcDirectoryNode x) => x.Name == "异常分组");
		if (npcDirectoryNode != null)
		{
			return npcDirectoryNode;
		}
		npcDirectoryNode = new NpcDirectoryNode
		{
			Name = "异常分组"
		};
		GetOrCreateDirectories().Add(npcDirectoryNode);
		return npcDirectoryNode;
	}

	public bool TryGetNpcDirectoryPath(int npcConfigUid, out string groupPath)
	{
		if (GetOrCreateDirectories() != null)
		{
			foreach (NpcDirectoryNode orCreateDirectory in GetOrCreateDirectories())
			{
				if (orCreateDirectory != null && orCreateDirectory.TryGetNpcDirectoryPath(npcConfigUid, null, out groupPath))
				{
					return true;
				}
			}
		}
		groupPath = null;
		return false;
	}

	public void RemoveNpc(int npcConfigUid)
	{
		foreach (NpcDirectoryNode orCreateDirectory in GetOrCreateDirectories())
		{
			orCreateDirectory?.RemoveNpc(npcConfigUid);
		}
	}
}
