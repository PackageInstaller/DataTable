using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PeriodicQuestControl : IMessage<PeriodicQuestControl>, IMessage, IEquatable<PeriodicQuestControl>, IDeepCloneable<PeriodicQuestControl>
{
	private static readonly MessageParser<PeriodicQuestControl> _parser = new MessageParser<PeriodicQuestControl>(() => new PeriodicQuestControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FinalReward1FieldNumber = 2;

	private int finalReward1_;

	public const int FinalRewardQty1FieldNumber = 3;

	private int finalRewardQty1_;

	public const int FinalReward2FieldNumber = 4;

	private int finalReward2_;

	public const int FinalRewardQty2FieldNumber = 5;

	private int finalRewardQty2_;

	public const int FinalReward3FieldNumber = 6;

	private int finalReward3_;

	public const int FinalRewardQty3FieldNumber = 7;

	private int finalRewardQty3_;

	public const int DesTextFieldNumber = 8;

	private string desText_ = "";

	public const int UIAssetsFieldNumber = 9;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 10;

	private string ctrlName_ = "";

	public const int PreviewTypeFieldNumber = 11;

	private int previewType_;

	[DebuggerNonUserCode]
	public static MessageParser<PeriodicQuestControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(646);

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
	public int FinalReward1
	{
		get
		{
			return finalReward1_;
		}
		set
		{
			finalReward1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinalRewardQty1
	{
		get
		{
			return finalRewardQty1_;
		}
		set
		{
			finalRewardQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinalReward2
	{
		get
		{
			return finalReward2_;
		}
		set
		{
			finalReward2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinalRewardQty2
	{
		get
		{
			return finalRewardQty2_;
		}
		set
		{
			finalRewardQty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinalReward3
	{
		get
		{
			return finalReward3_;
		}
		set
		{
			finalReward3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FinalRewardQty3
	{
		get
		{
			return finalRewardQty3_;
		}
		set
		{
			finalRewardQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DesText
	{
		get
		{
			return desText_;
		}
		set
		{
			desText_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int PreviewType
	{
		get
		{
			return previewType_;
		}
		set
		{
			previewType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PeriodicQuestControl()
	{
	}

	[DebuggerNonUserCode]
	public PeriodicQuestControl(PeriodicQuestControl other)
		: this()
	{
		id_ = other.id_;
		finalReward1_ = other.finalReward1_;
		finalRewardQty1_ = other.finalRewardQty1_;
		finalReward2_ = other.finalReward2_;
		finalRewardQty2_ = other.finalRewardQty2_;
		finalReward3_ = other.finalReward3_;
		finalRewardQty3_ = other.finalRewardQty3_;
		desText_ = other.desText_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		previewType_ = other.previewType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PeriodicQuestControl Clone()
	{
		return new PeriodicQuestControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PeriodicQuestControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(PeriodicQuestControl other)
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
		if (FinalReward1 != other.FinalReward1)
		{
			return false;
		}
		if (FinalRewardQty1 != other.FinalRewardQty1)
		{
			return false;
		}
		if (FinalReward2 != other.FinalReward2)
		{
			return false;
		}
		if (FinalRewardQty2 != other.FinalRewardQty2)
		{
			return false;
		}
		if (FinalReward3 != other.FinalReward3)
		{
			return false;
		}
		if (FinalRewardQty3 != other.FinalRewardQty3)
		{
			return false;
		}
		if (DesText != other.DesText)
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
		if (PreviewType != other.PreviewType)
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
		if (FinalReward1 != 0)
		{
			num ^= FinalReward1.GetHashCode();
		}
		if (FinalRewardQty1 != 0)
		{
			num ^= FinalRewardQty1.GetHashCode();
		}
		if (FinalReward2 != 0)
		{
			num ^= FinalReward2.GetHashCode();
		}
		if (FinalRewardQty2 != 0)
		{
			num ^= FinalRewardQty2.GetHashCode();
		}
		if (FinalReward3 != 0)
		{
			num ^= FinalReward3.GetHashCode();
		}
		if (FinalRewardQty3 != 0)
		{
			num ^= FinalRewardQty3.GetHashCode();
		}
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (PreviewType != 0)
		{
			num ^= PreviewType.GetHashCode();
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
		if (FinalReward1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FinalReward1);
		}
		if (FinalRewardQty1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FinalRewardQty1);
		}
		if (FinalReward2 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FinalReward2);
		}
		if (FinalRewardQty2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(FinalRewardQty2);
		}
		if (FinalReward3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FinalReward3);
		}
		if (FinalRewardQty3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(FinalRewardQty3);
		}
		if (DesText.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(DesText);
		}
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(CtrlName);
		}
		if (PreviewType != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(PreviewType);
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
		if (FinalReward1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalReward1);
		}
		if (FinalRewardQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalRewardQty1);
		}
		if (FinalReward2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalReward2);
		}
		if (FinalRewardQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalRewardQty2);
		}
		if (FinalReward3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalReward3);
		}
		if (FinalRewardQty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinalRewardQty3);
		}
		if (DesText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (PreviewType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PeriodicQuestControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FinalReward1 != 0)
			{
				FinalReward1 = other.FinalReward1;
			}
			if (other.FinalRewardQty1 != 0)
			{
				FinalRewardQty1 = other.FinalRewardQty1;
			}
			if (other.FinalReward2 != 0)
			{
				FinalReward2 = other.FinalReward2;
			}
			if (other.FinalRewardQty2 != 0)
			{
				FinalRewardQty2 = other.FinalRewardQty2;
			}
			if (other.FinalReward3 != 0)
			{
				FinalReward3 = other.FinalReward3;
			}
			if (other.FinalRewardQty3 != 0)
			{
				FinalRewardQty3 = other.FinalRewardQty3;
			}
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.PreviewType != 0)
			{
				PreviewType = other.PreviewType;
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
				FinalReward1 = input.ReadInt32();
				break;
			case 24u:
				FinalRewardQty1 = input.ReadInt32();
				break;
			case 32u:
				FinalReward2 = input.ReadInt32();
				break;
			case 40u:
				FinalRewardQty2 = input.ReadInt32();
				break;
			case 48u:
				FinalReward3 = input.ReadInt32();
				break;
			case 56u:
				FinalRewardQty3 = input.ReadInt32();
				break;
			case 66u:
				DesText = input.ReadString();
				break;
			case 74u:
				UIAssets = input.ReadString();
				break;
			case 82u:
				CtrlName = input.ReadString();
				break;
			case 88u:
				PreviewType = input.ReadInt32();
				break;
			}
		}
	}
}
