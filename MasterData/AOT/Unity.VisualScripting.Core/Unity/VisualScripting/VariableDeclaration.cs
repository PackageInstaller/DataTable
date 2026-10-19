using System;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
public sealed class VariableDeclaration
{
	[Serialize]
	public string name { get; private set; }

	[Value]
	[Serialize]
	public object value { get; set; }

	[Serialize]
	public SerializableType typeHandle { get; set; }

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public VariableDeclaration()
	{
	}

	public VariableDeclaration(string name, object value)
	{
		this.name = name;
		this.value = value;
	}
}
