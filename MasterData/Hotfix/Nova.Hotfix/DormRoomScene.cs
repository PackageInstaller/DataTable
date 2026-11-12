using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormRoomScene : IMessage<DormRoomScene>, IMessage, IEquatable<DormRoomScene>, IDeepCloneable<DormRoomScene>
{
	private static readonly MessageParser<DormRoomScene> _parser = new MessageParser<DormRoomScene>(() => new DormRoomScene());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DescFieldNumber = 2;

	private string desc_ = "";

	public const int IconResFieldNumber = 3;

	private string iconRes_ = "";

	public const int ListIconResFieldNumber = 4;

	private string listIconRes_ = "";

	public const int SceneResFieldNumber = 5;

	private string sceneRes_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DormRoomScene> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(312);

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
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IconRes
	{
		get
		{
			return iconRes_;
		}
		set
		{
			iconRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ListIconRes
	{
		get
		{
			return listIconRes_;
		}
		set
		{
			listIconRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SceneRes
	{
		get
		{
			return sceneRes_;
		}
		set
		{
			sceneRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DormRoomScene()
	{
	}

	[DebuggerNonUserCode]
	public DormRoomScene(DormRoomScene other)
		: this()
	{
		id_ = other.id_;
		desc_ = other.desc_;
		iconRes_ = other.iconRes_;
		listIconRes_ = other.listIconRes_;
		sceneRes_ = other.sceneRes_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormRoomScene Clone()
	{
		return new DormRoomScene(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormRoomScene);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormRoomScene other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (IconRes != other.IconRes)
		{
			return false;
		}
		if (ListIconRes != other.ListIconRes)
		{
			return false;
		}
		if (SceneRes != other.SceneRes)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (IconRes.Length != 0)
		{
			num ^= IconRes.GetHashCode();
		}
		if (ListIconRes.Length != 0)
		{
			num ^= ListIconRes.GetHashCode();
		}
		if (SceneRes.Length != 0)
		{
			num ^= SceneRes.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Desc);
		}
		if (IconRes.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(IconRes);
		}
		if (ListIconRes.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ListIconRes);
		}
		if (SceneRes.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(SceneRes);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (IconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes);
		}
		if (ListIconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ListIconRes);
		}
		if (SceneRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneRes);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormRoomScene other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.IconRes.Length != 0)
			{
				IconRes = other.IconRes;
			}
			if (other.ListIconRes.Length != 0)
			{
				ListIconRes = other.ListIconRes;
			}
			if (other.SceneRes.Length != 0)
			{
				SceneRes = other.SceneRes;
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
				Desc = input.ReadString();
				break;
			case 26u:
				IconRes = input.ReadString();
				break;
			case 34u:
				ListIconRes = input.ReadString();
				break;
			case 42u:
				SceneRes = input.ReadString();
				break;
			}
		}
	}
}
