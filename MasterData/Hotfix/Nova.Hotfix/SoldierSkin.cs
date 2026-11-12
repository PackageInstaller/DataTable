using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierSkin : IMessage<SoldierSkin>, IMessage, IEquatable<SoldierSkin>, IDeepCloneable<SoldierSkin>
{
	private static readonly MessageParser<SoldierSkin> _parser = new MessageParser<SoldierSkin>(() => new SoldierSkin());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	public const int ModelFieldNumber = 4;

	private string model_ = "";

	public const int RunAnimationSpdFieldNumber = 5;

	private int runAnimationSpd_;

	public const int WalkAnimationSpdFieldNumber = 6;

	private int walkAnimationSpd_;

	public const int BarHeightFieldNumber = 7;

	private int barHeight_;

	public const int ModelScaleFieldNumber = 8;

	private int modelScale_;

	public const int ColliderScaleFieldNumber = 9;

	private int colliderScale_;

	public const int ForbiddenBehitRotFieldNumber = 10;

	private bool forbiddenBehitRot_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierSkin> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(796);

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
	public SoldierSkin()
	{
	}

	[DebuggerNonUserCode]
	public SoldierSkin(SoldierSkin other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		icon_ = other.icon_;
		model_ = other.model_;
		runAnimationSpd_ = other.runAnimationSpd_;
		walkAnimationSpd_ = other.walkAnimationSpd_;
		barHeight_ = other.barHeight_;
		modelScale_ = other.modelScale_;
		colliderScale_ = other.colliderScale_;
		forbiddenBehitRot_ = other.forbiddenBehitRot_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierSkin Clone()
	{
		return new SoldierSkin(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierSkin);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierSkin other)
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
		if (Icon != other.Icon)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
		}
		if (Model.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Model);
		}
		if (RunAnimationSpd != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RunAnimationSpd);
		}
		if (WalkAnimationSpd != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(WalkAnimationSpd);
		}
		if (BarHeight != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(BarHeight);
		}
		if (ModelScale != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ModelScale);
		}
		if (ColliderScale != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ColliderScale);
		}
		if (ForbiddenBehitRot)
		{
			output.WriteRawTag(80);
			output.WriteBool(ForbiddenBehitRot);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierSkin other)
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
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				Icon = input.ReadString();
				break;
			case 34u:
				Model = input.ReadString();
				break;
			case 40u:
				RunAnimationSpd = input.ReadInt32();
				break;
			case 48u:
				WalkAnimationSpd = input.ReadInt32();
				break;
			case 56u:
				BarHeight = input.ReadInt32();
				break;
			case 64u:
				ModelScale = input.ReadInt32();
				break;
			case 72u:
				ColliderScale = input.ReadInt32();
				break;
			case 80u:
				ForbiddenBehitRot = input.ReadBool();
				break;
			}
		}
	}
}
