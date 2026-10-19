using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.CustomAdapters.Tree;

public interface ITreeParams
{
	ITreeNodeModel TreeRootNode { get; set; }

	List<ITreeNodeModel> FlattenedVisibleHierarchy { get; set; }
}
