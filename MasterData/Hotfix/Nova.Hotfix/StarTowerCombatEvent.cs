using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerCombatEvent : IMessage<StarTowerCombatEvent>, IMessage, IEquatable<StarTowerCombatEvent>, IDeepCloneable<StarTowerCombatEvent>
{
	private static readonly MessageParser<StarTowerCombatEvent> _parser = new MessageParser<StarTowerCombatEvent>(() => new StarTowerCombatEvent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int ParamsFieldNumber = 4;

	private string params_ = "";

	public const int ActiveFieldNumber = 5;

	private int active_;

	public const int StartFieldNumber = 6;

	private int start_;

	public const int InteractFieldNumber = 7;

	private int interact_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerCombatEvent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(834);

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
	public string Params
	{
		get
		{
			return params_;
		}
		set
		{
			params_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Active
	{
		get
		{
			return active_;
		}
		set
		{
			active_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Start
	{
		get
		{
			return start_;
		}
		set
		{
			start_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Interact
	{
		get
		{
			return interact_;
		}
		set
		{
			interact_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerCombatEvent()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerCombatEvent(StarTowerCombatEvent other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		type_ = other.type_;
		params_ = other.params_;
		active_ = other.active_;
		start_ = other.start_;
		interact_ = other.interact_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerCombatEvent Clone()
	{
		return new StarTowerCombatEvent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerCombatEvent);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerCombatEvent other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (Params != other.Params)
		{
			return false;
		}
		if (Active != other.Active)
		{
			return false;
		}
		if (Start != other.Start)
		{
			return false;
		}
		if (Interact != other.Interact)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Params.Length != 0)
		{
			num ^= Params.GetHashCode();
		}
		if (Active != 0)
		{
			num ^= Active.GetHashCode();
		}
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Interact != 0)
		{
			num ^= Interact.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (Params.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Params);
		}
		if (Active != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Active);
		}
		if (Start != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Start);
		}
		if (Interact != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Interact);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Params.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Params);
		}
		if (Active != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Active);
		}
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Interact != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Interact);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerCombatEvent other)
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
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Params.Length != 0)
			{
				Params = other.Params;
			}
			if (other.Active != 0)
			{
				Active = other.Active;
			}
			if (other.Start != 0)
			{
				Start = other.Start;
			}
			if (other.Interact != 0)
			{
				Interact = other.Interact;
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
				Type = input.ReadInt32();
				break;
			case 34u:
				Params = input.ReadString();
				break;
			case 40u:
				Active = input.ReadInt32();
				break;
			case 48u:
				Start = input.ReadInt32();
				break;
			case 56u:
				Interact = input.ReadInt32();
				break;
			}
		}
	}
}
