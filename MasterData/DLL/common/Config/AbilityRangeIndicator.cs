using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class AbilityRangeIndicator : IMessage<AbilityRangeIndicator>, IMessage, IEquatable<AbilityRangeIndicator>, IDeepCloneable<AbilityRangeIndicator>
{
	private static readonly MessageParser<AbilityRangeIndicator> _parser = new MessageParser<AbilityRangeIndicator>(() => new AbilityRangeIndicator());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DamageIndicatorRadiusFieldNumber = 2;

	private int damageIndicatorRadius_;

	public const int AssetPathFieldNumber = 3;

	private string assetPath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<AbilityRangeIndicator> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[7];

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
	public int DamageIndicatorRadius
	{
		get
		{
			return damageIndicatorRadius_;
		}
		set
		{
			damageIndicatorRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AssetPath
	{
		get
		{
			return assetPath_;
		}
		set
		{
			assetPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public AbilityRangeIndicator()
	{
	}

	[DebuggerNonUserCode]
	public AbilityRangeIndicator(AbilityRangeIndicator other)
		: this()
	{
		iD_ = other.iD_;
		damageIndicatorRadius_ = other.damageIndicatorRadius_;
		assetPath_ = other.assetPath_;
	}

	[DebuggerNonUserCode]
	public AbilityRangeIndicator Clone()
	{
		return new AbilityRangeIndicator(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AbilityRangeIndicator);
	}

	[DebuggerNonUserCode]
	public bool Equals(AbilityRangeIndicator other)
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
		if (DamageIndicatorRadius != other.DamageIndicatorRadius)
		{
			return false;
		}
		if (AssetPath != other.AssetPath)
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
		if (DamageIndicatorRadius != 0)
		{
			num ^= DamageIndicatorRadius.GetHashCode();
		}
		if (AssetPath.Length != 0)
		{
			num ^= AssetPath.GetHashCode();
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
		if (DamageIndicatorRadius != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DamageIndicatorRadius);
		}
		if (AssetPath.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(AssetPath);
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
		if (DamageIndicatorRadius != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageIndicatorRadius);
		}
		if (AssetPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AssetPath);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AbilityRangeIndicator other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.DamageIndicatorRadius != 0)
			{
				DamageIndicatorRadius = other.DamageIndicatorRadius;
			}
			if (other.AssetPath.Length != 0)
			{
				AssetPath = other.AssetPath;
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
			case 16u:
				DamageIndicatorRadius = input.ReadInt32();
				break;
			case 26u:
				AssetPath = input.ReadString();
				break;
			}
		}
	}
}
