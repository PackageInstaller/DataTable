using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class BloodStainNotify : IMessage<BloodStainNotify>, IMessage, IEquatable<BloodStainNotify>, IDeepCloneable<BloodStainNotify>, IBufferMessage
{
	private static readonly MessageParser<BloodStainNotify> _parser = new MessageParser<BloodStainNotify>(() => new BloodStainNotify());

	private UnknownFieldSet _unknownFields;

	public const int ChunkIdFieldNumber = 1;

	private int chunkId_;

	public const int BloodstainsFieldNumber = 2;

	private static readonly FieldCodec<Bloodstain> _repeated_bloodstains_codec = FieldCodec.ForMessage(18u, Bloodstain.Parser);

	private readonly RepeatedField<Bloodstain> bloodstains_ = new RepeatedField<Bloodstain>();

	public const int SelfBloodstainFieldNumber = 3;

	private Bloodstain selfBloodstain_;

	public const int OtherBloodstainDisabledFieldNumber = 4;

	private bool otherBloodstainDisabled_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BloodStainNotify> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[152];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChunkId
	{
		get
		{
			return chunkId_;
		}
		set
		{
			chunkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Bloodstain> Bloodstains => bloodstains_;

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
	public BloodStainNotify()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodStainNotify(BloodStainNotify other)
		: this()
	{
		chunkId_ = other.chunkId_;
		bloodstains_ = other.bloodstains_.Clone();
		selfBloodstain_ = ((other.selfBloodstain_ != null) ? other.selfBloodstain_.Clone() : null);
		otherBloodstainDisabled_ = other.otherBloodstainDisabled_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BloodStainNotify Clone()
	{
		return new BloodStainNotify(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BloodStainNotify);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BloodStainNotify other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ChunkId != other.ChunkId)
		{
			return false;
		}
		if (!bloodstains_.Equals(other.bloodstains_))
		{
			return false;
		}
		if (!object.Equals(SelfBloodstain, other.SelfBloodstain))
		{
			return false;
		}
		if (OtherBloodstainDisabled != other.OtherBloodstainDisabled)
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
		if (ChunkId != 0)
		{
			num ^= ChunkId.GetHashCode();
		}
		num ^= bloodstains_.GetHashCode();
		if (selfBloodstain_ != null)
		{
			num ^= SelfBloodstain.GetHashCode();
		}
		if (OtherBloodstainDisabled)
		{
			num ^= OtherBloodstainDisabled.GetHashCode();
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
		if (ChunkId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ChunkId);
		}
		bloodstains_.WriteTo(ref output, _repeated_bloodstains_codec);
		if (selfBloodstain_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(SelfBloodstain);
		}
		if (OtherBloodstainDisabled)
		{
			output.WriteRawTag(32);
			output.WriteBool(OtherBloodstainDisabled);
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
		if (ChunkId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkId);
		}
		num += bloodstains_.CalculateSize(_repeated_bloodstains_codec);
		if (selfBloodstain_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SelfBloodstain);
		}
		if (OtherBloodstainDisabled)
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
	public void MergeFrom(BloodStainNotify other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ChunkId != 0)
		{
			ChunkId = other.ChunkId;
		}
		bloodstains_.Add(other.bloodstains_);
		if (other.selfBloodstain_ != null)
		{
			if (selfBloodstain_ == null)
			{
				SelfBloodstain = new Bloodstain();
			}
			SelfBloodstain.MergeFrom(other.SelfBloodstain);
		}
		if (other.OtherBloodstainDisabled)
		{
			OtherBloodstainDisabled = other.OtherBloodstainDisabled;
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
			case 8u:
				ChunkId = input.ReadInt32();
				break;
			case 18u:
				bloodstains_.AddEntriesFrom(ref input, _repeated_bloodstains_codec);
				break;
			case 26u:
				if (selfBloodstain_ == null)
				{
					SelfBloodstain = new Bloodstain();
				}
				input.ReadMessage(SelfBloodstain);
				break;
			case 32u:
				OtherBloodstainDisabled = input.ReadBool();
				break;
			}
		}
	}
}
