using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class SceneMap : IMessage<SceneMap>, IMessage, IEquatable<SceneMap>, IDeepCloneable<SceneMap>
{
	private static readonly MessageParser<SceneMap> _parser = new MessageParser<SceneMap>(() => new SceneMap());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int MapDataPathFieldNumber = 2;

	private string mapDataPath_ = "";

	public const int ExternalParamFieldNumber = 3;

	private string externalParam_ = "";

	public const int AudioIDFieldNumber = 4;

	private int audioID_;

	public const int SpCharIDFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_spCharID_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> spCharID_ = new RepeatedField<int>();

	public const int SpLogicPathFieldNumber = 6;

	private static readonly FieldCodec<string> _repeated_spLogicPath_codec = FieldCodec.ForString(50u);

	private readonly RepeatedField<string> spLogicPath_ = new RepeatedField<string>();

	public const int SpBattlePanelPathFieldNumber = 7;

	private string spBattlePanelPath_ = "";

	public const int SkipWinActionFieldNumber = 8;

	private int skipWinAction_;

	public const int TimelinePathFieldNumber = 9;

	private static readonly FieldCodec<string> _repeated_timelinePath_codec = FieldCodec.ForString(74u);

	private readonly RepeatedField<string> timelinePath_ = new RepeatedField<string>();

	public const int ActivityStrikeSystemFieldNumber = 10;

	private bool activityStrikeSystem_;

	[DebuggerNonUserCode]
	public static MessageParser<SceneMap> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[52];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string MapDataPath
	{
		get
		{
			return mapDataPath_;
		}
		set
		{
			mapDataPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ExternalParam
	{
		get
		{
			return externalParam_;
		}
		set
		{
			externalParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AudioID
	{
		get
		{
			return audioID_;
		}
		set
		{
			audioID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SpCharID => spCharID_;

	[DebuggerNonUserCode]
	public RepeatedField<string> SpLogicPath => spLogicPath_;

	[DebuggerNonUserCode]
	public string SpBattlePanelPath
	{
		get
		{
			return spBattlePanelPath_;
		}
		set
		{
			spBattlePanelPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SkipWinAction
	{
		get
		{
			return skipWinAction_;
		}
		set
		{
			skipWinAction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> TimelinePath => timelinePath_;

	[DebuggerNonUserCode]
	public bool ActivityStrikeSystem
	{
		get
		{
			return activityStrikeSystem_;
		}
		set
		{
			activityStrikeSystem_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SceneMap()
	{
	}

	[DebuggerNonUserCode]
	public SceneMap(SceneMap other)
		: this()
	{
		iD_ = other.iD_;
		mapDataPath_ = other.mapDataPath_;
		externalParam_ = other.externalParam_;
		audioID_ = other.audioID_;
		spCharID_ = other.spCharID_.Clone();
		spLogicPath_ = other.spLogicPath_.Clone();
		spBattlePanelPath_ = other.spBattlePanelPath_;
		skipWinAction_ = other.skipWinAction_;
		timelinePath_ = other.timelinePath_.Clone();
		activityStrikeSystem_ = other.activityStrikeSystem_;
	}

	[DebuggerNonUserCode]
	public SceneMap Clone()
	{
		return new SceneMap(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SceneMap);
	}

	[DebuggerNonUserCode]
	public bool Equals(SceneMap other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (MapDataPath != other.MapDataPath)
		{
			return false;
		}
		if (ExternalParam != other.ExternalParam)
		{
			return false;
		}
		if (AudioID != other.AudioID)
		{
			return false;
		}
		if (!spCharID_.Equals(other.spCharID_))
		{
			return false;
		}
		if (!spLogicPath_.Equals(other.spLogicPath_))
		{
			return false;
		}
		if (SpBattlePanelPath != other.SpBattlePanelPath)
		{
			return false;
		}
		if (SkipWinAction != other.SkipWinAction)
		{
			return false;
		}
		if (!timelinePath_.Equals(other.timelinePath_))
		{
			return false;
		}
		if (ActivityStrikeSystem != other.ActivityStrikeSystem)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (MapDataPath.Length != 0)
		{
			num ^= MapDataPath.GetHashCode();
		}
		if (ExternalParam.Length != 0)
		{
			num ^= ExternalParam.GetHashCode();
		}
		if (AudioID != 0)
		{
			num ^= AudioID.GetHashCode();
		}
		num ^= spCharID_.GetHashCode();
		num ^= spLogicPath_.GetHashCode();
		if (SpBattlePanelPath.Length != 0)
		{
			num ^= SpBattlePanelPath.GetHashCode();
		}
		if (SkipWinAction != 0)
		{
			num ^= SkipWinAction.GetHashCode();
		}
		num ^= timelinePath_.GetHashCode();
		if (ActivityStrikeSystem)
		{
			num ^= ActivityStrikeSystem.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (MapDataPath.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(MapDataPath);
		}
		if (ExternalParam.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ExternalParam);
		}
		if (AudioID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AudioID);
		}
		spCharID_.WriteTo(output, _repeated_spCharID_codec);
		spLogicPath_.WriteTo(output, _repeated_spLogicPath_codec);
		if (SpBattlePanelPath.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(SpBattlePanelPath);
		}
		if (SkipWinAction != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SkipWinAction);
		}
		timelinePath_.WriteTo(output, _repeated_timelinePath_codec);
		if (ActivityStrikeSystem)
		{
			output.WriteRawTag(80);
			output.WriteBool(ActivityStrikeSystem);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (MapDataPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MapDataPath);
		}
		if (ExternalParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ExternalParam);
		}
		if (AudioID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioID);
		}
		num += spCharID_.CalculateSize(_repeated_spCharID_codec);
		num += spLogicPath_.CalculateSize(_repeated_spLogicPath_codec);
		if (SpBattlePanelPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpBattlePanelPath);
		}
		if (SkipWinAction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkipWinAction);
		}
		num += timelinePath_.CalculateSize(_repeated_timelinePath_codec);
		if (ActivityStrikeSystem)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SceneMap other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.MapDataPath.Length != 0)
			{
				MapDataPath = other.MapDataPath;
			}
			if (other.ExternalParam.Length != 0)
			{
				ExternalParam = other.ExternalParam;
			}
			if (other.AudioID != 0)
			{
				AudioID = other.AudioID;
			}
			spCharID_.Add(other.spCharID_);
			spLogicPath_.Add(other.spLogicPath_);
			if (other.SpBattlePanelPath.Length != 0)
			{
				SpBattlePanelPath = other.SpBattlePanelPath;
			}
			if (other.SkipWinAction != 0)
			{
				SkipWinAction = other.SkipWinAction;
			}
			timelinePath_.Add(other.timelinePath_);
			if (other.ActivityStrikeSystem)
			{
				ActivityStrikeSystem = other.ActivityStrikeSystem;
			}
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 18u:
				MapDataPath = input.ReadString();
				break;
			case 26u:
				ExternalParam = input.ReadString();
				break;
			case 32u:
				AudioID = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				spCharID_.AddEntriesFrom(input, _repeated_spCharID_codec);
				break;
			case 50u:
				spLogicPath_.AddEntriesFrom(input, _repeated_spLogicPath_codec);
				break;
			case 58u:
				SpBattlePanelPath = input.ReadString();
				break;
			case 64u:
				SkipWinAction = input.ReadInt32();
				break;
			case 74u:
				timelinePath_.AddEntriesFrom(input, _repeated_timelinePath_codec);
				break;
			case 80u:
				ActivityStrikeSystem = input.ReadBool();
				break;
			}
		}
	}
}
