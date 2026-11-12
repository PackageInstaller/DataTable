using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityTaskControl : IMessage<ActivityTaskControl>, IMessage, IEquatable<ActivityTaskControl>, IDeepCloneable<ActivityTaskControl>
{
	private static readonly MessageParser<ActivityTaskControl> _parser = new MessageParser<ActivityTaskControl>(() => new ActivityTaskControl());

	private UnknownFieldSet _unknownFields;

	public const int ActivityIdFieldNumber = 1;

	private int activityId_;

	public const int UIAssetsFieldNumber = 2;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 3;

	private string ctrlName_ = "";

	public const int PopUpUIAssetsFieldNumber = 4;

	private string popUpUIAssets_ = "";

	public const int FastEntranceIconFieldNumber = 5;

	private string fastEntranceIcon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityTaskControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(70);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
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
	public string PopUpUIAssets
	{
		get
		{
			return popUpUIAssets_;
		}
		set
		{
			popUpUIAssets_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string FastEntranceIcon
	{
		get
		{
			return fastEntranceIcon_;
		}
		set
		{
			fastEntranceIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityTaskControl()
	{
	}

	[DebuggerNonUserCode]
	public ActivityTaskControl(ActivityTaskControl other)
		: this()
	{
		activityId_ = other.activityId_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		popUpUIAssets_ = other.popUpUIAssets_;
		fastEntranceIcon_ = other.fastEntranceIcon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityTaskControl Clone()
	{
		return new ActivityTaskControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityTaskControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityTaskControl other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ActivityId != other.ActivityId)
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
		if (PopUpUIAssets != other.PopUpUIAssets)
		{
			return false;
		}
		if (FastEntranceIcon != other.FastEntranceIcon)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (PopUpUIAssets.Length != 0)
		{
			num ^= PopUpUIAssets.GetHashCode();
		}
		if (FastEntranceIcon.Length != 0)
		{
			num ^= FastEntranceIcon.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ActivityId);
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
		if (PopUpUIAssets.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(PopUpUIAssets);
		}
		if (FastEntranceIcon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(FastEntranceIcon);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (PopUpUIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PopUpUIAssets);
		}
		if (FastEntranceIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FastEntranceIcon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityTaskControl other)
	{
		if (other != null)
		{
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.PopUpUIAssets.Length != 0)
			{
				PopUpUIAssets = other.PopUpUIAssets;
			}
			if (other.FastEntranceIcon.Length != 0)
			{
				FastEntranceIcon = other.FastEntranceIcon;
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
				ActivityId = input.ReadInt32();
				break;
			case 18u:
				UIAssets = input.ReadString();
				break;
			case 26u:
				CtrlName = input.ReadString();
				break;
			case 34u:
				PopUpUIAssets = input.ReadString();
				break;
			case 42u:
				FastEntranceIcon = input.ReadString();
				break;
			}
		}
	}
}
