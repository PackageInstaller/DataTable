using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTower : IMessage<InfinityTower>, IMessage, IEquatable<InfinityTower>, IDeepCloneable<InfinityTower>
{
	private static readonly MessageParser<InfinityTower> _parser = new MessageParser<InfinityTower>(() => new InfinityTower());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int ElementTypeFieldNumber = 3;

	private int elementType_;

	public const int FormationSceneNameFieldNumber = 4;

	private string formationSceneName_ = "";

	public const int BgFieldNumber = 5;

	private string bg_ = "";

	public const int PreTowerLevelIdFieldNumber = 6;

	private int preTowerLevelId_;

	public const int OpenDayFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_openDay_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> openDay_ = new RepeatedField<int>();

	public const int OpenDayDescFieldNumber = 8;

	private string openDayDesc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTower> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(444);

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
	public int ElementType
	{
		get
		{
			return elementType_;
		}
		set
		{
			elementType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FormationSceneName
	{
		get
		{
			return formationSceneName_;
		}
		set
		{
			formationSceneName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Bg
	{
		get
		{
			return bg_;
		}
		set
		{
			bg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PreTowerLevelId
	{
		get
		{
			return preTowerLevelId_;
		}
		set
		{
			preTowerLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> OpenDay => openDay_;

	[DebuggerNonUserCode]
	public string OpenDayDesc
	{
		get
		{
			return openDayDesc_;
		}
		set
		{
			openDayDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public InfinityTower()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTower(InfinityTower other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		elementType_ = other.elementType_;
		formationSceneName_ = other.formationSceneName_;
		bg_ = other.bg_;
		preTowerLevelId_ = other.preTowerLevelId_;
		openDay_ = other.openDay_.Clone();
		openDayDesc_ = other.openDayDesc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTower Clone()
	{
		return new InfinityTower(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTower);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTower other)
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
		if (ElementType != other.ElementType)
		{
			return false;
		}
		if (FormationSceneName != other.FormationSceneName)
		{
			return false;
		}
		if (Bg != other.Bg)
		{
			return false;
		}
		if (PreTowerLevelId != other.PreTowerLevelId)
		{
			return false;
		}
		if (!openDay_.Equals(other.openDay_))
		{
			return false;
		}
		if (OpenDayDesc != other.OpenDayDesc)
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
		if (ElementType != 0)
		{
			num ^= ElementType.GetHashCode();
		}
		if (FormationSceneName.Length != 0)
		{
			num ^= FormationSceneName.GetHashCode();
		}
		if (Bg.Length != 0)
		{
			num ^= Bg.GetHashCode();
		}
		if (PreTowerLevelId != 0)
		{
			num ^= PreTowerLevelId.GetHashCode();
		}
		num ^= openDay_.GetHashCode();
		if (OpenDayDesc.Length != 0)
		{
			num ^= OpenDayDesc.GetHashCode();
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
		if (ElementType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ElementType);
		}
		if (FormationSceneName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(FormationSceneName);
		}
		if (Bg.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Bg);
		}
		if (PreTowerLevelId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PreTowerLevelId);
		}
		openDay_.WriteTo(output, _repeated_openDay_codec);
		if (OpenDayDesc.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(OpenDayDesc);
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
		if (ElementType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementType);
		}
		if (FormationSceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FormationSceneName);
		}
		if (Bg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Bg);
		}
		if (PreTowerLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreTowerLevelId);
		}
		num += openDay_.CalculateSize(_repeated_openDay_codec);
		if (OpenDayDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenDayDesc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTower other)
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
			if (other.ElementType != 0)
			{
				ElementType = other.ElementType;
			}
			if (other.FormationSceneName.Length != 0)
			{
				FormationSceneName = other.FormationSceneName;
			}
			if (other.Bg.Length != 0)
			{
				Bg = other.Bg;
			}
			if (other.PreTowerLevelId != 0)
			{
				PreTowerLevelId = other.PreTowerLevelId;
			}
			openDay_.Add(other.openDay_);
			if (other.OpenDayDesc.Length != 0)
			{
				OpenDayDesc = other.OpenDayDesc;
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
				ElementType = input.ReadInt32();
				break;
			case 34u:
				FormationSceneName = input.ReadString();
				break;
			case 42u:
				Bg = input.ReadString();
				break;
			case 48u:
				PreTowerLevelId = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				openDay_.AddEntriesFrom(input, _repeated_openDay_codec);
				break;
			case 66u:
				OpenDayDesc = input.ReadString();
				break;
			}
		}
	}
}
