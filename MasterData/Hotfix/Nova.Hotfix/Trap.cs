using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Trap : IMessage<Trap>, IMessage, IEquatable<Trap>, IDeepCloneable<Trap>
{
	private static readonly MessageParser<Trap> _parser = new MessageParser<Trap>(() => new Trap());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int FCIdFieldNumber = 3;

	private int fCId_;

	public const int ModelFieldNumber = 4;

	private string model_ = "";

	public const int ModelScaleFieldNumber = 5;

	private int modelScale_;

	public const int BuffFXScaleFieldNumber = 6;

	private int buffFXScale_;

	public const int ColliderScaleFieldNumber = 7;

	private int colliderScale_;

	public const int AttributeIdFieldNumber = 8;

	private string attributeId_ = "";

	public const int TempleteFieldNumber = 9;

	private int templete_;

	public const int BuffIdsFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_buffIds_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> buffIds_ = new RepeatedField<int>();

	public const int TurnOffBuffIdsFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_turnOffBuffIds_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> turnOffBuffIds_ = new RepeatedField<int>();

	public const int TurnOnBuffIdsFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_turnOnBuffIds_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> turnOnBuffIds_ = new RepeatedField<int>();

	public const int InterruptSkillFieldNumber = 13;

	private bool interruptSkill_;

	public const int SubTypeFieldNumber = 14;

	private int subType_;

	public const int FactionFieldNumber = 15;

	private int faction_;

	public const int FilterFieldNumber = 16;

	private static readonly FieldCodec<int> _repeated_filter_codec = FieldCodec.ForInt32(130u);

	private readonly RepeatedField<int> filter_ = new RepeatedField<int>();

	public const int IgnoreCollisionFieldNumber = 17;

	private bool ignoreCollision_;

	public const int ActiveEffFieldNumber = 18;

	private string activeEff_ = "";

	public const int ShapeTypeFieldNumber = 19;

	private int shapeType_;

	public const int WidthFieldNumber = 20;

	private float width_;

	public const int LengthFieldNumber = 21;

	private float length_;

	public const int RadiusFieldNumber = 22;

	private float radius_;

	public const int InnerRadiusFieldNumber = 23;

	private float innerRadius_;

	public const int AngleFieldNumber = 24;

	private float angle_;

	public const int OffsetFieldNumber = 25;

	private static readonly FieldCodec<float> _repeated_offset_codec = FieldCodec.ForFloat(202u);

	private readonly RepeatedField<float> offset_ = new RepeatedField<float>();

	public const int RotationFieldNumber = 26;

	private float rotation_;

	public const int IsMoveFieldNumber = 27;

	private bool isMove_;

	public const int IsBlockFieldNumber = 28;

	private bool isBlock_;

	public const int MovAccFieldNumber = 29;

	private int movAcc_;

	public const int RotSpdFieldNumber = 30;

	private int rotSpd_;

	public const int MoveSpdFieldNumber = 31;

	private int moveSpd_;

	public const int Tag1FieldNumber = 32;

	private string tag1_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Trap> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(998);

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
	public int FCId
	{
		get
		{
			return fCId_;
		}
		set
		{
			fCId_ = value;
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
	public int BuffFXScale
	{
		get
		{
			return buffFXScale_;
		}
		set
		{
			buffFXScale_ = value;
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
	public string AttributeId
	{
		get
		{
			return attributeId_;
		}
		set
		{
			attributeId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Templete
	{
		get
		{
			return templete_;
		}
		set
		{
			templete_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffIds => buffIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> TurnOffBuffIds => turnOffBuffIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> TurnOnBuffIds => turnOnBuffIds_;

	[DebuggerNonUserCode]
	public bool InterruptSkill
	{
		get
		{
			return interruptSkill_;
		}
		set
		{
			interruptSkill_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubType
	{
		get
		{
			return subType_;
		}
		set
		{
			subType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Filter => filter_;

	[DebuggerNonUserCode]
	public bool IgnoreCollision
	{
		get
		{
			return ignoreCollision_;
		}
		set
		{
			ignoreCollision_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ActiveEff
	{
		get
		{
			return activeEff_;
		}
		set
		{
			activeEff_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ShapeType
	{
		get
		{
			return shapeType_;
		}
		set
		{
			shapeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Width
	{
		get
		{
			return width_;
		}
		set
		{
			width_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Length
	{
		get
		{
			return length_;
		}
		set
		{
			length_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Radius
	{
		get
		{
			return radius_;
		}
		set
		{
			radius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float InnerRadius
	{
		get
		{
			return innerRadius_;
		}
		set
		{
			innerRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Angle
	{
		get
		{
			return angle_;
		}
		set
		{
			angle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<float> Offset => offset_;

	[DebuggerNonUserCode]
	public float Rotation
	{
		get
		{
			return rotation_;
		}
		set
		{
			rotation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsMove
	{
		get
		{
			return isMove_;
		}
		set
		{
			isMove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsBlock
	{
		get
		{
			return isBlock_;
		}
		set
		{
			isBlock_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovAcc
	{
		get
		{
			return movAcc_;
		}
		set
		{
			movAcc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotSpd
	{
		get
		{
			return rotSpd_;
		}
		set
		{
			rotSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MoveSpd
	{
		get
		{
			return moveSpd_;
		}
		set
		{
			moveSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Tag1
	{
		get
		{
			return tag1_;
		}
		set
		{
			tag1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Trap()
	{
	}

	[DebuggerNonUserCode]
	public Trap(Trap other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		fCId_ = other.fCId_;
		model_ = other.model_;
		modelScale_ = other.modelScale_;
		buffFXScale_ = other.buffFXScale_;
		colliderScale_ = other.colliderScale_;
		attributeId_ = other.attributeId_;
		templete_ = other.templete_;
		buffIds_ = other.buffIds_.Clone();
		turnOffBuffIds_ = other.turnOffBuffIds_.Clone();
		turnOnBuffIds_ = other.turnOnBuffIds_.Clone();
		interruptSkill_ = other.interruptSkill_;
		subType_ = other.subType_;
		faction_ = other.faction_;
		filter_ = other.filter_.Clone();
		ignoreCollision_ = other.ignoreCollision_;
		activeEff_ = other.activeEff_;
		shapeType_ = other.shapeType_;
		width_ = other.width_;
		length_ = other.length_;
		radius_ = other.radius_;
		innerRadius_ = other.innerRadius_;
		angle_ = other.angle_;
		offset_ = other.offset_.Clone();
		rotation_ = other.rotation_;
		isMove_ = other.isMove_;
		isBlock_ = other.isBlock_;
		movAcc_ = other.movAcc_;
		rotSpd_ = other.rotSpd_;
		moveSpd_ = other.moveSpd_;
		tag1_ = other.tag1_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Trap Clone()
	{
		return new Trap(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Trap);
	}

	[DebuggerNonUserCode]
	public bool Equals(Trap other)
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
		if (FCId != other.FCId)
		{
			return false;
		}
		if (Model != other.Model)
		{
			return false;
		}
		if (ModelScale != other.ModelScale)
		{
			return false;
		}
		if (BuffFXScale != other.BuffFXScale)
		{
			return false;
		}
		if (ColliderScale != other.ColliderScale)
		{
			return false;
		}
		if (AttributeId != other.AttributeId)
		{
			return false;
		}
		if (Templete != other.Templete)
		{
			return false;
		}
		if (!buffIds_.Equals(other.buffIds_))
		{
			return false;
		}
		if (!turnOffBuffIds_.Equals(other.turnOffBuffIds_))
		{
			return false;
		}
		if (!turnOnBuffIds_.Equals(other.turnOnBuffIds_))
		{
			return false;
		}
		if (InterruptSkill != other.InterruptSkill)
		{
			return false;
		}
		if (SubType != other.SubType)
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (!filter_.Equals(other.filter_))
		{
			return false;
		}
		if (IgnoreCollision != other.IgnoreCollision)
		{
			return false;
		}
		if (ActiveEff != other.ActiveEff)
		{
			return false;
		}
		if (ShapeType != other.ShapeType)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Width, other.Width))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Length, other.Length))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Radius, other.Radius))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(InnerRadius, other.InnerRadius))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Angle, other.Angle))
		{
			return false;
		}
		if (!offset_.Equals(other.offset_))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Rotation, other.Rotation))
		{
			return false;
		}
		if (IsMove != other.IsMove)
		{
			return false;
		}
		if (IsBlock != other.IsBlock)
		{
			return false;
		}
		if (MovAcc != other.MovAcc)
		{
			return false;
		}
		if (RotSpd != other.RotSpd)
		{
			return false;
		}
		if (MoveSpd != other.MoveSpd)
		{
			return false;
		}
		if (Tag1 != other.Tag1)
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
		if (FCId != 0)
		{
			num ^= FCId.GetHashCode();
		}
		if (Model.Length != 0)
		{
			num ^= Model.GetHashCode();
		}
		if (ModelScale != 0)
		{
			num ^= ModelScale.GetHashCode();
		}
		if (BuffFXScale != 0)
		{
			num ^= BuffFXScale.GetHashCode();
		}
		if (ColliderScale != 0)
		{
			num ^= ColliderScale.GetHashCode();
		}
		if (AttributeId.Length != 0)
		{
			num ^= AttributeId.GetHashCode();
		}
		if (Templete != 0)
		{
			num ^= Templete.GetHashCode();
		}
		num ^= buffIds_.GetHashCode();
		num ^= turnOffBuffIds_.GetHashCode();
		num ^= turnOnBuffIds_.GetHashCode();
		if (InterruptSkill)
		{
			num ^= InterruptSkill.GetHashCode();
		}
		if (SubType != 0)
		{
			num ^= SubType.GetHashCode();
		}
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		num ^= filter_.GetHashCode();
		if (IgnoreCollision)
		{
			num ^= IgnoreCollision.GetHashCode();
		}
		if (ActiveEff.Length != 0)
		{
			num ^= ActiveEff.GetHashCode();
		}
		if (ShapeType != 0)
		{
			num ^= ShapeType.GetHashCode();
		}
		if (Width != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Width);
		}
		if (Length != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Length);
		}
		if (Radius != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Radius);
		}
		if (InnerRadius != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(InnerRadius);
		}
		if (Angle != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Angle);
		}
		num ^= offset_.GetHashCode();
		if (Rotation != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Rotation);
		}
		if (IsMove)
		{
			num ^= IsMove.GetHashCode();
		}
		if (IsBlock)
		{
			num ^= IsBlock.GetHashCode();
		}
		if (MovAcc != 0)
		{
			num ^= MovAcc.GetHashCode();
		}
		if (RotSpd != 0)
		{
			num ^= RotSpd.GetHashCode();
		}
		if (MoveSpd != 0)
		{
			num ^= MoveSpd.GetHashCode();
		}
		if (Tag1.Length != 0)
		{
			num ^= Tag1.GetHashCode();
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
		if (FCId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FCId);
		}
		if (Model.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Model);
		}
		if (ModelScale != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ModelScale);
		}
		if (BuffFXScale != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(BuffFXScale);
		}
		if (ColliderScale != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ColliderScale);
		}
		if (AttributeId.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(AttributeId);
		}
		if (Templete != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Templete);
		}
		buffIds_.WriteTo(output, _repeated_buffIds_codec);
		turnOffBuffIds_.WriteTo(output, _repeated_turnOffBuffIds_codec);
		turnOnBuffIds_.WriteTo(output, _repeated_turnOnBuffIds_codec);
		if (InterruptSkill)
		{
			output.WriteRawTag(104);
			output.WriteBool(InterruptSkill);
		}
		if (SubType != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SubType);
		}
		if (Faction != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Faction);
		}
		filter_.WriteTo(output, _repeated_filter_codec);
		if (IgnoreCollision)
		{
			output.WriteRawTag(136, 1);
			output.WriteBool(IgnoreCollision);
		}
		if (ActiveEff.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(ActiveEff);
		}
		if (ShapeType != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(ShapeType);
		}
		if (Width != 0f)
		{
			output.WriteRawTag(165, 1);
			output.WriteFloat(Width);
		}
		if (Length != 0f)
		{
			output.WriteRawTag(173, 1);
			output.WriteFloat(Length);
		}
		if (Radius != 0f)
		{
			output.WriteRawTag(181, 1);
			output.WriteFloat(Radius);
		}
		if (InnerRadius != 0f)
		{
			output.WriteRawTag(189, 1);
			output.WriteFloat(InnerRadius);
		}
		if (Angle != 0f)
		{
			output.WriteRawTag(197, 1);
			output.WriteFloat(Angle);
		}
		offset_.WriteTo(output, _repeated_offset_codec);
		if (Rotation != 0f)
		{
			output.WriteRawTag(213, 1);
			output.WriteFloat(Rotation);
		}
		if (IsMove)
		{
			output.WriteRawTag(216, 1);
			output.WriteBool(IsMove);
		}
		if (IsBlock)
		{
			output.WriteRawTag(224, 1);
			output.WriteBool(IsBlock);
		}
		if (MovAcc != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(MovAcc);
		}
		if (RotSpd != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(RotSpd);
		}
		if (MoveSpd != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(MoveSpd);
		}
		if (Tag1.Length != 0)
		{
			output.WriteRawTag(130, 2);
			output.WriteString(Tag1);
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
		if (FCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FCId);
		}
		if (Model.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Model);
		}
		if (ModelScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelScale);
		}
		if (BuffFXScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffFXScale);
		}
		if (ColliderScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ColliderScale);
		}
		if (AttributeId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AttributeId);
		}
		if (Templete != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Templete);
		}
		num += buffIds_.CalculateSize(_repeated_buffIds_codec);
		num += turnOffBuffIds_.CalculateSize(_repeated_turnOffBuffIds_codec);
		num += turnOnBuffIds_.CalculateSize(_repeated_turnOnBuffIds_codec);
		if (InterruptSkill)
		{
			num += 2;
		}
		if (SubType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubType);
		}
		if (Faction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		num += filter_.CalculateSize(_repeated_filter_codec);
		if (IgnoreCollision)
		{
			num += 3;
		}
		if (ActiveEff.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ActiveEff);
		}
		if (ShapeType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ShapeType);
		}
		if (Width != 0f)
		{
			num += 6;
		}
		if (Length != 0f)
		{
			num += 6;
		}
		if (Radius != 0f)
		{
			num += 6;
		}
		if (InnerRadius != 0f)
		{
			num += 6;
		}
		if (Angle != 0f)
		{
			num += 6;
		}
		num += offset_.CalculateSize(_repeated_offset_codec);
		if (Rotation != 0f)
		{
			num += 6;
		}
		if (IsMove)
		{
			num += 3;
		}
		if (IsBlock)
		{
			num += 3;
		}
		if (MovAcc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MovAcc);
		}
		if (RotSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotSpd);
		}
		if (MoveSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MoveSpd);
		}
		if (Tag1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag1);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Trap other)
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
			if (other.FCId != 0)
			{
				FCId = other.FCId;
			}
			if (other.Model.Length != 0)
			{
				Model = other.Model;
			}
			if (other.ModelScale != 0)
			{
				ModelScale = other.ModelScale;
			}
			if (other.BuffFXScale != 0)
			{
				BuffFXScale = other.BuffFXScale;
			}
			if (other.ColliderScale != 0)
			{
				ColliderScale = other.ColliderScale;
			}
			if (other.AttributeId.Length != 0)
			{
				AttributeId = other.AttributeId;
			}
			if (other.Templete != 0)
			{
				Templete = other.Templete;
			}
			buffIds_.Add(other.buffIds_);
			turnOffBuffIds_.Add(other.turnOffBuffIds_);
			turnOnBuffIds_.Add(other.turnOnBuffIds_);
			if (other.InterruptSkill)
			{
				InterruptSkill = other.InterruptSkill;
			}
			if (other.SubType != 0)
			{
				SubType = other.SubType;
			}
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			filter_.Add(other.filter_);
			if (other.IgnoreCollision)
			{
				IgnoreCollision = other.IgnoreCollision;
			}
			if (other.ActiveEff.Length != 0)
			{
				ActiveEff = other.ActiveEff;
			}
			if (other.ShapeType != 0)
			{
				ShapeType = other.ShapeType;
			}
			if (other.Width != 0f)
			{
				Width = other.Width;
			}
			if (other.Length != 0f)
			{
				Length = other.Length;
			}
			if (other.Radius != 0f)
			{
				Radius = other.Radius;
			}
			if (other.InnerRadius != 0f)
			{
				InnerRadius = other.InnerRadius;
			}
			if (other.Angle != 0f)
			{
				Angle = other.Angle;
			}
			offset_.Add(other.offset_);
			if (other.Rotation != 0f)
			{
				Rotation = other.Rotation;
			}
			if (other.IsMove)
			{
				IsMove = other.IsMove;
			}
			if (other.IsBlock)
			{
				IsBlock = other.IsBlock;
			}
			if (other.MovAcc != 0)
			{
				MovAcc = other.MovAcc;
			}
			if (other.RotSpd != 0)
			{
				RotSpd = other.RotSpd;
			}
			if (other.MoveSpd != 0)
			{
				MoveSpd = other.MoveSpd;
			}
			if (other.Tag1.Length != 0)
			{
				Tag1 = other.Tag1;
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
			case 24u:
				FCId = input.ReadInt32();
				break;
			case 34u:
				Model = input.ReadString();
				break;
			case 40u:
				ModelScale = input.ReadInt32();
				break;
			case 48u:
				BuffFXScale = input.ReadInt32();
				break;
			case 56u:
				ColliderScale = input.ReadInt32();
				break;
			case 66u:
				AttributeId = input.ReadString();
				break;
			case 72u:
				Templete = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				buffIds_.AddEntriesFrom(input, _repeated_buffIds_codec);
				break;
			case 88u:
			case 90u:
				turnOffBuffIds_.AddEntriesFrom(input, _repeated_turnOffBuffIds_codec);
				break;
			case 96u:
			case 98u:
				turnOnBuffIds_.AddEntriesFrom(input, _repeated_turnOnBuffIds_codec);
				break;
			case 104u:
				InterruptSkill = input.ReadBool();
				break;
			case 112u:
				SubType = input.ReadInt32();
				break;
			case 120u:
				Faction = input.ReadInt32();
				break;
			case 128u:
			case 130u:
				filter_.AddEntriesFrom(input, _repeated_filter_codec);
				break;
			case 136u:
				IgnoreCollision = input.ReadBool();
				break;
			case 146u:
				ActiveEff = input.ReadString();
				break;
			case 152u:
				ShapeType = input.ReadInt32();
				break;
			case 165u:
				Width = input.ReadFloat();
				break;
			case 173u:
				Length = input.ReadFloat();
				break;
			case 181u:
				Radius = input.ReadFloat();
				break;
			case 189u:
				InnerRadius = input.ReadFloat();
				break;
			case 197u:
				Angle = input.ReadFloat();
				break;
			case 202u:
			case 205u:
				offset_.AddEntriesFrom(input, _repeated_offset_codec);
				break;
			case 213u:
				Rotation = input.ReadFloat();
				break;
			case 216u:
				IsMove = input.ReadBool();
				break;
			case 224u:
				IsBlock = input.ReadBool();
				break;
			case 232u:
				MovAcc = input.ReadInt32();
				break;
			case 240u:
				RotSpd = input.ReadInt32();
				break;
			case 248u:
				MoveSpd = input.ReadInt32();
				break;
			case 258u:
				Tag1 = input.ReadString();
				break;
			}
		}
	}
}
