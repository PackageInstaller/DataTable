using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerTalk : IMessage<StarTowerTalk>, IMessage, IEquatable<StarTowerTalk>, IDeepCloneable<StarTowerTalk>
{
	private static readonly MessageParser<StarTowerTalk> _parser = new MessageParser<StarTowerTalk>(() => new StarTowerTalk());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int ContentFieldNumber = 3;

	private string content_ = "";

	public const int ColorFieldNumber = 4;

	private string color_ = "";

	public const int FaceFieldNumber = 5;

	private string face_ = "";

	public const int VoiceFieldNumber = 6;

	private string voice_ = "";

	public const int NPCIdFieldNumber = 7;

	private int nPCId_;

	public const int AffinityFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_affinity_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> affinity_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerTalk> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(882);

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
	public string Content
	{
		get
		{
			return content_;
		}
		set
		{
			content_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Color
	{
		get
		{
			return color_;
		}
		set
		{
			color_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Face
	{
		get
		{
			return face_;
		}
		set
		{
			face_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Voice
	{
		get
		{
			return voice_;
		}
		set
		{
			voice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int NPCId
	{
		get
		{
			return nPCId_;
		}
		set
		{
			nPCId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Affinity => affinity_;

	[DebuggerNonUserCode]
	public StarTowerTalk()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerTalk(StarTowerTalk other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		content_ = other.content_;
		color_ = other.color_;
		face_ = other.face_;
		voice_ = other.voice_;
		nPCId_ = other.nPCId_;
		affinity_ = other.affinity_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerTalk Clone()
	{
		return new StarTowerTalk(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerTalk);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerTalk other)
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
		if (Content != other.Content)
		{
			return false;
		}
		if (Color != other.Color)
		{
			return false;
		}
		if (Face != other.Face)
		{
			return false;
		}
		if (Voice != other.Voice)
		{
			return false;
		}
		if (NPCId != other.NPCId)
		{
			return false;
		}
		if (!affinity_.Equals(other.affinity_))
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
		if (Content.Length != 0)
		{
			num ^= Content.GetHashCode();
		}
		if (Color.Length != 0)
		{
			num ^= Color.GetHashCode();
		}
		if (Face.Length != 0)
		{
			num ^= Face.GetHashCode();
		}
		if (Voice.Length != 0)
		{
			num ^= Voice.GetHashCode();
		}
		if (NPCId != 0)
		{
			num ^= NPCId.GetHashCode();
		}
		num ^= affinity_.GetHashCode();
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
		if (Content.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Content);
		}
		if (Color.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Color);
		}
		if (Face.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Face);
		}
		if (Voice.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Voice);
		}
		if (NPCId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(NPCId);
		}
		affinity_.WriteTo(output, _repeated_affinity_codec);
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
		if (Content.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Content);
		}
		if (Color.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Color);
		}
		if (Face.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Face);
		}
		if (Voice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Voice);
		}
		if (NPCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NPCId);
		}
		num += affinity_.CalculateSize(_repeated_affinity_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerTalk other)
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
			if (other.Content.Length != 0)
			{
				Content = other.Content;
			}
			if (other.Color.Length != 0)
			{
				Color = other.Color;
			}
			if (other.Face.Length != 0)
			{
				Face = other.Face;
			}
			if (other.Voice.Length != 0)
			{
				Voice = other.Voice;
			}
			if (other.NPCId != 0)
			{
				NPCId = other.NPCId;
			}
			affinity_.Add(other.affinity_);
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
				Content = input.ReadString();
				break;
			case 34u:
				Color = input.ReadString();
				break;
			case 42u:
				Face = input.ReadString();
				break;
			case 50u:
				Voice = input.ReadString();
				break;
			case 56u:
				NPCId = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				affinity_.AddEntriesFrom(input, _repeated_affinity_codec);
				break;
			}
		}
	}
}
