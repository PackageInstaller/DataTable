using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class CookMenu : IMessage<CookMenu>, IMessage, IEquatable<CookMenu>, IDeepCloneable<CookMenu>, IBufferMessage
{
	private static readonly MessageParser<CookMenu> _parser = new MessageParser<CookMenu>(() => new CookMenu());

	private UnknownFieldSet _unknownFields;

	public const int MainItemsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_mainItems_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> mainItems_ = new RepeatedField<Item>();

	public const int MinorItemsFieldNumber = 2;

	private static readonly FieldCodec<Item> _repeated_minorItems_codec = FieldCodec.ForMessage(18u, Item.Parser);

	private readonly RepeatedField<Item> minorItems_ = new RepeatedField<Item>();

	public const int MenuNameFieldNumber = 3;

	private string menuName_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CookMenu> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[144];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> MainItems => mainItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> MinorItems => minorItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string MenuName
	{
		get
		{
			return menuName_;
		}
		set
		{
			menuName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookMenu()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookMenu(CookMenu other)
		: this()
	{
		mainItems_ = other.mainItems_.Clone();
		minorItems_ = other.minorItems_.Clone();
		menuName_ = other.menuName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookMenu Clone()
	{
		return new CookMenu(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CookMenu);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CookMenu other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!mainItems_.Equals(other.mainItems_))
		{
			return false;
		}
		if (!minorItems_.Equals(other.minorItems_))
		{
			return false;
		}
		if (MenuName != other.MenuName)
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
		num ^= mainItems_.GetHashCode();
		num ^= minorItems_.GetHashCode();
		if (MenuName.Length != 0)
		{
			num ^= MenuName.GetHashCode();
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
		mainItems_.WriteTo(ref output, _repeated_mainItems_codec);
		minorItems_.WriteTo(ref output, _repeated_minorItems_codec);
		if (MenuName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(MenuName);
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
		num += mainItems_.CalculateSize(_repeated_mainItems_codec);
		num += minorItems_.CalculateSize(_repeated_minorItems_codec);
		if (MenuName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MenuName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CookMenu other)
	{
		if (other != null)
		{
			mainItems_.Add(other.mainItems_);
			minorItems_.Add(other.minorItems_);
			if (other.MenuName.Length != 0)
			{
				MenuName = other.MenuName;
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
				mainItems_.AddEntriesFrom(ref input, _repeated_mainItems_codec);
				break;
			case 18u:
				minorItems_.AddEntriesFrom(ref input, _repeated_minorItems_codec);
				break;
			case 26u:
				MenuName = input.ReadString();
				break;
			}
		}
	}
}
