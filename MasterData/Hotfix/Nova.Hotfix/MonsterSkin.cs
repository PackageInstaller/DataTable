using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterSkin : IMessage<MonsterSkin>, IMessage, IEquatable<MonsterSkin>, IDeepCloneable<MonsterSkin>
{
	private static readonly MessageParser<MonsterSkin> _parser = new MessageParser<MonsterSkin>(() => new MonsterSkin());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MonsterManualFieldNumber = 2;

	private int monsterManual_;

	public const int ModelFieldNumber = 3;

	private string model_ = "";

	public const int RunAnimationSpdFieldNumber = 4;

	private int runAnimationSpd_;

	public const int WalkAnimationSpdFieldNumber = 5;

	private int walkAnimationSpd_;

	public const int BarHeightFieldNumber = 6;

	private int barHeight_;

	public const int ModelScaleFieldNumber = 7;

	private int modelScale_;

	public const int ColliderScaleFieldNumber = 8;

	private int colliderScale_;

	public const int ForbiddenBehitRotFieldNumber = 9;

	private bool forbiddenBehitRot_;

	public const int EffectScaleValueFieldNumber = 10;

	private int effectScaleValue_;

	public const int HitFxRadialOffsetFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_hitFxRadialOffset_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> hitFxRadialOffset_ = new RepeatedField<int>();

	public const int TagEffectScaleValueFieldNumber = 12;

	private int tagEffectScaleValue_;

	[DebuggerNonUserCode]
	public static MessageParser<MonsterSkin> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(582);

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
	public int MonsterManual
	{
		get
		{
			return monsterManual_;
		}
		set
		{
			monsterManual_ = value;
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
	public int BarHeight
	{
		get
		{
			return barHeight_;
		}
		set
		{
			barHeight_ = value;
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
	public RepeatedField<int> HitFxRadialOffset => hitFxRadialOffset_;

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
	public MonsterSkin()
	{
	}

	[DebuggerNonUserCode]
	public MonsterSkin(MonsterSkin other)
		: this()
	{
		id_ = other.id_;
		monsterManual_ = other.monsterManual_;
		model_ = other.model_;
		runAnimationSpd_ = other.runAnimationSpd_;
		walkAnimationSpd_ = other.walkAnimationSpd_;
		barHeight_ = other.barHeight_;
		modelScale_ = other.modelScale_;
		colliderScale_ = other.colliderScale_;
		forbiddenBehitRot_ = other.forbiddenBehitRot_;
		effectScaleValue_ = other.effectScaleValue_;
		hitFxRadialOffset_ = other.hitFxRadialOffset_.Clone();
		tagEffectScaleValue_ = other.tagEffectScaleValue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterSkin Clone()
	{
		return new MonsterSkin(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterSkin);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterSkin other)
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
		if (MonsterManual != other.MonsterManual)
		{
			return false;
		}
		if (Model != other.Model)
		{
			return false;
		}
		if (RunAnimationSpd != other.RunAnimationSpd)
		{
			return false;
		}
		if (WalkAnimationSpd != other.WalkAnimationSpd)
		{
			return false;
		}
		if (BarHeight != other.BarHeight)
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
		if (ForbiddenBehitRot != other.ForbiddenBehitRot)
		{
			return false;
		}
		if (EffectScaleValue != other.EffectScaleValue)
		{
			return false;
		}
		if (!hitFxRadialOffset_.Equals(other.hitFxRadialOffset_))
		{
			return false;
		}
		if (TagEffectScaleValue != other.TagEffectScaleValue)
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
		if (MonsterManual != 0)
		{
			num ^= MonsterManual.GetHashCode();
		}
		if (Model.Length != 0)
		{
			num ^= Model.GetHashCode();
		}
		if (RunAnimationSpd != 0)
		{
			num ^= RunAnimationSpd.GetHashCode();
		}
		if (WalkAnimationSpd != 0)
		{
			num ^= WalkAnimationSpd.GetHashCode();
		}
		if (BarHeight != 0)
		{
			num ^= BarHeight.GetHashCode();
		}
		if (ModelScale != 0)
		{
			num ^= ModelScale.GetHashCode();
		}
		if (ColliderScale != 0)
		{
			num ^= ColliderScale.GetHashCode();
		}
		if (ForbiddenBehitRot)
		{
			num ^= ForbiddenBehitRot.GetHashCode();
		}
		if (EffectScaleValue != 0)
		{
			num ^= EffectScaleValue.GetHashCode();
		}
		num ^= hitFxRadialOffset_.GetHashCode();
		if (TagEffectScaleValue != 0)
		{
			num ^= TagEffectScaleValue.GetHashCode();
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
		if (MonsterManual != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MonsterManual);
		}
		if (Model.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Model);
		}
		if (RunAnimationSpd != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(RunAnimationSpd);
		}
		if (WalkAnimationSpd != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(WalkAnimationSpd);
		}
		if (BarHeight != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(BarHeight);
		}
		if (ModelScale != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ModelScale);
		}
		if (ColliderScale != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ColliderScale);
		}
		if (ForbiddenBehitRot)
		{
			output.WriteRawTag(72);
			output.WriteBool(ForbiddenBehitRot);
		}
		if (EffectScaleValue != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(EffectScaleValue);
		}
		hitFxRadialOffset_.WriteTo(output, _repeated_hitFxRadialOffset_codec);
		if (TagEffectScaleValue != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TagEffectScaleValue);
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
		if (MonsterManual != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterManual);
		}
		if (Model.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Model);
		}
		if (RunAnimationSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RunAnimationSpd);
		}
		if (WalkAnimationSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WalkAnimationSpd);
		}
		if (BarHeight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BarHeight);
		}
		if (ModelScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelScale);
		}
		if (ColliderScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ColliderScale);
		}
		if (ForbiddenBehitRot)
		{
			num += 2;
		}
		if (EffectScaleValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectScaleValue);
		}
		num += hitFxRadialOffset_.CalculateSize(_repeated_hitFxRadialOffset_codec);
		if (TagEffectScaleValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TagEffectScaleValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterSkin other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MonsterManual != 0)
			{
				MonsterManual = other.MonsterManual;
			}
			if (other.Model.Length != 0)
			{
				Model = other.Model;
			}
			if (other.RunAnimationSpd != 0)
			{
				RunAnimationSpd = other.RunAnimationSpd;
			}
			if (other.WalkAnimationSpd != 0)
			{
				WalkAnimationSpd = other.WalkAnimationSpd;
			}
			if (other.BarHeight != 0)
			{
				BarHeight = other.BarHeight;
			}
			if (other.ModelScale != 0)
			{
				ModelScale = other.ModelScale;
			}
			if (other.ColliderScale != 0)
			{
				ColliderScale = other.ColliderScale;
			}
			if (other.ForbiddenBehitRot)
			{
				ForbiddenBehitRot = other.ForbiddenBehitRot;
			}
			if (other.EffectScaleValue != 0)
			{
				EffectScaleValue = other.EffectScaleValue;
			}
			hitFxRadialOffset_.Add(other.hitFxRadialOffset_);
			if (other.TagEffectScaleValue != 0)
			{
				TagEffectScaleValue = other.TagEffectScaleValue;
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
				MonsterManual = input.ReadInt32();
				break;
			case 26u:
				Model = input.ReadString();
				break;
			case 32u:
				RunAnimationSpd = input.ReadInt32();
				break;
			case 40u:
				WalkAnimationSpd = input.ReadInt32();
				break;
			case 48u:
				BarHeight = input.ReadInt32();
				break;
			case 56u:
				ModelScale = input.ReadInt32();
				break;
			case 64u:
				ColliderScale = input.ReadInt32();
				break;
			case 72u:
				ForbiddenBehitRot = input.ReadBool();
				break;
			case 80u:
				EffectScaleValue = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				hitFxRadialOffset_.AddEntriesFrom(input, _repeated_hitFxRadialOffset_codec);
				break;
			case 96u:
				TagEffectScaleValue = input.ReadInt32();
				break;
			}
		}
	}
}
