namespace Unity.VisualScripting;

[SpecialUnit]
[UnitTitle("Node script is missing!")]
[UnitShortTitle("Missing Script!")]
public sealed class MissingType : Unit
{
	[Serialize]
	public string formerType { get; private set; }

	[Serialize]
	public string formerValue { get; private set; }

	protected override void Definition()
	{
	}
}
