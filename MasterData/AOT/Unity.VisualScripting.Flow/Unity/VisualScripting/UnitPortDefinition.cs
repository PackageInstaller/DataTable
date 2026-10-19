namespace Unity.VisualScripting;

public abstract class UnitPortDefinition : IUnitPortDefinition
{
	[InspectorDelayed]
	[Inspectable]
	[WarnBeforeEditing("Edit Port Key", "Changing the key of this definition will break any existing connection to this port. Are you sure you want to continue?", new object[] { null, "" })]
	[Serialize]
	public string key { get; set; }

	[Serialize]
	[Inspectable]
	public string label { get; set; }

	[Inspectable]
	[InspectorTextArea]
	[Serialize]
	public string summary { get; set; }

	[Inspectable]
	[Serialize]
	public bool hideLabel { get; set; }

	[DoNotSerialize]
	public virtual bool isValid => !string.IsNullOrEmpty(key);
}
