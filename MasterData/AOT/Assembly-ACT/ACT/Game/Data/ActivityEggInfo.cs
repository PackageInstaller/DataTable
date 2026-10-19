using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ActivityEggInfo : IMessage<ActivityEggInfo>, IMessage, IEquatable<ActivityEggInfo>, IDeepCloneable<ActivityEggInfo>, IBufferMessage
{
	private static readonly MessageParser<ActivityEggInfo> _parser = new MessageParser<ActivityEggInfo>(() => new ActivityEggInfo());

	private UnknownFieldSet _unknownFields;

	public const int TypeFieldNumber = 1;

	private ActivitEggType type_;

	public const int ParamsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_params_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> params_ = new RepeatedField<int>();

	public const int IsFinishFieldNumber = 3;

	private bool isFinish_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ActivityEggInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[256];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivitEggType Type
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
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Params => params_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsFinish
	{
		get
		{
			return isFinish_;
		}
		set
		{
			isFinish_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityEggInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityEggInfo(ActivityEggInfo other)
		: this()
	{
		type_ = other.type_;
		params_ = other.params_.Clone();
		isFinish_ = other.isFinish_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ActivityEggInfo Clone()
	{
		return new ActivityEggInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityEggInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ActivityEggInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (!params_.Equals(other.params_))
		{
			return false;
		}
		if (IsFinish != other.IsFinish)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Type != ActivitEggType.EggNull)
		{
			num ^= Type.GetHashCode();
		}
		num ^= params_.GetHashCode();
		if (IsFinish)
		{
			num ^= IsFinish.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Type != ActivitEggType.EggNull)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)Type);
		}
		params_.WriteTo(ref output, _repeated_params_codec);
		if (IsFinish)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsFinish);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Type != ActivitEggType.EggNull)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Type);
		}
		num += params_.CalculateSize(_repeated_params_codec);
		if (IsFinish)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ActivityEggInfo other)
	{
		if (other != null)
		{
			if (other.Type != ActivitEggType.EggNull)
			{
				Type = other.Type;
			}
			params_.Add(other.params_);
			if (other.IsFinish)
			{
				IsFinish = other.IsFinish;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Type = (ActivitEggType)input.ReadEnum();
				break;
			case 16u:
			case 18u:
				params_.AddEntriesFrom(ref input, _repeated_params_codec);
				break;
			case 24u:
				IsFinish = input.ReadBool();
				break;
			}
		}
	}
}
