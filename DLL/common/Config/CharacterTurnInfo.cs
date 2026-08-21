using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CharacterTurnInfo : IMessage<CharacterTurnInfo>, IMessage, IEquatable<CharacterTurnInfo>, IDeepCloneable<CharacterTurnInfo>
{
	private static readonly MessageParser<CharacterTurnInfo> _parser = new MessageParser<CharacterTurnInfo>(() => new CharacterTurnInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int RotationSpeedFieldNumber = 4;

	private int rotationSpeed_;

	public const int StopOnFaceFieldNumber = 5;

	private bool stopOnFace_;

	public const int TurnDirectionFieldNumber = 6;

	private int turnDirection_;

	[DebuggerNonUserCode]
	public static MessageParser<CharacterTurnInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[22];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Start
	{
		get
		{
			return start_;
		}
		set
		{
			start_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotationSpeed
	{
		get
		{
			return rotationSpeed_;
		}
		set
		{
			rotationSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool StopOnFace
	{
		get
		{
			return stopOnFace_;
		}
		set
		{
			stopOnFace_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TurnDirection
	{
		get
		{
			return turnDirection_;
		}
		set
		{
			turnDirection_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharacterTurnInfo()
	{
	}

	[DebuggerNonUserCode]
	public CharacterTurnInfo(CharacterTurnInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		rotationSpeed_ = other.rotationSpeed_;
		stopOnFace_ = other.stopOnFace_;
		turnDirection_ = other.turnDirection_;
	}

	[DebuggerNonUserCode]
	public CharacterTurnInfo Clone()
	{
		return new CharacterTurnInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterTurnInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterTurnInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Start != other.Start)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (RotationSpeed != other.RotationSpeed)
		{
			return false;
		}
		if (StopOnFace != other.StopOnFace)
		{
			return false;
		}
		if (TurnDirection != other.TurnDirection)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (RotationSpeed != 0)
		{
			num ^= RotationSpeed.GetHashCode();
		}
		if (StopOnFace)
		{
			num ^= StopOnFace.GetHashCode();
		}
		if (TurnDirection != 0)
		{
			num ^= TurnDirection.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Start != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Start);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Duration);
		}
		if (RotationSpeed != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RotationSpeed);
		}
		if (StopOnFace)
		{
			output.WriteRawTag(40);
			output.WriteBool(StopOnFace);
		}
		if (TurnDirection != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TurnDirection);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (RotationSpeed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RotationSpeed);
		}
		if (StopOnFace)
		{
			num += 2;
		}
		if (TurnDirection != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TurnDirection);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterTurnInfo other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Start != 0)
			{
				Start = other.Start;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.RotationSpeed != 0)
			{
				RotationSpeed = other.RotationSpeed;
			}
			if (other.StopOnFace)
			{
				StopOnFace = other.StopOnFace;
			}
			if (other.TurnDirection != 0)
			{
				TurnDirection = other.TurnDirection;
			}
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				Start = input.ReadInt32();
				break;
			case 24u:
				Duration = input.ReadInt32();
				break;
			case 32u:
				RotationSpeed = input.ReadInt32();
				break;
			case 40u:
				StopOnFace = input.ReadBool();
				break;
			case 48u:
				TurnDirection = input.ReadInt32();
				break;
			}
		}
	}
}
