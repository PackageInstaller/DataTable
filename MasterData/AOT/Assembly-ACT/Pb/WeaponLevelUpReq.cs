using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class WeaponLevelUpReq : IMessage<WeaponLevelUpReq>, IMessage, IEquatable<WeaponLevelUpReq>, IDeepCloneable<WeaponLevelUpReq>, IBufferMessage
{
	private static readonly MessageParser<WeaponLevelUpReq> _parser = new MessageParser<WeaponLevelUpReq>(() => new WeaponLevelUpReq());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int SpendWeaponUidsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_spendWeaponUids_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> spendWeaponUids_ = new RepeatedField<int>();

	public const int SpendItemsFieldNumber = 3;

	private static readonly FieldCodec<Item> _repeated_spendItems_codec = FieldCodec.ForMessage(26u, Item.Parser);

	private readonly RepeatedField<Item> spendItems_ = new RepeatedField<Item>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<WeaponLevelUpReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => WeaponReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> SpendWeaponUids => spendWeaponUids_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> SpendItems => spendItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public WeaponLevelUpReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public WeaponLevelUpReq(WeaponLevelUpReq other)
		: this()
	{
		uid_ = other.uid_;
		spendWeaponUids_ = other.spendWeaponUids_.Clone();
		spendItems_ = other.spendItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public WeaponLevelUpReq Clone()
	{
		return new WeaponLevelUpReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as WeaponLevelUpReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(WeaponLevelUpReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (!spendWeaponUids_.Equals(other.spendWeaponUids_))
		{
			return false;
		}
		if (!spendItems_.Equals(other.spendItems_))
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
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		num ^= spendWeaponUids_.GetHashCode();
		num ^= spendItems_.GetHashCode();
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
		if (Uid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Uid);
		}
		spendWeaponUids_.WriteTo(ref output, _repeated_spendWeaponUids_codec);
		spendItems_.WriteTo(ref output, _repeated_spendItems_codec);
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
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		num += spendWeaponUids_.CalculateSize(_repeated_spendWeaponUids_codec);
		num += spendItems_.CalculateSize(_repeated_spendItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(WeaponLevelUpReq other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			spendWeaponUids_.Add(other.spendWeaponUids_);
			spendItems_.Add(other.spendItems_);
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
				Uid = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				spendWeaponUids_.AddEntriesFrom(ref input, _repeated_spendWeaponUids_codec);
				break;
			case 26u:
				spendItems_.AddEntriesFrom(ref input, _repeated_spendItems_codec);
				break;
			}
		}
	}
}
