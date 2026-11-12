using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerMap : IMessage<StarTowerMap>, IMessage, IEquatable<StarTowerMap>, IDeepCloneable<StarTowerMap>
{
	private static readonly MessageParser<StarTowerMap> _parser = new MessageParser<StarTowerMap>(() => new StarTowerMap());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SceneResFieldNumber = 2;

	private string sceneRes_ = "";

	public const int BGSceneResFieldNumber = 3;

	private string bGSceneRes_ = "";

	public const int ThemeFieldNumber = 4;

	private int theme_;

	public const int PrefabNumFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_prefabNum_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> prefabNum_ = new RepeatedField<int>();

	public const int MirFieldNumber = 6;

	private bool mir_;

	public const int OutPortNumFieldNumber = 7;

	private int outPortNum_;

	public const int OutPortHintFieldNumber = 8;

	private bool outPortHint_;

	public const int BGMResFieldNumber = 9;

	private string bGMRes_ = "";

	public const int CompleteSoundEffectResFieldNumber = 10;

	private string completeSoundEffectRes_ = "";

	public const int IntroCutsceneFieldNumber = 11;

	private string introCutscene_ = "";

	public const int LevelScriptFieldNumber = 12;

	private string levelScript_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerMap> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(860);

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
	public string SceneRes
	{
		get
		{
			return sceneRes_;
		}
		set
		{
			sceneRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BGSceneRes
	{
		get
		{
			return bGSceneRes_;
		}
		set
		{
			bGSceneRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Theme
	{
		get
		{
			return theme_;
		}
		set
		{
			theme_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PrefabNum => prefabNum_;

	[DebuggerNonUserCode]
	public bool Mir
	{
		get
		{
			return mir_;
		}
		set
		{
			mir_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OutPortNum
	{
		get
		{
			return outPortNum_;
		}
		set
		{
			outPortNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool OutPortHint
	{
		get
		{
			return outPortHint_;
		}
		set
		{
			outPortHint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BGMRes
	{
		get
		{
			return bGMRes_;
		}
		set
		{
			bGMRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CompleteSoundEffectRes
	{
		get
		{
			return completeSoundEffectRes_;
		}
		set
		{
			completeSoundEffectRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IntroCutscene
	{
		get
		{
			return introCutscene_;
		}
		set
		{
			introCutscene_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LevelScript
	{
		get
		{
			return levelScript_;
		}
		set
		{
			levelScript_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StarTowerMap()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerMap(StarTowerMap other)
		: this()
	{
		id_ = other.id_;
		sceneRes_ = other.sceneRes_;
		bGSceneRes_ = other.bGSceneRes_;
		theme_ = other.theme_;
		prefabNum_ = other.prefabNum_.Clone();
		mir_ = other.mir_;
		outPortNum_ = other.outPortNum_;
		outPortHint_ = other.outPortHint_;
		bGMRes_ = other.bGMRes_;
		completeSoundEffectRes_ = other.completeSoundEffectRes_;
		introCutscene_ = other.introCutscene_;
		levelScript_ = other.levelScript_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerMap Clone()
	{
		return new StarTowerMap(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerMap);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerMap other)
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
		if (SceneRes != other.SceneRes)
		{
			return false;
		}
		if (BGSceneRes != other.BGSceneRes)
		{
			return false;
		}
		if (Theme != other.Theme)
		{
			return false;
		}
		if (!prefabNum_.Equals(other.prefabNum_))
		{
			return false;
		}
		if (Mir != other.Mir)
		{
			return false;
		}
		if (OutPortNum != other.OutPortNum)
		{
			return false;
		}
		if (OutPortHint != other.OutPortHint)
		{
			return false;
		}
		if (BGMRes != other.BGMRes)
		{
			return false;
		}
		if (CompleteSoundEffectRes != other.CompleteSoundEffectRes)
		{
			return false;
		}
		if (IntroCutscene != other.IntroCutscene)
		{
			return false;
		}
		if (LevelScript != other.LevelScript)
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
		if (SceneRes.Length != 0)
		{
			num ^= SceneRes.GetHashCode();
		}
		if (BGSceneRes.Length != 0)
		{
			num ^= BGSceneRes.GetHashCode();
		}
		if (Theme != 0)
		{
			num ^= Theme.GetHashCode();
		}
		num ^= prefabNum_.GetHashCode();
		if (Mir)
		{
			num ^= Mir.GetHashCode();
		}
		if (OutPortNum != 0)
		{
			num ^= OutPortNum.GetHashCode();
		}
		if (OutPortHint)
		{
			num ^= OutPortHint.GetHashCode();
		}
		if (BGMRes.Length != 0)
		{
			num ^= BGMRes.GetHashCode();
		}
		if (CompleteSoundEffectRes.Length != 0)
		{
			num ^= CompleteSoundEffectRes.GetHashCode();
		}
		if (IntroCutscene.Length != 0)
		{
			num ^= IntroCutscene.GetHashCode();
		}
		if (LevelScript.Length != 0)
		{
			num ^= LevelScript.GetHashCode();
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
		if (SceneRes.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(SceneRes);
		}
		if (BGSceneRes.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BGSceneRes);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Theme);
		}
		prefabNum_.WriteTo(output, _repeated_prefabNum_codec);
		if (Mir)
		{
			output.WriteRawTag(48);
			output.WriteBool(Mir);
		}
		if (OutPortNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(OutPortNum);
		}
		if (OutPortHint)
		{
			output.WriteRawTag(64);
			output.WriteBool(OutPortHint);
		}
		if (BGMRes.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(BGMRes);
		}
		if (CompleteSoundEffectRes.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(CompleteSoundEffectRes);
		}
		if (IntroCutscene.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(LevelScript);
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
		if (SceneRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneRes);
		}
		if (BGSceneRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGSceneRes);
		}
		if (Theme != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Theme);
		}
		num += prefabNum_.CalculateSize(_repeated_prefabNum_codec);
		if (Mir)
		{
			num += 2;
		}
		if (OutPortNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OutPortNum);
		}
		if (OutPortHint)
		{
			num += 2;
		}
		if (BGMRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGMRes);
		}
		if (CompleteSoundEffectRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteSoundEffectRes);
		}
		if (IntroCutscene.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IntroCutscene);
		}
		if (LevelScript.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelScript);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerMap other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SceneRes.Length != 0)
			{
				SceneRes = other.SceneRes;
			}
			if (other.BGSceneRes.Length != 0)
			{
				BGSceneRes = other.BGSceneRes;
			}
			if (other.Theme != 0)
			{
				Theme = other.Theme;
			}
			prefabNum_.Add(other.prefabNum_);
			if (other.Mir)
			{
				Mir = other.Mir;
			}
			if (other.OutPortNum != 0)
			{
				OutPortNum = other.OutPortNum;
			}
			if (other.OutPortHint)
			{
				OutPortHint = other.OutPortHint;
			}
			if (other.BGMRes.Length != 0)
			{
				BGMRes = other.BGMRes;
			}
			if (other.CompleteSoundEffectRes.Length != 0)
			{
				CompleteSoundEffectRes = other.CompleteSoundEffectRes;
			}
			if (other.IntroCutscene.Length != 0)
			{
				IntroCutscene = other.IntroCutscene;
			}
			if (other.LevelScript.Length != 0)
			{
				LevelScript = other.LevelScript;
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
				SceneRes = input.ReadString();
				break;
			case 26u:
				BGSceneRes = input.ReadString();
				break;
			case 32u:
				Theme = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				prefabNum_.AddEntriesFrom(input, _repeated_prefabNum_codec);
				break;
			case 48u:
				Mir = input.ReadBool();
				break;
			case 56u:
				OutPortNum = input.ReadInt32();
				break;
			case 64u:
				OutPortHint = input.ReadBool();
				break;
			case 74u:
				BGMRes = input.ReadString();
				break;
			case 82u:
				CompleteSoundEffectRes = input.ReadString();
				break;
			case 90u:
				IntroCutscene = input.ReadString();
				break;
			case 98u:
				LevelScript = input.ReadString();
				break;
			}
		}
	}
}
