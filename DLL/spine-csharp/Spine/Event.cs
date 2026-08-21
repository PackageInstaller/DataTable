using System;

namespace Spine;

public class Event
{
	internal readonly EventData data;

	internal readonly float time;

	internal int intValue;

	internal float floatValue;

	internal string stringValue;

	internal float volume;

	internal float balance;

	public EventData Data => data;

	public float Time => time;

	public int Int
	{
		get
		{
			return intValue;
		}
		set
		{
			intValue = value;
		}
	}

	public float Float
	{
		get
		{
			return floatValue;
		}
		set
		{
			floatValue = value;
		}
	}

	public string String
	{
		get
		{
			return stringValue;
		}
		set
		{
			stringValue = value;
		}
	}

	public float Volume
	{
		get
		{
			return volume;
		}
		set
		{
			volume = value;
		}
	}

	public float Balance
	{
		get
		{
			return balance;
		}
		set
		{
			balance = value;
		}
	}

	public Event(float time, EventData data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data", "data cannot be null.");
		}
		this.time = time;
		this.data = data;
	}

	public override string ToString()
	{
		return data.Name;
	}
}
