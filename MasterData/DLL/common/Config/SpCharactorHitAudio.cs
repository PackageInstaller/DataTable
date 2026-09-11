using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class SpCharactorHitAudio : IMessage<SpCharactorHitAudio>, IMessage, IEquatable<SpCharactorHitAudio>, IDeepCloneable<SpCharactorHitAudio>
{
	private static readonly MessageParser<SpCharactorHitAudio> _parser = new MessageParser<SpCharactorHitAudio>(() => new SpCharactorHitAudio());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int AudioIDBodyFieldNumber = 2;

	private int audioIDBody_;

	public const int AudioIDLightArmourFieldNumber = 3;

	private int audioIDLightArmour_;

	public const int AudioIDHeavyArmourFieldNumber = 4;

	private int audioIDHeavyArmour_;

	public const int AudioIDMetalFieldNumber = 5;

	private int audioIDMetal_;

	[DebuggerNonUserCode]
	public static MessageParser<SpCharactorHitAudio> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[58];

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
	public int AudioIDBody
	{
		get
		{
			return audioIDBody_;
		}
		set
		{
			audioIDBody_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AudioIDLightArmour
	{
		get
		{
			return audioIDLightArmour_;
		}
		set
		{
			audioIDLightArmour_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AudioIDHeavyArmour
	{
		get
		{
			return audioIDHeavyArmour_;
		}
		set
		{
			audioIDHeavyArmour_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AudioIDMetal
	{
		get
		{
			return audioIDMetal_;
		}
		set
		{
			audioIDMetal_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SpCharactorHitAudio()
	{
	}

	[DebuggerNonUserCode]
	public SpCharactorHitAudio(SpCharactorHitAudio other)
		: this()
	{
		iD_ = other.iD_;
		audioIDBody_ = other.audioIDBody_;
		audioIDLightArmour_ = other.audioIDLightArmour_;
		audioIDHeavyArmour_ = other.audioIDHeavyArmour_;
		audioIDMetal_ = other.audioIDMetal_;
	}

	[DebuggerNonUserCode]
	public SpCharactorHitAudio Clone()
	{
		return new SpCharactorHitAudio(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SpCharactorHitAudio);
	}

	[DebuggerNonUserCode]
	public bool Equals(SpCharactorHitAudio other)
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
		if (AudioIDBody != other.AudioIDBody)
		{
			return false;
		}
		if (AudioIDLightArmour != other.AudioIDLightArmour)
		{
			return false;
		}
		if (AudioIDHeavyArmour != other.AudioIDHeavyArmour)
		{
			return false;
		}
		if (AudioIDMetal != other.AudioIDMetal)
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
		if (AudioIDBody != 0)
		{
			num ^= AudioIDBody.GetHashCode();
		}
		if (AudioIDLightArmour != 0)
		{
			num ^= AudioIDLightArmour.GetHashCode();
		}
		if (AudioIDHeavyArmour != 0)
		{
			num ^= AudioIDHeavyArmour.GetHashCode();
		}
		if (AudioIDMetal != 0)
		{
			num ^= AudioIDMetal.GetHashCode();
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
		if (AudioIDBody != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AudioIDBody);
		}
		if (AudioIDLightArmour != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AudioIDLightArmour);
		}
		if (AudioIDHeavyArmour != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AudioIDHeavyArmour);
		}
		if (AudioIDMetal != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(AudioIDMetal);
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
		if (AudioIDBody != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioIDBody);
		}
		if (AudioIDLightArmour != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioIDLightArmour);
		}
		if (AudioIDHeavyArmour != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioIDHeavyArmour);
		}
		if (AudioIDMetal != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioIDMetal);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SpCharactorHitAudio other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.AudioIDBody != 0)
			{
				AudioIDBody = other.AudioIDBody;
			}
			if (other.AudioIDLightArmour != 0)
			{
				AudioIDLightArmour = other.AudioIDLightArmour;
			}
			if (other.AudioIDHeavyArmour != 0)
			{
				AudioIDHeavyArmour = other.AudioIDHeavyArmour;
			}
			if (other.AudioIDMetal != 0)
			{
				AudioIDMetal = other.AudioIDMetal;
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
				AudioIDBody = input.ReadInt32();
				break;
			case 24u:
				AudioIDLightArmour = input.ReadInt32();
				break;
			case 32u:
				AudioIDHeavyArmour = input.ReadInt32();
				break;
			case 40u:
				AudioIDMetal = input.ReadInt32();
				break;
			}
		}
	}
}
