using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Skin : IMessage<Skin>, IMessage, IEquatable<Skin>, IDeepCloneable<Skin>
{
	private static readonly MessageParser<Skin> _parser = new MessageParser<Skin>(() => new Skin());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int HeroFieldNumber = 2;

	private int hero_;

	public const int BattleModelPathFieldNumber = 3;

	private string battleModelPath_ = "";

	public const int BattleCameraParamFieldNumber = 4;

	private int battleCameraParam_;

	public const int TransfigurationFieldNumber = 5;

	private int transfiguration_;

	public const int RenderTimelineFieldNumber = 6;

	private string renderTimeline_ = "";

	public const int RenderFlowscriptFieldNumber = 7;

	private string renderFlowscript_ = "";

	public const int AdditionalRenderTimelineArrayFieldNumber = 8;

	private static readonly FieldCodec<string> _repeated_additionalRenderTimelineArray_codec = FieldCodec.ForString(66u);

	private readonly RepeatedField<string> additionalRenderTimelineArray_ = new RepeatedField<string>();

	public const int SourceSpaceAssetPathFieldNumber = 9;

	private string sourceSpaceAssetPath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Skin> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[56];

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
	public int Hero
	{
		get
		{
			return hero_;
		}
		set
		{
			hero_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BattleModelPath
	{
		get
		{
			return battleModelPath_;
		}
		set
		{
			battleModelPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int BattleCameraParam
	{
		get
		{
			return battleCameraParam_;
		}
		set
		{
			battleCameraParam_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Transfiguration
	{
		get
		{
			return transfiguration_;
		}
		set
		{
			transfiguration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RenderTimeline
	{
		get
		{
			return renderTimeline_;
		}
		set
		{
			renderTimeline_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RenderFlowscript
	{
		get
		{
			return renderFlowscript_;
		}
		set
		{
			renderFlowscript_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> AdditionalRenderTimelineArray => additionalRenderTimelineArray_;

	[DebuggerNonUserCode]
	public string SourceSpaceAssetPath
	{
		get
		{
			return sourceSpaceAssetPath_;
		}
		set
		{
			sourceSpaceAssetPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Skin()
	{
	}

	[DebuggerNonUserCode]
	public Skin(Skin other)
		: this()
	{
		iD_ = other.iD_;
		hero_ = other.hero_;
		battleModelPath_ = other.battleModelPath_;
		battleCameraParam_ = other.battleCameraParam_;
		transfiguration_ = other.transfiguration_;
		renderTimeline_ = other.renderTimeline_;
		renderFlowscript_ = other.renderFlowscript_;
		additionalRenderTimelineArray_ = other.additionalRenderTimelineArray_.Clone();
		sourceSpaceAssetPath_ = other.sourceSpaceAssetPath_;
	}

	[DebuggerNonUserCode]
	public Skin Clone()
	{
		return new Skin(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Skin);
	}

	[DebuggerNonUserCode]
	public bool Equals(Skin other)
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
		if (Hero != other.Hero)
		{
			return false;
		}
		if (BattleModelPath != other.BattleModelPath)
		{
			return false;
		}
		if (BattleCameraParam != other.BattleCameraParam)
		{
			return false;
		}
		if (Transfiguration != other.Transfiguration)
		{
			return false;
		}
		if (RenderTimeline != other.RenderTimeline)
		{
			return false;
		}
		if (RenderFlowscript != other.RenderFlowscript)
		{
			return false;
		}
		if (!additionalRenderTimelineArray_.Equals(other.additionalRenderTimelineArray_))
		{
			return false;
		}
		if (SourceSpaceAssetPath != other.SourceSpaceAssetPath)
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
		if (Hero != 0)
		{
			num ^= Hero.GetHashCode();
		}
		if (BattleModelPath.Length != 0)
		{
			num ^= BattleModelPath.GetHashCode();
		}
		if (BattleCameraParam != 0)
		{
			num ^= BattleCameraParam.GetHashCode();
		}
		if (Transfiguration != 0)
		{
			num ^= Transfiguration.GetHashCode();
		}
		if (RenderTimeline.Length != 0)
		{
			num ^= RenderTimeline.GetHashCode();
		}
		if (RenderFlowscript.Length != 0)
		{
			num ^= RenderFlowscript.GetHashCode();
		}
		num ^= additionalRenderTimelineArray_.GetHashCode();
		if (SourceSpaceAssetPath.Length != 0)
		{
			num ^= SourceSpaceAssetPath.GetHashCode();
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
		if (Hero != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Hero);
		}
		if (BattleModelPath.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BattleModelPath);
		}
		if (BattleCameraParam != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BattleCameraParam);
		}
		if (Transfiguration != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Transfiguration);
		}
		if (RenderTimeline.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(RenderTimeline);
		}
		if (RenderFlowscript.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(RenderFlowscript);
		}
		additionalRenderTimelineArray_.WriteTo(output, _repeated_additionalRenderTimelineArray_codec);
		if (SourceSpaceAssetPath.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(SourceSpaceAssetPath);
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
		if (Hero != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hero);
		}
		if (BattleModelPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleModelPath);
		}
		if (BattleCameraParam != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleCameraParam);
		}
		if (Transfiguration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Transfiguration);
		}
		if (RenderTimeline.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RenderTimeline);
		}
		if (RenderFlowscript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RenderFlowscript);
		}
		num += additionalRenderTimelineArray_.CalculateSize(_repeated_additionalRenderTimelineArray_codec);
		if (SourceSpaceAssetPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SourceSpaceAssetPath);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Skin other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Hero != 0)
			{
				Hero = other.Hero;
			}
			if (other.BattleModelPath.Length != 0)
			{
				BattleModelPath = other.BattleModelPath;
			}
			if (other.BattleCameraParam != 0)
			{
				BattleCameraParam = other.BattleCameraParam;
			}
			if (other.Transfiguration != 0)
			{
				Transfiguration = other.Transfiguration;
			}
			if (other.RenderTimeline.Length != 0)
			{
				RenderTimeline = other.RenderTimeline;
			}
			if (other.RenderFlowscript.Length != 0)
			{
				RenderFlowscript = other.RenderFlowscript;
			}
			additionalRenderTimelineArray_.Add(other.additionalRenderTimelineArray_);
			if (other.SourceSpaceAssetPath.Length != 0)
			{
				SourceSpaceAssetPath = other.SourceSpaceAssetPath;
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
			case 16u:
				Hero = input.ReadInt32();
				break;
			case 26u:
				BattleModelPath = input.ReadString();
				break;
			case 32u:
				BattleCameraParam = input.ReadInt32();
				break;
			case 40u:
				Transfiguration = input.ReadInt32();
				break;
			case 50u:
				RenderTimeline = input.ReadString();
				break;
			case 58u:
				RenderFlowscript = input.ReadString();
				break;
			case 66u:
				additionalRenderTimelineArray_.AddEntriesFrom(input, _repeated_additionalRenderTimelineArray_codec);
				break;
			case 74u:
				SourceSpaceAssetPath = input.ReadString();
				break;
			}
		}
	}
}
