using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Potential : IMessage<Potential>, IMessage, IEquatable<Potential>, IDeepCloneable<Potential>
{
	private static readonly MessageParser<Potential> _parser = new MessageParser<Potential>(() => new Potential());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int BuildFieldNumber = 3;

	private int build_;

	public const int BranchTypeFieldNumber = 4;

	private int branchType_;

	public const int MaxLevelFieldNumber = 5;

	private int maxLevel_;

	public const int ScoreGroupIdFieldNumber = 6;

	private int scoreGroupId_;

	public const int BuildScoreFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_buildScore_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> buildScore_ = new RepeatedField<int>();

	public const int GameBookIdFieldNumber = 8;

	private int gameBookId_;

	public const int EffectGroupIdFieldNumber = 9;

	private int effectGroupId_;

	public const int IsEffectiveFieldNumber = 10;

	private bool isEffective_;

	public const int PotentialTag1FieldNumber = 11;

	private string potentialTag1_ = "";

	public const int PotentialTag2FieldNumber = 12;

	private string potentialTag2_ = "";

	public const int PotentialTag3FieldNumber = 13;

	private string potentialTag3_ = "";

	public const int PotentialTag4FieldNumber = 14;

	private string potentialTag4_ = "";

	public const int CornerFieldNumber = 15;

	private int corner_;

	public const int SpBgFieldNumber = 16;

	private string spBg_ = "";

	public const int SpFaceFieldNumber = 17;

	private string spFace_ = "";

	public const int EffectId1FieldNumber = 18;

	private int effectId1_;

	public const int EffectId2FieldNumber = 19;

	private int effectId2_;

	public const int EffectId3FieldNumber = 20;

	private int effectId3_;

	public const int EffectId4FieldNumber = 21;

	private int effectId4_;

	public const int BriefDescFieldNumber = 22;

	private string briefDesc_ = "";

	public const int DescFieldNumber = 23;

	private string desc_ = "";

	public const int Param1FieldNumber = 24;

	private string param1_ = "";

	public const int Param2FieldNumber = 25;

	private string param2_ = "";

	public const int Param3FieldNumber = 26;

	private string param3_ = "";

	public const int Param4FieldNumber = 27;

	private string param4_ = "";

	public const int Param5FieldNumber = 28;

	private string param5_ = "";

	public const int Param6FieldNumber = 29;

	private string param6_ = "";

	public const int Param7FieldNumber = 30;

	private string param7_ = "";

	public const int Param8FieldNumber = 31;

	private string param8_ = "";

	public const int Param9FieldNumber = 32;

	private string param9_ = "";

	public const int Param10FieldNumber = 33;

	private string param10_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Potential> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(658);

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
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Build
	{
		get
		{
			return build_;
		}
		set
		{
			build_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BranchType
	{
		get
		{
			return branchType_;
		}
		set
		{
			branchType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreGroupId
	{
		get
		{
			return scoreGroupId_;
		}
		set
		{
			scoreGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BuildScore => buildScore_;

	[DebuggerNonUserCode]
	public int GameBookId
	{
		get
		{
			return gameBookId_;
		}
		set
		{
			gameBookId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectGroupId
	{
		get
		{
			return effectGroupId_;
		}
		set
		{
			effectGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsEffective
	{
		get
		{
			return isEffective_;
		}
		set
		{
			isEffective_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PotentialTag1
	{
		get
		{
			return potentialTag1_;
		}
		set
		{
			potentialTag1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialTag2
	{
		get
		{
			return potentialTag2_;
		}
		set
		{
			potentialTag2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialTag3
	{
		get
		{
			return potentialTag3_;
		}
		set
		{
			potentialTag3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PotentialTag4
	{
		get
		{
			return potentialTag4_;
		}
		set
		{
			potentialTag4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Corner
	{
		get
		{
			return corner_;
		}
		set
		{
			corner_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SpBg
	{
		get
		{
			return spBg_;
		}
		set
		{
			spBg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SpFace
	{
		get
		{
			return spFace_;
		}
		set
		{
			spFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EffectId1
	{
		get
		{
			return effectId1_;
		}
		set
		{
			effectId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId2
	{
		get
		{
			return effectId2_;
		}
		set
		{
			effectId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId3
	{
		get
		{
			return effectId3_;
		}
		set
		{
			effectId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectId4
	{
		get
		{
			return effectId4_;
		}
		set
		{
			effectId4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BriefDesc
	{
		get
		{
			return briefDesc_;
		}
		set
		{
			briefDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param6
	{
		get
		{
			return param6_;
		}
		set
		{
			param6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param7
	{
		get
		{
			return param7_;
		}
		set
		{
			param7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param8
	{
		get
		{
			return param8_;
		}
		set
		{
			param8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param9
	{
		get
		{
			return param9_;
		}
		set
		{
			param9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param10
	{
		get
		{
			return param10_;
		}
		set
		{
			param10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Potential()
	{
	}

	[DebuggerNonUserCode]
	public Potential(Potential other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		build_ = other.build_;
		branchType_ = other.branchType_;
		maxLevel_ = other.maxLevel_;
		scoreGroupId_ = other.scoreGroupId_;
		buildScore_ = other.buildScore_.Clone();
		gameBookId_ = other.gameBookId_;
		effectGroupId_ = other.effectGroupId_;
		isEffective_ = other.isEffective_;
		potentialTag1_ = other.potentialTag1_;
		potentialTag2_ = other.potentialTag2_;
		potentialTag3_ = other.potentialTag3_;
		potentialTag4_ = other.potentialTag4_;
		corner_ = other.corner_;
		spBg_ = other.spBg_;
		spFace_ = other.spFace_;
		effectId1_ = other.effectId1_;
		effectId2_ = other.effectId2_;
		effectId3_ = other.effectId3_;
		effectId4_ = other.effectId4_;
		briefDesc_ = other.briefDesc_;
		desc_ = other.desc_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		param8_ = other.param8_;
		param9_ = other.param9_;
		param10_ = other.param10_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Potential Clone()
	{
		return new Potential(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Potential);
	}

	[DebuggerNonUserCode]
	public bool Equals(Potential other)
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
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Build != other.Build)
		{
			return false;
		}
		if (BranchType != other.BranchType)
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (ScoreGroupId != other.ScoreGroupId)
		{
			return false;
		}
		if (!buildScore_.Equals(other.buildScore_))
		{
			return false;
		}
		if (GameBookId != other.GameBookId)
		{
			return false;
		}
		if (EffectGroupId != other.EffectGroupId)
		{
			return false;
		}
		if (IsEffective != other.IsEffective)
		{
			return false;
		}
		if (PotentialTag1 != other.PotentialTag1)
		{
			return false;
		}
		if (PotentialTag2 != other.PotentialTag2)
		{
			return false;
		}
		if (PotentialTag3 != other.PotentialTag3)
		{
			return false;
		}
		if (PotentialTag4 != other.PotentialTag4)
		{
			return false;
		}
		if (Corner != other.Corner)
		{
			return false;
		}
		if (SpBg != other.SpBg)
		{
			return false;
		}
		if (SpFace != other.SpFace)
		{
			return false;
		}
		if (EffectId1 != other.EffectId1)
		{
			return false;
		}
		if (EffectId2 != other.EffectId2)
		{
			return false;
		}
		if (EffectId3 != other.EffectId3)
		{
			return false;
		}
		if (EffectId4 != other.EffectId4)
		{
			return false;
		}
		if (BriefDesc != other.BriefDesc)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
		{
			return false;
		}
		if (Param6 != other.Param6)
		{
			return false;
		}
		if (Param7 != other.Param7)
		{
			return false;
		}
		if (Param8 != other.Param8)
		{
			return false;
		}
		if (Param9 != other.Param9)
		{
			return false;
		}
		if (Param10 != other.Param10)
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
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Build != 0)
		{
			num ^= Build.GetHashCode();
		}
		if (BranchType != 0)
		{
			num ^= BranchType.GetHashCode();
		}
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		if (ScoreGroupId != 0)
		{
			num ^= ScoreGroupId.GetHashCode();
		}
		num ^= buildScore_.GetHashCode();
		if (GameBookId != 0)
		{
			num ^= GameBookId.GetHashCode();
		}
		if (EffectGroupId != 0)
		{
			num ^= EffectGroupId.GetHashCode();
		}
		if (IsEffective)
		{
			num ^= IsEffective.GetHashCode();
		}
		if (PotentialTag1.Length != 0)
		{
			num ^= PotentialTag1.GetHashCode();
		}
		if (PotentialTag2.Length != 0)
		{
			num ^= PotentialTag2.GetHashCode();
		}
		if (PotentialTag3.Length != 0)
		{
			num ^= PotentialTag3.GetHashCode();
		}
		if (PotentialTag4.Length != 0)
		{
			num ^= PotentialTag4.GetHashCode();
		}
		if (Corner != 0)
		{
			num ^= Corner.GetHashCode();
		}
		if (SpBg.Length != 0)
		{
			num ^= SpBg.GetHashCode();
		}
		if (SpFace.Length != 0)
		{
			num ^= SpFace.GetHashCode();
		}
		if (EffectId1 != 0)
		{
			num ^= EffectId1.GetHashCode();
		}
		if (EffectId2 != 0)
		{
			num ^= EffectId2.GetHashCode();
		}
		if (EffectId3 != 0)
		{
			num ^= EffectId3.GetHashCode();
		}
		if (EffectId4 != 0)
		{
			num ^= EffectId4.GetHashCode();
		}
		if (BriefDesc.Length != 0)
		{
			num ^= BriefDesc.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
		}
		if (Param6.Length != 0)
		{
			num ^= Param6.GetHashCode();
		}
		if (Param7.Length != 0)
		{
			num ^= Param7.GetHashCode();
		}
		if (Param8.Length != 0)
		{
			num ^= Param8.GetHashCode();
		}
		if (Param9.Length != 0)
		{
			num ^= Param9.GetHashCode();
		}
		if (Param10.Length != 0)
		{
			num ^= Param10.GetHashCode();
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
		if (CharId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharId);
		}
		if (Build != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Build);
		}
		if (BranchType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BranchType);
		}
		if (MaxLevel != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MaxLevel);
		}
		if (ScoreGroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ScoreGroupId);
		}
		buildScore_.WriteTo(output, _repeated_buildScore_codec);
		if (GameBookId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(GameBookId);
		}
		if (EffectGroupId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EffectGroupId);
		}
		if (IsEffective)
		{
			output.WriteRawTag(80);
			output.WriteBool(IsEffective);
		}
		if (PotentialTag1.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(PotentialTag1);
		}
		if (PotentialTag2.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(PotentialTag2);
		}
		if (PotentialTag3.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(PotentialTag3);
		}
		if (PotentialTag4.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(PotentialTag4);
		}
		if (Corner != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Corner);
		}
		if (SpBg.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(SpBg);
		}
		if (SpFace.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(SpFace);
		}
		if (EffectId1 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(EffectId1);
		}
		if (EffectId2 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(EffectId2);
		}
		if (EffectId3 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(EffectId3);
		}
		if (EffectId4 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(EffectId4);
		}
		if (BriefDesc.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(Desc);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(226, 1);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(234, 1);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(242, 1);
			output.WriteString(Param7);
		}
		if (Param8.Length != 0)
		{
			output.WriteRawTag(250, 1);
			output.WriteString(Param8);
		}
		if (Param9.Length != 0)
		{
			output.WriteRawTag(130, 2);
			output.WriteString(Param9);
		}
		if (Param10.Length != 0)
		{
			output.WriteRawTag(138, 2);
			output.WriteString(Param10);
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
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Build != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Build);
		}
		if (BranchType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BranchType);
		}
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		if (ScoreGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreGroupId);
		}
		num += buildScore_.CalculateSize(_repeated_buildScore_codec);
		if (GameBookId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GameBookId);
		}
		if (EffectGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectGroupId);
		}
		if (IsEffective)
		{
			num += 2;
		}
		if (PotentialTag1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialTag1);
		}
		if (PotentialTag2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialTag2);
		}
		if (PotentialTag3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialTag3);
		}
		if (PotentialTag4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PotentialTag4);
		}
		if (Corner != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Corner);
		}
		if (SpBg.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SpBg);
		}
		if (SpFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SpFace);
		}
		if (EffectId1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectId1);
		}
		if (EffectId2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectId2);
		}
		if (EffectId3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectId3);
		}
		if (EffectId4 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectId4);
		}
		if (BriefDesc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Param1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (Param6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (Param8.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param8);
		}
		if (Param9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param9);
		}
		if (Param10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param10);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Potential other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Build != 0)
			{
				Build = other.Build;
			}
			if (other.BranchType != 0)
			{
				BranchType = other.BranchType;
			}
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			if (other.ScoreGroupId != 0)
			{
				ScoreGroupId = other.ScoreGroupId;
			}
			buildScore_.Add(other.buildScore_);
			if (other.GameBookId != 0)
			{
				GameBookId = other.GameBookId;
			}
			if (other.EffectGroupId != 0)
			{
				EffectGroupId = other.EffectGroupId;
			}
			if (other.IsEffective)
			{
				IsEffective = other.IsEffective;
			}
			if (other.PotentialTag1.Length != 0)
			{
				PotentialTag1 = other.PotentialTag1;
			}
			if (other.PotentialTag2.Length != 0)
			{
				PotentialTag2 = other.PotentialTag2;
			}
			if (other.PotentialTag3.Length != 0)
			{
				PotentialTag3 = other.PotentialTag3;
			}
			if (other.PotentialTag4.Length != 0)
			{
				PotentialTag4 = other.PotentialTag4;
			}
			if (other.Corner != 0)
			{
				Corner = other.Corner;
			}
			if (other.SpBg.Length != 0)
			{
				SpBg = other.SpBg;
			}
			if (other.SpFace.Length != 0)
			{
				SpFace = other.SpFace;
			}
			if (other.EffectId1 != 0)
			{
				EffectId1 = other.EffectId1;
			}
			if (other.EffectId2 != 0)
			{
				EffectId2 = other.EffectId2;
			}
			if (other.EffectId3 != 0)
			{
				EffectId3 = other.EffectId3;
			}
			if (other.EffectId4 != 0)
			{
				EffectId4 = other.EffectId4;
			}
			if (other.BriefDesc.Length != 0)
			{
				BriefDesc = other.BriefDesc;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
			}
			if (other.Param6.Length != 0)
			{
				Param6 = other.Param6;
			}
			if (other.Param7.Length != 0)
			{
				Param7 = other.Param7;
			}
			if (other.Param8.Length != 0)
			{
				Param8 = other.Param8;
			}
			if (other.Param9.Length != 0)
			{
				Param9 = other.Param9;
			}
			if (other.Param10.Length != 0)
			{
				Param10 = other.Param10;
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
				CharId = input.ReadInt32();
				break;
			case 24u:
				Build = input.ReadInt32();
				break;
			case 32u:
				BranchType = input.ReadInt32();
				break;
			case 40u:
				MaxLevel = input.ReadInt32();
				break;
			case 48u:
				ScoreGroupId = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				buildScore_.AddEntriesFrom(input, _repeated_buildScore_codec);
				break;
			case 64u:
				GameBookId = input.ReadInt32();
				break;
			case 72u:
				EffectGroupId = input.ReadInt32();
				break;
			case 80u:
				IsEffective = input.ReadBool();
				break;
			case 90u:
				PotentialTag1 = input.ReadString();
				break;
			case 98u:
				PotentialTag2 = input.ReadString();
				break;
			case 106u:
				PotentialTag3 = input.ReadString();
				break;
			case 114u:
				PotentialTag4 = input.ReadString();
				break;
			case 120u:
				Corner = input.ReadInt32();
				break;
			case 130u:
				SpBg = input.ReadString();
				break;
			case 138u:
				SpFace = input.ReadString();
				break;
			case 144u:
				EffectId1 = input.ReadInt32();
				break;
			case 152u:
				EffectId2 = input.ReadInt32();
				break;
			case 160u:
				EffectId3 = input.ReadInt32();
				break;
			case 168u:
				EffectId4 = input.ReadInt32();
				break;
			case 178u:
				BriefDesc = input.ReadString();
				break;
			case 186u:
				Desc = input.ReadString();
				break;
			case 194u:
				Param1 = input.ReadString();
				break;
			case 202u:
				Param2 = input.ReadString();
				break;
			case 210u:
				Param3 = input.ReadString();
				break;
			case 218u:
				Param4 = input.ReadString();
				break;
			case 226u:
				Param5 = input.ReadString();
				break;
			case 234u:
				Param6 = input.ReadString();
				break;
			case 242u:
				Param7 = input.ReadString();
				break;
			case 250u:
				Param8 = input.ReadString();
				break;
			case 258u:
				Param9 = input.ReadString();
				break;
			case 266u:
				Param10 = input.ReadString();
				break;
			}
		}
	}
}
