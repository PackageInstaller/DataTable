using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterSkin : IMessage<CharacterSkin>, IMessage, IEquatable<CharacterSkin>, IDeepCloneable<CharacterSkin>
{
	private static readonly MessageParser<CharacterSkin> _parser = new MessageParser<CharacterSkin>(() => new CharacterSkin());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int IsShowFieldNumber = 4;

	private bool isShow_;

	public const int CharIdFieldNumber = 5;

	private int charId_;

	public const int TypeFieldNumber = 6;

	private int type_;

	public const int SourceDescFieldNumber = 7;

	private int sourceDesc_;

	public const int SkinExtraTagFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_skinExtraTag_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> skinExtraTag_ = new RepeatedField<int>();

	public const int TransformFieldNumber = 9;

	private string transform_ = "";

	public const int WalkAnimationSpdFieldNumber = 10;

	private int walkAnimationSpd_;

	public const int RunAnimationSpdFieldNumber = 11;

	private int runAnimationSpd_;

	public const int SpRunAnimationSpdFieldNumber = 12;

	private int spRunAnimationSpd_;

	public const int ModelScaleFieldNumber = 13;

	private int modelScale_;

	public const int ColliderScaleFieldNumber = 14;

	private int colliderScale_;

	public const int ModelShowScaleFieldNumber = 15;

	private int modelShowScale_;

	public const int ModelEndScaleFieldNumber = 16;

	private int modelEndScale_;

	public const int ForbiddenBehitRotFieldNumber = 17;

	private bool forbiddenBehitRot_;

	public const int IconFieldNumber = 18;

	private string icon_ = "";

	public const int PortraitFieldNumber = 19;

	private string portrait_ = "";

	public const int BgFieldNumber = 20;

	private string bg_ = "";

	public const int OffsetFieldNumber = 21;

	private string offset_ = "";

	public const int L2DFieldNumber = 22;

	private string l2D_ = "";

	public const int CharacterCGFieldNumber = 23;

	private int characterCG_;

	public const int ModelFieldNumber = 24;

	private string model_ = "";

	public const int ModelShowFieldNumber = 25;

	private string modelShow_ = "";

	public const int ModelEndFieldNumber = 26;

	private string modelEnd_ = "";

	public const int GachaL2DFieldNumber = 27;

	private string gachaL2D_ = "";

	public const int SkinThemeFieldNumber = 28;

	private int skinTheme_;

	public const int EffectScaleValueFieldNumber = 29;

	private int effectScaleValue_;

	public const int TagEffectScaleValueFieldNumber = 30;

	private int tagEffectScaleValue_;

	public const int SmoothTimeFieldNumber = 31;

	private int smoothTime_;

	public const int TrialGroupFieldNumber = 32;

	private int trialGroup_;

	[DebuggerNonUserCode]
	public static MessageParser<CharacterSkin> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(168);

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
	public bool IsShow
	{
		get
		{
			return isShow_;
		}
		set
		{
			isShow_ = value;
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
	public int SourceDesc
	{
		get
		{
			return sourceDesc_;
		}
		set
		{
			sourceDesc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SkinExtraTag => skinExtraTag_;

	[DebuggerNonUserCode]
	public string Transform
	{
		get
		{
			return transform_;
		}
		set
		{
			transform_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int WalkAnimationSpd
	{
		get
		{
			return walkAnimationSpd_;
		}
		set
		{
			walkAnimationSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunAnimationSpd
	{
		get
		{
			return runAnimationSpd_;
		}
		set
		{
			runAnimationSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpRunAnimationSpd
	{
		get
		{
			return spRunAnimationSpd_;
		}
		set
		{
			spRunAnimationSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ModelScale
	{
		get
		{
			return modelScale_;
		}
		set
		{
			modelScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ColliderScale
	{
		get
		{
			return colliderScale_;
		}
		set
		{
			colliderScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ModelShowScale
	{
		get
		{
			return modelShowScale_;
		}
		set
		{
			modelShowScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ModelEndScale
	{
		get
		{
			return modelEndScale_;
		}
		set
		{
			modelEndScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ForbiddenBehitRot
	{
		get
		{
			return forbiddenBehitRot_;
		}
		set
		{
			forbiddenBehitRot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Portrait
	{
		get
		{
			return portrait_;
		}
		set
		{
			portrait_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Bg
	{
		get
		{
			return bg_;
		}
		set
		{
			bg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Offset
	{
		get
		{
			return offset_;
		}
		set
		{
			offset_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string L2D
	{
		get
		{
			return l2D_;
		}
		set
		{
			l2D_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CharacterCG
	{
		get
		{
			return characterCG_;
		}
		set
		{
			characterCG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Model
	{
		get
		{
			return model_;
		}
		set
		{
			model_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ModelShow
	{
		get
		{
			return modelShow_;
		}
		set
		{
			modelShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ModelEnd
	{
		get
		{
			return modelEnd_;
		}
		set
		{
			modelEnd_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string GachaL2D
	{
		get
		{
			return gachaL2D_;
		}
		set
		{
			gachaL2D_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SkinTheme
	{
		get
		{
			return skinTheme_;
		}
		set
		{
			skinTheme_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectScaleValue
	{
		get
		{
			return effectScaleValue_;
		}
		set
		{
			effectScaleValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TagEffectScaleValue
	{
		get
		{
			return tagEffectScaleValue_;
		}
		set
		{
			tagEffectScaleValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SmoothTime
	{
		get
		{
			return smoothTime_;
		}
		set
		{
			smoothTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TrialGroup
	{
		get
		{
			return trialGroup_;
		}
		set
		{
			trialGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CharacterSkin()
	{
	}

	[DebuggerNonUserCode]
	public CharacterSkin(CharacterSkin other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		isShow_ = other.isShow_;
		charId_ = other.charId_;
		type_ = other.type_;
		sourceDesc_ = other.sourceDesc_;
		skinExtraTag_ = other.skinExtraTag_.Clone();
		transform_ = other.transform_;
		walkAnimationSpd_ = other.walkAnimationSpd_;
		runAnimationSpd_ = other.runAnimationSpd_;
		spRunAnimationSpd_ = other.spRunAnimationSpd_;
		modelScale_ = other.modelScale_;
		colliderScale_ = other.colliderScale_;
		modelShowScale_ = other.modelShowScale_;
		modelEndScale_ = other.modelEndScale_;
		forbiddenBehitRot_ = other.forbiddenBehitRot_;
		icon_ = other.icon_;
		portrait_ = other.portrait_;
		bg_ = other.bg_;
		offset_ = other.offset_;
		l2D_ = other.l2D_;
		characterCG_ = other.characterCG_;
		model_ = other.model_;
		modelShow_ = other.modelShow_;
		modelEnd_ = other.modelEnd_;
		gachaL2D_ = other.gachaL2D_;
		skinTheme_ = other.skinTheme_;
		effectScaleValue_ = other.effectScaleValue_;
		tagEffectScaleValue_ = other.tagEffectScaleValue_;
		smoothTime_ = other.smoothTime_;
		trialGroup_ = other.trialGroup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterSkin Clone()
	{
		return new CharacterSkin(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterSkin);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterSkin other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (IsShow != other.IsShow)
		{
			return false;
		}
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (SourceDesc != other.SourceDesc)
		{
			return false;
		}
		if (!skinExtraTag_.Equals(other.skinExtraTag_))
		{
			return false;
		}
		if (Transform != other.Transform)
		{
			return false;
		}
		if (WalkAnimationSpd != other.WalkAnimationSpd)
		{
			return false;
		}
		if (RunAnimationSpd != other.RunAnimationSpd)
		{
			return false;
		}
		if (SpRunAnimationSpd != other.SpRunAnimationSpd)
		{
			return false;
		}
		if (ModelScale != other.ModelScale)
		{
			return false;
		}
		if (ColliderScale != other.ColliderScale)
		{
			return false;
		}
		if (ModelShowScale != other.ModelShowScale)
		{
			return false;
		}
		if (ModelEndScale != other.ModelEndScale)
		{
			return false;
		}
		if (ForbiddenBehitRot != other.ForbiddenBehitRot)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Portrait != other.Portrait)
		{
			return false;
		}
		if (Bg != other.Bg)
		{
			return false;
		}
		if (Offset != other.Offset)
		{
			return false;
		}
		if (L2D != other.L2D)
		{
			return false;
		}
		if (CharacterCG != other.CharacterCG)
		{
			return false;
		}
		if (Model != other.Model)
		{
			return false;
		}
		if (ModelShow != other.ModelShow)
		{
			return false;
		}
		if (ModelEnd != other.ModelEnd)
		{
			return false;
		}
		if (GachaL2D != other.GachaL2D)
		{
			return false;
		}
		if (SkinTheme != other.SkinTheme)
		{
			return false;
		}
		if (EffectScaleValue != other.EffectScaleValue)
		{
			return false;
		}
		if (TagEffectScaleValue != other.TagEffectScaleValue)
		{
			return false;
		}
		if (SmoothTime != other.SmoothTime)
		{
			return false;
		}
		if (TrialGroup != other.TrialGroup)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (SourceDesc != 0)
		{
			num ^= SourceDesc.GetHashCode();
		}
		num ^= skinExtraTag_.GetHashCode();
		if (Transform.Length != 0)
		{
			num ^= Transform.GetHashCode();
		}
		if (WalkAnimationSpd != 0)
		{
			num ^= WalkAnimationSpd.GetHashCode();
		}
		if (RunAnimationSpd != 0)
		{
			num ^= RunAnimationSpd.GetHashCode();
		}
		if (SpRunAnimationSpd != 0)
		{
			num ^= SpRunAnimationSpd.GetHashCode();
		}
		if (ModelScale != 0)
		{
			num ^= ModelScale.GetHashCode();
		}
		if (ColliderScale != 0)
		{
			num ^= ColliderScale.GetHashCode();
		}
		if (ModelShowScale != 0)
		{
			num ^= ModelShowScale.GetHashCode();
		}
		if (ModelEndScale != 0)
		{
			num ^= ModelEndScale.GetHashCode();
		}
		if (ForbiddenBehitRot)
		{
			num ^= ForbiddenBehitRot.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Portrait.Length != 0)
		{
			num ^= Portrait.GetHashCode();
		}
		if (Bg.Length != 0)
		{
			num ^= Bg.GetHashCode();
		}
		if (Offset.Length != 0)
		{
			num ^= Offset.GetHashCode();
		}
		if (L2D.Length != 0)
		{
			num ^= L2D.GetHashCode();
		}
		if (CharacterCG != 0)
		{
			num ^= CharacterCG.GetHashCode();
		}
		if (Model.Length != 0)
		{
			num ^= Model.GetHashCode();
		}
		if (ModelShow.Length != 0)
		{
			num ^= ModelShow.GetHashCode();
		}
		if (ModelEnd.Length != 0)
		{
			num ^= ModelEnd.GetHashCode();
		}
		if (GachaL2D.Length != 0)
		{
			num ^= GachaL2D.GetHashCode();
		}
		if (SkinTheme != 0)
		{
			num ^= SkinTheme.GetHashCode();
		}
		if (EffectScaleValue != 0)
		{
			num ^= EffectScaleValue.GetHashCode();
		}
		if (TagEffectScaleValue != 0)
		{
			num ^= TagEffectScaleValue.GetHashCode();
		}
		if (SmoothTime != 0)
		{
			num ^= SmoothTime.GetHashCode();
		}
		if (TrialGroup != 0)
		{
			num ^= TrialGroup.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (IsShow)
		{
			output.WriteRawTag(32);
			output.WriteBool(IsShow);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CharId);
		}
		if (Type != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type);
		}
		if (SourceDesc != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SourceDesc);
		}
		skinExtraTag_.WriteTo(output, _repeated_skinExtraTag_codec);
		if (Transform.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Transform);
		}
		if (WalkAnimationSpd != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(WalkAnimationSpd);
		}
		if (RunAnimationSpd != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RunAnimationSpd);
		}
		if (SpRunAnimationSpd != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SpRunAnimationSpd);
		}
		if (ModelScale != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ModelScale);
		}
		if (ColliderScale != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(ColliderScale);
		}
		if (ModelShowScale != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ModelShowScale);
		}
		if (ModelEndScale != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(ModelEndScale);
		}
		if (ForbiddenBehitRot)
		{
			output.WriteRawTag(136, 1);
			output.WriteBool(ForbiddenBehitRot);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Icon);
		}
		if (Portrait.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Portrait);
		}
		if (Bg.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Bg);
		}
		if (Offset.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Offset);
		}
		if (L2D.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(L2D);
		}
		if (CharacterCG != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(CharacterCG);
		}
		if (Model.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Model);
		}
		if (ModelShow.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(ModelShow);
		}
		if (ModelEnd.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(ModelEnd);
		}
		if (GachaL2D.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(GachaL2D);
		}
		if (SkinTheme != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(SkinTheme);
		}
		if (EffectScaleValue != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(EffectScaleValue);
		}
		if (TagEffectScaleValue != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(TagEffectScaleValue);
		}
		if (SmoothTime != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(SmoothTime);
		}
		if (TrialGroup != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(TrialGroup);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (IsShow)
		{
			num += 2;
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (SourceDesc != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SourceDesc);
		}
		num += skinExtraTag_.CalculateSize(_repeated_skinExtraTag_codec);
		if (Transform.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Transform);
		}
		if (WalkAnimationSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WalkAnimationSpd);
		}
		if (RunAnimationSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RunAnimationSpd);
		}
		if (SpRunAnimationSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpRunAnimationSpd);
		}
		if (ModelScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelScale);
		}
		if (ColliderScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ColliderScale);
		}
		if (ModelShowScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelShowScale);
		}
		if (ModelEndScale != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ModelEndScale);
		}
		if (ForbiddenBehitRot)
		{
			num += 3;
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Portrait.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Portrait);
		}
		if (Bg.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Bg);
		}
		if (Offset.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Offset);
		}
		if (L2D.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(L2D);
		}
		if (CharacterCG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CharacterCG);
		}
		if (Model.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Model);
		}
		if (ModelShow.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ModelShow);
		}
		if (ModelEnd.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ModelEnd);
		}
		if (GachaL2D.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(GachaL2D);
		}
		if (SkinTheme != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkinTheme);
		}
		if (EffectScaleValue != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectScaleValue);
		}
		if (TagEffectScaleValue != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TagEffectScaleValue);
		}
		if (SmoothTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SmoothTime);
		}
		if (TrialGroup != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TrialGroup);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterSkin other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.IsShow)
			{
				IsShow = other.IsShow;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.SourceDesc != 0)
			{
				SourceDesc = other.SourceDesc;
			}
			skinExtraTag_.Add(other.skinExtraTag_);
			if (other.Transform.Length != 0)
			{
				Transform = other.Transform;
			}
			if (other.WalkAnimationSpd != 0)
			{
				WalkAnimationSpd = other.WalkAnimationSpd;
			}
			if (other.RunAnimationSpd != 0)
			{
				RunAnimationSpd = other.RunAnimationSpd;
			}
			if (other.SpRunAnimationSpd != 0)
			{
				SpRunAnimationSpd = other.SpRunAnimationSpd;
			}
			if (other.ModelScale != 0)
			{
				ModelScale = other.ModelScale;
			}
			if (other.ColliderScale != 0)
			{
				ColliderScale = other.ColliderScale;
			}
			if (other.ModelShowScale != 0)
			{
				ModelShowScale = other.ModelShowScale;
			}
			if (other.ModelEndScale != 0)
			{
				ModelEndScale = other.ModelEndScale;
			}
			if (other.ForbiddenBehitRot)
			{
				ForbiddenBehitRot = other.ForbiddenBehitRot;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Portrait.Length != 0)
			{
				Portrait = other.Portrait;
			}
			if (other.Bg.Length != 0)
			{
				Bg = other.Bg;
			}
			if (other.Offset.Length != 0)
			{
				Offset = other.Offset;
			}
			if (other.L2D.Length != 0)
			{
				L2D = other.L2D;
			}
			if (other.CharacterCG != 0)
			{
				CharacterCG = other.CharacterCG;
			}
			if (other.Model.Length != 0)
			{
				Model = other.Model;
			}
			if (other.ModelShow.Length != 0)
			{
				ModelShow = other.ModelShow;
			}
			if (other.ModelEnd.Length != 0)
			{
				ModelEnd = other.ModelEnd;
			}
			if (other.GachaL2D.Length != 0)
			{
				GachaL2D = other.GachaL2D;
			}
			if (other.SkinTheme != 0)
			{
				SkinTheme = other.SkinTheme;
			}
			if (other.EffectScaleValue != 0)
			{
				EffectScaleValue = other.EffectScaleValue;
			}
			if (other.TagEffectScaleValue != 0)
			{
				TagEffectScaleValue = other.TagEffectScaleValue;
			}
			if (other.SmoothTime != 0)
			{
				SmoothTime = other.SmoothTime;
			}
			if (other.TrialGroup != 0)
			{
				TrialGroup = other.TrialGroup;
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
				Name = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				IsShow = input.ReadBool();
				break;
			case 40u:
				CharId = input.ReadInt32();
				break;
			case 48u:
				Type = input.ReadInt32();
				break;
			case 56u:
				SourceDesc = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				skinExtraTag_.AddEntriesFrom(input, _repeated_skinExtraTag_codec);
				break;
			case 74u:
				Transform = input.ReadString();
				break;
			case 80u:
				WalkAnimationSpd = input.ReadInt32();
				break;
			case 88u:
				RunAnimationSpd = input.ReadInt32();
				break;
			case 96u:
				SpRunAnimationSpd = input.ReadInt32();
				break;
			case 104u:
				ModelScale = input.ReadInt32();
				break;
			case 112u:
				ColliderScale = input.ReadInt32();
				break;
			case 120u:
				ModelShowScale = input.ReadInt32();
				break;
			case 128u:
				ModelEndScale = input.ReadInt32();
				break;
			case 136u:
				ForbiddenBehitRot = input.ReadBool();
				break;
			case 146u:
				Icon = input.ReadString();
				break;
			case 154u:
				Portrait = input.ReadString();
				break;
			case 162u:
				Bg = input.ReadString();
				break;
			case 170u:
				Offset = input.ReadString();
				break;
			case 178u:
				L2D = input.ReadString();
				break;
			case 184u:
				CharacterCG = input.ReadInt32();
				break;
			case 194u:
				Model = input.ReadString();
				break;
			case 202u:
				ModelShow = input.ReadString();
				break;
			case 210u:
				ModelEnd = input.ReadString();
				break;
			case 218u:
				GachaL2D = input.ReadString();
				break;
			case 224u:
				SkinTheme = input.ReadInt32();
				break;
			case 232u:
				EffectScaleValue = input.ReadInt32();
				break;
			case 240u:
				TagEffectScaleValue = input.ReadInt32();
				break;
			case 248u:
				SmoothTime = input.ReadInt32();
				break;
			case 256u:
				TrialGroup = input.ReadInt32();
				break;
			}
		}
	}
}
