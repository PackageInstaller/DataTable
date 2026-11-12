using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerMsg : IMessage<InfinityTowerMsg>, IMessage, IEquatable<InfinityTowerMsg>, IDeepCloneable<InfinityTowerMsg>
{
	private static readonly MessageParser<InfinityTowerMsg> _parser = new MessageParser<InfinityTowerMsg>(() => new InfinityTowerMsg());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int ContentFieldNumber = 3;

	private string content_ = "";

	public const int TypeFieldNumber = 4;

	private int type_;

	public const int DayOfWeekFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_dayOfWeek_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> dayOfWeek_ = new RepeatedField<int>();

	public const int ConditionFieldNumber = 6;

	private int condition_;

	public const int ParamsFieldNumber = 7;

	private string params_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerMsg> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(460);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DayOfWeek => dayOfWeek_;

	[DebuggerNonUserCode]
	public int Condition
	{
		get
		{
			return condition_;
		}
		set
		{
			condition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Params
	{
		get
		{
			return params_;
		}
		set
		{
			params_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public InfinityTowerMsg()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerMsg(InfinityTowerMsg other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		content_ = other.content_;
		type_ = other.type_;
		dayOfWeek_ = other.dayOfWeek_.Clone();
		condition_ = other.condition_;
		params_ = other.params_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerMsg Clone()
	{
		return new InfinityTowerMsg(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerMsg);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerMsg other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Content != other.Content)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (!dayOfWeek_.Equals(other.dayOfWeek_))
		{
			return false;
		}
		if (Condition != other.Condition)
		{
			return false;
		}
		if (Params != other.Params)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		num ^= dayOfWeek_.GetHashCode();
		if (Condition != 0)
		{
			num ^= Condition.GetHashCode();
		}
		if (Params.Length != 0)
		{
			num ^= Params.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Content.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Content);
		}
		if (Type != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type);
		}
		dayOfWeek_.WriteTo(output, _repeated_dayOfWeek_codec);
		if (Condition != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Condition);
		}
		if (Params.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Params);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		num += dayOfWeek_.CalculateSize(_repeated_dayOfWeek_codec);
		if (Condition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Condition);
		}
		if (Params.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Params);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerMsg other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			dayOfWeek_.Add(other.dayOfWeek_);
			if (other.Condition != 0)
			{
				Condition = other.Condition;
			}
			if (other.Params.Length != 0)
			{
				Params = other.Params;
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
				Title = input.ReadString();
				break;
			case 26u:
				Content = input.ReadString();
				break;
			case 32u:
				Type = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				dayOfWeek_.AddEntriesFrom(input, _repeated_dayOfWeek_codec);
				break;
			case 48u:
				Condition = input.ReadInt32();
				break;
			case 58u:
				Params = input.ReadString();
				break;
			}
		}
	}
}
