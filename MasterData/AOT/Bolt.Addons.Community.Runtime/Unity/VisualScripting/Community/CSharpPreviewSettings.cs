using UnityEngine;

namespace Unity.VisualScripting.Community;

public sealed class CSharpPreviewSettings : ScriptableObject
{
	public Color VariableColor = new Color(38f, 204f, 204f, 255f);

	public Color StringColor = new Color(204f, 136f, 51f, 255f);

	public Color NumericColor = new Color(221f, 255f, 187f, 255f);

	public Color ConstructColor = new Color(68f, 138f, 255f, 255f);

	public Color TypeColor = new Color(51f, 238f, 170f, 255f);

	public Color EnumColor = new Color(255f, 255f, 187f, 255f);

	public Color InterfaceColor = new Color(221f, 255f, 187f, 255f);

	public bool ShowSubgraphComment = true;

	public void Initalize()
	{
		VariableColor = new Color(38f, 204f, 204f, 255f);
		StringColor = new Color(204f, 136f, 51f, 255f);
		NumericColor = new Color(221f, 255f, 187f, 255f);
		ConstructColor = new Color(68f, 138f, 255f, 255f);
		TypeColor = new Color(51f, 238f, 170f, 255f);
		EnumColor = new Color(255f, 255f, 187f, 255f);
		InterfaceColor = new Color(221f, 255f, 187f, 255f);
	}
}
