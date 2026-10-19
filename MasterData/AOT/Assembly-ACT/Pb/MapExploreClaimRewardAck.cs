using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapExploreClaimRewardAck : IMessage<MapExploreClaimRewardAck>, IMessage, IEquatable<MapExploreClaimRewardAck>, IDeepCloneable<MapExploreClaimRewardAck>, IBufferMessage
{
	private static readonly MessageParser<MapExploreClaimRewardAck> _parser = new MessageParser<MapExploreClaimRewardAck>(() => new MapExploreClaimRewardAck());

	private UnknownFieldSet _unknownFields;

	public const int GotItemsFieldNumber = 1;

	private static readonly FieldCodec<UniversalItem> _repeated_gotItems_codec = FieldCodec.ForMessage(10u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotItems_ = new RepeatedField<UniversalItem>();

	public const int AreaExploreFieldNumber = 2;

	private MapAreaExplore areaExplore_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapExploreClaimRewardAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[21];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaExplore AreaExplore
	{
		get
		{
			return areaExplore_;
		}
		set
		{
			areaExplore_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapExploreClaimRewardAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapExploreClaimRewardAck(MapExploreClaimRewardAck other)
		: this()
	{
		gotItems_ = other.gotItems_.Clone();
		areaExplore_ = ((other.areaExplore_ != null) ? other.areaExplore_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapExploreClaimRewardAck Clone()
	{
		return new MapExploreClaimRewardAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapExploreClaimRewardAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapExploreClaimRewardAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!gotItems_.Equals(other.gotItems_))
		{
			return false;
		}
		if (!object.Equals(AreaExplore, other.AreaExplore))
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
		num ^= gotItems_.GetHashCode();
		if (areaExplore_ != null)
		{
			num ^= AreaExplore.GetHashCode();
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
		gotItems_.WriteTo(ref output, _repeated_gotItems_codec);
		if (areaExplore_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(AreaExplore);
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
		num += gotItems_.CalculateSize(_repeated_gotItems_codec);
		if (areaExplore_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AreaExplore);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapExploreClaimRewardAck other)
	{
		if (other == null)
		{
			return;
		}
		gotItems_.Add(other.gotItems_);
		if (other.areaExplore_ != null)
		{
			if (areaExplore_ == null)
			{
				AreaExplore = new MapAreaExplore();
			}
			AreaExplore.MergeFrom(other.AreaExplore);
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
				gotItems_.AddEntriesFrom(ref input, _repeated_gotItems_codec);
				break;
			case 18u:
				if (areaExplore_ == null)
				{
					AreaExplore = new MapAreaExplore();
				}
				input.ReadMessage(AreaExplore);
				break;
			}
		}
	}
}
