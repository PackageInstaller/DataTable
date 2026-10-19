using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssNtf : IMessage<AbyssNtf>, IMessage, IEquatable<AbyssNtf>, IDeepCloneable<AbyssNtf>, IBufferMessage
{
	private static readonly MessageParser<AbyssNtf> _parser = new MessageParser<AbyssNtf>(() => new AbyssNtf());

	private UnknownFieldSet _unknownFields;

	public const int AbyssFieldNumber = 1;

	private Abyss abyss_;

	public const int AbyssesFieldNumber = 2;

	private static readonly MapField<int, Abyss>.Codec _map_abysses_codec = new MapField<int, Abyss>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Abyss.Parser), 18u);

	private readonly MapField<int, Abyss> abysses_ = new MapField<int, Abyss>();

	public const int LastChallengeAbyssIDFieldNumber = 3;

	private int lastChallengeAbyssID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[14];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss Abyss
	{
		get
		{
			return abyss_;
		}
		set
		{
			abyss_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Abyss> Abysses => abysses_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastChallengeAbyssID
	{
		get
		{
			return lastChallengeAbyssID_;
		}
		set
		{
			lastChallengeAbyssID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssNtf(AbyssNtf other)
		: this()
	{
		abyss_ = ((other.abyss_ != null) ? other.abyss_.Clone() : null);
		abysses_ = other.abysses_.Clone();
		lastChallengeAbyssID_ = other.lastChallengeAbyssID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssNtf Clone()
	{
		return new AbyssNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Abyss, other.Abyss))
		{
			return false;
		}
		if (!Abysses.Equals(other.Abysses))
		{
			return false;
		}
		if (LastChallengeAbyssID != other.LastChallengeAbyssID)
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
		if (abyss_ != null)
		{
			num ^= Abyss.GetHashCode();
		}
		num ^= Abysses.GetHashCode();
		if (LastChallengeAbyssID != 0)
		{
			num ^= LastChallengeAbyssID.GetHashCode();
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
		if (abyss_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Abyss);
		}
		abysses_.WriteTo(ref output, _map_abysses_codec);
		if (LastChallengeAbyssID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LastChallengeAbyssID);
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
		if (abyss_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Abyss);
		}
		num += abysses_.CalculateSize(_map_abysses_codec);
		if (LastChallengeAbyssID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastChallengeAbyssID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.abyss_ != null)
		{
			if (abyss_ == null)
			{
				Abyss = new Abyss();
			}
			Abyss.MergeFrom(other.Abyss);
		}
		abysses_.Add(other.abysses_);
		if (other.LastChallengeAbyssID != 0)
		{
			LastChallengeAbyssID = other.LastChallengeAbyssID;
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
				if (abyss_ == null)
				{
					Abyss = new Abyss();
				}
				input.ReadMessage(Abyss);
				break;
			case 18u:
				abysses_.AddEntriesFrom(ref input, _map_abysses_codec);
				break;
			case 24u:
				LastChallengeAbyssID = input.ReadInt32();
				break;
			}
		}
	}
}
