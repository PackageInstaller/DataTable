using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoEntityData : IMessage<ProtoEntityData>, IMessage, IEquatable<ProtoEntityData>, IDeepCloneable<ProtoEntityData>
{
	private static readonly MessageParser<ProtoEntityData> _parser = new MessageParser<ProtoEntityData>(() => new ProtoEntityData());

	public const int NameFieldNumber = 1;

	private string name_ = "";

	public const int IdFieldNumber = 2;

	private int id_;

	public const int BlackboardFieldNumber = 3;

	private ProtoBlackboardSource blackboard_;

	public const int TypeFieldNumber = 4;

	private static readonly FieldCodec<string> _repeated_type_codec = FieldCodec.ForString(34u);

	private readonly RepeatedField<string> type_ = new RepeatedField<string>();

	public const int IsEnableFieldNumber = 5;

	private bool isEnable_;

	[DebuggerNonUserCode]
	public static MessageParser<ProtoEntityData> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[11];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public ProtoBlackboardSource Blackboard
	{
		get
		{
			return blackboard_;
		}
		set
		{
			blackboard_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> Type => type_;

	[DebuggerNonUserCode]
	public bool IsEnable
	{
		get
		{
			return isEnable_;
		}
		set
		{
			isEnable_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ProtoEntityData()
	{
	}

	[DebuggerNonUserCode]
	public ProtoEntityData(ProtoEntityData other)
		: this()
	{
		name_ = other.name_;
		id_ = other.id_;
		Blackboard = ((other.blackboard_ != null) ? other.Blackboard.Clone() : null);
		type_ = other.type_.Clone();
		isEnable_ = other.isEnable_;
	}

	[DebuggerNonUserCode]
	public ProtoEntityData Clone()
	{
		return new ProtoEntityData(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoEntityData);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoEntityData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!object.Equals(Blackboard, other.Blackboard))
		{
			return false;
		}
		if (!type_.Equals(other.type_))
		{
			return false;
		}
		if (IsEnable != other.IsEnable)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (blackboard_ != null)
		{
			num ^= Blackboard.GetHashCode();
		}
		num ^= type_.GetHashCode();
		if (IsEnable)
		{
			num ^= IsEnable.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		if (Id != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Id);
		}
		if (blackboard_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Blackboard);
		}
		type_.WriteTo(output, _repeated_type_codec);
		if (IsEnable)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsEnable);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (blackboard_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Blackboard);
		}
		num += type_.CalculateSize(_repeated_type_codec);
		if (IsEnable)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoEntityData other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Name.Length != 0)
		{
			Name = other.Name;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.blackboard_ != null)
		{
			if (blackboard_ == null)
			{
				blackboard_ = new ProtoBlackboardSource();
			}
			Blackboard.MergeFrom(other.Blackboard);
		}
		type_.Add(other.type_);
		if (other.IsEnable)
		{
			IsEnable = other.IsEnable;
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
			case 10u:
				Name = input.ReadString();
				break;
			case 16u:
				Id = input.ReadInt32();
				break;
			case 26u:
				if (blackboard_ == null)
				{
					blackboard_ = new ProtoBlackboardSource();
				}
				input.ReadMessage(blackboard_);
				break;
			case 34u:
				type_.AddEntriesFrom(input, _repeated_type_codec);
				break;
			case 40u:
				IsEnable = input.ReadBool();
				break;
			}
		}
	}
}
