using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Shield : IMessage<Shield>, IMessage, IEquatable<Shield>, IDeepCloneable<Shield>
{
	private static readonly MessageParser<Shield> _parser = new MessageParser<Shield>(() => new Shield());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int LevelTypeDataFieldNumber = 3;

	private int levelTypeData_;

	public const int LevelDataFieldNumber = 4;

	private int levelData_;

	public const int MainOrSupportFieldNumber = 5;

	private int mainOrSupport_;

	public const int BindEffectFieldNumber = 6;

	private string bindEffect_ = "";

	public const int ShieldTag1FieldNumber = 7;

	private int shieldTag1_;

	public const int ShieldTag2FieldNumber = 8;

	private int shieldTag2_;

	public const int ShieldTag3FieldNumber = 9;

	private int shieldTag3_;

	public const int TimeSuperpositionFieldNumber = 10;

	private int timeSuperposition_;

	public const int NotRemoveFieldNumber = 11;

	private bool notRemove_;

	public const int NotShieldScaleFieldNumber = 12;

	private bool notShieldScale_;

	[DebuggerNonUserCode]
	public static MessageParser<Shield> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(714);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string BindEffect
	{
		get
		{
			return bindEffect_;
		}
		set
		{
			bindEffect_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ShieldTag1
	{
		get
		{
			return shieldTag1_;
		}
		set
		{
			shieldTag1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShieldTag2
	{
		get
		{
			return shieldTag2_;
		}
		set
		{
			shieldTag2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShieldTag3
	{
		get
		{
			return shieldTag3_;
		}
		set
		{
			shieldTag3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeSuperposition
	{
		get
		{
			return timeSuperposition_;
		}
		set
		{
			timeSuperposition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NotRemove
	{
		get
		{
			return notRemove_;
		}
		set
		{
			notRemove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NotShieldScale
	{
		get
		{
			return notShieldScale_;
		}
		set
		{
			notShieldScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Shield()
	{
	}

	[DebuggerNonUserCode]
	public Shield(Shield other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		levelTypeData_ = other.levelTypeData_;
		levelData_ = other.levelData_;
		mainOrSupport_ = other.mainOrSupport_;
		bindEffect_ = other.bindEffect_;
		shieldTag1_ = other.shieldTag1_;
		shieldTag2_ = other.shieldTag2_;
		shieldTag3_ = other.shieldTag3_;
		timeSuperposition_ = other.timeSuperposition_;
		notRemove_ = other.notRemove_;
		notShieldScale_ = other.notShieldScale_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Shield Clone()
	{
		return new Shield(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Shield);
	}

	[DebuggerNonUserCode]
	public bool Equals(Shield other)
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
		if (Name != other.Name)
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
		if (BindEffect != other.BindEffect)
		{
			return false;
		}
		if (ShieldTag1 != other.ShieldTag1)
		{
			return false;
		}
		if (ShieldTag2 != other.ShieldTag2)
		{
			return false;
		}
		if (ShieldTag3 != other.ShieldTag3)
		{
			return false;
		}
		if (TimeSuperposition != other.TimeSuperposition)
		{
			return false;
		}
		if (NotRemove != other.NotRemove)
		{
			return false;
		}
		if (NotShieldScale != other.NotShieldScale)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
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
		if (BindEffect.Length != 0)
		{
			num ^= BindEffect.GetHashCode();
		}
		if (ShieldTag1 != 0)
		{
			num ^= ShieldTag1.GetHashCode();
		}
		if (ShieldTag2 != 0)
		{
			num ^= ShieldTag2.GetHashCode();
		}
		if (ShieldTag3 != 0)
		{
			num ^= ShieldTag3.GetHashCode();
		}
		if (TimeSuperposition != 0)
		{
			num ^= TimeSuperposition.GetHashCode();
		}
		if (NotRemove)
		{
			num ^= NotRemove.GetHashCode();
		}
		if (NotShieldScale)
		{
			num ^= NotShieldScale.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (LevelTypeData != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelTypeData);
		}
		if (LevelData != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LevelData);
		}
		if (MainOrSupport != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MainOrSupport);
		}
		if (BindEffect.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(BindEffect);
		}
		if (ShieldTag1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ShieldTag1);
		}
		if (ShieldTag2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ShieldTag2);
		}
		if (ShieldTag3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ShieldTag3);
		}
		if (TimeSuperposition != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(TimeSuperposition);
		}
		if (NotRemove)
		{
			output.WriteRawTag(88);
			output.WriteBool(NotRemove);
		}
		if (NotShieldScale)
		{
			output.WriteRawTag(96);
			output.WriteBool(NotShieldScale);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
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
		if (BindEffect.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BindEffect);
		}
		if (ShieldTag1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShieldTag1);
		}
		if (ShieldTag2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShieldTag2);
		}
		if (ShieldTag3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShieldTag3);
		}
		if (TimeSuperposition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeSuperposition);
		}
		if (NotRemove)
		{
			num += 2;
		}
		if (NotShieldScale)
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
	public void MergeFrom(Shield other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
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
			if (other.BindEffect.Length != 0)
			{
				BindEffect = other.BindEffect;
			}
			if (other.ShieldTag1 != 0)
			{
				ShieldTag1 = other.ShieldTag1;
			}
			if (other.ShieldTag2 != 0)
			{
				ShieldTag2 = other.ShieldTag2;
			}
			if (other.ShieldTag3 != 0)
			{
				ShieldTag3 = other.ShieldTag3;
			}
			if (other.TimeSuperposition != 0)
			{
				TimeSuperposition = other.TimeSuperposition;
			}
			if (other.NotRemove)
			{
				NotRemove = other.NotRemove;
			}
			if (other.NotShieldScale)
			{
				NotShieldScale = other.NotShieldScale;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				LevelTypeData = input.ReadInt32();
				break;
			case 32u:
				LevelData = input.ReadInt32();
				break;
			case 40u:
				MainOrSupport = input.ReadInt32();
				break;
			case 50u:
				BindEffect = input.ReadString();
				break;
			case 56u:
				ShieldTag1 = input.ReadInt32();
				break;
			case 64u:
				ShieldTag2 = input.ReadInt32();
				break;
			case 72u:
				ShieldTag3 = input.ReadInt32();
				break;
			case 80u:
				TimeSuperposition = input.ReadInt32();
				break;
			case 88u:
				NotRemove = input.ReadBool();
				break;
			case 96u:
				NotShieldScale = input.ReadBool();
				break;
			}
		}
	}
}
