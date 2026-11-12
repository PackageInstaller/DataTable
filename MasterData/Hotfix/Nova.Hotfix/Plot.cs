using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Plot : IMessage<Plot>, IMessage, IEquatable<Plot>, IDeepCloneable<Plot>
{
	private static readonly MessageParser<Plot> _parser = new MessageParser<Plot>(() => new Plot());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharFieldNumber = 2;

	private int char_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int AvgIdFieldNumber = 5;

	private string avgId_ = "";

	public const int PlotTypeFieldNumber = 6;

	private int plotType_;

	public const int MainlinesFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_mainlines_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> mainlines_ = new RepeatedField<int>();

	public const int PrePlotFieldNumber = 8;

	private int prePlot_;

	public const int UnlockAffinityLevelFieldNumber = 9;

	private int unlockAffinityLevel_;

	public const int UnlockSkinIdFieldNumber = 10;

	private int unlockSkinId_;

	public const int ConnectChatIdFieldNumber = 11;

	private int connectChatId_;

	public const int CharAdvanceCondFieldNumber = 12;

	private string charAdvanceCond_ = "";

	public const int RewardsFieldNumber = 13;

	private string rewards_ = "";

	public const int PicSourceFieldNumber = 14;

	private string picSource_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Plot> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(652);

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
	public int Char
	{
		get
		{
			return char_;
		}
		set
		{
			char_ = value;
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
	public string AvgId
	{
		get
		{
			return avgId_;
		}
		set
		{
			avgId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PlotType
	{
		get
		{
			return plotType_;
		}
		set
		{
			plotType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Mainlines => mainlines_;

	[DebuggerNonUserCode]
	public int PrePlot
	{
		get
		{
			return prePlot_;
		}
		set
		{
			prePlot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockAffinityLevel
	{
		get
		{
			return unlockAffinityLevel_;
		}
		set
		{
			unlockAffinityLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockSkinId
	{
		get
		{
			return unlockSkinId_;
		}
		set
		{
			unlockSkinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ConnectChatId
	{
		get
		{
			return connectChatId_;
		}
		set
		{
			connectChatId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CharAdvanceCond
	{
		get
		{
			return charAdvanceCond_;
		}
		set
		{
			charAdvanceCond_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Rewards
	{
		get
		{
			return rewards_;
		}
		set
		{
			rewards_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PicSource
	{
		get
		{
			return picSource_;
		}
		set
		{
			picSource_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Plot()
	{
	}

	[DebuggerNonUserCode]
	public Plot(Plot other)
		: this()
	{
		id_ = other.id_;
		char_ = other.char_;
		name_ = other.name_;
		desc_ = other.desc_;
		avgId_ = other.avgId_;
		plotType_ = other.plotType_;
		mainlines_ = other.mainlines_.Clone();
		prePlot_ = other.prePlot_;
		unlockAffinityLevel_ = other.unlockAffinityLevel_;
		unlockSkinId_ = other.unlockSkinId_;
		connectChatId_ = other.connectChatId_;
		charAdvanceCond_ = other.charAdvanceCond_;
		rewards_ = other.rewards_;
		picSource_ = other.picSource_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Plot Clone()
	{
		return new Plot(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Plot);
	}

	[DebuggerNonUserCode]
	public bool Equals(Plot other)
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
		if (Char != other.Char)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (PlotType != other.PlotType)
		{
			return false;
		}
		if (!mainlines_.Equals(other.mainlines_))
		{
			return false;
		}
		if (PrePlot != other.PrePlot)
		{
			return false;
		}
		if (UnlockAffinityLevel != other.UnlockAffinityLevel)
		{
			return false;
		}
		if (UnlockSkinId != other.UnlockSkinId)
		{
			return false;
		}
		if (ConnectChatId != other.ConnectChatId)
		{
			return false;
		}
		if (CharAdvanceCond != other.CharAdvanceCond)
		{
			return false;
		}
		if (Rewards != other.Rewards)
		{
			return false;
		}
		if (PicSource != other.PicSource)
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
		if (Char != 0)
		{
			num ^= Char.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		if (PlotType != 0)
		{
			num ^= PlotType.GetHashCode();
		}
		num ^= mainlines_.GetHashCode();
		if (PrePlot != 0)
		{
			num ^= PrePlot.GetHashCode();
		}
		if (UnlockAffinityLevel != 0)
		{
			num ^= UnlockAffinityLevel.GetHashCode();
		}
		if (UnlockSkinId != 0)
		{
			num ^= UnlockSkinId.GetHashCode();
		}
		if (ConnectChatId != 0)
		{
			num ^= ConnectChatId.GetHashCode();
		}
		if (CharAdvanceCond.Length != 0)
		{
			num ^= CharAdvanceCond.GetHashCode();
		}
		if (Rewards.Length != 0)
		{
			num ^= Rewards.GetHashCode();
		}
		if (PicSource.Length != 0)
		{
			num ^= PicSource.GetHashCode();
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
		if (Char != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Char);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AvgId);
		}
		if (PlotType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PlotType);
		}
		mainlines_.WriteTo(output, _repeated_mainlines_codec);
		if (PrePlot != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PrePlot);
		}
		if (UnlockAffinityLevel != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(UnlockAffinityLevel);
		}
		if (UnlockSkinId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(UnlockSkinId);
		}
		if (ConnectChatId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ConnectChatId);
		}
		if (CharAdvanceCond.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(CharAdvanceCond);
		}
		if (Rewards.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Rewards);
		}
		if (PicSource.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(PicSource);
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
		if (Char != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Char);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		if (PlotType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlotType);
		}
		num += mainlines_.CalculateSize(_repeated_mainlines_codec);
		if (PrePlot != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PrePlot);
		}
		if (UnlockAffinityLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockAffinityLevel);
		}
		if (UnlockSkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockSkinId);
		}
		if (ConnectChatId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConnectChatId);
		}
		if (CharAdvanceCond.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharAdvanceCond);
		}
		if (Rewards.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Rewards);
		}
		if (PicSource.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PicSource);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Plot other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Char != 0)
			{
				Char = other.Char;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			if (other.PlotType != 0)
			{
				PlotType = other.PlotType;
			}
			mainlines_.Add(other.mainlines_);
			if (other.PrePlot != 0)
			{
				PrePlot = other.PrePlot;
			}
			if (other.UnlockAffinityLevel != 0)
			{
				UnlockAffinityLevel = other.UnlockAffinityLevel;
			}
			if (other.UnlockSkinId != 0)
			{
				UnlockSkinId = other.UnlockSkinId;
			}
			if (other.ConnectChatId != 0)
			{
				ConnectChatId = other.ConnectChatId;
			}
			if (other.CharAdvanceCond.Length != 0)
			{
				CharAdvanceCond = other.CharAdvanceCond;
			}
			if (other.Rewards.Length != 0)
			{
				Rewards = other.Rewards;
			}
			if (other.PicSource.Length != 0)
			{
				PicSource = other.PicSource;
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
				Char = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				AvgId = input.ReadString();
				break;
			case 48u:
				PlotType = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				mainlines_.AddEntriesFrom(input, _repeated_mainlines_codec);
				break;
			case 64u:
				PrePlot = input.ReadInt32();
				break;
			case 72u:
				UnlockAffinityLevel = input.ReadInt32();
				break;
			case 80u:
				UnlockSkinId = input.ReadInt32();
				break;
			case 88u:
				ConnectChatId = input.ReadInt32();
				break;
			case 98u:
				CharAdvanceCond = input.ReadString();
				break;
			case 106u:
				Rewards = input.ReadString();
				break;
			case 114u:
				PicSource = input.ReadString();
				break;
			}
		}
	}
}
