using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBookFateCardBundle : IMessage<StarTowerBookFateCardBundle>, IMessage, IEquatable<StarTowerBookFateCardBundle>, IDeepCloneable<StarTowerBookFateCardBundle>
{
	private static readonly MessageParser<StarTowerBookFateCardBundle> _parser = new MessageParser<StarTowerBookFateCardBundle>(() => new StarTowerBookFateCardBundle());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int ShortNameFieldNumber = 3;

	private string shortName_ = "";

	public const int SortIdFieldNumber = 4;

	private int sortId_;

	public const int TagFieldNumber = 5;

	private string tag_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	public const int TextFieldNumber = 7;

	private string text_ = "";

	public const int WorldClassFieldNumber = 8;

	private int worldClass_;

	public const int StarTowerIdFieldNumber = 9;

	private int starTowerId_;

	public const int CollectCardsFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_collectCards_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> collectCards_ = new RepeatedField<int>();

	public const int UnlockCardsFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_unlockCards_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> unlockCards_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBookFateCardBundle> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(824);

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
	public string ShortName
	{
		get
		{
			return shortName_;
		}
		set
		{
			shortName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SortId
	{
		get
		{
			return sortId_;
		}
		set
		{
			sortId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Text
	{
		get
		{
			return text_;
		}
		set
		{
			text_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StarTowerId
	{
		get
		{
			return starTowerId_;
		}
		set
		{
			starTowerId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CollectCards => collectCards_;

	[DebuggerNonUserCode]
	public RepeatedField<int> UnlockCards => unlockCards_;

	[DebuggerNonUserCode]
	public StarTowerBookFateCardBundle()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCardBundle(StarTowerBookFateCardBundle other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		shortName_ = other.shortName_;
		sortId_ = other.sortId_;
		tag_ = other.tag_;
		icon_ = other.icon_;
		text_ = other.text_;
		worldClass_ = other.worldClass_;
		starTowerId_ = other.starTowerId_;
		collectCards_ = other.collectCards_.Clone();
		unlockCards_ = other.unlockCards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCardBundle Clone()
	{
		return new StarTowerBookFateCardBundle(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBookFateCardBundle);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBookFateCardBundle other)
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
		if (ShortName != other.ShortName)
		{
			return false;
		}
		if (SortId != other.SortId)
		{
			return false;
		}
		if (Tag != other.Tag)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Text != other.Text)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (StarTowerId != other.StarTowerId)
		{
			return false;
		}
		if (!collectCards_.Equals(other.collectCards_))
		{
			return false;
		}
		if (!unlockCards_.Equals(other.unlockCards_))
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
		if (ShortName.Length != 0)
		{
			num ^= ShortName.GetHashCode();
		}
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (Tag.Length != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Text.Length != 0)
		{
			num ^= Text.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		if (StarTowerId != 0)
		{
			num ^= StarTowerId.GetHashCode();
		}
		num ^= collectCards_.GetHashCode();
		num ^= unlockCards_.GetHashCode();
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
		if (ShortName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ShortName);
		}
		if (SortId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SortId);
		}
		if (Tag.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Tag);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
		}
		if (Text.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Text);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(WorldClass);
		}
		if (StarTowerId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(StarTowerId);
		}
		collectCards_.WriteTo(output, _repeated_collectCards_codec);
		unlockCards_.WriteTo(output, _repeated_unlockCards_codec);
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
		if (ShortName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ShortName);
		}
		if (SortId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (Tag.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Tag);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Text.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Text);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		if (StarTowerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarTowerId);
		}
		num += collectCards_.CalculateSize(_repeated_collectCards_codec);
		num += unlockCards_.CalculateSize(_repeated_unlockCards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBookFateCardBundle other)
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
			if (other.ShortName.Length != 0)
			{
				ShortName = other.ShortName;
			}
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.Tag.Length != 0)
			{
				Tag = other.Tag;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Text.Length != 0)
			{
				Text = other.Text;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			if (other.StarTowerId != 0)
			{
				StarTowerId = other.StarTowerId;
			}
			collectCards_.Add(other.collectCards_);
			unlockCards_.Add(other.unlockCards_);
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
			case 26u:
				ShortName = input.ReadString();
				break;
			case 32u:
				SortId = input.ReadInt32();
				break;
			case 42u:
				Tag = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			case 58u:
				Text = input.ReadString();
				break;
			case 64u:
				WorldClass = input.ReadInt32();
				break;
			case 72u:
				StarTowerId = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				collectCards_.AddEntriesFrom(input, _repeated_collectCards_codec);
				break;
			case 88u:
			case 90u:
				unlockCards_.AddEntriesFrom(input, _repeated_unlockCards_codec);
				break;
			}
		}
	}
}
