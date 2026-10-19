using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GuideLogs : IMessage<GuideLogs>, IMessage, IEquatable<GuideLogs>, IDeepCloneable<GuideLogs>, IBufferMessage
{
	private static readonly MessageParser<GuideLogs> _parser = new MessageParser<GuideLogs>(() => new GuideLogs());

	private UnknownFieldSet _unknownFields;

	public const int InterfaceGuideFieldNumber = 1;

	private static readonly MapField<int, int>.Codec _map_interfaceGuide_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 10u);

	private readonly MapField<int, int> interfaceGuide_ = new MapField<int, int>();

	public const int GuideItemsFieldNumber = 2;

	private static readonly MapField<int, GuideItem>.Codec _map_guideItems_codec = new MapField<int, GuideItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, GuideItem.Parser), 18u);

	private readonly MapField<int, GuideItem> guideItems_ = new MapField<int, GuideItem>();

	public const int AllGuidesFieldNumber = 3;

	private static readonly MapField<int, GuideState>.Codec _map_allGuides_codec = new MapField<int, GuideState>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, GuideState.Parser), 26u);

	private readonly MapField<int, GuideState> allGuides_ = new MapField<int, GuideState>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GuideLogs> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[164];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> InterfaceGuide => interfaceGuide_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, GuideItem> GuideItems => guideItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, GuideState> AllGuides => allGuides_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogs()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogs(GuideLogs other)
		: this()
	{
		interfaceGuide_ = other.interfaceGuide_.Clone();
		guideItems_ = other.guideItems_.Clone();
		allGuides_ = other.allGuides_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GuideLogs Clone()
	{
		return new GuideLogs(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GuideLogs);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GuideLogs other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!InterfaceGuide.Equals(other.InterfaceGuide))
		{
			return false;
		}
		if (!GuideItems.Equals(other.GuideItems))
		{
			return false;
		}
		if (!AllGuides.Equals(other.AllGuides))
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
		num ^= InterfaceGuide.GetHashCode();
		num ^= GuideItems.GetHashCode();
		num ^= AllGuides.GetHashCode();
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
		interfaceGuide_.WriteTo(ref output, _map_interfaceGuide_codec);
		guideItems_.WriteTo(ref output, _map_guideItems_codec);
		allGuides_.WriteTo(ref output, _map_allGuides_codec);
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
		num += interfaceGuide_.CalculateSize(_map_interfaceGuide_codec);
		num += guideItems_.CalculateSize(_map_guideItems_codec);
		num += allGuides_.CalculateSize(_map_allGuides_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GuideLogs other)
	{
		if (other != null)
		{
			interfaceGuide_.Add(other.interfaceGuide_);
			guideItems_.Add(other.guideItems_);
			allGuides_.Add(other.allGuides_);
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
				interfaceGuide_.AddEntriesFrom(ref input, _map_interfaceGuide_codec);
				break;
			case 18u:
				guideItems_.AddEntriesFrom(ref input, _map_guideItems_codec);
				break;
			case 26u:
				allGuides_.AddEntriesFrom(ref input, _map_allGuides_codec);
				break;
			}
		}
	}
}
