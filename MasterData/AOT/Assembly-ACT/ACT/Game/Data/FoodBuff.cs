using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class FoodBuff : IMessage<FoodBuff>, IMessage, IEquatable<FoodBuff>, IDeepCloneable<FoodBuff>, IBufferMessage
{
	private static readonly MessageParser<FoodBuff> _parser = new MessageParser<FoodBuff>(() => new FoodBuff());

	private UnknownFieldSet _unknownFields;

	public const int MainBuffsFieldNumber = 1;

	private static readonly FieldCodec<BuffWithRate> _repeated_mainBuffs_codec = FieldCodec.ForMessage(10u, BuffWithRate.Parser);

	private readonly RepeatedField<BuffWithRate> mainBuffs_ = new RepeatedField<BuffWithRate>();

	public const int MinorBuffsFieldNumber = 2;

	private static readonly FieldCodec<BuffWithRate> _repeated_minorBuffs_codec = FieldCodec.ForMessage(18u, BuffWithRate.Parser);

	private readonly RepeatedField<BuffWithRate> minorBuffs_ = new RepeatedField<BuffWithRate>();

	public const int StartEffectTsFieldNumber = 3;

	private long startEffectTs_;

	public const int MinorItemsFieldNumber = 4;

	private static readonly FieldCodec<Item> _repeated_minorItems_codec = FieldCodec.ForMessage(34u, Item.Parser);

	private readonly RepeatedField<Item> minorItems_ = new RepeatedField<Item>();

	public const int CookWayFieldNumber = 5;

	private CookWay cookWay_;

	public const int MainItemsFieldNumber = 6;

	private static readonly FieldCodec<Item> _repeated_mainItems_codec = FieldCodec.ForMessage(50u, Item.Parser);

	private readonly RepeatedField<Item> mainItems_ = new RepeatedField<Item>();

	public const int MenuIDFieldNumber = 7;

	private int menuID_;

	public const int CustomWayNameIDFieldNumber = 8;

	private int customWayNameID_;

	public const int ResetMinorBuffNumFieldNumber = 9;

	private int resetMinorBuffNum_;

	public const int SavedCustomMenuFieldNumber = 10;

	private bool savedCustomMenu_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FoodBuff> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[64];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<BuffWithRate> MainBuffs => mainBuffs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<BuffWithRate> MinorBuffs => minorBuffs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long StartEffectTs
	{
		get
		{
			return startEffectTs_;
		}
		set
		{
			startEffectTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> MinorItems => minorItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CookWay CookWay
	{
		get
		{
			return cookWay_;
		}
		set
		{
			cookWay_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> MainItems => mainItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MenuID
	{
		get
		{
			return menuID_;
		}
		set
		{
			menuID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CustomWayNameID
	{
		get
		{
			return customWayNameID_;
		}
		set
		{
			customWayNameID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ResetMinorBuffNum
	{
		get
		{
			return resetMinorBuffNum_;
		}
		set
		{
			resetMinorBuffNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool SavedCustomMenu
	{
		get
		{
			return savedCustomMenu_;
		}
		set
		{
			savedCustomMenu_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FoodBuff()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FoodBuff(FoodBuff other)
		: this()
	{
		mainBuffs_ = other.mainBuffs_.Clone();
		minorBuffs_ = other.minorBuffs_.Clone();
		startEffectTs_ = other.startEffectTs_;
		minorItems_ = other.minorItems_.Clone();
		cookWay_ = other.cookWay_;
		mainItems_ = other.mainItems_.Clone();
		menuID_ = other.menuID_;
		customWayNameID_ = other.customWayNameID_;
		resetMinorBuffNum_ = other.resetMinorBuffNum_;
		savedCustomMenu_ = other.savedCustomMenu_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FoodBuff Clone()
	{
		return new FoodBuff(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FoodBuff);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FoodBuff other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!mainBuffs_.Equals(other.mainBuffs_))
		{
			return false;
		}
		if (!minorBuffs_.Equals(other.minorBuffs_))
		{
			return false;
		}
		if (StartEffectTs != other.StartEffectTs)
		{
			return false;
		}
		if (!minorItems_.Equals(other.minorItems_))
		{
			return false;
		}
		if (CookWay != other.CookWay)
		{
			return false;
		}
		if (!mainItems_.Equals(other.mainItems_))
		{
			return false;
		}
		if (MenuID != other.MenuID)
		{
			return false;
		}
		if (CustomWayNameID != other.CustomWayNameID)
		{
			return false;
		}
		if (ResetMinorBuffNum != other.ResetMinorBuffNum)
		{
			return false;
		}
		if (SavedCustomMenu != other.SavedCustomMenu)
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
		num ^= mainBuffs_.GetHashCode();
		num ^= minorBuffs_.GetHashCode();
		if (StartEffectTs != 0L)
		{
			num ^= StartEffectTs.GetHashCode();
		}
		num ^= minorItems_.GetHashCode();
		if (CookWay != CookWay.Menu)
		{
			num ^= CookWay.GetHashCode();
		}
		num ^= mainItems_.GetHashCode();
		if (MenuID != 0)
		{
			num ^= MenuID.GetHashCode();
		}
		if (CustomWayNameID != 0)
		{
			num ^= CustomWayNameID.GetHashCode();
		}
		if (ResetMinorBuffNum != 0)
		{
			num ^= ResetMinorBuffNum.GetHashCode();
		}
		if (SavedCustomMenu)
		{
			num ^= SavedCustomMenu.GetHashCode();
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
		mainBuffs_.WriteTo(ref output, _repeated_mainBuffs_codec);
		minorBuffs_.WriteTo(ref output, _repeated_minorBuffs_codec);
		if (StartEffectTs != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(StartEffectTs);
		}
		minorItems_.WriteTo(ref output, _repeated_minorItems_codec);
		if (CookWay != CookWay.Menu)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)CookWay);
		}
		mainItems_.WriteTo(ref output, _repeated_mainItems_codec);
		if (MenuID != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MenuID);
		}
		if (CustomWayNameID != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(CustomWayNameID);
		}
		if (ResetMinorBuffNum != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ResetMinorBuffNum);
		}
		if (SavedCustomMenu)
		{
			output.WriteRawTag(80);
			output.WriteBool(SavedCustomMenu);
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
		num += mainBuffs_.CalculateSize(_repeated_mainBuffs_codec);
		num += minorBuffs_.CalculateSize(_repeated_minorBuffs_codec);
		if (StartEffectTs != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(StartEffectTs);
		}
		num += minorItems_.CalculateSize(_repeated_minorItems_codec);
		if (CookWay != CookWay.Menu)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)CookWay);
		}
		num += mainItems_.CalculateSize(_repeated_mainItems_codec);
		if (MenuID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MenuID);
		}
		if (CustomWayNameID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CustomWayNameID);
		}
		if (ResetMinorBuffNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResetMinorBuffNum);
		}
		if (SavedCustomMenu)
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
	public void MergeFrom(FoodBuff other)
	{
		if (other != null)
		{
			mainBuffs_.Add(other.mainBuffs_);
			minorBuffs_.Add(other.minorBuffs_);
			if (other.StartEffectTs != 0L)
			{
				StartEffectTs = other.StartEffectTs;
			}
			minorItems_.Add(other.minorItems_);
			if (other.CookWay != CookWay.Menu)
			{
				CookWay = other.CookWay;
			}
			mainItems_.Add(other.mainItems_);
			if (other.MenuID != 0)
			{
				MenuID = other.MenuID;
			}
			if (other.CustomWayNameID != 0)
			{
				CustomWayNameID = other.CustomWayNameID;
			}
			if (other.ResetMinorBuffNum != 0)
			{
				ResetMinorBuffNum = other.ResetMinorBuffNum;
			}
			if (other.SavedCustomMenu)
			{
				SavedCustomMenu = other.SavedCustomMenu;
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
				mainBuffs_.AddEntriesFrom(ref input, _repeated_mainBuffs_codec);
				break;
			case 18u:
				minorBuffs_.AddEntriesFrom(ref input, _repeated_minorBuffs_codec);
				break;
			case 24u:
				StartEffectTs = input.ReadInt64();
				break;
			case 34u:
				minorItems_.AddEntriesFrom(ref input, _repeated_minorItems_codec);
				break;
			case 40u:
				CookWay = (CookWay)input.ReadEnum();
				break;
			case 50u:
				mainItems_.AddEntriesFrom(ref input, _repeated_mainItems_codec);
				break;
			case 56u:
				MenuID = input.ReadInt32();
				break;
			case 64u:
				CustomWayNameID = input.ReadInt32();
				break;
			case 72u:
				ResetMinorBuffNum = input.ReadInt32();
				break;
			case 80u:
				SavedCustomMenu = input.ReadBool();
				break;
			}
		}
	}
}
