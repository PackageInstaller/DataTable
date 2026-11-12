using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GuideGroup : IMessage<GuideGroup>, IMessage, IEquatable<GuideGroup>, IDeepCloneable<GuideGroup>
{
	private static readonly MessageParser<GuideGroup> _parser = new MessageParser<GuideGroup>(() => new GuideGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GuideDetectionTypeFieldNumber = 2;

	private int guideDetectionType_;

	public const int PassiveMsgFieldNumber = 3;

	private string passiveMsg_ = "";

	public const int GuidePreposeFieldNumber = 4;

	private int guidePrepose_;

	public const int PreposeParamsFieldNumber = 5;

	private string preposeParams_ = "";

	public const int GuidePrepose2FieldNumber = 6;

	private int guidePrepose2_;

	public const int PreposeParams2FieldNumber = 7;

	private string preposeParams2_ = "";

	public const int GuidePostFieldNumber = 8;

	private int guidePost_;

	public const int PostParamsFieldNumber = 9;

	private string postParams_ = "";

	public const int GuideTriggerFieldNumber = 10;

	private int guideTrigger_;

	public const int TriggerParamsFieldNumber = 11;

	private string triggerParams_ = "";

	public const int TowerStateFieldNumber = 12;

	private bool towerState_;

	public const int ScriptPathFieldNumber = 13;

	private string scriptPath_ = "";

	public const int IsActiveFieldNumber = 14;

	private bool isActive_;

	[DebuggerNonUserCode]
	public static MessageParser<GuideGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(412);

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
	public int GuideDetectionType
	{
		get
		{
			return guideDetectionType_;
		}
		set
		{
			guideDetectionType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PassiveMsg
	{
		get
		{
			return passiveMsg_;
		}
		set
		{
			passiveMsg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GuidePrepose
	{
		get
		{
			return guidePrepose_;
		}
		set
		{
			guidePrepose_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PreposeParams
	{
		get
		{
			return preposeParams_;
		}
		set
		{
			preposeParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GuidePrepose2
	{
		get
		{
			return guidePrepose2_;
		}
		set
		{
			guidePrepose2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PreposeParams2
	{
		get
		{
			return preposeParams2_;
		}
		set
		{
			preposeParams2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GuidePost
	{
		get
		{
			return guidePost_;
		}
		set
		{
			guidePost_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PostParams
	{
		get
		{
			return postParams_;
		}
		set
		{
			postParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GuideTrigger
	{
		get
		{
			return guideTrigger_;
		}
		set
		{
			guideTrigger_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParams
	{
		get
		{
			return triggerParams_;
		}
		set
		{
			triggerParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool TowerState
	{
		get
		{
			return towerState_;
		}
		set
		{
			towerState_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ScriptPath
	{
		get
		{
			return scriptPath_;
		}
		set
		{
			scriptPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsActive
	{
		get
		{
			return isActive_;
		}
		set
		{
			isActive_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GuideGroup()
	{
	}

	[DebuggerNonUserCode]
	public GuideGroup(GuideGroup other)
		: this()
	{
		id_ = other.id_;
		guideDetectionType_ = other.guideDetectionType_;
		passiveMsg_ = other.passiveMsg_;
		guidePrepose_ = other.guidePrepose_;
		preposeParams_ = other.preposeParams_;
		guidePrepose2_ = other.guidePrepose2_;
		preposeParams2_ = other.preposeParams2_;
		guidePost_ = other.guidePost_;
		postParams_ = other.postParams_;
		guideTrigger_ = other.guideTrigger_;
		triggerParams_ = other.triggerParams_;
		towerState_ = other.towerState_;
		scriptPath_ = other.scriptPath_;
		isActive_ = other.isActive_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GuideGroup Clone()
	{
		return new GuideGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GuideGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(GuideGroup other)
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
		if (GuideDetectionType != other.GuideDetectionType)
		{
			return false;
		}
		if (PassiveMsg != other.PassiveMsg)
		{
			return false;
		}
		if (GuidePrepose != other.GuidePrepose)
		{
			return false;
		}
		if (PreposeParams != other.PreposeParams)
		{
			return false;
		}
		if (GuidePrepose2 != other.GuidePrepose2)
		{
			return false;
		}
		if (PreposeParams2 != other.PreposeParams2)
		{
			return false;
		}
		if (GuidePost != other.GuidePost)
		{
			return false;
		}
		if (PostParams != other.PostParams)
		{
			return false;
		}
		if (GuideTrigger != other.GuideTrigger)
		{
			return false;
		}
		if (TriggerParams != other.TriggerParams)
		{
			return false;
		}
		if (TowerState != other.TowerState)
		{
			return false;
		}
		if (ScriptPath != other.ScriptPath)
		{
			return false;
		}
		if (IsActive != other.IsActive)
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
		if (GuideDetectionType != 0)
		{
			num ^= GuideDetectionType.GetHashCode();
		}
		if (PassiveMsg.Length != 0)
		{
			num ^= PassiveMsg.GetHashCode();
		}
		if (GuidePrepose != 0)
		{
			num ^= GuidePrepose.GetHashCode();
		}
		if (PreposeParams.Length != 0)
		{
			num ^= PreposeParams.GetHashCode();
		}
		if (GuidePrepose2 != 0)
		{
			num ^= GuidePrepose2.GetHashCode();
		}
		if (PreposeParams2.Length != 0)
		{
			num ^= PreposeParams2.GetHashCode();
		}
		if (GuidePost != 0)
		{
			num ^= GuidePost.GetHashCode();
		}
		if (PostParams.Length != 0)
		{
			num ^= PostParams.GetHashCode();
		}
		if (GuideTrigger != 0)
		{
			num ^= GuideTrigger.GetHashCode();
		}
		if (TriggerParams.Length != 0)
		{
			num ^= TriggerParams.GetHashCode();
		}
		if (TowerState)
		{
			num ^= TowerState.GetHashCode();
		}
		if (ScriptPath.Length != 0)
		{
			num ^= ScriptPath.GetHashCode();
		}
		if (IsActive)
		{
			num ^= IsActive.GetHashCode();
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
		if (GuideDetectionType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GuideDetectionType);
		}
		if (PassiveMsg.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(PassiveMsg);
		}
		if (GuidePrepose != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GuidePrepose);
		}
		if (PreposeParams.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(PreposeParams);
		}
		if (GuidePrepose2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(GuidePrepose2);
		}
		if (PreposeParams2.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(PreposeParams2);
		}
		if (GuidePost != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(GuidePost);
		}
		if (PostParams.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(PostParams);
		}
		if (GuideTrigger != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(GuideTrigger);
		}
		if (TriggerParams.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(TriggerParams);
		}
		if (TowerState)
		{
			output.WriteRawTag(96);
			output.WriteBool(TowerState);
		}
		if (ScriptPath.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(ScriptPath);
		}
		if (IsActive)
		{
			output.WriteRawTag(112);
			output.WriteBool(IsActive);
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
		if (GuideDetectionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuideDetectionType);
		}
		if (PassiveMsg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PassiveMsg);
		}
		if (GuidePrepose != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuidePrepose);
		}
		if (PreposeParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PreposeParams);
		}
		if (GuidePrepose2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuidePrepose2);
		}
		if (PreposeParams2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PreposeParams2);
		}
		if (GuidePost != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuidePost);
		}
		if (PostParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PostParams);
		}
		if (GuideTrigger != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuideTrigger);
		}
		if (TriggerParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParams);
		}
		if (TowerState)
		{
			num += 2;
		}
		if (ScriptPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ScriptPath);
		}
		if (IsActive)
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
	public void MergeFrom(GuideGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GuideDetectionType != 0)
			{
				GuideDetectionType = other.GuideDetectionType;
			}
			if (other.PassiveMsg.Length != 0)
			{
				PassiveMsg = other.PassiveMsg;
			}
			if (other.GuidePrepose != 0)
			{
				GuidePrepose = other.GuidePrepose;
			}
			if (other.PreposeParams.Length != 0)
			{
				PreposeParams = other.PreposeParams;
			}
			if (other.GuidePrepose2 != 0)
			{
				GuidePrepose2 = other.GuidePrepose2;
			}
			if (other.PreposeParams2.Length != 0)
			{
				PreposeParams2 = other.PreposeParams2;
			}
			if (other.GuidePost != 0)
			{
				GuidePost = other.GuidePost;
			}
			if (other.PostParams.Length != 0)
			{
				PostParams = other.PostParams;
			}
			if (other.GuideTrigger != 0)
			{
				GuideTrigger = other.GuideTrigger;
			}
			if (other.TriggerParams.Length != 0)
			{
				TriggerParams = other.TriggerParams;
			}
			if (other.TowerState)
			{
				TowerState = other.TowerState;
			}
			if (other.ScriptPath.Length != 0)
			{
				ScriptPath = other.ScriptPath;
			}
			if (other.IsActive)
			{
				IsActive = other.IsActive;
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
				GuideDetectionType = input.ReadInt32();
				break;
			case 26u:
				PassiveMsg = input.ReadString();
				break;
			case 32u:
				GuidePrepose = input.ReadInt32();
				break;
			case 42u:
				PreposeParams = input.ReadString();
				break;
			case 48u:
				GuidePrepose2 = input.ReadInt32();
				break;
			case 58u:
				PreposeParams2 = input.ReadString();
				break;
			case 64u:
				GuidePost = input.ReadInt32();
				break;
			case 74u:
				PostParams = input.ReadString();
				break;
			case 80u:
				GuideTrigger = input.ReadInt32();
				break;
			case 90u:
				TriggerParams = input.ReadString();
				break;
			case 96u:
				TowerState = input.ReadBool();
				break;
			case 106u:
				ScriptPath = input.ReadString();
				break;
			case 112u:
				IsActive = input.ReadBool();
				break;
			}
		}
	}
}
