using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Item : IMessage<Item>, IMessage, IEquatable<Item>, IDeepCloneable<Item>, IBufferMessage, IMargeFrom<Item>, IBagItem
{
	private static readonly MessageParser<Item> _parser = new MessageParser<Item>(() => new Item());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CountFieldNumber = 2;

	private int count_;

	public const int IsNewFieldNumber = 3;

	private bool isNew_;

	public const int ExpireTimeFieldNumber = 4;

	private long expireTime_;

	public const int UidFieldNumber = 5;

	private int uid_;

	public bool notEnough;

	public bool selected;

	public bool haveRandom;

	public int randomCount;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Item> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Count
	{
		get
		{
			return count_;
		}
		set
		{
			count_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsNew
	{
		get
		{
			return isNew_;
		}
		set
		{
			isNew_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long ExpireTime
	{
		get
		{
			return expireTime_;
		}
		set
		{
			expireTime_ = value;
		}
	}

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

	public int itemType => CoreUtils.GetData(id_, RuntimeConfigs.data.itemDatas)?.type ?? 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Item()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Item(Item other)
		: this()
	{
		id_ = other.id_;
		count_ = other.count_;
		isNew_ = other.isNew_;
		expireTime_ = other.expireTime_;
		uid_ = other.uid_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Item Clone()
	{
		return new Item(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Item);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Item other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Count != other.Count)
		{
			return false;
		}
		if (IsNew != other.IsNew)
		{
			return false;
		}
		if (ExpireTime != other.ExpireTime)
		{
			return false;
		}
		if (Uid != other.Uid)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Count != 0)
		{
			num ^= Count.GetHashCode();
		}
		if (IsNew)
		{
			num ^= IsNew.GetHashCode();
		}
		if (ExpireTime != 0L)
		{
			num ^= ExpireTime.GetHashCode();
		}
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Count != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Count);
		}
		if (IsNew)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsNew);
		}
		if (ExpireTime != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(ExpireTime);
		}
		if (Uid != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Uid);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Count);
		}
		if (IsNew)
		{
			num += 2;
		}
		if (ExpireTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ExpireTime);
		}
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Item other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Count != 0)
			{
				Count = other.Count;
			}
			if (other.IsNew)
			{
				IsNew = other.IsNew;
			}
			if (other.ExpireTime != 0L)
			{
				ExpireTime = other.ExpireTime;
			}
			if (other.Uid != 0)
			{
				Uid = other.Uid;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				Count = input.ReadInt32();
				break;
			case 24u:
				IsNew = input.ReadBool();
				break;
			case 32u:
				ExpireTime = input.ReadInt64();
				break;
			case 40u:
				Uid = input.ReadInt32();
				break;
			}
		}
	}

	public void MargeFrom(Item other)
	{
		count_ = other.count_;
	}

	public void Refresh()
	{
	}

	public int GetId()
	{
		return Id;
	}

	public int GetCount()
	{
		return count_;
	}

	public int GetQuality()
	{
		return CoreUtils.GetData(Id, RuntimeConfigs.data.itemDatas)?.quality ?? 0;
	}

	public int GetLocalizationName()
	{
		return CoreUtils.GetData(Id, RuntimeConfigs.data.itemDatas)?.nameLocal ?? 0;
	}

	public string GetNameString()
	{
		int localizationName = GetLocalizationName();
		if (localizationName == 0)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString("shortcommon", localizationName);
	}

	public int GetUid()
	{
		return Uid;
	}

	public long GetExpireTime()
	{
		return expireTime_ * 1000;
	}

	public bool IsDisuse()
	{
		if (!IsLimitTimeItem())
		{
			return false;
		}
		return TimeManager.ServerTime.NowTimestamp >= GetExpireTime();
	}

	public bool IsLimitTimeItem()
	{
		ItemData data = CoreUtils.GetData(id_, RuntimeConfigs.data.itemDatas);
		if (data == null || data.ItemDateType == 0)
		{
			return false;
		}
		return true;
	}

	public int GetHoldingLimitNum()
	{
		ItemData data = CoreUtils.GetData(id_, RuntimeConfigs.data.itemDatas);
		if (data.stackLimit > 0)
		{
			return data.stackLimit;
		}
		return -1;
	}
}
