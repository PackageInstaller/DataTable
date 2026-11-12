using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class FollowSocialMediaControl : IMessage<FollowSocialMediaControl>, IMessage, IEquatable<FollowSocialMediaControl>, IDeepCloneable<FollowSocialMediaControl>
{
	private static readonly MessageParser<FollowSocialMediaControl> _parser = new MessageParser<FollowSocialMediaControl>(() => new FollowSocialMediaControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int UseTypeFieldNumber = 2;

	private int useType_;

	public const int UIAssetsFieldNumber = 3;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 4;

	private string ctrlName_ = "";

	public const int LinkListFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_linkList_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> linkList_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<FollowSocialMediaControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(354);

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
	public int UseType
	{
		get
		{
			return useType_;
		}
		set
		{
			useType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UIAssets
	{
		get
		{
			return uIAssets_;
		}
		set
		{
			uIAssets_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CtrlName
	{
		get
		{
			return ctrlName_;
		}
		set
		{
			ctrlName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> LinkList => linkList_;

	[DebuggerNonUserCode]
	public FollowSocialMediaControl()
	{
	}

	[DebuggerNonUserCode]
	public FollowSocialMediaControl(FollowSocialMediaControl other)
		: this()
	{
		id_ = other.id_;
		useType_ = other.useType_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		linkList_ = other.linkList_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public FollowSocialMediaControl Clone()
	{
		return new FollowSocialMediaControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FollowSocialMediaControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(FollowSocialMediaControl other)
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
		if (UseType != other.UseType)
		{
			return false;
		}
		if (UIAssets != other.UIAssets)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (!linkList_.Equals(other.linkList_))
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
		if (UseType != 0)
		{
			num ^= UseType.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		num ^= linkList_.GetHashCode();
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
		if (UseType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(UseType);
		}
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(CtrlName);
		}
		linkList_.WriteTo(output, _repeated_linkList_codec);
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
		if (UseType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseType);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		num += linkList_.CalculateSize(_repeated_linkList_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(FollowSocialMediaControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.UseType != 0)
			{
				UseType = other.UseType;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			linkList_.Add(other.linkList_);
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
				UseType = input.ReadInt32();
				break;
			case 26u:
				UIAssets = input.ReadString();
				break;
			case 34u:
				CtrlName = input.ReadString();
				break;
			case 40u:
			case 42u:
				linkList_.AddEntriesFrom(input, _repeated_linkList_codec);
				break;
			}
		}
	}
}
