using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class OnceAdditionalAttribute : IMessage<OnceAdditionalAttribute>, IMessage, IEquatable<OnceAdditionalAttribute>, IDeepCloneable<OnceAdditionalAttribute>
{
	private static readonly MessageParser<OnceAdditionalAttribute> _parser = new MessageParser<OnceAdditionalAttribute>(() => new OnceAdditionalAttribute());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelTypeDataFieldNumber = 2;

	private int levelTypeData_;

	public const int LevelDataFieldNumber = 3;

	private int levelData_;

	public const int MainOrSupportFieldNumber = 4;

	private int mainOrSupport_;

	[DebuggerNonUserCode]
	public static MessageParser<OnceAdditionalAttribute> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(604);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
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
	public int LevelTypeData
	{
		get
		{
			return levelTypeData_;
		}
		set
		{
			levelTypeData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelData
	{
		get
		{
			return levelData_;
		}
		set
		{
			levelData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MainOrSupport
	{
		get
		{
			return mainOrSupport_;
		}
		set
		{
			mainOrSupport_ = value;
		}
	}

	[DebuggerNonUserCode]
	public OnceAdditionalAttribute()
	{
	}

	[DebuggerNonUserCode]
	public OnceAdditionalAttribute(OnceAdditionalAttribute other)
		: this()
	{
		id_ = other.id_;
		levelTypeData_ = other.levelTypeData_;
		levelData_ = other.levelData_;
		mainOrSupport_ = other.mainOrSupport_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public OnceAdditionalAttribute Clone()
	{
		return new OnceAdditionalAttribute(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as OnceAdditionalAttribute);
	}

	[DebuggerNonUserCode]
	public bool Equals(OnceAdditionalAttribute other)
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
		if (LevelTypeData != other.LevelTypeData)
		{
			return false;
		}
		if (LevelData != other.LevelData)
		{
			return false;
		}
		if (MainOrSupport != other.MainOrSupport)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (LevelTypeData != 0)
		{
			num ^= LevelTypeData.GetHashCode();
		}
		if (LevelData != 0)
		{
			num ^= LevelData.GetHashCode();
		}
		if (MainOrSupport != 0)
		{
			num ^= MainOrSupport.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (LevelTypeData != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LevelTypeData);
		}
		if (LevelData != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelData);
		}
		if (MainOrSupport != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MainOrSupport);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (LevelTypeData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelTypeData);
		}
		if (LevelData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelData);
		}
		if (MainOrSupport != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainOrSupport);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(OnceAdditionalAttribute other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.LevelTypeData != 0)
			{
				LevelTypeData = other.LevelTypeData;
			}
			if (other.LevelData != 0)
			{
				LevelData = other.LevelData;
			}
			if (other.MainOrSupport != 0)
			{
				MainOrSupport = other.MainOrSupport;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				LevelTypeData = input.ReadInt32();
				break;
			case 24u:
				LevelData = input.ReadInt32();
				break;
			case 32u:
				MainOrSupport = input.ReadInt32();
				break;
			}
		}
	}
}
