using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterCG : IMessage<CharacterCG>, IMessage, IEquatable<CharacterCG>, IDeepCloneable<CharacterCG>
{
	private static readonly MessageParser<CharacterCG> _parser = new MessageParser<CharacterCG>(() => new CharacterCG());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FullScreenPortraitFieldNumber = 2;

	private string fullScreenPortrait_ = "";

	public const int FullScreenL2DFieldNumber = 3;

	private string fullScreenL2D_ = "";

	public const int UnlockPlotFieldNumber = 4;

	private int unlockPlot_;

	public const int NameFieldNumber = 5;

	private string name_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharacterCG> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(162);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FullScreenPortrait
	{
		get
		{
			return fullScreenPortrait_;
		}
		set
		{
			fullScreenPortrait_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FullScreenL2D
	{
		get
		{
			return fullScreenL2D_;
		}
		set
		{
			fullScreenL2D_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int UnlockPlot
	{
		get
		{
			return unlockPlot_;
		}
		set
		{
			unlockPlot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CharacterCG()
	{
	}

	[DebuggerNonUserCode]
	public CharacterCG(CharacterCG other)
		: this()
	{
		id_ = other.id_;
		fullScreenPortrait_ = other.fullScreenPortrait_;
		fullScreenL2D_ = other.fullScreenL2D_;
		unlockPlot_ = other.unlockPlot_;
		name_ = other.name_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterCG Clone()
	{
		return new CharacterCG(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterCG);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterCG other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (FullScreenPortrait != other.FullScreenPortrait)
		{
			return false;
		}
		if (FullScreenL2D != other.FullScreenL2D)
		{
			return false;
		}
		if (UnlockPlot != other.UnlockPlot)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (FullScreenPortrait.Length != 0)
		{
			num ^= FullScreenPortrait.GetHashCode();
		}
		if (FullScreenL2D.Length != 0)
		{
			num ^= FullScreenL2D.GetHashCode();
		}
		if (UnlockPlot != 0)
		{
			num ^= UnlockPlot.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (FullScreenPortrait.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(FullScreenPortrait);
		}
		if (FullScreenL2D.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(FullScreenL2D);
		}
		if (UnlockPlot != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockPlot);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (FullScreenPortrait.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FullScreenPortrait);
		}
		if (FullScreenL2D.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FullScreenL2D);
		}
		if (UnlockPlot != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockPlot);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterCG other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FullScreenPortrait.Length != 0)
			{
				FullScreenPortrait = other.FullScreenPortrait;
			}
			if (other.FullScreenL2D.Length != 0)
			{
				FullScreenL2D = other.FullScreenL2D;
			}
			if (other.UnlockPlot != 0)
			{
				UnlockPlot = other.UnlockPlot;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 18u:
				FullScreenPortrait = input.ReadString();
				break;
			case 26u:
				FullScreenL2D = input.ReadString();
				break;
			case 32u:
				UnlockPlot = input.ReadInt32();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			}
		}
	}
}
