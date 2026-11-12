using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ThrowGiftFloor : IMessage<ThrowGiftFloor>, IMessage, IEquatable<ThrowGiftFloor>, IDeepCloneable<ThrowGiftFloor>
{
	private static readonly MessageParser<ThrowGiftFloor> _parser = new MessageParser<ThrowGiftFloor>(() => new ThrowGiftFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SceneNameFieldNumber = 2;

	private string sceneName_ = "";

	public const int ConfigPrefabNameFieldNumber = 3;

	private string configPrefabName_ = "";

	public const int LevelScriptFieldNumber = 4;

	private string levelScript_ = "";

	public const int GiftNumFieldNumber = 5;

	private int giftNum_;

	public const int InitialGiftSortFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_initialGiftSort_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> initialGiftSort_ = new RepeatedField<int>();

	public const int GiftRandomFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_giftRandom_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> giftRandom_ = new RepeatedField<int>();

	public const int SpeedMinFieldNumber = 8;

	private int speedMin_;

	public const int SpeedMaxFieldNumber = 9;

	private int speedMax_;

	public const int AngelMinFieldNumber = 10;

	private int angelMin_;

	public const int GravityFieldNumber = 11;

	private int gravity_;

	public const int BGMFieldNumber = 12;

	private string bGM_ = "";

	public const int LeaveTriggerEventFieldNumber = 13;

	private string leaveTriggerEvent_ = "";

	public const int GuideLineFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_guideLine_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> guideLine_ = new RepeatedField<int>();

	public const int DictionaryIDFieldNumber = 15;

	private int dictionaryID_;

	[DebuggerNonUserCode]
	public static MessageParser<ThrowGiftFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(926);

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
	public string SceneName
	{
		get
		{
			return sceneName_;
		}
		set
		{
			sceneName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ConfigPrefabName
	{
		get
		{
			return configPrefabName_;
		}
		set
		{
			configPrefabName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LevelScript
	{
		get
		{
			return levelScript_;
		}
		set
		{
			levelScript_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GiftNum
	{
		get
		{
			return giftNum_;
		}
		set
		{
			giftNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> InitialGiftSort => initialGiftSort_;

	[DebuggerNonUserCode]
	public RepeatedField<int> GiftRandom => giftRandom_;

	[DebuggerNonUserCode]
	public int SpeedMin
	{
		get
		{
			return speedMin_;
		}
		set
		{
			speedMin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpeedMax
	{
		get
		{
			return speedMax_;
		}
		set
		{
			speedMax_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AngelMin
	{
		get
		{
			return angelMin_;
		}
		set
		{
			angelMin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Gravity
	{
		get
		{
			return gravity_;
		}
		set
		{
			gravity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BGM
	{
		get
		{
			return bGM_;
		}
		set
		{
			bGM_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LeaveTriggerEvent
	{
		get
		{
			return leaveTriggerEvent_;
		}
		set
		{
			leaveTriggerEvent_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> GuideLine => guideLine_;

	[DebuggerNonUserCode]
	public int DictionaryID
	{
		get
		{
			return dictionaryID_;
		}
		set
		{
			dictionaryID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ThrowGiftFloor()
	{
	}

	[DebuggerNonUserCode]
	public ThrowGiftFloor(ThrowGiftFloor other)
		: this()
	{
		id_ = other.id_;
		sceneName_ = other.sceneName_;
		configPrefabName_ = other.configPrefabName_;
		levelScript_ = other.levelScript_;
		giftNum_ = other.giftNum_;
		initialGiftSort_ = other.initialGiftSort_.Clone();
		giftRandom_ = other.giftRandom_.Clone();
		speedMin_ = other.speedMin_;
		speedMax_ = other.speedMax_;
		angelMin_ = other.angelMin_;
		gravity_ = other.gravity_;
		bGM_ = other.bGM_;
		leaveTriggerEvent_ = other.leaveTriggerEvent_;
		guideLine_ = other.guideLine_.Clone();
		dictionaryID_ = other.dictionaryID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ThrowGiftFloor Clone()
	{
		return new ThrowGiftFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrowGiftFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrowGiftFloor other)
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
		if (SceneName != other.SceneName)
		{
			return false;
		}
		if (ConfigPrefabName != other.ConfigPrefabName)
		{
			return false;
		}
		if (LevelScript != other.LevelScript)
		{
			return false;
		}
		if (GiftNum != other.GiftNum)
		{
			return false;
		}
		if (!initialGiftSort_.Equals(other.initialGiftSort_))
		{
			return false;
		}
		if (!giftRandom_.Equals(other.giftRandom_))
		{
			return false;
		}
		if (SpeedMin != other.SpeedMin)
		{
			return false;
		}
		if (SpeedMax != other.SpeedMax)
		{
			return false;
		}
		if (AngelMin != other.AngelMin)
		{
			return false;
		}
		if (Gravity != other.Gravity)
		{
			return false;
		}
		if (BGM != other.BGM)
		{
			return false;
		}
		if (LeaveTriggerEvent != other.LeaveTriggerEvent)
		{
			return false;
		}
		if (!guideLine_.Equals(other.guideLine_))
		{
			return false;
		}
		if (DictionaryID != other.DictionaryID)
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
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (ConfigPrefabName.Length != 0)
		{
			num ^= ConfigPrefabName.GetHashCode();
		}
		if (LevelScript.Length != 0)
		{
			num ^= LevelScript.GetHashCode();
		}
		if (GiftNum != 0)
		{
			num ^= GiftNum.GetHashCode();
		}
		num ^= initialGiftSort_.GetHashCode();
		num ^= giftRandom_.GetHashCode();
		if (SpeedMin != 0)
		{
			num ^= SpeedMin.GetHashCode();
		}
		if (SpeedMax != 0)
		{
			num ^= SpeedMax.GetHashCode();
		}
		if (AngelMin != 0)
		{
			num ^= AngelMin.GetHashCode();
		}
		if (Gravity != 0)
		{
			num ^= Gravity.GetHashCode();
		}
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num ^= LeaveTriggerEvent.GetHashCode();
		}
		num ^= guideLine_.GetHashCode();
		if (DictionaryID != 0)
		{
			num ^= DictionaryID.GetHashCode();
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
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ConfigPrefabName);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(LevelScript);
		}
		if (GiftNum != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(GiftNum);
		}
		initialGiftSort_.WriteTo(output, _repeated_initialGiftSort_codec);
		giftRandom_.WriteTo(output, _repeated_giftRandom_codec);
		if (SpeedMin != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SpeedMin);
		}
		if (SpeedMax != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(SpeedMax);
		}
		if (AngelMin != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(AngelMin);
		}
		if (Gravity != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Gravity);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(LeaveTriggerEvent);
		}
		guideLine_.WriteTo(output, _repeated_guideLine_codec);
		if (DictionaryID != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(DictionaryID);
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
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (ConfigPrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigPrefabName);
		}
		if (LevelScript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelScript);
		}
		if (GiftNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GiftNum);
		}
		num += initialGiftSort_.CalculateSize(_repeated_initialGiftSort_codec);
		num += giftRandom_.CalculateSize(_repeated_giftRandom_codec);
		if (SpeedMin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpeedMin);
		}
		if (SpeedMax != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpeedMax);
		}
		if (AngelMin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AngelMin);
		}
		if (Gravity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Gravity);
		}
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (LeaveTriggerEvent.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LeaveTriggerEvent);
		}
		num += guideLine_.CalculateSize(_repeated_guideLine_codec);
		if (DictionaryID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DictionaryID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrowGiftFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.ConfigPrefabName.Length != 0)
			{
				ConfigPrefabName = other.ConfigPrefabName;
			}
			if (other.LevelScript.Length != 0)
			{
				LevelScript = other.LevelScript;
			}
			if (other.GiftNum != 0)
			{
				GiftNum = other.GiftNum;
			}
			initialGiftSort_.Add(other.initialGiftSort_);
			giftRandom_.Add(other.giftRandom_);
			if (other.SpeedMin != 0)
			{
				SpeedMin = other.SpeedMin;
			}
			if (other.SpeedMax != 0)
			{
				SpeedMax = other.SpeedMax;
			}
			if (other.AngelMin != 0)
			{
				AngelMin = other.AngelMin;
			}
			if (other.Gravity != 0)
			{
				Gravity = other.Gravity;
			}
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			if (other.LeaveTriggerEvent.Length != 0)
			{
				LeaveTriggerEvent = other.LeaveTriggerEvent;
			}
			guideLine_.Add(other.guideLine_);
			if (other.DictionaryID != 0)
			{
				DictionaryID = other.DictionaryID;
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
				SceneName = input.ReadString();
				break;
			case 26u:
				ConfigPrefabName = input.ReadString();
				break;
			case 34u:
				LevelScript = input.ReadString();
				break;
			case 40u:
				GiftNum = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				initialGiftSort_.AddEntriesFrom(input, _repeated_initialGiftSort_codec);
				break;
			case 56u:
			case 58u:
				giftRandom_.AddEntriesFrom(input, _repeated_giftRandom_codec);
				break;
			case 64u:
				SpeedMin = input.ReadInt32();
				break;
			case 72u:
				SpeedMax = input.ReadInt32();
				break;
			case 80u:
				AngelMin = input.ReadInt32();
				break;
			case 88u:
				Gravity = input.ReadInt32();
				break;
			case 98u:
				BGM = input.ReadString();
				break;
			case 106u:
				LeaveTriggerEvent = input.ReadString();
				break;
			case 112u:
			case 114u:
				guideLine_.AddEntriesFrom(input, _repeated_guideLine_codec);
				break;
			case 120u:
				DictionaryID = input.ReadInt32();
				break;
			}
		}
	}
}
