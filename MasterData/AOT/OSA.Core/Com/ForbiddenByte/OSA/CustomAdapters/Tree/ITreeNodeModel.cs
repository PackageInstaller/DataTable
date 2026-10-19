using System;
using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.CustomAdapters.Tree;

public interface ITreeNodeModel
{
	Type CachedType { get; }

	ITreeNodeModel Parent { get; set; }

	List<ITreeNodeModel> Children { get; set; }

	int Depth { get; set; }

	bool Expanded { get; set; }

	bool IsDirectory()
	{
		List<ITreeNodeModel> children = Children;
		if (children != null)
		{
			return children.Count > 0;
		}
		return false;
	}
}
