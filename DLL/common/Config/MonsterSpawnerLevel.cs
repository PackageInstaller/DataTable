using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class MonsterSpawnerLevel : IMessage<MonsterSpawnerLevel>, IMessage, IEquatable<MonsterSpawnerLevel>, IDeepCloneable<MonsterSpawnerLevel>
{
	private static readonly MessageParser<MonsterSpawnerLevel> _parser = new MessageParser<MonsterSpawnerLevel>(() => new MonsterSpawnerLevel());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int WaveTypeFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_waveType_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> waveType_ = new RepeatedField<int>();

	public const int WaveMonsterFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_waveMonster_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> waveMonster_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<MonsterSpawnerLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[42];

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
	public RepeatedField<int> WaveType => waveType_;

	[DebuggerNonUserCode]
	public RepeatedField<int> WaveMonster => waveMonster_;

	[DebuggerNonUserCode]
	public MonsterSpawnerLevel()
	{
	}

	[DebuggerNonUserCode]
	public MonsterSpawnerLevel(MonsterSpawnerLevel other)
		: this()
	{
		iD_ = other.iD_;
		waveType_ = other.waveType_.Clone();
		waveMonster_ = other.waveMonster_.Clone();
	}

	[DebuggerNonUserCode]
	public MonsterSpawnerLevel Clone()
	{
		return new MonsterSpawnerLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterSpawnerLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterSpawnerLevel other)
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
		if (!waveType_.Equals(other.waveType_))
		{
			return false;
		}
		if (!waveMonster_.Equals(other.waveMonster_))
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
		num ^= waveType_.GetHashCode();
		return num ^ waveMonster_.GetHashCode();
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
		waveType_.WriteTo(output, _repeated_waveType_codec);
		waveMonster_.WriteTo(output, _repeated_waveMonster_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		num += waveType_.CalculateSize(_repeated_waveType_codec);
		return num + waveMonster_.CalculateSize(_repeated_waveMonster_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterSpawnerLevel other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			waveType_.Add(other.waveType_);
			waveMonster_.Add(other.waveMonster_);
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
			case 18u:
				waveType_.AddEntriesFrom(input, _repeated_waveType_codec);
				break;
			case 24u:
			case 26u:
				waveMonster_.AddEntriesFrom(input, _repeated_waveMonster_codec);
				break;
			}
		}
	}
}
