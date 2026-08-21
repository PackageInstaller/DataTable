using System;

namespace Spine;

public class EventData
{
	internal string name;

	public string Name => name;

	public int Int { get; set; }

	public float Float { get; set; }

	public string String { get; set; }

	public string AudioPath { get; set; }

	public float Volume { get; set; }

	public float Balance { get; set; }

	public EventData(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null.");
		}
		this.name = name;
	}

	public override string ToString()
	{
		return Name;
	}
}
