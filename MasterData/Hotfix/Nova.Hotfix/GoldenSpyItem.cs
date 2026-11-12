using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyItem : IMessage<GoldenSpyItem>, IMessage, IEquatable<GoldenSpyItem>, IDeepCloneable<GoldenSpyItem>
{
	private static readonly MessageParser<GoldenSpyItem> _parser = new MessageParser<GoldenSpyItem>(() => new GoldenSpyItem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int ItemTypeFieldNumber = 3;

	private int itemType_;

	public const int WeightFieldNumber = 4;

	private int weight_;

	public const int ScoreFieldNumber = 5;

	private int score_;

	public const int IconPathFieldNumber = 6;

	private string iconPath_ = "";

	public const int PrefabNameFieldNumber = 7;

	private string prefabName_ = "";

	public const int LuaCtrlFieldNumber = 8;

	private string luaCtrl_ = "";

	public const int ParamsFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_params_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> params_ = new RepeatedField<int>();

	public const int ShowValueFieldNumber = 10;

	private bool showValue_;

	public const int IsTaskFieldNumber = 11;

	private bool isTask_;

	public const int NeedShowFlashFieldNumber = 12;

	private bool needShowFlash_;

	public const int IsBigFieldNumber = 13;

	private bool isBig_;

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyItem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(400);

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
	public int ItemType
	{
		get
		{
			return itemType_;
		}
		set
		{
			itemType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Score
	{
		get
		{
			return score_;
		}
		set
		{
			score_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string IconPath
	{
		get
		{
			return iconPath_;
		}
		set
		{
			iconPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PrefabName
	{
		get
		{
			return prefabName_;
		}
		set
		{
			prefabName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LuaCtrl
	{
		get
		{
			return luaCtrl_;
		}
		set
		{
			luaCtrl_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Params => params_;

	[DebuggerNonUserCode]
	public bool ShowValue
	{
		get
		{
			return showValue_;
		}
		set
		{
			showValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsTask
	{
		get
		{
			return isTask_;
		}
		set
		{
			isTask_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NeedShowFlash
	{
		get
		{
			return needShowFlash_;
		}
		set
		{
			needShowFlash_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsBig
	{
		get
		{
			return isBig_;
		}
		set
		{
			isBig_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GoldenSpyItem()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyItem(GoldenSpyItem other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		itemType_ = other.itemType_;
		weight_ = other.weight_;
		score_ = other.score_;
		iconPath_ = other.iconPath_;
		prefabName_ = other.prefabName_;
		luaCtrl_ = other.luaCtrl_;
		params_ = other.params_.Clone();
		showValue_ = other.showValue_;
		isTask_ = other.isTask_;
		needShowFlash_ = other.needShowFlash_;
		isBig_ = other.isBig_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyItem Clone()
	{
		return new GoldenSpyItem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyItem);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyItem other)
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
		if (ItemType != other.ItemType)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (Score != other.Score)
		{
			return false;
		}
		if (IconPath != other.IconPath)
		{
			return false;
		}
		if (PrefabName != other.PrefabName)
		{
			return false;
		}
		if (LuaCtrl != other.LuaCtrl)
		{
			return false;
		}
		if (!params_.Equals(other.params_))
		{
			return false;
		}
		if (ShowValue != other.ShowValue)
		{
			return false;
		}
		if (IsTask != other.IsTask)
		{
			return false;
		}
		if (NeedShowFlash != other.NeedShowFlash)
		{
			return false;
		}
		if (IsBig != other.IsBig)
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
		if (ItemType != 0)
		{
			num ^= ItemType.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (Score != 0)
		{
			num ^= Score.GetHashCode();
		}
		if (IconPath.Length != 0)
		{
			num ^= IconPath.GetHashCode();
		}
		if (PrefabName.Length != 0)
		{
			num ^= PrefabName.GetHashCode();
		}
		if (LuaCtrl.Length != 0)
		{
			num ^= LuaCtrl.GetHashCode();
		}
		num ^= params_.GetHashCode();
		if (ShowValue)
		{
			num ^= ShowValue.GetHashCode();
		}
		if (IsTask)
		{
			num ^= IsTask.GetHashCode();
		}
		if (NeedShowFlash)
		{
			num ^= NeedShowFlash.GetHashCode();
		}
		if (IsBig)
		{
			num ^= IsBig.GetHashCode();
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
		if (ItemType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ItemType);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Weight);
		}
		if (Score != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Score);
		}
		if (IconPath.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(IconPath);
		}
		if (PrefabName.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(PrefabName);
		}
		if (LuaCtrl.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(LuaCtrl);
		}
		params_.WriteTo(output, _repeated_params_codec);
		if (ShowValue)
		{
			output.WriteRawTag(80);
			output.WriteBool(ShowValue);
		}
		if (IsTask)
		{
			output.WriteRawTag(88);
			output.WriteBool(IsTask);
		}
		if (NeedShowFlash)
		{
			output.WriteRawTag(96);
			output.WriteBool(NeedShowFlash);
		}
		if (IsBig)
		{
			output.WriteRawTag(104);
			output.WriteBool(IsBig);
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
		if (ItemType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemType);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (Score != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Score);
		}
		if (IconPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconPath);
		}
		if (PrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PrefabName);
		}
		if (LuaCtrl.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LuaCtrl);
		}
		num += params_.CalculateSize(_repeated_params_codec);
		if (ShowValue)
		{
			num += 2;
		}
		if (IsTask)
		{
			num += 2;
		}
		if (NeedShowFlash)
		{
			num += 2;
		}
		if (IsBig)
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
	public void MergeFrom(GoldenSpyItem other)
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
			if (other.ItemType != 0)
			{
				ItemType = other.ItemType;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.Score != 0)
			{
				Score = other.Score;
			}
			if (other.IconPath.Length != 0)
			{
				IconPath = other.IconPath;
			}
			if (other.PrefabName.Length != 0)
			{
				PrefabName = other.PrefabName;
			}
			if (other.LuaCtrl.Length != 0)
			{
				LuaCtrl = other.LuaCtrl;
			}
			params_.Add(other.params_);
			if (other.ShowValue)
			{
				ShowValue = other.ShowValue;
			}
			if (other.IsTask)
			{
				IsTask = other.IsTask;
			}
			if (other.NeedShowFlash)
			{
				NeedShowFlash = other.NeedShowFlash;
			}
			if (other.IsBig)
			{
				IsBig = other.IsBig;
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
				ItemType = input.ReadInt32();
				break;
			case 32u:
				Weight = input.ReadInt32();
				break;
			case 40u:
				Score = input.ReadInt32();
				break;
			case 50u:
				IconPath = input.ReadString();
				break;
			case 58u:
				PrefabName = input.ReadString();
				break;
			case 66u:
				LuaCtrl = input.ReadString();
				break;
			case 72u:
			case 74u:
				params_.AddEntriesFrom(input, _repeated_params_codec);
				break;
			case 80u:
				ShowValue = input.ReadBool();
				break;
			case 88u:
				IsTask = input.ReadBool();
				break;
			case 96u:
				NeedShowFlash = input.ReadBool();
				break;
			case 104u:
				IsBig = input.ReadBool();
				break;
			}
		}
	}
}
