using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourObject : IMessage<MathParkourObject>, IMessage, IEquatable<MathParkourObject>, IDeepCloneable<MathParkourObject>
{
	private static readonly MessageParser<MathParkourObject> _parser = new MessageParser<MathParkourObject>(() => new MathParkourObject());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int ObjTypeFieldNumber = 3;

	private int objType_;

	public const int AssetPathFieldNumber = 4;

	private string assetPath_ = "";

	public const int HudOffsetFieldNumber = 5;

	private float hudOffset_;

	public const int Param1FieldNumber = 6;

	private string param1_ = "";

	public const int Param2FieldNumber = 7;

	private string param2_ = "";

	public const int Param3FieldNumber = 8;

	private string param3_ = "";

	public const int Param4FieldNumber = 9;

	private string param4_ = "";

	public const int Param5FieldNumber = 10;

	private string param5_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourObject> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(544);

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
	public int ObjType
	{
		get
		{
			return objType_;
		}
		set
		{
			objType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AssetPath
	{
		get
		{
			return assetPath_;
		}
		set
		{
			assetPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public float HudOffset
	{
		get
		{
			return hudOffset_;
		}
		set
		{
			hudOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MathParkourObject()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourObject(MathParkourObject other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		objType_ = other.objType_;
		assetPath_ = other.assetPath_;
		hudOffset_ = other.hudOffset_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourObject Clone()
	{
		return new MathParkourObject(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourObject);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourObject other)
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
		if (ObjType != other.ObjType)
		{
			return false;
		}
		if (AssetPath != other.AssetPath)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(HudOffset, other.HudOffset))
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
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
		if (ObjType != 0)
		{
			num ^= ObjType.GetHashCode();
		}
		if (AssetPath.Length != 0)
		{
			num ^= AssetPath.GetHashCode();
		}
		if (HudOffset != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(HudOffset);
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
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
		if (ObjType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ObjType);
		}
		if (AssetPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(AssetPath);
		}
		if (HudOffset != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(HudOffset);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param5);
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
		if (ObjType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ObjType);
		}
		if (AssetPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AssetPath);
		}
		if (HudOffset != 0f)
		{
			num += 5;
		}
		if (Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourObject other)
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
			if (other.ObjType != 0)
			{
				ObjType = other.ObjType;
			}
			if (other.AssetPath.Length != 0)
			{
				AssetPath = other.AssetPath;
			}
			if (other.HudOffset != 0f)
			{
				HudOffset = other.HudOffset;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
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
				ObjType = input.ReadInt32();
				break;
			case 34u:
				AssetPath = input.ReadString();
				break;
			case 45u:
				HudOffset = input.ReadFloat();
				break;
			case 50u:
				Param1 = input.ReadString();
				break;
			case 58u:
				Param2 = input.ReadString();
				break;
			case 66u:
				Param3 = input.ReadString();
				break;
			case 74u:
				Param4 = input.ReadString();
				break;
			case 82u:
				Param5 = input.ReadString();
				break;
			}
		}
	}
}
