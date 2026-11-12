using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MainScreenCG : IMessage<MainScreenCG>, IMessage, IEquatable<MainScreenCG>, IDeepCloneable<MainScreenCG>
{
	private static readonly MessageParser<MainScreenCG> _parser = new MessageParser<MainScreenCG>(() => new MainScreenCG());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IsShownFieldNumber = 2;

	private bool isShown_;

	public const int FullScreenImgFieldNumber = 3;

	private string fullScreenImg_ = "";

	public const int FullScreenL2DFieldNumber = 4;

	private string fullScreenL2D_ = "";

	public const int ListImgFieldNumber = 5;

	private string listImg_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	public const int NameFieldNumber = 7;

	private string name_ = "";

	public const int SortFieldNumber = 8;

	private int sort_;

	[DebuggerNonUserCode]
	public static MessageParser<MainScreenCG> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(508);

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
	public bool IsShown
	{
		get
		{
			return isShown_;
		}
		set
		{
			isShown_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FullScreenImg
	{
		get
		{
			return fullScreenImg_;
		}
		set
		{
			fullScreenImg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FullScreenL2D
	{
		get
		{
			return fullScreenL2D_;
		}
		set
		{
			fullScreenL2D_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ListImg
	{
		get
		{
			return listImg_;
		}
		set
		{
			listImg_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public MainScreenCG()
	{
	}

	[DebuggerNonUserCode]
	public MainScreenCG(MainScreenCG other)
		: this()
	{
		id_ = other.id_;
		isShown_ = other.isShown_;
		fullScreenImg_ = other.fullScreenImg_;
		fullScreenL2D_ = other.fullScreenL2D_;
		listImg_ = other.listImg_;
		icon_ = other.icon_;
		name_ = other.name_;
		sort_ = other.sort_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MainScreenCG Clone()
	{
		return new MainScreenCG(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MainScreenCG);
	}

	[DebuggerNonUserCode]
	public bool Equals(MainScreenCG other)
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
		if (IsShown != other.IsShown)
		{
			return false;
		}
		if (FullScreenImg != other.FullScreenImg)
		{
			return false;
		}
		if (FullScreenL2D != other.FullScreenL2D)
		{
			return false;
		}
		if (ListImg != other.ListImg)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Sort != other.Sort)
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
		if (IsShown)
		{
			num ^= IsShown.GetHashCode();
		}
		if (FullScreenImg.Length != 0)
		{
			num ^= FullScreenImg.GetHashCode();
		}
		if (FullScreenL2D.Length != 0)
		{
			num ^= FullScreenL2D.GetHashCode();
		}
		if (ListImg.Length != 0)
		{
			num ^= ListImg.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
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
		if (IsShown)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsShown);
		}
		if (FullScreenImg.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(FullScreenImg);
		}
		if (FullScreenL2D.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(FullScreenL2D);
		}
		if (ListImg.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ListImg);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Name);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Sort);
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
		if (IsShown)
		{
			num += 2;
		}
		if (FullScreenImg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FullScreenImg);
		}
		if (FullScreenL2D.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FullScreenL2D);
		}
		if (ListImg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ListImg);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MainScreenCG other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.IsShown)
			{
				IsShown = other.IsShown;
			}
			if (other.FullScreenImg.Length != 0)
			{
				FullScreenImg = other.FullScreenImg;
			}
			if (other.FullScreenL2D.Length != 0)
			{
				FullScreenL2D = other.FullScreenL2D;
			}
			if (other.ListImg.Length != 0)
			{
				ListImg = other.ListImg;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
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
			case 16u:
				IsShown = input.ReadBool();
				break;
			case 26u:
				FullScreenImg = input.ReadString();
				break;
			case 34u:
				FullScreenL2D = input.ReadString();
				break;
			case 42u:
				ListImg = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			case 58u:
				Name = input.ReadString();
				break;
			case 64u:
				Sort = input.ReadInt32();
				break;
			}
		}
	}
}
