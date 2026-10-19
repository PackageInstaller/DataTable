using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueTalentTree : IMessage<RogueTalentTree>, IMessage, IEquatable<RogueTalentTree>, IDeepCloneable<RogueTalentTree>, IBufferMessage
{
	private static readonly MessageParser<RogueTalentTree> _parser = new MessageParser<RogueTalentTree>(() => new RogueTalentTree());

	private UnknownFieldSet _unknownFields;

	public const int CodesFieldNumber = 1;

	private static readonly MapField<int, RogueTalentTreeCode>.Codec _map_codes_codec = new MapField<int, RogueTalentTreeCode>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueTalentTreeCode.Parser), 10u);

	private readonly MapField<int, RogueTalentTreeCode> codes_ = new MapField<int, RogueTalentTreeCode>();

	public const int NodesFieldNumber = 2;

	private static readonly MapField<int, RogueTalentTreeNode>.Codec _map_nodes_codec = new MapField<int, RogueTalentTreeNode>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, RogueTalentTreeNode.Parser), 18u);

	private readonly MapField<int, RogueTalentTreeNode> nodes_ = new MapField<int, RogueTalentTreeNode>();

	public const int UsedPointFieldNumber = 3;

	private int usedPoint_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueTalentTree> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[232];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, RogueTalentTreeCode> Codes => codes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, RogueTalentTreeNode> Nodes => nodes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int UsedPoint
	{
		get
		{
			return usedPoint_;
		}
		set
		{
			usedPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTalentTree()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTalentTree(RogueTalentTree other)
		: this()
	{
		codes_ = other.codes_.Clone();
		nodes_ = other.nodes_.Clone();
		usedPoint_ = other.usedPoint_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueTalentTree Clone()
	{
		return new RogueTalentTree(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueTalentTree);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueTalentTree other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Codes.Equals(other.Codes))
		{
			return false;
		}
		if (!Nodes.Equals(other.Nodes))
		{
			return false;
		}
		if (UsedPoint != other.UsedPoint)
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
		num ^= Codes.GetHashCode();
		num ^= Nodes.GetHashCode();
		if (UsedPoint != 0)
		{
			num ^= UsedPoint.GetHashCode();
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
		codes_.WriteTo(ref output, _map_codes_codec);
		nodes_.WriteTo(ref output, _map_nodes_codec);
		if (UsedPoint != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(UsedPoint);
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
		num += codes_.CalculateSize(_map_codes_codec);
		num += nodes_.CalculateSize(_map_nodes_codec);
		if (UsedPoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UsedPoint);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueTalentTree other)
	{
		if (other != null)
		{
			codes_.Add(other.codes_);
			nodes_.Add(other.nodes_);
			if (other.UsedPoint != 0)
			{
				UsedPoint = other.UsedPoint;
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
				codes_.AddEntriesFrom(ref input, _map_codes_codec);
				break;
			case 18u:
				nodes_.AddEntriesFrom(ref input, _map_nodes_codec);
				break;
			case 24u:
				UsedPoint = input.ReadInt32();
				break;
			}
		}
	}
}
