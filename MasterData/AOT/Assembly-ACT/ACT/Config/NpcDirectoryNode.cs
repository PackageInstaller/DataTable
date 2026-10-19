using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public sealed class NpcDirectoryNode
{
	public const string DefaultGroupName = "异常分组";

	[HideInInspector]
	public int DirectoryId;

	public string Name = "异常分组";

	public List<NpcDirectoryNode> Directories = new List<NpcDirectoryNode>();

	public List<int> NpcConfigUids = new List<int>();

	public List<NpcDirectoryNode> GetOrCreateDirectories()
	{
		if (Directories == null)
		{
			Directories = new List<NpcDirectoryNode>();
		}
		return Directories;
	}

	public List<int> GetOrCreateNpcConfigUids()
	{
		if (NpcConfigUids == null)
		{
			NpcConfigUids = new List<int>();
		}
		return NpcConfigUids;
	}

	public bool HasDirectoryData()
	{
		return true;
	}

	public void AddNpc(int npcConfigUid)
	{
		List<int> orCreateNpcConfigUids = GetOrCreateNpcConfigUids();
		if (!orCreateNpcConfigUids.Contains(npcConfigUid))
		{
			orCreateNpcConfigUids.Add(npcConfigUid);
		}
	}

	public bool TryGetNpcDirectoryPath(int npcConfigUid, string parentPath, out string groupPath)
	{
		string text = (string.IsNullOrEmpty(parentPath) ? Name : (parentPath + "/" + Name));
		if (GetOrCreateNpcConfigUids().Contains(npcConfigUid))
		{
			groupPath = text;
			return true;
		}
		foreach (NpcDirectoryNode orCreateDirectory in GetOrCreateDirectories())
		{
			if (orCreateDirectory != null && orCreateDirectory.TryGetNpcDirectoryPath(npcConfigUid, text, out groupPath))
			{
				return true;
			}
		}
		groupPath = null;
		return false;
	}

	public void RemoveNpc(int npcConfigUid)
	{
		GetOrCreateNpcConfigUids().RemoveAll((int x) => x == npcConfigUid);
		foreach (NpcDirectoryNode orCreateDirectory in GetOrCreateDirectories())
		{
			orCreateDirectory?.RemoveNpc(npcConfigUid);
		}
	}
}
