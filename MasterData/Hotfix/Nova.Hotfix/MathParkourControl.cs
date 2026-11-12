using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourControl : IMessage<MathParkourControl>, IMessage, IEquatable<MathParkourControl>, IDeepCloneable<MathParkourControl>
{
	private static readonly MessageParser<MathParkourControl> _parser = new MessageParser<MathParkourControl>(() => new MathParkourControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int UIAssetsFieldNumber = 2;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 3;

	private string ctrlName_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int RewardsShowFieldNumber = 5;

	private string rewardsShow_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(538);

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
	public string RewardsShow
	{
		get
		{
			return rewardsShow_;
		}
		set
		{
			rewardsShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MathParkourControl()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourControl(MathParkourControl other)
		: this()
	{
		id_ = other.id_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		desc_ = other.desc_;
		rewardsShow_ = other.rewardsShow_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourControl Clone()
	{
		return new MathParkourControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourControl other)
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
		if (UIAssets != other.UIAssets)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (RewardsShow != other.RewardsShow)
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
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (RewardsShow.Length != 0)
		{
			num ^= RewardsShow.GetHashCode();
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
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CtrlName);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (RewardsShow.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(RewardsShow);
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
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (RewardsShow.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardsShow);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.RewardsShow.Length != 0)
			{
				RewardsShow = other.RewardsShow;
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
				UIAssets = input.ReadString();
				break;
			case 26u:
				CtrlName = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				RewardsShow = input.ReadString();
				break;
			}
		}
	}
}
