using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TempleInfo : IMessage<TempleInfo>, IMessage, IEquatable<TempleInfo>, IDeepCloneable<TempleInfo>, IBufferMessage
{
	private static readonly MessageParser<TempleInfo> _parser = new MessageParser<TempleInfo>(() => new TempleInfo());

	private UnknownFieldSet _unknownFields;

	public const int AreaInfoFieldNumber = 1;

	private static readonly MapField<int, TempleArea>.Codec _map_areaInfo_codec = new MapField<int, TempleArea>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, TempleArea.Parser), 10u);

	private readonly MapField<int, TempleArea> areaInfo_ = new MapField<int, TempleArea>();

	public const int TemplesFieldNumber = 3;

	private static readonly MapField<int, Temple>.Codec _map_temples_codec = new MapField<int, Temple>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Temple.Parser), 26u);

	private readonly MapField<int, Temple> temples_ = new MapField<int, Temple>();

	public const int CurChallengeIdFieldNumber = 4;

	private int curChallengeId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[141];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, TempleArea> AreaInfo => areaInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Temple> Temples => temples_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurChallengeId
	{
		get
		{
			return curChallengeId_;
		}
		set
		{
			curChallengeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleInfo(TempleInfo other)
		: this()
	{
		areaInfo_ = other.areaInfo_.Clone();
		temples_ = other.temples_.Clone();
		curChallengeId_ = other.curChallengeId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleInfo Clone()
	{
		return new TempleInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!AreaInfo.Equals(other.AreaInfo))
		{
			return false;
		}
		if (!Temples.Equals(other.Temples))
		{
			return false;
		}
		if (CurChallengeId != other.CurChallengeId)
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
		num ^= AreaInfo.GetHashCode();
		num ^= Temples.GetHashCode();
		if (CurChallengeId != 0)
		{
			num ^= CurChallengeId.GetHashCode();
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
		areaInfo_.WriteTo(ref output, _map_areaInfo_codec);
		temples_.WriteTo(ref output, _map_temples_codec);
		if (CurChallengeId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CurChallengeId);
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
		num += areaInfo_.CalculateSize(_map_areaInfo_codec);
		num += temples_.CalculateSize(_map_temples_codec);
		if (CurChallengeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurChallengeId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleInfo other)
	{
		if (other != null)
		{
			areaInfo_.Add(other.areaInfo_);
			temples_.Add(other.temples_);
			if (other.CurChallengeId != 0)
			{
				CurChallengeId = other.CurChallengeId;
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
			case 10u:
				areaInfo_.AddEntriesFrom(ref input, _map_areaInfo_codec);
				break;
			case 26u:
				temples_.AddEntriesFrom(ref input, _map_temples_codec);
				break;
			case 32u:
				CurChallengeId = input.ReadInt32();
				break;
			}
		}
	}
}
