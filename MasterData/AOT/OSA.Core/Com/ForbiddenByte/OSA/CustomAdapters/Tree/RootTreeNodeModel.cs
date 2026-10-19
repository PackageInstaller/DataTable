using System;
using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.CustomAdapters.Tree;

public class RootTreeNodeModel : ITreeNodeModel
{
	public Type CachedType { get; }

	public ITreeNodeModel Parent { get; set; }

	public List<ITreeNodeModel> Children { get; set; }

	public int Depth { get; set; }

	public bool Expanded { get; set; }

	public RootTreeNodeModel()
	{
		CachedType = typeof(RootTreeNodeModel);
		Parent = null;
		Children = new List<ITreeNodeModel>();
		Depth = 0;
		Expanded = false;
	}
}
