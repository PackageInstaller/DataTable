using System;

public struct CommanderID(int id) : IEquatable<CommanderID>
{
	public static readonly CommanderID None;

	public static readonly CommanderID DefaultLocalCommander;

	public readonly int ID = id;

	public override bool Equals(object obj)
	{
		if (obj is CommanderID)
		{
			return ID == ((CommanderID)obj).ID;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return ID;
	}

	public static bool operator ==(CommanderID a, CommanderID b)
	{
		return a.ID == b.ID;
	}

	public static bool operator !=(CommanderID a, CommanderID b)
	{
		return a.ID != b.ID;
	}

	public override string ToString()
	{
		int iD = ID;
		return iD.ToString();
	}

	bool IEquatable<CommanderID>.Equals(CommanderID other)
	{
		return ID == other.ID;
	}

	static CommanderID()
	{
		None = new CommanderID(0);
		DefaultLocalCommander = new CommanderID(1);
	}
}
