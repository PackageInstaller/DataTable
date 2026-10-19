using System.Collections.Generic;

namespace ACT.UI;

public class CustomUISchemeModifyWrapper
{
	public int SchemeId { get; }

	public string Name { get; }

	public float EdgeOffset { get; }

	public List<CustomUICompModify> Modifications { get; }

	public CustomUISchemeModifyWrapper(int schemeId, string name, float edgeOffset, List<CustomUICompModify> modifications)
	{
		SchemeId = schemeId;
		Name = name;
		EdgeOffset = edgeOffset;
		Modifications = modifications;
	}
}
