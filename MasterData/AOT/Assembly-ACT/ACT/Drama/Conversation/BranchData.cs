using System;
using Sirenix.Serialization;

namespace ACT.Drama.Conversation;

[Serializable]
public class BranchData
{
	[OdinSerialize]
	public DramaCondition conditions;

	public int content;
}
