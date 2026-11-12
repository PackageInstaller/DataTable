using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerNPC : IMessage<StarTowerNPC>, IMessage, IEquatable<StarTowerNPC>, IDeepCloneable<StarTowerNPC>
{
	private static readonly MessageParser<StarTowerNPC> _parser = new MessageParser<StarTowerNPC>(() => new StarTowerNPC());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int AffinityGroupIdFieldNumber = 3;

	private int affinityGroupId_;

	public const int NPCDescFieldNumber = 4;

	private string nPCDesc_ = "";

	public const int HeadFieldNumber = 5;

	private string head_ = "";

	public const int ImageFieldNumber = 6;

	private string image_ = "";

	public const int NPCSkinFieldNumber = 7;

	private int nPCSkin_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerNPC> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(868);

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
	public int AffinityGroupId
	{
		get
		{
			return affinityGroupId_;
		}
		set
		{
			affinityGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string NPCDesc
	{
		get
		{
			return nPCDesc_;
		}
		set
		{
			nPCDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Head
	{
		get
		{
			return head_;
		}
		set
		{
			head_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Image
	{
		get
		{
			return image_;
		}
		set
		{
			image_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int NPCSkin
	{
		get
		{
			return nPCSkin_;
		}
		set
		{
			nPCSkin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerNPC()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerNPC(StarTowerNPC other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		affinityGroupId_ = other.affinityGroupId_;
		nPCDesc_ = other.nPCDesc_;
		head_ = other.head_;
		image_ = other.image_;
		nPCSkin_ = other.nPCSkin_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerNPC Clone()
	{
		return new StarTowerNPC(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerNPC);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerNPC other)
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
		if (AffinityGroupId != other.AffinityGroupId)
		{
			return false;
		}
		if (NPCDesc != other.NPCDesc)
		{
			return false;
		}
		if (Head != other.Head)
		{
			return false;
		}
		if (Image != other.Image)
		{
			return false;
		}
		if (NPCSkin != other.NPCSkin)
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
		if (AffinityGroupId != 0)
		{
			num ^= AffinityGroupId.GetHashCode();
		}
		if (NPCDesc.Length != 0)
		{
			num ^= NPCDesc.GetHashCode();
		}
		if (Head.Length != 0)
		{
			num ^= Head.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (NPCSkin != 0)
		{
			num ^= NPCSkin.GetHashCode();
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
		if (AffinityGroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AffinityGroupId);
		}
		if (NPCDesc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(NPCDesc);
		}
		if (Head.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Head);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Image);
		}
		if (NPCSkin != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(NPCSkin);
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
		if (AffinityGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityGroupId);
		}
		if (NPCDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(NPCDesc);
		}
		if (Head.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Head);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (NPCSkin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NPCSkin);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerNPC other)
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
			if (other.AffinityGroupId != 0)
			{
				AffinityGroupId = other.AffinityGroupId;
			}
			if (other.NPCDesc.Length != 0)
			{
				NPCDesc = other.NPCDesc;
			}
			if (other.Head.Length != 0)
			{
				Head = other.Head;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.NPCSkin != 0)
			{
				NPCSkin = other.NPCSkin;
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
				AffinityGroupId = input.ReadInt32();
				break;
			case 34u:
				NPCDesc = input.ReadString();
				break;
			case 42u:
				Head = input.ReadString();
				break;
			case 50u:
				Image = input.ReadString();
				break;
			case 56u:
				NPCSkin = input.ReadInt32();
				break;
			}
		}
	}
}
