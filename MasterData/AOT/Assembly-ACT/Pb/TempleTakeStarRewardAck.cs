using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TempleTakeStarRewardAck : IMessage<TempleTakeStarRewardAck>, IMessage, IEquatable<TempleTakeStarRewardAck>, IDeepCloneable<TempleTakeStarRewardAck>, IBufferMessage
{
	private static readonly MessageParser<TempleTakeStarRewardAck> _parser = new MessageParser<TempleTakeStarRewardAck>(() => new TempleTakeStarRewardAck());

	private UnknownFieldSet _unknownFields;

	public const int RewardsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_rewards_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> rewards_ = new RepeatedField<Item>();

	public const int TempleAreaInfoFieldNumber = 2;

	private TempleArea templeAreaInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleTakeStarRewardAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TempleReflection.Descriptor.MessageTypes[15];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleArea TempleAreaInfo
	{
		get
		{
			return templeAreaInfo_;
		}
		set
		{
			templeAreaInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleTakeStarRewardAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleTakeStarRewardAck(TempleTakeStarRewardAck other)
		: this()
	{
		rewards_ = other.rewards_.Clone();
		templeAreaInfo_ = ((other.templeAreaInfo_ != null) ? other.templeAreaInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleTakeStarRewardAck Clone()
	{
		return new TempleTakeStarRewardAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleTakeStarRewardAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleTakeStarRewardAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!rewards_.Equals(other.rewards_))
		{
			return false;
		}
		if (!object.Equals(TempleAreaInfo, other.TempleAreaInfo))
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
		num ^= rewards_.GetHashCode();
		if (templeAreaInfo_ != null)
		{
			num ^= TempleAreaInfo.GetHashCode();
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
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
		if (templeAreaInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(TempleAreaInfo);
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
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (templeAreaInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TempleAreaInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleTakeStarRewardAck other)
	{
		if (other == null)
		{
			return;
		}
		rewards_.Add(other.rewards_);
		if (other.templeAreaInfo_ != null)
		{
			if (templeAreaInfo_ == null)
			{
				TempleAreaInfo = new TempleArea();
			}
			TempleAreaInfo.MergeFrom(other.TempleAreaInfo);
		}
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
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			case 18u:
				if (templeAreaInfo_ == null)
				{
					TempleAreaInfo = new TempleArea();
				}
				input.ReadMessage(TempleAreaInfo);
				break;
			}
		}
	}
}
