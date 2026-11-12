using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrillControl : IMessage<JointDrillControl>, IMessage, IEquatable<JointDrillControl>, IDeepCloneable<JointDrillControl>
{
	private static readonly MessageParser<JointDrillControl> _parser = new MessageParser<JointDrillControl>(() => new JointDrillControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int DrillStartTimeFieldNumber = 3;

	private int drillStartTime_;

	public const int DrillDurationTimeFieldNumber = 4;

	private int drillDurationTime_;

	public const int DrillLevelGroupIdFieldNumber = 5;

	private int drillLevelGroupId_;

	public const int DrillQuestGroupIdFieldNumber = 6;

	private int drillQuestGroupId_;

	public const int DrillPlotIdFieldNumber = 7;

	private string drillPlotId_ = "";

	public const int PlotTitleFieldNumber = 8;

	private string plotTitle_ = "";

	public const int PlotDescFieldNumber = 9;

	private string plotDesc_ = "";

	public const int ImageFieldNumber = 10;

	private string image_ = "";

	public const int BGFieldNumber = 11;

	private string bG_ = "";

	public const int DrillPrefabFieldNumber = 12;

	private string drillPrefab_ = "";

	public const int CtrlNameFieldNumber = 13;

	private string ctrlName_ = "";

	public const int DescTextFieldNumber = 14;

	private string descText_ = "";

	public const int DetailDescFieldNumber = 15;

	private string detailDesc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<JointDrillControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(474);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DrillStartTime
	{
		get
		{
			return drillStartTime_;
		}
		set
		{
			drillStartTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DrillDurationTime
	{
		get
		{
			return drillDurationTime_;
		}
		set
		{
			drillDurationTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DrillLevelGroupId
	{
		get
		{
			return drillLevelGroupId_;
		}
		set
		{
			drillLevelGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DrillQuestGroupId
	{
		get
		{
			return drillQuestGroupId_;
		}
		set
		{
			drillQuestGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DrillPlotId
	{
		get
		{
			return drillPlotId_;
		}
		set
		{
			drillPlotId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PlotTitle
	{
		get
		{
			return plotTitle_;
		}
		set
		{
			plotTitle_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PlotDesc
	{
		get
		{
			return plotDesc_;
		}
		set
		{
			plotDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string BG
	{
		get
		{
			return bG_;
		}
		set
		{
			bG_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DrillPrefab
	{
		get
		{
			return drillPrefab_;
		}
		set
		{
			drillPrefab_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string DescText
	{
		get
		{
			return descText_;
		}
		set
		{
			descText_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DetailDesc
	{
		get
		{
			return detailDesc_;
		}
		set
		{
			detailDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public JointDrillControl()
	{
	}

	[DebuggerNonUserCode]
	public JointDrillControl(JointDrillControl other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		drillStartTime_ = other.drillStartTime_;
		drillDurationTime_ = other.drillDurationTime_;
		drillLevelGroupId_ = other.drillLevelGroupId_;
		drillQuestGroupId_ = other.drillQuestGroupId_;
		drillPlotId_ = other.drillPlotId_;
		plotTitle_ = other.plotTitle_;
		plotDesc_ = other.plotDesc_;
		image_ = other.image_;
		bG_ = other.bG_;
		drillPrefab_ = other.drillPrefab_;
		ctrlName_ = other.ctrlName_;
		descText_ = other.descText_;
		detailDesc_ = other.detailDesc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public JointDrillControl Clone()
	{
		return new JointDrillControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrillControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrillControl other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (DrillStartTime != other.DrillStartTime)
		{
			return false;
		}
		if (DrillDurationTime != other.DrillDurationTime)
		{
			return false;
		}
		if (DrillLevelGroupId != other.DrillLevelGroupId)
		{
			return false;
		}
		if (DrillQuestGroupId != other.DrillQuestGroupId)
		{
			return false;
		}
		if (DrillPlotId != other.DrillPlotId)
		{
			return false;
		}
		if (PlotTitle != other.PlotTitle)
		{
			return false;
		}
		if (PlotDesc != other.PlotDesc)
		{
			return false;
		}
		if (Image != other.Image)
		{
			return false;
		}
		if (BG != other.BG)
		{
			return false;
		}
		if (DrillPrefab != other.DrillPrefab)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (DescText != other.DescText)
		{
			return false;
		}
		if (DetailDesc != other.DetailDesc)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (DrillStartTime != 0)
		{
			num ^= DrillStartTime.GetHashCode();
		}
		if (DrillDurationTime != 0)
		{
			num ^= DrillDurationTime.GetHashCode();
		}
		if (DrillLevelGroupId != 0)
		{
			num ^= DrillLevelGroupId.GetHashCode();
		}
		if (DrillQuestGroupId != 0)
		{
			num ^= DrillQuestGroupId.GetHashCode();
		}
		if (DrillPlotId.Length != 0)
		{
			num ^= DrillPlotId.GetHashCode();
		}
		if (PlotTitle.Length != 0)
		{
			num ^= PlotTitle.GetHashCode();
		}
		if (PlotDesc.Length != 0)
		{
			num ^= PlotDesc.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (BG.Length != 0)
		{
			num ^= BG.GetHashCode();
		}
		if (DrillPrefab.Length != 0)
		{
			num ^= DrillPrefab.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (DescText.Length != 0)
		{
			num ^= DescText.GetHashCode();
		}
		if (DetailDesc.Length != 0)
		{
			num ^= DetailDesc.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (DrillStartTime != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DrillStartTime);
		}
		if (DrillDurationTime != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DrillDurationTime);
		}
		if (DrillLevelGroupId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DrillLevelGroupId);
		}
		if (DrillQuestGroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(DrillQuestGroupId);
		}
		if (DrillPlotId.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(DrillPlotId);
		}
		if (PlotTitle.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(PlotTitle);
		}
		if (PlotDesc.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(PlotDesc);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Image);
		}
		if (BG.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(BG);
		}
		if (DrillPrefab.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(DrillPrefab);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(CtrlName);
		}
		if (DescText.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(DescText);
		}
		if (DetailDesc.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(DetailDesc);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (DrillStartTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrillStartTime);
		}
		if (DrillDurationTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrillDurationTime);
		}
		if (DrillLevelGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrillLevelGroupId);
		}
		if (DrillQuestGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrillQuestGroupId);
		}
		if (DrillPlotId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DrillPlotId);
		}
		if (PlotTitle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PlotTitle);
		}
		if (PlotDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PlotDesc);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (BG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BG);
		}
		if (DrillPrefab.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DrillPrefab);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (DescText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescText);
		}
		if (DetailDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DetailDesc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(JointDrillControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.DrillStartTime != 0)
			{
				DrillStartTime = other.DrillStartTime;
			}
			if (other.DrillDurationTime != 0)
			{
				DrillDurationTime = other.DrillDurationTime;
			}
			if (other.DrillLevelGroupId != 0)
			{
				DrillLevelGroupId = other.DrillLevelGroupId;
			}
			if (other.DrillQuestGroupId != 0)
			{
				DrillQuestGroupId = other.DrillQuestGroupId;
			}
			if (other.DrillPlotId.Length != 0)
			{
				DrillPlotId = other.DrillPlotId;
			}
			if (other.PlotTitle.Length != 0)
			{
				PlotTitle = other.PlotTitle;
			}
			if (other.PlotDesc.Length != 0)
			{
				PlotDesc = other.PlotDesc;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.BG.Length != 0)
			{
				BG = other.BG;
			}
			if (other.DrillPrefab.Length != 0)
			{
				DrillPrefab = other.DrillPrefab;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.DescText.Length != 0)
			{
				DescText = other.DescText;
			}
			if (other.DetailDesc.Length != 0)
			{
				DetailDesc = other.DetailDesc;
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
				Type = input.ReadInt32();
				break;
			case 24u:
				DrillStartTime = input.ReadInt32();
				break;
			case 32u:
				DrillDurationTime = input.ReadInt32();
				break;
			case 40u:
				DrillLevelGroupId = input.ReadInt32();
				break;
			case 48u:
				DrillQuestGroupId = input.ReadInt32();
				break;
			case 58u:
				DrillPlotId = input.ReadString();
				break;
			case 66u:
				PlotTitle = input.ReadString();
				break;
			case 74u:
				PlotDesc = input.ReadString();
				break;
			case 82u:
				Image = input.ReadString();
				break;
			case 90u:
				BG = input.ReadString();
				break;
			case 98u:
				DrillPrefab = input.ReadString();
				break;
			case 106u:
				CtrlName = input.ReadString();
				break;
			case 114u:
				DescText = input.ReadString();
				break;
			case 122u:
				DetailDesc = input.ReadString();
				break;
			}
		}
	}
}
