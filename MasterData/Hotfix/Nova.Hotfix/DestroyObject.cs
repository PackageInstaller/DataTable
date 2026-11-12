using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DestroyObject : IMessage<DestroyObject>, IMessage, IEquatable<DestroyObject>, IDeepCloneable<DestroyObject>
{
	private static readonly MessageParser<DestroyObject> _parser = new MessageParser<DestroyObject>(() => new DestroyObject());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int LvFieldNumber = 3;

	private int lv_;

	public const int AttributeIdFieldNumber = 4;

	private string attributeId_ = "";

	public const int TempleteFieldNumber = 5;

	private int templete_;

	public const int FactionFieldNumber = 6;

	private int faction_;

	[DebuggerNonUserCode]
	public static MessageParser<DestroyObject> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(260);

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
	public int Lv
	{
		get
		{
			return lv_;
		}
		set
		{
			lv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AttributeId
	{
		get
		{
			return attributeId_;
		}
		set
		{
			attributeId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Templete
	{
		get
		{
			return templete_;
		}
		set
		{
			templete_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DestroyObject()
	{
	}

	[DebuggerNonUserCode]
	public DestroyObject(DestroyObject other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		lv_ = other.lv_;
		attributeId_ = other.attributeId_;
		templete_ = other.templete_;
		faction_ = other.faction_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DestroyObject Clone()
	{
		return new DestroyObject(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DestroyObject);
	}

	[DebuggerNonUserCode]
	public bool Equals(DestroyObject other)
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
		if (Lv != other.Lv)
		{
			return false;
		}
		if (AttributeId != other.AttributeId)
		{
			return false;
		}
		if (Templete != other.Templete)
		{
			return false;
		}
		if (Faction != other.Faction)
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
		if (Lv != 0)
		{
			num ^= Lv.GetHashCode();
		}
		if (AttributeId.Length != 0)
		{
			num ^= AttributeId.GetHashCode();
		}
		if (Templete != 0)
		{
			num ^= Templete.GetHashCode();
		}
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
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
		if (Lv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Lv);
		}
		if (AttributeId.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(AttributeId);
		}
		if (Templete != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Templete);
		}
		if (Faction != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Faction);
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
		if (Lv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lv);
		}
		if (AttributeId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AttributeId);
		}
		if (Templete != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Templete);
		}
		if (Faction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DestroyObject other)
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
			if (other.Lv != 0)
			{
				Lv = other.Lv;
			}
			if (other.AttributeId.Length != 0)
			{
				AttributeId = other.AttributeId;
			}
			if (other.Templete != 0)
			{
				Templete = other.Templete;
			}
			if (other.Faction != 0)
			{
				Faction = other.Faction;
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
				Lv = input.ReadInt32();
				break;
			case 34u:
				AttributeId = input.ReadString();
				break;
			case 40u:
				Templete = input.ReadInt32();
				break;
			case 48u:
				Faction = input.ReadInt32();
				break;
			}
		}
	}
}
