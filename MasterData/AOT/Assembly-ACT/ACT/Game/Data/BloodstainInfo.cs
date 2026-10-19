using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BloodstainInfo : IMessage<BloodstainInfo>, IMessage, IEquatable<BloodstainInfo>, IDeepCloneable<BloodstainInfo>, IBufferMessage
{
	private static readonly MessageParser<BloodstainInfo> _parser = new MessageParser<BloodstainInfo>(() => new BloodstainInfo());

	private UnknownFieldSet _unknownFields;

	public const int ChunkBloodstainsFieldNumber = 5;

	private static readonly MapField<int, BloodstainChunkInfo>.Codec _map_chunkBloodstains_codec = new MapField<int, BloodstainChunkInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, BloodstainChunkInfo.Parser), 42u);

	private readonly MapField<int, BloodstainChunkInfo> chunkBloodstains_ = new MapField<int, BloodstainChunkInfo>();

	public const int SelfBloodstainFieldNumber = 1;

	private Bloodstain selfBloodstain_;

	public const int OtherBloodstainsFieldNumber = 2;

	private static readonly FieldCodec<Bloodstain> _repeated_otherBloodstains_codec = FieldCodec.ForMessage(18u, Bloodstain.Parser);

	private readonly RepeatedField<Bloodstain> otherBloodstains_ = new RepeatedField<Bloodstain>();

	public const int OtherBloodstainDisabledFieldNumber = 3;

	private bool otherBloodstainDisabled_;

	public const int InteractedBloodstainIdsFieldNumber = 4;

	private static readonly FieldCodec<string> _repeated_interactedBloodstainIds_codec = FieldCodec.ForString(34u);

	private readonly RepeatedField<string> interactedBloodstainIds_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BloodstainInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[177];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, BloodstainChunkInfo> ChunkBloodstains => chunkBloodstains_;

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
	public bool OtherBloodstainDisabled
	{
		get
		{
			return otherBloodstainDisabled_;
		}
		set
		{
			otherBloodstainDisabled_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<string> InteractedBloodstainIds => interactedBloodstainIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainInfo(BloodstainInfo other)
		: this()
	{
		chunkBloodstains_ = other.chunkBloodstains_.Clone();
		selfBloodstain_ = ((other.selfBloodstain_ != null) ? other.selfBloodstain_.Clone() : null);
		otherBloodstains_ = other.otherBloodstains_.Clone();
		otherBloodstainDisabled_ = other.otherBloodstainDisabled_;
		interactedBloodstainIds_ = other.interactedBloodstainIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodstainInfo Clone()
	{
		return new BloodstainInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BloodstainInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BloodstainInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!ChunkBloodstains.Equals(other.ChunkBloodstains))
		{
			return false;
		}
		if (!object.Equals(SelfBloodstain, other.SelfBloodstain))
		{
			return false;
		}
		if (!otherBloodstains_.Equals(other.otherBloodstains_))
		{
			return false;
		}
		if (OtherBloodstainDisabled != other.OtherBloodstainDisabled)
		{
			return false;
		}
		if (!interactedBloodstainIds_.Equals(other.interactedBloodstainIds_))
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
		num ^= ChunkBloodstains.GetHashCode();
		if (selfBloodstain_ != null)
		{
			num ^= SelfBloodstain.GetHashCode();
		}
		num ^= otherBloodstains_.GetHashCode();
		if (OtherBloodstainDisabled)
		{
			num ^= OtherBloodstainDisabled.GetHashCode();
		}
		num ^= interactedBloodstainIds_.GetHashCode();
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
		if (OtherBloodstainDisabled)
		{
			output.WriteRawTag(24);
			output.WriteBool(OtherBloodstainDisabled);
		}
		interactedBloodstainIds_.WriteTo(ref output, _repeated_interactedBloodstainIds_codec);
		chunkBloodstains_.WriteTo(ref output, _map_chunkBloodstains_codec);
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
		num += chunkBloodstains_.CalculateSize(_map_chunkBloodstains_codec);
		if (selfBloodstain_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SelfBloodstain);
		}
		num += otherBloodstains_.CalculateSize(_repeated_otherBloodstains_codec);
		if (OtherBloodstainDisabled)
		{
			num += 2;
		}
		num += interactedBloodstainIds_.CalculateSize(_repeated_interactedBloodstainIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BloodstainInfo other)
	{
		if (other == null)
		{
			return;
		}
		chunkBloodstains_.Add(other.chunkBloodstains_);
		if (other.selfBloodstain_ != null)
		{
			if (selfBloodstain_ == null)
			{
				SelfBloodstain = new Bloodstain();
			}
			SelfBloodstain.MergeFrom(other.SelfBloodstain);
		}
		otherBloodstains_.Add(other.otherBloodstains_);
		if (other.OtherBloodstainDisabled)
		{
			OtherBloodstainDisabled = other.OtherBloodstainDisabled;
		}
		interactedBloodstainIds_.Add(other.interactedBloodstainIds_);
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
			case 24u:
				OtherBloodstainDisabled = input.ReadBool();
				break;
			case 34u:
				interactedBloodstainIds_.AddEntriesFrom(ref input, _repeated_interactedBloodstainIds_codec);
				break;
			case 42u:
				chunkBloodstains_.AddEntriesFrom(ref input, _map_chunkBloodstains_codec);
				break;
			}
		}
	}
}
