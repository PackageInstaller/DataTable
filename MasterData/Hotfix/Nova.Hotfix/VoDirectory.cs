using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VoDirectory : IMessage<VoDirectory>, IMessage, IEquatable<VoDirectory>, IDeepCloneable<VoDirectory>
{
	private static readonly MessageParser<VoDirectory> _parser = new MessageParser<VoDirectory>(() => new VoDirectory());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int VoResourceFieldNumber = 2;

	private string voResource_ = "";

	public const int CharacterIdFieldNumber = 3;

	private int characterId_;

	public const int VotypeFieldNumber = 4;

	private string votype_ = "";

	public const int SkinIdFieldNumber = 5;

	private int skinId_;

	[DebuggerNonUserCode]
	public static MessageParser<VoDirectory> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1072);

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
	public string VoResource
	{
		get
		{
			return voResource_;
		}
		set
		{
			voResource_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CharacterId
	{
		get
		{
			return characterId_;
		}
		set
		{
			characterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Votype
	{
		get
		{
			return votype_;
		}
		set
		{
			votype_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VoDirectory()
	{
	}

	[DebuggerNonUserCode]
	public VoDirectory(VoDirectory other)
		: this()
	{
		id_ = other.id_;
		voResource_ = other.voResource_;
		characterId_ = other.characterId_;
		votype_ = other.votype_;
		skinId_ = other.skinId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VoDirectory Clone()
	{
		return new VoDirectory(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VoDirectory);
	}

	[DebuggerNonUserCode]
	public bool Equals(VoDirectory other)
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
		if (VoResource != other.VoResource)
		{
			return false;
		}
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (Votype != other.Votype)
		{
			return false;
		}
		if (SkinId != other.SkinId)
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
		if (VoResource.Length != 0)
		{
			num ^= VoResource.GetHashCode();
		}
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		if (Votype.Length != 0)
		{
			num ^= Votype.GetHashCode();
		}
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
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
		if (VoResource.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(VoResource);
		}
		if (CharacterId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharacterId);
		}
		if (Votype.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Votype);
		}
		if (SkinId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SkinId);
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
		if (VoResource.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoResource);
		}
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		if (Votype.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Votype);
		}
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VoDirectory other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.VoResource.Length != 0)
			{
				VoResource = other.VoResource;
			}
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.Votype.Length != 0)
			{
				Votype = other.Votype;
			}
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
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
				VoResource = input.ReadString();
				break;
			case 24u:
				CharacterId = input.ReadInt32();
				break;
			case 34u:
				Votype = input.ReadString();
				break;
			case 40u:
				SkinId = input.ReadInt32();
				break;
			}
		}
	}
}
