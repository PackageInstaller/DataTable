using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Treasure : IMessage<Treasure>, IMessage, IEquatable<Treasure>, IDeepCloneable<Treasure>, IBufferMessage, IBagItem
{
	private static readonly MessageParser<Treasure> _parser = new MessageParser<Treasure>(() => new Treasure());

	private UnknownFieldSet _unknownFields;

	public const int TreasureIdFieldNumber = 1;

	private int treasureId_;

	public const int GainTimeFieldNumber = 2;

	private int gainTime_;

	public TreasureType Type;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Treasure> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[279];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TreasureId
	{
		get
		{
			return treasureId_;
		}
		set
		{
			treasureId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GainTime
	{
		get
		{
			return gainTime_;
		}
		set
		{
			gainTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Treasure()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Treasure(Treasure other)
		: this()
	{
		treasureId_ = other.treasureId_;
		gainTime_ = other.gainTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Treasure Clone()
	{
		return new Treasure(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Treasure);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Treasure other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TreasureId != other.TreasureId)
		{
			return false;
		}
		if (GainTime != other.GainTime)
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
		if (TreasureId != 0)
		{
			num ^= TreasureId.GetHashCode();
		}
		if (GainTime != 0)
		{
			num ^= GainTime.GetHashCode();
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
		if (TreasureId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TreasureId);
		}
		if (GainTime != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GainTime);
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
		if (TreasureId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TreasureId);
		}
		if (GainTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GainTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Treasure other)
	{
		if (other != null)
		{
			if (other.TreasureId != 0)
			{
				TreasureId = other.TreasureId;
			}
			if (other.GainTime != 0)
			{
				GainTime = other.GainTime;
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
				TreasureId = input.ReadInt32();
				break;
			case 16u:
				GainTime = input.ReadInt32();
				break;
			}
		}
	}

	public int GetId()
	{
		return TreasureId;
	}

	public int GetUid()
	{
		return 0;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetItemId()
	{
		return CoreUtils.GetData(TreasureId, RuntimeConfigs.data.itemTreasureDatas)?.itemId ?? 0;
	}

	public int GetQuality()
	{
		ItemData data = CoreUtils.GetData(CoreUtils.GetData(TreasureId, RuntimeConfigs.data.itemTreasureDatas).itemId, RuntimeConfigs.data.itemDatas);
		if (Model<TreasureModel>.Interface.HasGain(TreasureId))
		{
			return data.quality;
		}
		return 1;
	}

	public int GetLocalizationName()
	{
		return 0;
	}

	public void MargeFrom(Treasure change)
	{
		if (this != change && change != null)
		{
			TreasureId = change.TreasureId;
			GainTime = change.GainTime;
			Type = change.Type;
		}
	}
}
