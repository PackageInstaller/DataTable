using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Handbook : IMessage<Handbook>, IMessage, IEquatable<Handbook>, IDeepCloneable<Handbook>, IBufferMessage
{
	private static readonly MessageParser<Handbook> _parser = new MessageParser<Handbook>(() => new Handbook());

	private UnknownFieldSet _unknownFields;

	public const int InfosFieldNumber = 1;

	private static readonly MapField<int, HandbookInfo>.Codec _map_infos_codec = new MapField<int, HandbookInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, HandbookInfo.Parser), 10u);

	private readonly MapField<int, HandbookInfo> infos_ = new MapField<int, HandbookInfo>();

	public const int MonsterHandbookFieldNumber = 2;

	private MonsterHandbook monsterHandbook_;

	public const int GrowthGuideFieldNumber = 3;

	private PlayerGrowthGuide growthGuide_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Handbook> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[129];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, HandbookInfo> Infos => infos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonsterHandbook MonsterHandbook
	{
		get
		{
			return monsterHandbook_;
		}
		set
		{
			monsterHandbook_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PlayerGrowthGuide GrowthGuide
	{
		get
		{
			return growthGuide_;
		}
		set
		{
			growthGuide_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Handbook()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Handbook(Handbook other)
		: this()
	{
		infos_ = other.infos_.Clone();
		monsterHandbook_ = ((other.monsterHandbook_ != null) ? other.monsterHandbook_.Clone() : null);
		growthGuide_ = ((other.growthGuide_ != null) ? other.growthGuide_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Handbook Clone()
	{
		return new Handbook(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Handbook);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Handbook other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Infos.Equals(other.Infos))
		{
			return false;
		}
		if (!object.Equals(MonsterHandbook, other.MonsterHandbook))
		{
			return false;
		}
		if (!object.Equals(GrowthGuide, other.GrowthGuide))
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
		num ^= Infos.GetHashCode();
		if (monsterHandbook_ != null)
		{
			num ^= MonsterHandbook.GetHashCode();
		}
		if (growthGuide_ != null)
		{
			num ^= GrowthGuide.GetHashCode();
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
		infos_.WriteTo(ref output, _map_infos_codec);
		if (monsterHandbook_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(MonsterHandbook);
		}
		if (growthGuide_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(GrowthGuide);
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
		num += infos_.CalculateSize(_map_infos_codec);
		if (monsterHandbook_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MonsterHandbook);
		}
		if (growthGuide_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(GrowthGuide);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Handbook other)
	{
		if (other == null)
		{
			return;
		}
		infos_.Add(other.infos_);
		if (other.monsterHandbook_ != null)
		{
			if (monsterHandbook_ == null)
			{
				MonsterHandbook = new MonsterHandbook();
			}
			MonsterHandbook.MergeFrom(other.MonsterHandbook);
		}
		if (other.growthGuide_ != null)
		{
			if (growthGuide_ == null)
			{
				GrowthGuide = new PlayerGrowthGuide();
			}
			GrowthGuide.MergeFrom(other.GrowthGuide);
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
				infos_.AddEntriesFrom(ref input, _map_infos_codec);
				break;
			case 18u:
				if (monsterHandbook_ == null)
				{
					MonsterHandbook = new MonsterHandbook();
				}
				input.ReadMessage(MonsterHandbook);
				break;
			case 26u:
				if (growthGuide_ == null)
				{
					GrowthGuide = new PlayerGrowthGuide();
				}
				input.ReadMessage(GrowthGuide);
				break;
			}
		}
	}
}
