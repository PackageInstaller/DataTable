using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormRoom : IMessage<DormRoom>, IMessage, IEquatable<DormRoom>, IDeepCloneable<DormRoom>
{
	private static readonly MessageParser<DormRoom> _parser = new MessageParser<DormRoom>(() => new DormRoom());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RoomTypeFieldNumber = 2;

	private int roomType_;

	public const int RoomSizeTypeFieldNumber = 3;

	private int roomSizeType_;

	public const int SceneResFieldNumber = 4;

	private int sceneRes_;

	public const int DefaultNameFieldNumber = 5;

	private string defaultName_ = "";

	public const int DefaultLayoutIdFieldNumber = 6;

	private int defaultLayoutId_;

	public const int TransUIStyleFieldNumber = 7;

	private string transUIStyle_ = "";

	public const int BGMFieldNumber = 8;

	private string bGM_ = "";

	public const int DefaultCanUseFieldNumber = 9;

	private bool defaultCanUse_;

	public const int RoleNumFieldNumber = 10;

	private int roleNum_;

	public const int FloorRatioFieldNumber = 11;

	private int floorRatio_;

	[DebuggerNonUserCode]
	public static MessageParser<DormRoom> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(308);

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
	public int RoomType
	{
		get
		{
			return roomType_;
		}
		set
		{
			roomType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RoomSizeType
	{
		get
		{
			return roomSizeType_;
		}
		set
		{
			roomSizeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SceneRes
	{
		get
		{
			return sceneRes_;
		}
		set
		{
			sceneRes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DefaultName
	{
		get
		{
			return defaultName_;
		}
		set
		{
			defaultName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DefaultLayoutId
	{
		get
		{
			return defaultLayoutId_;
		}
		set
		{
			defaultLayoutId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TransUIStyle
	{
		get
		{
			return transUIStyle_;
		}
		set
		{
			transUIStyle_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public bool DefaultCanUse
	{
		get
		{
			return defaultCanUse_;
		}
		set
		{
			defaultCanUse_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RoleNum
	{
		get
		{
			return roleNum_;
		}
		set
		{
			roleNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorRatio
	{
		get
		{
			return floorRatio_;
		}
		set
		{
			floorRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DormRoom()
	{
	}

	[DebuggerNonUserCode]
	public DormRoom(DormRoom other)
		: this()
	{
		id_ = other.id_;
		roomType_ = other.roomType_;
		roomSizeType_ = other.roomSizeType_;
		sceneRes_ = other.sceneRes_;
		defaultName_ = other.defaultName_;
		defaultLayoutId_ = other.defaultLayoutId_;
		transUIStyle_ = other.transUIStyle_;
		bGM_ = other.bGM_;
		defaultCanUse_ = other.defaultCanUse_;
		roleNum_ = other.roleNum_;
		floorRatio_ = other.floorRatio_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormRoom Clone()
	{
		return new DormRoom(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormRoom);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormRoom other)
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
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (RoomSizeType != other.RoomSizeType)
		{
			return false;
		}
		if (SceneRes != other.SceneRes)
		{
			return false;
		}
		if (DefaultName != other.DefaultName)
		{
			return false;
		}
		if (DefaultLayoutId != other.DefaultLayoutId)
		{
			return false;
		}
		if (TransUIStyle != other.TransUIStyle)
		{
			return false;
		}
		if (BGM != other.BGM)
		{
			return false;
		}
		if (DefaultCanUse != other.DefaultCanUse)
		{
			return false;
		}
		if (RoleNum != other.RoleNum)
		{
			return false;
		}
		if (FloorRatio != other.FloorRatio)
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
		if (RoomType != 0)
		{
			num ^= RoomType.GetHashCode();
		}
		if (RoomSizeType != 0)
		{
			num ^= RoomSizeType.GetHashCode();
		}
		if (SceneRes != 0)
		{
			num ^= SceneRes.GetHashCode();
		}
		if (DefaultName.Length != 0)
		{
			num ^= DefaultName.GetHashCode();
		}
		if (DefaultLayoutId != 0)
		{
			num ^= DefaultLayoutId.GetHashCode();
		}
		if (TransUIStyle.Length != 0)
		{
			num ^= TransUIStyle.GetHashCode();
		}
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (DefaultCanUse)
		{
			num ^= DefaultCanUse.GetHashCode();
		}
		if (RoleNum != 0)
		{
			num ^= RoleNum.GetHashCode();
		}
		if (FloorRatio != 0)
		{
			num ^= FloorRatio.GetHashCode();
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
		if (RoomType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RoomType);
		}
		if (RoomSizeType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RoomSizeType);
		}
		if (SceneRes != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SceneRes);
		}
		if (DefaultName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DefaultName);
		}
		if (DefaultLayoutId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(DefaultLayoutId);
		}
		if (TransUIStyle.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(TransUIStyle);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BGM);
		}
		if (DefaultCanUse)
		{
			output.WriteRawTag(72);
			output.WriteBool(DefaultCanUse);
		}
		if (RoleNum != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(RoleNum);
		}
		if (FloorRatio != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(FloorRatio);
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
		if (RoomType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoomType);
		}
		if (RoomSizeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoomSizeType);
		}
		if (SceneRes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SceneRes);
		}
		if (DefaultName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DefaultName);
		}
		if (DefaultLayoutId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DefaultLayoutId);
		}
		if (TransUIStyle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TransUIStyle);
		}
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (DefaultCanUse)
		{
			num += 2;
		}
		if (RoleNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoleNum);
		}
		if (FloorRatio != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorRatio);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormRoom other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RoomType != 0)
			{
				RoomType = other.RoomType;
			}
			if (other.RoomSizeType != 0)
			{
				RoomSizeType = other.RoomSizeType;
			}
			if (other.SceneRes != 0)
			{
				SceneRes = other.SceneRes;
			}
			if (other.DefaultName.Length != 0)
			{
				DefaultName = other.DefaultName;
			}
			if (other.DefaultLayoutId != 0)
			{
				DefaultLayoutId = other.DefaultLayoutId;
			}
			if (other.TransUIStyle.Length != 0)
			{
				TransUIStyle = other.TransUIStyle;
			}
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			if (other.DefaultCanUse)
			{
				DefaultCanUse = other.DefaultCanUse;
			}
			if (other.RoleNum != 0)
			{
				RoleNum = other.RoleNum;
			}
			if (other.FloorRatio != 0)
			{
				FloorRatio = other.FloorRatio;
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
				RoomType = input.ReadInt32();
				break;
			case 24u:
				RoomSizeType = input.ReadInt32();
				break;
			case 32u:
				SceneRes = input.ReadInt32();
				break;
			case 42u:
				DefaultName = input.ReadString();
				break;
			case 48u:
				DefaultLayoutId = input.ReadInt32();
				break;
			case 58u:
				TransUIStyle = input.ReadString();
				break;
			case 66u:
				BGM = input.ReadString();
				break;
			case 72u:
				DefaultCanUse = input.ReadBool();
				break;
			case 80u:
				RoleNum = input.ReadInt32();
				break;
			case 88u:
				FloorRatio = input.ReadInt32();
				break;
			}
		}
	}
}
