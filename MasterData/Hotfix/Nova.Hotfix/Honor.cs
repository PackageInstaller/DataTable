using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Honor : IMessage<Honor>, IMessage, IEquatable<Honor>, IDeepCloneable<Honor>
{
	private static readonly MessageParser<Honor> _parser = new MessageParser<Honor>(() => new Honor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int IsUnlockFieldNumber = 3;

	private bool isUnlock_;

	public const int TypeFieldNumber = 4;

	private int type_;

	public const int TabTypeFieldNumber = 5;

	private int tabType_;

	public const int ParamsFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_params_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> params_ = new RepeatedField<int>();

	public const int PriotityFieldNumber = 7;

	private int priotity_;

	public const int MainResFieldNumber = 8;

	private string mainRes_ = "";

	public const int SubResFieldNumber = 9;

	private string subRes_ = "";

	public const int SortFieldNumber = 10;

	private int sort_;

	public const int BGTypeFieldNumber = 11;

	private int bGType_;

	[DebuggerNonUserCode]
	public static MessageParser<Honor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(424);

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
	public bool IsUnlock
	{
		get
		{
			return isUnlock_;
		}
		set
		{
			isUnlock_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TabType
	{
		get
		{
			return tabType_;
		}
		set
		{
			tabType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Params => params_;

	[DebuggerNonUserCode]
	public int Priotity
	{
		get
		{
			return priotity_;
		}
		set
		{
			priotity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string MainRes
	{
		get
		{
			return mainRes_;
		}
		set
		{
			mainRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SubRes
	{
		get
		{
			return subRes_;
		}
		set
		{
			subRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BGType
	{
		get
		{
			return bGType_;
		}
		set
		{
			bGType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Honor()
	{
	}

	[DebuggerNonUserCode]
	public Honor(Honor other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		isUnlock_ = other.isUnlock_;
		type_ = other.type_;
		tabType_ = other.tabType_;
		params_ = other.params_.Clone();
		priotity_ = other.priotity_;
		mainRes_ = other.mainRes_;
		subRes_ = other.subRes_;
		sort_ = other.sort_;
		bGType_ = other.bGType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Honor Clone()
	{
		return new Honor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Honor);
	}

	[DebuggerNonUserCode]
	public bool Equals(Honor other)
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
		if (IsUnlock != other.IsUnlock)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (TabType != other.TabType)
		{
			return false;
		}
		if (!params_.Equals(other.params_))
		{
			return false;
		}
		if (Priotity != other.Priotity)
		{
			return false;
		}
		if (MainRes != other.MainRes)
		{
			return false;
		}
		if (SubRes != other.SubRes)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (BGType != other.BGType)
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
		if (IsUnlock)
		{
			num ^= IsUnlock.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (TabType != 0)
		{
			num ^= TabType.GetHashCode();
		}
		num ^= params_.GetHashCode();
		if (Priotity != 0)
		{
			num ^= Priotity.GetHashCode();
		}
		if (MainRes.Length != 0)
		{
			num ^= MainRes.GetHashCode();
		}
		if (SubRes.Length != 0)
		{
			num ^= SubRes.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (BGType != 0)
		{
			num ^= BGType.GetHashCode();
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
		if (IsUnlock)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsUnlock);
		}
		if (Type != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type);
		}
		if (TabType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TabType);
		}
		params_.WriteTo(output, _repeated_params_codec);
		if (Priotity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Priotity);
		}
		if (MainRes.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(MainRes);
		}
		if (SubRes.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(SubRes);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Sort);
		}
		if (BGType != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(BGType);
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
		if (IsUnlock)
		{
			num += 2;
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (TabType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TabType);
		}
		num += params_.CalculateSize(_repeated_params_codec);
		if (Priotity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priotity);
		}
		if (MainRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MainRes);
		}
		if (SubRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SubRes);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (BGType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BGType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Honor other)
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
			if (other.IsUnlock)
			{
				IsUnlock = other.IsUnlock;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.TabType != 0)
			{
				TabType = other.TabType;
			}
			params_.Add(other.params_);
			if (other.Priotity != 0)
			{
				Priotity = other.Priotity;
			}
			if (other.MainRes.Length != 0)
			{
				MainRes = other.MainRes;
			}
			if (other.SubRes.Length != 0)
			{
				SubRes = other.SubRes;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.BGType != 0)
			{
				BGType = other.BGType;
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
				IsUnlock = input.ReadBool();
				break;
			case 32u:
				Type = input.ReadInt32();
				break;
			case 40u:
				TabType = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				params_.AddEntriesFrom(input, _repeated_params_codec);
				break;
			case 56u:
				Priotity = input.ReadInt32();
				break;
			case 66u:
				MainRes = input.ReadString();
				break;
			case 74u:
				SubRes = input.ReadString();
				break;
			case 80u:
				Sort = input.ReadInt32();
				break;
			case 88u:
				BGType = input.ReadInt32();
				break;
			}
		}
	}
}
