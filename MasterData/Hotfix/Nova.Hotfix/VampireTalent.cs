using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireTalent : IMessage<VampireTalent>, IMessage, IEquatable<VampireTalent>, IDeepCloneable<VampireTalent>
{
	private static readonly MessageParser<VampireTalent> _parser = new MessageParser<VampireTalent>(() => new VampireTalent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescTagFieldNumber = 3;

	private int descTag_;

	public const int ParamFieldNumber = 4;

	private int param_;

	public const int PrevFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_prev_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> prev_ = new RepeatedField<int>();

	public const int IsServerFieldNumber = 6;

	private bool isServer_;

	public const int IsClientFieldNumber = 7;

	private bool isClient_;

	public const int EffectFieldNumber = 8;

	private int effect_;

	public const int ParamsFieldNumber = 9;

	private string params_ = "";

	public const int PointFieldNumber = 10;

	private int point_;

	public const int IconFieldNumber = 11;

	private string icon_ = "";

	public const int EffectIdFieldNumber = 12;

	private int effectId_;

	[DebuggerNonUserCode]
	public static MessageParser<VampireTalent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1066);

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
	public int DescTag
	{
		get
		{
			return descTag_;
		}
		set
		{
			descTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param
	{
		get
		{
			return param_;
		}
		set
		{
			param_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Prev => prev_;

	[DebuggerNonUserCode]
	public bool IsServer
	{
		get
		{
			return isServer_;
		}
		set
		{
			isServer_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsClient
	{
		get
		{
			return isClient_;
		}
		set
		{
			isClient_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Effect
	{
		get
		{
			return effect_;
		}
		set
		{
			effect_ = value;
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
	public int Point
	{
		get
		{
			return point_;
		}
		set
		{
			point_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EffectId
	{
		get
		{
			return effectId_;
		}
		set
		{
			effectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VampireTalent()
	{
	}

	[DebuggerNonUserCode]
	public VampireTalent(VampireTalent other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		descTag_ = other.descTag_;
		param_ = other.param_;
		prev_ = other.prev_.Clone();
		isServer_ = other.isServer_;
		isClient_ = other.isClient_;
		effect_ = other.effect_;
		params_ = other.params_;
		point_ = other.point_;
		icon_ = other.icon_;
		effectId_ = other.effectId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireTalent Clone()
	{
		return new VampireTalent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireTalent);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireTalent other)
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
		if (DescTag != other.DescTag)
		{
			return false;
		}
		if (Param != other.Param)
		{
			return false;
		}
		if (!prev_.Equals(other.prev_))
		{
			return false;
		}
		if (IsServer != other.IsServer)
		{
			return false;
		}
		if (IsClient != other.IsClient)
		{
			return false;
		}
		if (Effect != other.Effect)
		{
			return false;
		}
		if (Params != other.Params)
		{
			return false;
		}
		if (Point != other.Point)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (EffectId != other.EffectId)
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
		if (DescTag != 0)
		{
			num ^= DescTag.GetHashCode();
		}
		if (Param != 0)
		{
			num ^= Param.GetHashCode();
		}
		num ^= prev_.GetHashCode();
		if (IsServer)
		{
			num ^= IsServer.GetHashCode();
		}
		if (IsClient)
		{
			num ^= IsClient.GetHashCode();
		}
		if (Effect != 0)
		{
			num ^= Effect.GetHashCode();
		}
		if (Params.Length != 0)
		{
			num ^= Params.GetHashCode();
		}
		if (Point != 0)
		{
			num ^= Point.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (EffectId != 0)
		{
			num ^= EffectId.GetHashCode();
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
		if (DescTag != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DescTag);
		}
		if (Param != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Param);
		}
		prev_.WriteTo(output, _repeated_prev_codec);
		if (IsServer)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsServer);
		}
		if (IsClient)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsClient);
		}
		if (Effect != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Effect);
		}
		if (Params.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Params);
		}
		if (Point != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Point);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Icon);
		}
		if (EffectId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(EffectId);
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
		if (DescTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DescTag);
		}
		if (Param != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param);
		}
		num += prev_.CalculateSize(_repeated_prev_codec);
		if (IsServer)
		{
			num += 2;
		}
		if (IsClient)
		{
			num += 2;
		}
		if (Effect != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect);
		}
		if (Params.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Params);
		}
		if (Point != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Point);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (EffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireTalent other)
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
			if (other.DescTag != 0)
			{
				DescTag = other.DescTag;
			}
			if (other.Param != 0)
			{
				Param = other.Param;
			}
			prev_.Add(other.prev_);
			if (other.IsServer)
			{
				IsServer = other.IsServer;
			}
			if (other.IsClient)
			{
				IsClient = other.IsClient;
			}
			if (other.Effect != 0)
			{
				Effect = other.Effect;
			}
			if (other.Params.Length != 0)
			{
				Params = other.Params;
			}
			if (other.Point != 0)
			{
				Point = other.Point;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.EffectId != 0)
			{
				EffectId = other.EffectId;
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
				DescTag = input.ReadInt32();
				break;
			case 32u:
				Param = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				prev_.AddEntriesFrom(input, _repeated_prev_codec);
				break;
			case 48u:
				IsServer = input.ReadBool();
				break;
			case 56u:
				IsClient = input.ReadBool();
				break;
			case 64u:
				Effect = input.ReadInt32();
				break;
			case 74u:
				Params = input.ReadString();
				break;
			case 80u:
				Point = input.ReadInt32();
				break;
			case 90u:
				Icon = input.ReadString();
				break;
			case 96u:
				EffectId = input.ReadInt32();
				break;
			}
		}
	}
}
