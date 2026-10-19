using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueChallengeReq : IMessage<RogueChallengeReq>, IMessage, IEquatable<RogueChallengeReq>, IDeepCloneable<RogueChallengeReq>, IBufferMessage
{
	private static readonly MessageParser<RogueChallengeReq> _parser = new MessageParser<RogueChallengeReq>(() => new RogueChallengeReq());

	private UnknownFieldSet _unknownFields;

	public const int ModeIdFieldNumber = 1;

	private int modeId_;

	public const int CoreIdFieldNumber = 2;

	private int coreId_;

	public const int BattleCharacterFieldNumber = 3;

	private TeamUsage battleCharacter_;

	public const int SeedFieldNumber = 4;

	private long seed_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueChallengeReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ModeId
	{
		get
		{
			return modeId_;
		}
		set
		{
			modeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CoreId
	{
		get
		{
			return coreId_;
		}
		set
		{
			coreId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TeamUsage BattleCharacter
	{
		get
		{
			return battleCharacter_;
		}
		set
		{
			battleCharacter_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Seed
	{
		get
		{
			return seed_;
		}
		set
		{
			seed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueChallengeReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueChallengeReq(RogueChallengeReq other)
		: this()
	{
		modeId_ = other.modeId_;
		coreId_ = other.coreId_;
		battleCharacter_ = ((other.battleCharacter_ != null) ? other.battleCharacter_.Clone() : null);
		seed_ = other.seed_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueChallengeReq Clone()
	{
		return new RogueChallengeReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueChallengeReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueChallengeReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ModeId != other.ModeId)
		{
			return false;
		}
		if (CoreId != other.CoreId)
		{
			return false;
		}
		if (!object.Equals(BattleCharacter, other.BattleCharacter))
		{
			return false;
		}
		if (Seed != other.Seed)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (ModeId != 0)
		{
			num ^= ModeId.GetHashCode();
		}
		if (CoreId != 0)
		{
			num ^= CoreId.GetHashCode();
		}
		if (battleCharacter_ != null)
		{
			num ^= BattleCharacter.GetHashCode();
		}
		if (Seed != 0L)
		{
			num ^= Seed.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (ModeId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ModeId);
		}
		if (CoreId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CoreId);
		}
		if (battleCharacter_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(BattleCharacter);
		}
		if (Seed != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(Seed);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (ModeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModeId);
		}
		if (CoreId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CoreId);
		}
		if (battleCharacter_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BattleCharacter);
		}
		if (Seed != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Seed);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueChallengeReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ModeId != 0)
		{
			ModeId = other.ModeId;
		}
		if (other.CoreId != 0)
		{
			CoreId = other.CoreId;
		}
		if (other.battleCharacter_ != null)
		{
			if (battleCharacter_ == null)
			{
				BattleCharacter = new TeamUsage();
			}
			BattleCharacter.MergeFrom(other.BattleCharacter);
		}
		if (other.Seed != 0L)
		{
			Seed = other.Seed;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				ModeId = input.ReadInt32();
				break;
			case 16u:
				CoreId = input.ReadInt32();
				break;
			case 26u:
				if (battleCharacter_ == null)
				{
					BattleCharacter = new TeamUsage();
				}
				input.ReadMessage(BattleCharacter);
				break;
			case 32u:
				Seed = input.ReadInt64();
				break;
			}
		}
	}
}
