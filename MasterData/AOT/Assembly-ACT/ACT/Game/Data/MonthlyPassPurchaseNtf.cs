using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MonthlyPassPurchaseNtf : IMessage<MonthlyPassPurchaseNtf>, IMessage, IEquatable<MonthlyPassPurchaseNtf>, IDeepCloneable<MonthlyPassPurchaseNtf>, IBufferMessage
{
	private static readonly MessageParser<MonthlyPassPurchaseNtf> _parser = new MessageParser<MonthlyPassPurchaseNtf>(() => new MonthlyPassPurchaseNtf());

	private UnknownFieldSet _unknownFields;

	public const int PassFieldNumber = 1;

	private MonthlyPassEntry pass_;

	public const int ExtraItemsFieldNumber = 2;

	private static readonly FieldCodec<UniversalItem> _repeated_extraItems_codec = FieldCodec.ForMessage(18u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> extraItems_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MonthlyPassPurchaseNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassEntry Pass
	{
		get
		{
			return pass_;
		}
		set
		{
			pass_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> ExtraItems => extraItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassPurchaseNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassPurchaseNtf(MonthlyPassPurchaseNtf other)
		: this()
	{
		pass_ = ((other.pass_ != null) ? other.pass_.Clone() : null);
		extraItems_ = other.extraItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassPurchaseNtf Clone()
	{
		return new MonthlyPassPurchaseNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MonthlyPassPurchaseNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MonthlyPassPurchaseNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Pass, other.Pass))
		{
			return false;
		}
		if (!extraItems_.Equals(other.extraItems_))
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
		if (pass_ != null)
		{
			num ^= Pass.GetHashCode();
		}
		num ^= extraItems_.GetHashCode();
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
		if (pass_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Pass);
		}
		extraItems_.WriteTo(ref output, _repeated_extraItems_codec);
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
		if (pass_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Pass);
		}
		num += extraItems_.CalculateSize(_repeated_extraItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MonthlyPassPurchaseNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.pass_ != null)
		{
			if (pass_ == null)
			{
				Pass = new MonthlyPassEntry();
			}
			Pass.MergeFrom(other.Pass);
		}
		extraItems_.Add(other.extraItems_);
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			case 10u:
				if (pass_ == null)
				{
					Pass = new MonthlyPassEntry();
				}
				input.ReadMessage(Pass);
				break;
			case 18u:
				extraItems_.AddEntriesFrom(ref input, _repeated_extraItems_codec);
				break;
			}
		}
	}
}
