using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierBossPersonalityGrade : IMessage<SoldierBossPersonalityGrade>, IMessage, IEquatable<SoldierBossPersonalityGrade>, IDeepCloneable<SoldierBossPersonalityGrade>
{
	private static readonly MessageParser<SoldierBossPersonalityGrade> _parser = new MessageParser<SoldierBossPersonalityGrade>(() => new SoldierBossPersonalityGrade());

	private UnknownFieldSet _unknownFields;

	public const int SoldierPersonalityGradeFieldNumber = 1;

	private int soldierPersonalityGrade_;

	public const int AdjustValueFieldNumber = 2;

	private string adjustValue_ = "";

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SoldierBossPersonalityGrade> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(730);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int SoldierPersonalityGrade
	{
		get
		{
			return soldierPersonalityGrade_;
		}
		set
		{
			soldierPersonalityGrade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AdjustValue
	{
		get
		{
			return adjustValue_;
		}
		set
		{
			adjustValue_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public SoldierBossPersonalityGrade()
	{
	}

	[DebuggerNonUserCode]
	public SoldierBossPersonalityGrade(SoldierBossPersonalityGrade other)
		: this()
	{
		soldierPersonalityGrade_ = other.soldierPersonalityGrade_;
		adjustValue_ = other.adjustValue_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierBossPersonalityGrade Clone()
	{
		return new SoldierBossPersonalityGrade(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierBossPersonalityGrade);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierBossPersonalityGrade other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SoldierPersonalityGrade != other.SoldierPersonalityGrade)
		{
			return false;
		}
		if (AdjustValue != other.AdjustValue)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (SoldierPersonalityGrade != 0)
		{
			num ^= SoldierPersonalityGrade.GetHashCode();
		}
		if (AdjustValue.Length != 0)
		{
			num ^= AdjustValue.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (SoldierPersonalityGrade != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SoldierPersonalityGrade);
		}
		if (AdjustValue.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(AdjustValue);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
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
		if (SoldierPersonalityGrade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SoldierPersonalityGrade);
		}
		if (AdjustValue.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AdjustValue);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierBossPersonalityGrade other)
	{
		if (other != null)
		{
			if (other.SoldierPersonalityGrade != 0)
			{
				SoldierPersonalityGrade = other.SoldierPersonalityGrade;
			}
			if (other.AdjustValue.Length != 0)
			{
				AdjustValue = other.AdjustValue;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				SoldierPersonalityGrade = input.ReadInt32();
				break;
			case 18u:
				AdjustValue = input.ReadString();
				break;
			case 26u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
