using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Effect : IMessage<Effect>, IMessage, IEquatable<Effect>, IDeepCloneable<Effect>
{
	private static readonly MessageParser<Effect> _parser = new MessageParser<Effect>(() => new Effect());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int LevelTypeDataFieldNumber = 3;

	private int levelTypeData_;

	public const int LevelDataFieldNumber = 4;

	private int levelData_;

	public const int MainOrSupportFieldNumber = 5;

	private int mainOrSupport_;

	public const int TriggerFieldNumber = 6;

	private int trigger_;

	public const int TriggerTargetFieldNumber = 7;

	private int triggerTarget_;

	public const int TriggerCondition1FieldNumber = 8;

	private int triggerCondition1_;

	public const int TriggerParam1FieldNumber = 9;

	private string triggerParam1_ = "";

	public const int TriggerParam2FieldNumber = 10;

	private string triggerParam2_ = "";

	public const int TriggerParam3FieldNumber = 11;

	private string triggerParam3_ = "";

	public const int TriggerParam4FieldNumber = 12;

	private string triggerParam4_ = "";

	public const int TriggerTarget2FieldNumber = 13;

	private int triggerTarget2_;

	public const int TriggerCondition2FieldNumber = 14;

	private int triggerCondition2_;

	public const int Trigger2Param1FieldNumber = 15;

	private string trigger2Param1_ = "";

	public const int Trigger2Param2FieldNumber = 16;

	private string trigger2Param2_ = "";

	public const int Trigger2Param3FieldNumber = 17;

	private string trigger2Param3_ = "";

	public const int Trigger2Param4FieldNumber = 18;

	private string trigger2Param4_ = "";

	public const int TriggerLogicTypeFieldNumber = 19;

	private int triggerLogicType_;

	public const int TakeEffectTarget1FieldNumber = 20;

	private int takeEffectTarget1_;

	public const int TakeEffectCondition1FieldNumber = 21;

	private int takeEffectCondition1_;

	public const int TakeEffectParam1FieldNumber = 22;

	private string takeEffectParam1_ = "";

	public const int TakeEffectParam2FieldNumber = 23;

	private string takeEffectParam2_ = "";

	public const int TakeEffectParam3FieldNumber = 24;

	private string takeEffectParam3_ = "";

	public const int TakeEffectParam4FieldNumber = 25;

	private string takeEffectParam4_ = "";

	public const int TakeEffectTarget2FieldNumber = 26;

	private int takeEffectTarget2_;

	public const int TakeEffectCondition2FieldNumber = 27;

	private int takeEffectCondition2_;

	public const int TakeEffect2Param1FieldNumber = 28;

	private string takeEffect2Param1_ = "";

	public const int TakeEffect2Param2FieldNumber = 29;

	private string takeEffect2Param2_ = "";

	public const int TakeEffect2Param3FieldNumber = 30;

	private string takeEffect2Param3_ = "";

	public const int TakeEffect2Param4FieldNumber = 31;

	private string takeEffect2Param4_ = "";

	public const int TakeEffectLogicTypeFieldNumber = 32;

	private int takeEffectLogicType_;

	public const int Target1FieldNumber = 33;

	private int target1_;

	public const int TargetCondition1FieldNumber = 34;

	private int targetCondition1_;

	public const int TargetParam1FieldNumber = 35;

	private string targetParam1_ = "";

	public const int TargetParam2FieldNumber = 36;

	private string targetParam2_ = "";

	public const int TargetParam3FieldNumber = 37;

	private string targetParam3_ = "";

	public const int TargetParam4FieldNumber = 38;

	private string targetParam4_ = "";

	public const int TargetCondition2FieldNumber = 39;

	private int targetCondition2_;

	public const int Target2Param1FieldNumber = 40;

	private string target2Param1_ = "";

	public const int Target2Param2FieldNumber = 41;

	private string target2Param2_ = "";

	public const int Target2Param3FieldNumber = 42;

	private string target2Param3_ = "";

	public const int Target2Param4FieldNumber = 43;

	private string target2Param4_ = "";

	public const int FilterLogicTypeFieldNumber = 44;

	private int filterLogicType_;

	[DebuggerNonUserCode]
	public static MessageParser<Effect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(326);

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
	public int LevelTypeData
	{
		get
		{
			return levelTypeData_;
		}
		set
		{
			levelTypeData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelData
	{
		get
		{
			return levelData_;
		}
		set
		{
			levelData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MainOrSupport
	{
		get
		{
			return mainOrSupport_;
		}
		set
		{
			mainOrSupport_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Trigger
	{
		get
		{
			return trigger_;
		}
		set
		{
			trigger_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerTarget
	{
		get
		{
			return triggerTarget_;
		}
		set
		{
			triggerTarget_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerCondition1
	{
		get
		{
			return triggerCondition1_;
		}
		set
		{
			triggerCondition1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam1
	{
		get
		{
			return triggerParam1_;
		}
		set
		{
			triggerParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam2
	{
		get
		{
			return triggerParam2_;
		}
		set
		{
			triggerParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam3
	{
		get
		{
			return triggerParam3_;
		}
		set
		{
			triggerParam3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam4
	{
		get
		{
			return triggerParam4_;
		}
		set
		{
			triggerParam4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TriggerTarget2
	{
		get
		{
			return triggerTarget2_;
		}
		set
		{
			triggerTarget2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerCondition2
	{
		get
		{
			return triggerCondition2_;
		}
		set
		{
			triggerCondition2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Trigger2Param1
	{
		get
		{
			return trigger2Param1_;
		}
		set
		{
			trigger2Param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Trigger2Param2
	{
		get
		{
			return trigger2Param2_;
		}
		set
		{
			trigger2Param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Trigger2Param3
	{
		get
		{
			return trigger2Param3_;
		}
		set
		{
			trigger2Param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Trigger2Param4
	{
		get
		{
			return trigger2Param4_;
		}
		set
		{
			trigger2Param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TriggerLogicType
	{
		get
		{
			return triggerLogicType_;
		}
		set
		{
			triggerLogicType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TakeEffectTarget1
	{
		get
		{
			return takeEffectTarget1_;
		}
		set
		{
			takeEffectTarget1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TakeEffectCondition1
	{
		get
		{
			return takeEffectCondition1_;
		}
		set
		{
			takeEffectCondition1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffectParam1
	{
		get
		{
			return takeEffectParam1_;
		}
		set
		{
			takeEffectParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffectParam2
	{
		get
		{
			return takeEffectParam2_;
		}
		set
		{
			takeEffectParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffectParam3
	{
		get
		{
			return takeEffectParam3_;
		}
		set
		{
			takeEffectParam3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffectParam4
	{
		get
		{
			return takeEffectParam4_;
		}
		set
		{
			takeEffectParam4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TakeEffectTarget2
	{
		get
		{
			return takeEffectTarget2_;
		}
		set
		{
			takeEffectTarget2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TakeEffectCondition2
	{
		get
		{
			return takeEffectCondition2_;
		}
		set
		{
			takeEffectCondition2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffect2Param1
	{
		get
		{
			return takeEffect2Param1_;
		}
		set
		{
			takeEffect2Param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffect2Param2
	{
		get
		{
			return takeEffect2Param2_;
		}
		set
		{
			takeEffect2Param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffect2Param3
	{
		get
		{
			return takeEffect2Param3_;
		}
		set
		{
			takeEffect2Param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TakeEffect2Param4
	{
		get
		{
			return takeEffect2Param4_;
		}
		set
		{
			takeEffect2Param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TakeEffectLogicType
	{
		get
		{
			return takeEffectLogicType_;
		}
		set
		{
			takeEffectLogicType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Target1
	{
		get
		{
			return target1_;
		}
		set
		{
			target1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TargetCondition1
	{
		get
		{
			return targetCondition1_;
		}
		set
		{
			targetCondition1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TargetParam1
	{
		get
		{
			return targetParam1_;
		}
		set
		{
			targetParam1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TargetParam2
	{
		get
		{
			return targetParam2_;
		}
		set
		{
			targetParam2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TargetParam3
	{
		get
		{
			return targetParam3_;
		}
		set
		{
			targetParam3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TargetParam4
	{
		get
		{
			return targetParam4_;
		}
		set
		{
			targetParam4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TargetCondition2
	{
		get
		{
			return targetCondition2_;
		}
		set
		{
			targetCondition2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Target2Param1
	{
		get
		{
			return target2Param1_;
		}
		set
		{
			target2Param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Target2Param2
	{
		get
		{
			return target2Param2_;
		}
		set
		{
			target2Param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Target2Param3
	{
		get
		{
			return target2Param3_;
		}
		set
		{
			target2Param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Target2Param4
	{
		get
		{
			return target2Param4_;
		}
		set
		{
			target2Param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FilterLogicType
	{
		get
		{
			return filterLogicType_;
		}
		set
		{
			filterLogicType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Effect()
	{
	}

	[DebuggerNonUserCode]
	public Effect(Effect other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		levelTypeData_ = other.levelTypeData_;
		levelData_ = other.levelData_;
		mainOrSupport_ = other.mainOrSupport_;
		trigger_ = other.trigger_;
		triggerTarget_ = other.triggerTarget_;
		triggerCondition1_ = other.triggerCondition1_;
		triggerParam1_ = other.triggerParam1_;
		triggerParam2_ = other.triggerParam2_;
		triggerParam3_ = other.triggerParam3_;
		triggerParam4_ = other.triggerParam4_;
		triggerTarget2_ = other.triggerTarget2_;
		triggerCondition2_ = other.triggerCondition2_;
		trigger2Param1_ = other.trigger2Param1_;
		trigger2Param2_ = other.trigger2Param2_;
		trigger2Param3_ = other.trigger2Param3_;
		trigger2Param4_ = other.trigger2Param4_;
		triggerLogicType_ = other.triggerLogicType_;
		takeEffectTarget1_ = other.takeEffectTarget1_;
		takeEffectCondition1_ = other.takeEffectCondition1_;
		takeEffectParam1_ = other.takeEffectParam1_;
		takeEffectParam2_ = other.takeEffectParam2_;
		takeEffectParam3_ = other.takeEffectParam3_;
		takeEffectParam4_ = other.takeEffectParam4_;
		takeEffectTarget2_ = other.takeEffectTarget2_;
		takeEffectCondition2_ = other.takeEffectCondition2_;
		takeEffect2Param1_ = other.takeEffect2Param1_;
		takeEffect2Param2_ = other.takeEffect2Param2_;
		takeEffect2Param3_ = other.takeEffect2Param3_;
		takeEffect2Param4_ = other.takeEffect2Param4_;
		takeEffectLogicType_ = other.takeEffectLogicType_;
		target1_ = other.target1_;
		targetCondition1_ = other.targetCondition1_;
		targetParam1_ = other.targetParam1_;
		targetParam2_ = other.targetParam2_;
		targetParam3_ = other.targetParam3_;
		targetParam4_ = other.targetParam4_;
		targetCondition2_ = other.targetCondition2_;
		target2Param1_ = other.target2Param1_;
		target2Param2_ = other.target2Param2_;
		target2Param3_ = other.target2Param3_;
		target2Param4_ = other.target2Param4_;
		filterLogicType_ = other.filterLogicType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Effect Clone()
	{
		return new Effect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Effect);
	}

	[DebuggerNonUserCode]
	public bool Equals(Effect other)
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
		if (LevelTypeData != other.LevelTypeData)
		{
			return false;
		}
		if (LevelData != other.LevelData)
		{
			return false;
		}
		if (MainOrSupport != other.MainOrSupport)
		{
			return false;
		}
		if (Trigger != other.Trigger)
		{
			return false;
		}
		if (TriggerTarget != other.TriggerTarget)
		{
			return false;
		}
		if (TriggerCondition1 != other.TriggerCondition1)
		{
			return false;
		}
		if (TriggerParam1 != other.TriggerParam1)
		{
			return false;
		}
		if (TriggerParam2 != other.TriggerParam2)
		{
			return false;
		}
		if (TriggerParam3 != other.TriggerParam3)
		{
			return false;
		}
		if (TriggerParam4 != other.TriggerParam4)
		{
			return false;
		}
		if (TriggerTarget2 != other.TriggerTarget2)
		{
			return false;
		}
		if (TriggerCondition2 != other.TriggerCondition2)
		{
			return false;
		}
		if (Trigger2Param1 != other.Trigger2Param1)
		{
			return false;
		}
		if (Trigger2Param2 != other.Trigger2Param2)
		{
			return false;
		}
		if (Trigger2Param3 != other.Trigger2Param3)
		{
			return false;
		}
		if (Trigger2Param4 != other.Trigger2Param4)
		{
			return false;
		}
		if (TriggerLogicType != other.TriggerLogicType)
		{
			return false;
		}
		if (TakeEffectTarget1 != other.TakeEffectTarget1)
		{
			return false;
		}
		if (TakeEffectCondition1 != other.TakeEffectCondition1)
		{
			return false;
		}
		if (TakeEffectParam1 != other.TakeEffectParam1)
		{
			return false;
		}
		if (TakeEffectParam2 != other.TakeEffectParam2)
		{
			return false;
		}
		if (TakeEffectParam3 != other.TakeEffectParam3)
		{
			return false;
		}
		if (TakeEffectParam4 != other.TakeEffectParam4)
		{
			return false;
		}
		if (TakeEffectTarget2 != other.TakeEffectTarget2)
		{
			return false;
		}
		if (TakeEffectCondition2 != other.TakeEffectCondition2)
		{
			return false;
		}
		if (TakeEffect2Param1 != other.TakeEffect2Param1)
		{
			return false;
		}
		if (TakeEffect2Param2 != other.TakeEffect2Param2)
		{
			return false;
		}
		if (TakeEffect2Param3 != other.TakeEffect2Param3)
		{
			return false;
		}
		if (TakeEffect2Param4 != other.TakeEffect2Param4)
		{
			return false;
		}
		if (TakeEffectLogicType != other.TakeEffectLogicType)
		{
			return false;
		}
		if (Target1 != other.Target1)
		{
			return false;
		}
		if (TargetCondition1 != other.TargetCondition1)
		{
			return false;
		}
		if (TargetParam1 != other.TargetParam1)
		{
			return false;
		}
		if (TargetParam2 != other.TargetParam2)
		{
			return false;
		}
		if (TargetParam3 != other.TargetParam3)
		{
			return false;
		}
		if (TargetParam4 != other.TargetParam4)
		{
			return false;
		}
		if (TargetCondition2 != other.TargetCondition2)
		{
			return false;
		}
		if (Target2Param1 != other.Target2Param1)
		{
			return false;
		}
		if (Target2Param2 != other.Target2Param2)
		{
			return false;
		}
		if (Target2Param3 != other.Target2Param3)
		{
			return false;
		}
		if (Target2Param4 != other.Target2Param4)
		{
			return false;
		}
		if (FilterLogicType != other.FilterLogicType)
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
		if (LevelTypeData != 0)
		{
			num ^= LevelTypeData.GetHashCode();
		}
		if (LevelData != 0)
		{
			num ^= LevelData.GetHashCode();
		}
		if (MainOrSupport != 0)
		{
			num ^= MainOrSupport.GetHashCode();
		}
		if (Trigger != 0)
		{
			num ^= Trigger.GetHashCode();
		}
		if (TriggerTarget != 0)
		{
			num ^= TriggerTarget.GetHashCode();
		}
		if (TriggerCondition1 != 0)
		{
			num ^= TriggerCondition1.GetHashCode();
		}
		if (TriggerParam1.Length != 0)
		{
			num ^= TriggerParam1.GetHashCode();
		}
		if (TriggerParam2.Length != 0)
		{
			num ^= TriggerParam2.GetHashCode();
		}
		if (TriggerParam3.Length != 0)
		{
			num ^= TriggerParam3.GetHashCode();
		}
		if (TriggerParam4.Length != 0)
		{
			num ^= TriggerParam4.GetHashCode();
		}
		if (TriggerTarget2 != 0)
		{
			num ^= TriggerTarget2.GetHashCode();
		}
		if (TriggerCondition2 != 0)
		{
			num ^= TriggerCondition2.GetHashCode();
		}
		if (Trigger2Param1.Length != 0)
		{
			num ^= Trigger2Param1.GetHashCode();
		}
		if (Trigger2Param2.Length != 0)
		{
			num ^= Trigger2Param2.GetHashCode();
		}
		if (Trigger2Param3.Length != 0)
		{
			num ^= Trigger2Param3.GetHashCode();
		}
		if (Trigger2Param4.Length != 0)
		{
			num ^= Trigger2Param4.GetHashCode();
		}
		if (TriggerLogicType != 0)
		{
			num ^= TriggerLogicType.GetHashCode();
		}
		if (TakeEffectTarget1 != 0)
		{
			num ^= TakeEffectTarget1.GetHashCode();
		}
		if (TakeEffectCondition1 != 0)
		{
			num ^= TakeEffectCondition1.GetHashCode();
		}
		if (TakeEffectParam1.Length != 0)
		{
			num ^= TakeEffectParam1.GetHashCode();
		}
		if (TakeEffectParam2.Length != 0)
		{
			num ^= TakeEffectParam2.GetHashCode();
		}
		if (TakeEffectParam3.Length != 0)
		{
			num ^= TakeEffectParam3.GetHashCode();
		}
		if (TakeEffectParam4.Length != 0)
		{
			num ^= TakeEffectParam4.GetHashCode();
		}
		if (TakeEffectTarget2 != 0)
		{
			num ^= TakeEffectTarget2.GetHashCode();
		}
		if (TakeEffectCondition2 != 0)
		{
			num ^= TakeEffectCondition2.GetHashCode();
		}
		if (TakeEffect2Param1.Length != 0)
		{
			num ^= TakeEffect2Param1.GetHashCode();
		}
		if (TakeEffect2Param2.Length != 0)
		{
			num ^= TakeEffect2Param2.GetHashCode();
		}
		if (TakeEffect2Param3.Length != 0)
		{
			num ^= TakeEffect2Param3.GetHashCode();
		}
		if (TakeEffect2Param4.Length != 0)
		{
			num ^= TakeEffect2Param4.GetHashCode();
		}
		if (TakeEffectLogicType != 0)
		{
			num ^= TakeEffectLogicType.GetHashCode();
		}
		if (Target1 != 0)
		{
			num ^= Target1.GetHashCode();
		}
		if (TargetCondition1 != 0)
		{
			num ^= TargetCondition1.GetHashCode();
		}
		if (TargetParam1.Length != 0)
		{
			num ^= TargetParam1.GetHashCode();
		}
		if (TargetParam2.Length != 0)
		{
			num ^= TargetParam2.GetHashCode();
		}
		if (TargetParam3.Length != 0)
		{
			num ^= TargetParam3.GetHashCode();
		}
		if (TargetParam4.Length != 0)
		{
			num ^= TargetParam4.GetHashCode();
		}
		if (TargetCondition2 != 0)
		{
			num ^= TargetCondition2.GetHashCode();
		}
		if (Target2Param1.Length != 0)
		{
			num ^= Target2Param1.GetHashCode();
		}
		if (Target2Param2.Length != 0)
		{
			num ^= Target2Param2.GetHashCode();
		}
		if (Target2Param3.Length != 0)
		{
			num ^= Target2Param3.GetHashCode();
		}
		if (Target2Param4.Length != 0)
		{
			num ^= Target2Param4.GetHashCode();
		}
		if (FilterLogicType != 0)
		{
			num ^= FilterLogicType.GetHashCode();
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
		if (LevelTypeData != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelTypeData);
		}
		if (LevelData != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LevelData);
		}
		if (MainOrSupport != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MainOrSupport);
		}
		if (Trigger != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Trigger);
		}
		if (TriggerTarget != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TriggerTarget);
		}
		if (TriggerCondition1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(TriggerCondition1);
		}
		if (TriggerParam1.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(TriggerParam1);
		}
		if (TriggerParam2.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(TriggerParam2);
		}
		if (TriggerParam3.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(TriggerParam3);
		}
		if (TriggerParam4.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(TriggerParam4);
		}
		if (TriggerTarget2 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(TriggerTarget2);
		}
		if (TriggerCondition2 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(TriggerCondition2);
		}
		if (Trigger2Param1.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Trigger2Param1);
		}
		if (Trigger2Param2.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Trigger2Param2);
		}
		if (Trigger2Param3.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Trigger2Param3);
		}
		if (Trigger2Param4.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Trigger2Param4);
		}
		if (TriggerLogicType != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(TriggerLogicType);
		}
		if (TakeEffectTarget1 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(TakeEffectTarget1);
		}
		if (TakeEffectCondition1 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(TakeEffectCondition1);
		}
		if (TakeEffectParam1.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(TakeEffectParam1);
		}
		if (TakeEffectParam2.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(TakeEffectParam2);
		}
		if (TakeEffectParam3.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(TakeEffectParam3);
		}
		if (TakeEffectParam4.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(TakeEffectParam4);
		}
		if (TakeEffectTarget2 != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(TakeEffectTarget2);
		}
		if (TakeEffectCondition2 != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(TakeEffectCondition2);
		}
		if (TakeEffect2Param1.Length != 0)
		{
			output.WriteRawTag(226, 1);
			output.WriteString(TakeEffect2Param1);
		}
		if (TakeEffect2Param2.Length != 0)
		{
			output.WriteRawTag(234, 1);
			output.WriteString(TakeEffect2Param2);
		}
		if (TakeEffect2Param3.Length != 0)
		{
			output.WriteRawTag(242, 1);
			output.WriteString(TakeEffect2Param3);
		}
		if (TakeEffect2Param4.Length != 0)
		{
			output.WriteRawTag(250, 1);
			output.WriteString(TakeEffect2Param4);
		}
		if (TakeEffectLogicType != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(TakeEffectLogicType);
		}
		if (Target1 != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(Target1);
		}
		if (TargetCondition1 != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(TargetCondition1);
		}
		if (TargetParam1.Length != 0)
		{
			output.WriteRawTag(154, 2);
			output.WriteString(TargetParam1);
		}
		if (TargetParam2.Length != 0)
		{
			output.WriteRawTag(162, 2);
			output.WriteString(TargetParam2);
		}
		if (TargetParam3.Length != 0)
		{
			output.WriteRawTag(170, 2);
			output.WriteString(TargetParam3);
		}
		if (TargetParam4.Length != 0)
		{
			output.WriteRawTag(178, 2);
			output.WriteString(TargetParam4);
		}
		if (TargetCondition2 != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(TargetCondition2);
		}
		if (Target2Param1.Length != 0)
		{
			output.WriteRawTag(194, 2);
			output.WriteString(Target2Param1);
		}
		if (Target2Param2.Length != 0)
		{
			output.WriteRawTag(202, 2);
			output.WriteString(Target2Param2);
		}
		if (Target2Param3.Length != 0)
		{
			output.WriteRawTag(210, 2);
			output.WriteString(Target2Param3);
		}
		if (Target2Param4.Length != 0)
		{
			output.WriteRawTag(218, 2);
			output.WriteString(Target2Param4);
		}
		if (FilterLogicType != 0)
		{
			output.WriteRawTag(224, 2);
			output.WriteInt32(FilterLogicType);
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
		if (LevelTypeData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelTypeData);
		}
		if (LevelData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelData);
		}
		if (MainOrSupport != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainOrSupport);
		}
		if (Trigger != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Trigger);
		}
		if (TriggerTarget != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerTarget);
		}
		if (TriggerCondition1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerCondition1);
		}
		if (TriggerParam1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam1);
		}
		if (TriggerParam2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam2);
		}
		if (TriggerParam3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam3);
		}
		if (TriggerParam4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam4);
		}
		if (TriggerTarget2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerTarget2);
		}
		if (TriggerCondition2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerCondition2);
		}
		if (Trigger2Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Trigger2Param1);
		}
		if (Trigger2Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Trigger2Param2);
		}
		if (Trigger2Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Trigger2Param3);
		}
		if (Trigger2Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Trigger2Param4);
		}
		if (TriggerLogicType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TriggerLogicType);
		}
		if (TakeEffectTarget1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TakeEffectTarget1);
		}
		if (TakeEffectCondition1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TakeEffectCondition1);
		}
		if (TakeEffectParam1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffectParam1);
		}
		if (TakeEffectParam2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffectParam2);
		}
		if (TakeEffectParam3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffectParam3);
		}
		if (TakeEffectParam4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffectParam4);
		}
		if (TakeEffectTarget2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TakeEffectTarget2);
		}
		if (TakeEffectCondition2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TakeEffectCondition2);
		}
		if (TakeEffect2Param1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffect2Param1);
		}
		if (TakeEffect2Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffect2Param2);
		}
		if (TakeEffect2Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffect2Param3);
		}
		if (TakeEffect2Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TakeEffect2Param4);
		}
		if (TakeEffectLogicType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TakeEffectLogicType);
		}
		if (Target1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Target1);
		}
		if (TargetCondition1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TargetCondition1);
		}
		if (TargetParam1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TargetParam1);
		}
		if (TargetParam2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TargetParam2);
		}
		if (TargetParam3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TargetParam3);
		}
		if (TargetParam4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TargetParam4);
		}
		if (TargetCondition2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TargetCondition2);
		}
		if (Target2Param1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Target2Param1);
		}
		if (Target2Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Target2Param2);
		}
		if (Target2Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Target2Param3);
		}
		if (Target2Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Target2Param4);
		}
		if (FilterLogicType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FilterLogicType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Effect other)
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
			if (other.LevelTypeData != 0)
			{
				LevelTypeData = other.LevelTypeData;
			}
			if (other.LevelData != 0)
			{
				LevelData = other.LevelData;
			}
			if (other.MainOrSupport != 0)
			{
				MainOrSupport = other.MainOrSupport;
			}
			if (other.Trigger != 0)
			{
				Trigger = other.Trigger;
			}
			if (other.TriggerTarget != 0)
			{
				TriggerTarget = other.TriggerTarget;
			}
			if (other.TriggerCondition1 != 0)
			{
				TriggerCondition1 = other.TriggerCondition1;
			}
			if (other.TriggerParam1.Length != 0)
			{
				TriggerParam1 = other.TriggerParam1;
			}
			if (other.TriggerParam2.Length != 0)
			{
				TriggerParam2 = other.TriggerParam2;
			}
			if (other.TriggerParam3.Length != 0)
			{
				TriggerParam3 = other.TriggerParam3;
			}
			if (other.TriggerParam4.Length != 0)
			{
				TriggerParam4 = other.TriggerParam4;
			}
			if (other.TriggerTarget2 != 0)
			{
				TriggerTarget2 = other.TriggerTarget2;
			}
			if (other.TriggerCondition2 != 0)
			{
				TriggerCondition2 = other.TriggerCondition2;
			}
			if (other.Trigger2Param1.Length != 0)
			{
				Trigger2Param1 = other.Trigger2Param1;
			}
			if (other.Trigger2Param2.Length != 0)
			{
				Trigger2Param2 = other.Trigger2Param2;
			}
			if (other.Trigger2Param3.Length != 0)
			{
				Trigger2Param3 = other.Trigger2Param3;
			}
			if (other.Trigger2Param4.Length != 0)
			{
				Trigger2Param4 = other.Trigger2Param4;
			}
			if (other.TriggerLogicType != 0)
			{
				TriggerLogicType = other.TriggerLogicType;
			}
			if (other.TakeEffectTarget1 != 0)
			{
				TakeEffectTarget1 = other.TakeEffectTarget1;
			}
			if (other.TakeEffectCondition1 != 0)
			{
				TakeEffectCondition1 = other.TakeEffectCondition1;
			}
			if (other.TakeEffectParam1.Length != 0)
			{
				TakeEffectParam1 = other.TakeEffectParam1;
			}
			if (other.TakeEffectParam2.Length != 0)
			{
				TakeEffectParam2 = other.TakeEffectParam2;
			}
			if (other.TakeEffectParam3.Length != 0)
			{
				TakeEffectParam3 = other.TakeEffectParam3;
			}
			if (other.TakeEffectParam4.Length != 0)
			{
				TakeEffectParam4 = other.TakeEffectParam4;
			}
			if (other.TakeEffectTarget2 != 0)
			{
				TakeEffectTarget2 = other.TakeEffectTarget2;
			}
			if (other.TakeEffectCondition2 != 0)
			{
				TakeEffectCondition2 = other.TakeEffectCondition2;
			}
			if (other.TakeEffect2Param1.Length != 0)
			{
				TakeEffect2Param1 = other.TakeEffect2Param1;
			}
			if (other.TakeEffect2Param2.Length != 0)
			{
				TakeEffect2Param2 = other.TakeEffect2Param2;
			}
			if (other.TakeEffect2Param3.Length != 0)
			{
				TakeEffect2Param3 = other.TakeEffect2Param3;
			}
			if (other.TakeEffect2Param4.Length != 0)
			{
				TakeEffect2Param4 = other.TakeEffect2Param4;
			}
			if (other.TakeEffectLogicType != 0)
			{
				TakeEffectLogicType = other.TakeEffectLogicType;
			}
			if (other.Target1 != 0)
			{
				Target1 = other.Target1;
			}
			if (other.TargetCondition1 != 0)
			{
				TargetCondition1 = other.TargetCondition1;
			}
			if (other.TargetParam1.Length != 0)
			{
				TargetParam1 = other.TargetParam1;
			}
			if (other.TargetParam2.Length != 0)
			{
				TargetParam2 = other.TargetParam2;
			}
			if (other.TargetParam3.Length != 0)
			{
				TargetParam3 = other.TargetParam3;
			}
			if (other.TargetParam4.Length != 0)
			{
				TargetParam4 = other.TargetParam4;
			}
			if (other.TargetCondition2 != 0)
			{
				TargetCondition2 = other.TargetCondition2;
			}
			if (other.Target2Param1.Length != 0)
			{
				Target2Param1 = other.Target2Param1;
			}
			if (other.Target2Param2.Length != 0)
			{
				Target2Param2 = other.Target2Param2;
			}
			if (other.Target2Param3.Length != 0)
			{
				Target2Param3 = other.Target2Param3;
			}
			if (other.Target2Param4.Length != 0)
			{
				Target2Param4 = other.Target2Param4;
			}
			if (other.FilterLogicType != 0)
			{
				FilterLogicType = other.FilterLogicType;
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
				LevelTypeData = input.ReadInt32();
				break;
			case 32u:
				LevelData = input.ReadInt32();
				break;
			case 40u:
				MainOrSupport = input.ReadInt32();
				break;
			case 48u:
				Trigger = input.ReadInt32();
				break;
			case 56u:
				TriggerTarget = input.ReadInt32();
				break;
			case 64u:
				TriggerCondition1 = input.ReadInt32();
				break;
			case 74u:
				TriggerParam1 = input.ReadString();
				break;
			case 82u:
				TriggerParam2 = input.ReadString();
				break;
			case 90u:
				TriggerParam3 = input.ReadString();
				break;
			case 98u:
				TriggerParam4 = input.ReadString();
				break;
			case 104u:
				TriggerTarget2 = input.ReadInt32();
				break;
			case 112u:
				TriggerCondition2 = input.ReadInt32();
				break;
			case 122u:
				Trigger2Param1 = input.ReadString();
				break;
			case 130u:
				Trigger2Param2 = input.ReadString();
				break;
			case 138u:
				Trigger2Param3 = input.ReadString();
				break;
			case 146u:
				Trigger2Param4 = input.ReadString();
				break;
			case 152u:
				TriggerLogicType = input.ReadInt32();
				break;
			case 160u:
				TakeEffectTarget1 = input.ReadInt32();
				break;
			case 168u:
				TakeEffectCondition1 = input.ReadInt32();
				break;
			case 178u:
				TakeEffectParam1 = input.ReadString();
				break;
			case 186u:
				TakeEffectParam2 = input.ReadString();
				break;
			case 194u:
				TakeEffectParam3 = input.ReadString();
				break;
			case 202u:
				TakeEffectParam4 = input.ReadString();
				break;
			case 208u:
				TakeEffectTarget2 = input.ReadInt32();
				break;
			case 216u:
				TakeEffectCondition2 = input.ReadInt32();
				break;
			case 226u:
				TakeEffect2Param1 = input.ReadString();
				break;
			case 234u:
				TakeEffect2Param2 = input.ReadString();
				break;
			case 242u:
				TakeEffect2Param3 = input.ReadString();
				break;
			case 250u:
				TakeEffect2Param4 = input.ReadString();
				break;
			case 256u:
				TakeEffectLogicType = input.ReadInt32();
				break;
			case 264u:
				Target1 = input.ReadInt32();
				break;
			case 272u:
				TargetCondition1 = input.ReadInt32();
				break;
			case 282u:
				TargetParam1 = input.ReadString();
				break;
			case 290u:
				TargetParam2 = input.ReadString();
				break;
			case 298u:
				TargetParam3 = input.ReadString();
				break;
			case 306u:
				TargetParam4 = input.ReadString();
				break;
			case 312u:
				TargetCondition2 = input.ReadInt32();
				break;
			case 322u:
				Target2Param1 = input.ReadString();
				break;
			case 330u:
				Target2Param2 = input.ReadString();
				break;
			case 338u:
				Target2Param3 = input.ReadString();
				break;
			case 346u:
				Target2Param4 = input.ReadString();
				break;
			case 352u:
				FilterLogicType = input.ReadInt32();
				break;
			}
		}
	}
}
