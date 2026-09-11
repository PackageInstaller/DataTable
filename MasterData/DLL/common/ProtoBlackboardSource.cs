using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;
using Google.Protobuf.WellKnownTypes;

public sealed class ProtoBlackboardSource : IMessage<ProtoBlackboardSource>, IMessage, IEquatable<ProtoBlackboardSource>, IDeepCloneable<ProtoBlackboardSource>
{
	private static readonly MessageParser<ProtoBlackboardSource> _parser = new MessageParser<ProtoBlackboardSource>(() => new ProtoBlackboardSource());

	public const int MapFieldNumber = 1;

	private static readonly MapField<string, Any>.Codec _map_map_codec = new MapField<string, Any>.Codec(FieldCodec.ForString(10u), FieldCodec.ForMessage(18u, Any.Parser), 10u);

	private readonly MapField<string, Any> map_ = new MapField<string, Any>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoBlackboardSource> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public MapField<string, Any> Map => map_;

	[DebuggerNonUserCode]
	public ProtoBlackboardSource()
	{
	}

	[DebuggerNonUserCode]
	public ProtoBlackboardSource(ProtoBlackboardSource other)
		: this()
	{
		map_ = other.map_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoBlackboardSource Clone()
	{
		return new ProtoBlackboardSource(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoBlackboardSource);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoBlackboardSource other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Map.Equals(other.Map))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		return num ^ Map.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		map_.WriteTo(output, _map_map_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		return num + map_.CalculateSize(_map_map_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoBlackboardSource other)
	{
		if (other != null)
		{
			map_.Add(other.map_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				map_.AddEntriesFrom(input, _map_map_codec);
			}
		}
	}
}
