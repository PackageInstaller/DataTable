using UnityEngine;

namespace Unity.VisualScripting;

[IncludeInSettings(false)]
public sealed class VariablesAsset : LudiqScriptableObject
{
	[Inspectable]
	[Serialize]
	[InspectorWide(true)]
	public VariableDeclarations declarations { get; internal set; } = new VariableDeclarations();

	[ContextMenu("Show Data...")]
	protected override void ShowData()
	{
		base.ShowData();
	}
}
