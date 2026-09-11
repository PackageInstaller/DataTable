using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class boss_appear_UI_text : IMessage<boss_appear_UI_text>, IMessage, IEquatable<boss_appear_UI_text>, IDeepCloneable<boss_appear_UI_text>
{
	private static readonly MessageParser<boss_appear_UI_text> _parser = new MessageParser<boss_appear_UI_text>(() => new boss_appear_UI_text());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int MainNameFieldNumber = 2;

	private string mainName_ = "";

	public const int SubNameFieldNumber = 3;

	private string subName_ = "";

	public const int FactionFieldNumber = 4;

	private string faction_ = "";

	public const int FeaturesFieldNumber = 5;

	private string features_ = "";

	public const int AttackTypeFieldNumber = 6;

	private string attackType_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<boss_appear_UI_text> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[80];

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
	public string MainName
	{
		get
		{
			return mainName_;
		}
		set
		{
			mainName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SubName
	{
		get
		{
			return subName_;
		}
		set
		{
			subName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Features
	{
		get
		{
			return features_;
		}
		set
		{
			features_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AttackType
	{
		get
		{
			return attackType_;
		}
		set
		{
			attackType_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public boss_appear_UI_text()
	{
	}

	[DebuggerNonUserCode]
	public boss_appear_UI_text(boss_appear_UI_text other)
		: this()
	{
		iD_ = other.iD_;
		mainName_ = other.mainName_;
		subName_ = other.subName_;
		faction_ = other.faction_;
		features_ = other.features_;
		attackType_ = other.attackType_;
	}

	[DebuggerNonUserCode]
	public boss_appear_UI_text Clone()
	{
		return new boss_appear_UI_text(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as boss_appear_UI_text);
	}

	[DebuggerNonUserCode]
	public bool Equals(boss_appear_UI_text other)
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
		if (MainName != other.MainName)
		{
			return false;
		}
		if (SubName != other.SubName)
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (Features != other.Features)
		{
			return false;
		}
		if (AttackType != other.AttackType)
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
		if (MainName.Length != 0)
		{
			num ^= MainName.GetHashCode();
		}
		if (SubName.Length != 0)
		{
			num ^= SubName.GetHashCode();
		}
		if (Faction.Length != 0)
		{
			num ^= Faction.GetHashCode();
		}
		if (Features.Length != 0)
		{
			num ^= Features.GetHashCode();
		}
		if (AttackType.Length != 0)
		{
			num ^= AttackType.GetHashCode();
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
		if (MainName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(MainName);
		}
		if (SubName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(SubName);
		}
		if (Faction.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Faction);
		}
		if (Features.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Features);
		}
		if (AttackType.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(AttackType);
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
		if (MainName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MainName);
		}
		if (SubName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SubName);
		}
		if (Faction.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Faction);
		}
		if (Features.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Features);
		}
		if (AttackType.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AttackType);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(boss_appear_UI_text other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.MainName.Length != 0)
			{
				MainName = other.MainName;
			}
			if (other.SubName.Length != 0)
			{
				SubName = other.SubName;
			}
			if (other.Faction.Length != 0)
			{
				Faction = other.Faction;
			}
			if (other.Features.Length != 0)
			{
				Features = other.Features;
			}
			if (other.AttackType.Length != 0)
			{
				AttackType = other.AttackType;
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
				MainName = input.ReadString();
				break;
			case 26u:
				SubName = input.ReadString();
				break;
			case 34u:
				Faction = input.ReadString();
				break;
			case 42u:
				Features = input.ReadString();
				break;
			case 50u:
				AttackType = input.ReadString();
				break;
			}
		}
	}
}
