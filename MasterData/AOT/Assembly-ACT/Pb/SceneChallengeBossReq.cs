using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SceneChallengeBossReq : IMessage<SceneChallengeBossReq>, IMessage, IEquatable<SceneChallengeBossReq>, IDeepCloneable<SceneChallengeBossReq>, IBufferMessage
{
	private static readonly MessageParser<SceneChallengeBossReq> _parser = new MessageParser<SceneChallengeBossReq>(() => new SceneChallengeBossReq());

	private UnknownFieldSet _unknownFields;

	public const int DifficultyLevelFieldNumber = 1;

	private int difficultyLevel_;

	public const int InteractionUidFieldNumber = 2;

	private int interactionUid_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneChallengeBossReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => InteracteventReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DifficultyLevel
	{
		get
		{
			return difficultyLevel_;
		}
		set
		{
			difficultyLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int InteractionUid
	{
		get
		{
			return interactionUid_;
		}
		set
		{
			interactionUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneChallengeBossReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneChallengeBossReq(SceneChallengeBossReq other)
		: this()
	{
		difficultyLevel_ = other.difficultyLevel_;
		interactionUid_ = other.interactionUid_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneChallengeBossReq Clone()
	{
		return new SceneChallengeBossReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneChallengeBossReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneChallengeBossReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (DifficultyLevel != other.DifficultyLevel)
		{
			return false;
		}
		if (InteractionUid != other.InteractionUid)
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
		if (DifficultyLevel != 0)
		{
			num ^= DifficultyLevel.GetHashCode();
		}
		if (InteractionUid != 0)
		{
			num ^= InteractionUid.GetHashCode();
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
		if (DifficultyLevel != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(DifficultyLevel);
		}
		if (InteractionUid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(InteractionUid);
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
		if (DifficultyLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DifficultyLevel);
		}
		if (InteractionUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InteractionUid);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneChallengeBossReq other)
	{
		if (other != null)
		{
			if (other.DifficultyLevel != 0)
			{
				DifficultyLevel = other.DifficultyLevel;
			}
			if (other.InteractionUid != 0)
			{
				InteractionUid = other.InteractionUid;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
				DifficultyLevel = input.ReadInt32();
				break;
			case 16u:
				InteractionUid = input.ReadInt32();
				break;
			}
		}
	}
}
