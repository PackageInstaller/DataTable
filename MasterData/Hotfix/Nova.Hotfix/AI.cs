using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AI : IMessage<AI>, IMessage, IEquatable<AI>, IDeepCloneable<AI>
{
	private static readonly MessageParser<AI> _parser = new MessageParser<AI>(() => new AI());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FCSpawnFieldNumber = 2;

	private string fCSpawn_ = "";

	public const int FCIdleFieldNumber = 3;

	private string fCIdle_ = "";

	public const int FCActionFieldNumber = 4;

	private string fCAction_ = "";

	public const int FCLostControlFieldNumber = 5;

	private string fCLostControl_ = "";

	public const int FCDeathFieldNumber = 6;

	private string fCDeath_ = "";

	public const int FCGlobalFieldNumber = 7;

	private string fCGlobal_ = "";

	public const int FCComboGroupFieldNumber = 8;

	private string fCComboGroup_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<AI> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(92);

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
	public string FCSpawn
	{
		get
		{
			return fCSpawn_;
		}
		set
		{
			fCSpawn_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCIdle
	{
		get
		{
			return fCIdle_;
		}
		set
		{
			fCIdle_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCAction
	{
		get
		{
			return fCAction_;
		}
		set
		{
			fCAction_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCLostControl
	{
		get
		{
			return fCLostControl_;
		}
		set
		{
			fCLostControl_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCDeath
	{
		get
		{
			return fCDeath_;
		}
		set
		{
			fCDeath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCGlobal
	{
		get
		{
			return fCGlobal_;
		}
		set
		{
			fCGlobal_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FCComboGroup
	{
		get
		{
			return fCComboGroup_;
		}
		set
		{
			fCComboGroup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public AI()
	{
	}

	[DebuggerNonUserCode]
	public AI(AI other)
		: this()
	{
		id_ = other.id_;
		fCSpawn_ = other.fCSpawn_;
		fCIdle_ = other.fCIdle_;
		fCAction_ = other.fCAction_;
		fCLostControl_ = other.fCLostControl_;
		fCDeath_ = other.fCDeath_;
		fCGlobal_ = other.fCGlobal_;
		fCComboGroup_ = other.fCComboGroup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AI Clone()
	{
		return new AI(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AI);
	}

	[DebuggerNonUserCode]
	public bool Equals(AI other)
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
		if (FCSpawn != other.FCSpawn)
		{
			return false;
		}
		if (FCIdle != other.FCIdle)
		{
			return false;
		}
		if (FCAction != other.FCAction)
		{
			return false;
		}
		if (FCLostControl != other.FCLostControl)
		{
			return false;
		}
		if (FCDeath != other.FCDeath)
		{
			return false;
		}
		if (FCGlobal != other.FCGlobal)
		{
			return false;
		}
		if (FCComboGroup != other.FCComboGroup)
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
		if (FCSpawn.Length != 0)
		{
			num ^= FCSpawn.GetHashCode();
		}
		if (FCIdle.Length != 0)
		{
			num ^= FCIdle.GetHashCode();
		}
		if (FCAction.Length != 0)
		{
			num ^= FCAction.GetHashCode();
		}
		if (FCLostControl.Length != 0)
		{
			num ^= FCLostControl.GetHashCode();
		}
		if (FCDeath.Length != 0)
		{
			num ^= FCDeath.GetHashCode();
		}
		if (FCGlobal.Length != 0)
		{
			num ^= FCGlobal.GetHashCode();
		}
		if (FCComboGroup.Length != 0)
		{
			num ^= FCComboGroup.GetHashCode();
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
		if (FCSpawn.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(FCSpawn);
		}
		if (FCIdle.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(FCIdle);
		}
		if (FCAction.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(FCAction);
		}
		if (FCLostControl.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(FCLostControl);
		}
		if (FCDeath.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(FCDeath);
		}
		if (FCGlobal.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(FCGlobal);
		}
		if (FCComboGroup.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(FCComboGroup);
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
		if (FCSpawn.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCSpawn);
		}
		if (FCIdle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCIdle);
		}
		if (FCAction.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCAction);
		}
		if (FCLostControl.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCLostControl);
		}
		if (FCDeath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCDeath);
		}
		if (FCGlobal.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCGlobal);
		}
		if (FCComboGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCComboGroup);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AI other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FCSpawn.Length != 0)
			{
				FCSpawn = other.FCSpawn;
			}
			if (other.FCIdle.Length != 0)
			{
				FCIdle = other.FCIdle;
			}
			if (other.FCAction.Length != 0)
			{
				FCAction = other.FCAction;
			}
			if (other.FCLostControl.Length != 0)
			{
				FCLostControl = other.FCLostControl;
			}
			if (other.FCDeath.Length != 0)
			{
				FCDeath = other.FCDeath;
			}
			if (other.FCGlobal.Length != 0)
			{
				FCGlobal = other.FCGlobal;
			}
			if (other.FCComboGroup.Length != 0)
			{
				FCComboGroup = other.FCComboGroup;
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
				FCSpawn = input.ReadString();
				break;
			case 26u:
				FCIdle = input.ReadString();
				break;
			case 34u:
				FCAction = input.ReadString();
				break;
			case 42u:
				FCLostControl = input.ReadString();
				break;
			case 50u:
				FCDeath = input.ReadString();
				break;
			case 58u:
				FCGlobal = input.ReadString();
				break;
			case 66u:
				FCComboGroup = input.ReadString();
				break;
			}
		}
	}
}
