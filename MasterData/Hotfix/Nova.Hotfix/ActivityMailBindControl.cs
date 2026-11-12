using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityMailBindControl : IMessage<ActivityMailBindControl>, IMessage, IEquatable<ActivityMailBindControl>, IDeepCloneable<ActivityMailBindControl>
{
	private static readonly MessageParser<ActivityMailBindControl> _parser = new MessageParser<ActivityMailBindControl>(() => new ActivityMailBindControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int Reward1TidFieldNumber = 2;

	private int reward1Tid_;

	public const int Reward1QtyFieldNumber = 3;

	private int reward1Qty_;

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int UIAssetsFieldNumber = 5;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 6;

	private string ctrlName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityMailBindControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(24);

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
	public int Reward1Tid
	{
		get
		{
			return reward1Tid_;
		}
		set
		{
			reward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward1Qty
	{
		get
		{
			return reward1Qty_;
		}
		set
		{
			reward1Qty_ = value;
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
	public ActivityMailBindControl()
	{
	}

	[DebuggerNonUserCode]
	public ActivityMailBindControl(ActivityMailBindControl other)
		: this()
	{
		id_ = other.id_;
		reward1Tid_ = other.reward1Tid_;
		reward1Qty_ = other.reward1Qty_;
		desc_ = other.desc_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityMailBindControl Clone()
	{
		return new ActivityMailBindControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityMailBindControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityMailBindControl other)
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
		if (Reward1Tid != other.Reward1Tid)
		{
			return false;
		}
		if (Reward1Qty != other.Reward1Qty)
		{
			return false;
		}
		if (Desc != other.Desc)
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
		if (Reward1Tid != 0)
		{
			num ^= Reward1Tid.GetHashCode();
		}
		if (Reward1Qty != 0)
		{
			num ^= Reward1Qty.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
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
		if (Reward1Tid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Reward1Qty);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CtrlName);
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
		if (Reward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Tid);
		}
		if (Reward1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward1Qty);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityMailBindControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Reward1Tid != 0)
			{
				Reward1Tid = other.Reward1Tid;
			}
			if (other.Reward1Qty != 0)
			{
				Reward1Qty = other.Reward1Qty;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
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
				Reward1Tid = input.ReadInt32();
				break;
			case 24u:
				Reward1Qty = input.ReadInt32();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				UIAssets = input.ReadString();
				break;
			case 50u:
				CtrlName = input.ReadString();
				break;
			}
		}
	}
}
