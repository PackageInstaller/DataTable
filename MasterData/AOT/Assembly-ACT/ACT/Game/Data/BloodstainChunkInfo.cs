using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BloodstainChunkInfo : IMessage<BloodstainChunkInfo>, IMessage, IEquatable<BloodstainChunkInfo>, IDeepCloneable<BloodstainChunkInfo>, IBufferMessage
{
	private static readonly MessageParser<BloodstainChunkInfo> _parser = new MessageParser<BloodstainChunkInfo>(() => new BloodstainChunkInfo());

	private UnknownFieldSet _unknownFields;

	public const int SelfBloodstainFieldNumber = 1;

	private Bloodstain selfBloodstain_;

	public const int OtherBloodstainsFieldNumber = 2;

	private static readonly FieldCodec<Bloodstain> _repeated_otherBloodstains_codec = FieldCodec.ForMessage(18u, Bloodstain.Parser);

	private readonly RepeatedField<Bloodstain> otherBloodstains_ = new RepeatedField<Bloodstain>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BloodstainChunkInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[176];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Bloodstain SelfBloodstain
	{
		get
		{
			return selfBloodstain_;
		}
		set
		{
			selfBloodstain_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Bloodstain> OtherBloodstains => otherBloodstains_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainChunkInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainChunkInfo(BloodstainChunkInfo other)
		: this()
	{
		selfBloodstain_ = ((other.selfBloodstain_ != null) ? other.selfBloodstain_.Clone() : null);
		otherBloodstains_ = other.otherBloodstains_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainChunkInfo Clone()
	{
		return new BloodstainChunkInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BloodstainChunkInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BloodstainChunkInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(SelfBloodstain, other.SelfBloodstain))
		{
			return false;
		}
		if (!otherBloodstains_.Equals(other.otherBloodstains_))
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
		if (selfBloodstain_ != null)
		{
			num ^= SelfBloodstain.GetHashCode();
		}
		num ^= otherBloodstains_.GetHashCode();
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
		if (selfBloodstain_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(SelfBloodstain);
		}
		otherBloodstains_.WriteTo(ref output, _repeated_otherBloodstains_codec);
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
		if (selfBloodstain_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SelfBloodstain);
		}
		num += otherBloodstains_.CalculateSize(_repeated_otherBloodstains_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BloodstainChunkInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.selfBloodstain_ != null)
		{
			if (selfBloodstain_ == null)
			{
				SelfBloodstain = new Bloodstain();
			}
			SelfBloodstain.MergeFrom(other.SelfBloodstain);
		}
		otherBloodstains_.Add(other.otherBloodstains_);
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
				if (selfBloodstain_ == null)
				{
					SelfBloodstain = new Bloodstain();
				}
				input.ReadMessage(SelfBloodstain);
				break;
			case 18u:
				otherBloodstains_.AddEntriesFrom(ref input, _repeated_otherBloodstains_codec);
				break;
			}
		}
	}
}
