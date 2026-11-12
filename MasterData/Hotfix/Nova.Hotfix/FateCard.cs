using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class FateCard : IMessage<FateCard>, IMessage, IEquatable<FateCard>, IDeepCloneable<FateCard>
{
	private static readonly MessageParser<FateCard> _parser = new MessageParser<FateCard>(() => new FateCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int Desc2FieldNumber = 4;

	private string desc2_ = "";

	public const int IsTowerFieldNumber = 5;

	private bool isTower_;

	public const int IsVampireFieldNumber = 6;

	private bool isVampire_;

	public const int IsVampireSpecialFieldNumber = 7;

	private bool isVampireSpecial_;

	public const int ActiveNumberFieldNumber = 8;

	private int activeNumber_;

	public const int DurationFieldNumber = 9;

	private int duration_;

	public const int ActiveRoomTypesFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_activeRoomTypes_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> activeRoomTypes_ = new RepeatedField<int>();

	public const int ActiveActionFieldNumber = 11;

	private int activeAction_;

	public const int MethodModeFieldNumber = 12;

	private int methodMode_;

	public const int ClientEffectFieldNumber = 13;

	private int clientEffect_;

	public const int ClientExEffectFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_clientExEffect_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> clientExEffect_ = new RepeatedField<int>();

	public const int CountFieldNumber = 15;

	private int count_;

	public const int ThemeTypeFieldNumber = 16;

	private int themeType_;

	public const int ThemeValueFieldNumber = 17;

	private int themeValue_;

	public const int ThemeTriggerTypeFieldNumber = 18;

	private static readonly FieldCodec<int> _repeated_themeTriggerType_codec = FieldCodec.ForInt32(146u);

	private readonly RepeatedField<int> themeTriggerType_ = new RepeatedField<int>();

	public const int EffectiveImmediatelyFieldNumber = 19;

	private bool effectiveImmediately_;

	public const int RemovableFieldNumber = 20;

	private bool removable_;

	public const int Param1FieldNumber = 21;

	private string param1_ = "";

	public const int Param2FieldNumber = 22;

	private string param2_ = "";

	public const int Param3FieldNumber = 23;

	private string param3_ = "";

	public const int Param4FieldNumber = 24;

	private string param4_ = "";

	public const int Param5FieldNumber = 25;

	private string param5_ = "";

	public const int Param6FieldNumber = 26;

	private string param6_ = "";

	public const int Param7FieldNumber = 27;

	private string param7_ = "";

	public const int Param8FieldNumber = 28;

	private string param8_ = "";

	public const int Param9FieldNumber = 29;

	private string param9_ = "";

	public const int Param10FieldNumber = 30;

	private string param10_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<FateCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(350);

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
	public string Desc2
	{
		get
		{
			return desc2_;
		}
		set
		{
			desc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsTower
	{
		get
		{
			return isTower_;
		}
		set
		{
			isTower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsVampire
	{
		get
		{
			return isVampire_;
		}
		set
		{
			isVampire_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsVampireSpecial
	{
		get
		{
			return isVampireSpecial_;
		}
		set
		{
			isVampireSpecial_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActiveNumber
	{
		get
		{
			return activeNumber_;
		}
		set
		{
			activeNumber_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ActiveRoomTypes => activeRoomTypes_;

	[DebuggerNonUserCode]
	public int ActiveAction
	{
		get
		{
			return activeAction_;
		}
		set
		{
			activeAction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MethodMode
	{
		get
		{
			return methodMode_;
		}
		set
		{
			methodMode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ClientEffect
	{
		get
		{
			return clientEffect_;
		}
		set
		{
			clientEffect_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientExEffect => clientExEffect_;

	[DebuggerNonUserCode]
	public int Count
	{
		get
		{
			return count_;
		}
		set
		{
			count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThemeType
	{
		get
		{
			return themeType_;
		}
		set
		{
			themeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThemeValue
	{
		get
		{
			return themeValue_;
		}
		set
		{
			themeValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ThemeTriggerType => themeTriggerType_;

	[DebuggerNonUserCode]
	public bool EffectiveImmediately
	{
		get
		{
			return effectiveImmediately_;
		}
		set
		{
			effectiveImmediately_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Removable
	{
		get
		{
			return removable_;
		}
		set
		{
			removable_ = value;
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
	public FateCard()
	{
	}

	[DebuggerNonUserCode]
	public FateCard(FateCard other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		desc2_ = other.desc2_;
		isTower_ = other.isTower_;
		isVampire_ = other.isVampire_;
		isVampireSpecial_ = other.isVampireSpecial_;
		activeNumber_ = other.activeNumber_;
		duration_ = other.duration_;
		activeRoomTypes_ = other.activeRoomTypes_.Clone();
		activeAction_ = other.activeAction_;
		methodMode_ = other.methodMode_;
		clientEffect_ = other.clientEffect_;
		clientExEffect_ = other.clientExEffect_.Clone();
		count_ = other.count_;
		themeType_ = other.themeType_;
		themeValue_ = other.themeValue_;
		themeTriggerType_ = other.themeTriggerType_.Clone();
		effectiveImmediately_ = other.effectiveImmediately_;
		removable_ = other.removable_;
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
	public FateCard Clone()
	{
		return new FateCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FateCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(FateCard other)
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
		if (Desc2 != other.Desc2)
		{
			return false;
		}
		if (IsTower != other.IsTower)
		{
			return false;
		}
		if (IsVampire != other.IsVampire)
		{
			return false;
		}
		if (IsVampireSpecial != other.IsVampireSpecial)
		{
			return false;
		}
		if (ActiveNumber != other.ActiveNumber)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (!activeRoomTypes_.Equals(other.activeRoomTypes_))
		{
			return false;
		}
		if (ActiveAction != other.ActiveAction)
		{
			return false;
		}
		if (MethodMode != other.MethodMode)
		{
			return false;
		}
		if (ClientEffect != other.ClientEffect)
		{
			return false;
		}
		if (!clientExEffect_.Equals(other.clientExEffect_))
		{
			return false;
		}
		if (Count != other.Count)
		{
			return false;
		}
		if (ThemeType != other.ThemeType)
		{
			return false;
		}
		if (ThemeValue != other.ThemeValue)
		{
			return false;
		}
		if (!themeTriggerType_.Equals(other.themeTriggerType_))
		{
			return false;
		}
		if (EffectiveImmediately != other.EffectiveImmediately)
		{
			return false;
		}
		if (Removable != other.Removable)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Desc2.Length != 0)
		{
			num ^= Desc2.GetHashCode();
		}
		if (IsTower)
		{
			num ^= IsTower.GetHashCode();
		}
		if (IsVampire)
		{
			num ^= IsVampire.GetHashCode();
		}
		if (IsVampireSpecial)
		{
			num ^= IsVampireSpecial.GetHashCode();
		}
		if (ActiveNumber != 0)
		{
			num ^= ActiveNumber.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		num ^= activeRoomTypes_.GetHashCode();
		if (ActiveAction != 0)
		{
			num ^= ActiveAction.GetHashCode();
		}
		if (MethodMode != 0)
		{
			num ^= MethodMode.GetHashCode();
		}
		if (ClientEffect != 0)
		{
			num ^= ClientEffect.GetHashCode();
		}
		num ^= clientExEffect_.GetHashCode();
		if (Count != 0)
		{
			num ^= Count.GetHashCode();
		}
		if (ThemeType != 0)
		{
			num ^= ThemeType.GetHashCode();
		}
		if (ThemeValue != 0)
		{
			num ^= ThemeValue.GetHashCode();
		}
		num ^= themeTriggerType_.GetHashCode();
		if (EffectiveImmediately)
		{
			num ^= EffectiveImmediately.GetHashCode();
		}
		if (Removable)
		{
			num ^= Removable.GetHashCode();
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
		if (Desc2.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc2);
		}
		if (IsTower)
		{
			output.WriteRawTag(40);
			output.WriteBool(IsTower);
		}
		if (IsVampire)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsVampire);
		}
		if (IsVampireSpecial)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsVampireSpecial);
		}
		if (ActiveNumber != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ActiveNumber);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Duration);
		}
		activeRoomTypes_.WriteTo(output, _repeated_activeRoomTypes_codec);
		if (ActiveAction != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ActiveAction);
		}
		if (MethodMode != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(MethodMode);
		}
		if (ClientEffect != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ClientEffect);
		}
		clientExEffect_.WriteTo(output, _repeated_clientExEffect_codec);
		if (Count != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Count);
		}
		if (ThemeType != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(ThemeType);
		}
		if (ThemeValue != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ThemeValue);
		}
		themeTriggerType_.WriteTo(output, _repeated_themeTriggerType_codec);
		if (EffectiveImmediately)
		{
			output.WriteRawTag(152, 1);
			output.WriteBool(EffectiveImmediately);
		}
		if (Removable)
		{
			output.WriteRawTag(160, 1);
			output.WriteBool(Removable);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(Param7);
		}
		if (Param8.Length != 0)
		{
			output.WriteRawTag(226, 1);
			output.WriteString(Param8);
		}
		if (Param9.Length != 0)
		{
			output.WriteRawTag(234, 1);
			output.WriteString(Param9);
		}
		if (Param10.Length != 0)
		{
			output.WriteRawTag(242, 1);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Desc2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc2);
		}
		if (IsTower)
		{
			num += 2;
		}
		if (IsVampire)
		{
			num += 2;
		}
		if (IsVampireSpecial)
		{
			num += 2;
		}
		if (ActiveNumber != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActiveNumber);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		num += activeRoomTypes_.CalculateSize(_repeated_activeRoomTypes_codec);
		if (ActiveAction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActiveAction);
		}
		if (MethodMode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MethodMode);
		}
		if (ClientEffect != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ClientEffect);
		}
		num += clientExEffect_.CalculateSize(_repeated_clientExEffect_codec);
		if (Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Count);
		}
		if (ThemeType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ThemeType);
		}
		if (ThemeValue != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ThemeValue);
		}
		num += themeTriggerType_.CalculateSize(_repeated_themeTriggerType_codec);
		if (EffectiveImmediately)
		{
			num += 3;
		}
		if (Removable)
		{
			num += 3;
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
	public void MergeFrom(FateCard other)
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
			if (other.Desc2.Length != 0)
			{
				Desc2 = other.Desc2;
			}
			if (other.IsTower)
			{
				IsTower = other.IsTower;
			}
			if (other.IsVampire)
			{
				IsVampire = other.IsVampire;
			}
			if (other.IsVampireSpecial)
			{
				IsVampireSpecial = other.IsVampireSpecial;
			}
			if (other.ActiveNumber != 0)
			{
				ActiveNumber = other.ActiveNumber;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			activeRoomTypes_.Add(other.activeRoomTypes_);
			if (other.ActiveAction != 0)
			{
				ActiveAction = other.ActiveAction;
			}
			if (other.MethodMode != 0)
			{
				MethodMode = other.MethodMode;
			}
			if (other.ClientEffect != 0)
			{
				ClientEffect = other.ClientEffect;
			}
			clientExEffect_.Add(other.clientExEffect_);
			if (other.Count != 0)
			{
				Count = other.Count;
			}
			if (other.ThemeType != 0)
			{
				ThemeType = other.ThemeType;
			}
			if (other.ThemeValue != 0)
			{
				ThemeValue = other.ThemeValue;
			}
			themeTriggerType_.Add(other.themeTriggerType_);
			if (other.EffectiveImmediately)
			{
				EffectiveImmediately = other.EffectiveImmediately;
			}
			if (other.Removable)
			{
				Removable = other.Removable;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 34u:
				Desc2 = input.ReadString();
				break;
			case 40u:
				IsTower = input.ReadBool();
				break;
			case 48u:
				IsVampire = input.ReadBool();
				break;
			case 56u:
				IsVampireSpecial = input.ReadBool();
				break;
			case 64u:
				ActiveNumber = input.ReadInt32();
				break;
			case 72u:
				Duration = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				activeRoomTypes_.AddEntriesFrom(input, _repeated_activeRoomTypes_codec);
				break;
			case 88u:
				ActiveAction = input.ReadInt32();
				break;
			case 96u:
				MethodMode = input.ReadInt32();
				break;
			case 104u:
				ClientEffect = input.ReadInt32();
				break;
			case 112u:
			case 114u:
				clientExEffect_.AddEntriesFrom(input, _repeated_clientExEffect_codec);
				break;
			case 120u:
				Count = input.ReadInt32();
				break;
			case 128u:
				ThemeType = input.ReadInt32();
				break;
			case 136u:
				ThemeValue = input.ReadInt32();
				break;
			case 144u:
			case 146u:
				themeTriggerType_.AddEntriesFrom(input, _repeated_themeTriggerType_codec);
				break;
			case 152u:
				EffectiveImmediately = input.ReadBool();
				break;
			case 160u:
				Removable = input.ReadBool();
				break;
			case 170u:
				Param1 = input.ReadString();
				break;
			case 178u:
				Param2 = input.ReadString();
				break;
			case 186u:
				Param3 = input.ReadString();
				break;
			case 194u:
				Param4 = input.ReadString();
				break;
			case 202u:
				Param5 = input.ReadString();
				break;
			case 210u:
				Param6 = input.ReadString();
				break;
			case 218u:
				Param7 = input.ReadString();
				break;
			case 226u:
				Param8 = input.ReadString();
				break;
			case 234u:
				Param9 = input.ReadString();
				break;
			case 242u:
				Param10 = input.ReadString();
				break;
			}
		}
	}
}
