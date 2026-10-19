using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SignInGroup : IMessage<SignInGroup>, IMessage, IEquatable<SignInGroup>, IDeepCloneable<SignInGroup>, IBufferMessage
{
	private static readonly MessageParser<SignInGroup> _parser = new MessageParser<SignInGroup>(() => new SignInGroup());

	private UnknownFieldSet _unknownFields;

	public const int GroupIdFieldNumber = 1;

	private int groupId_;

	public const int ChallengeInfosFieldNumber = 2;

	private static readonly MapField<int, SignInChallenge>.Codec _map_challengeInfos_codec = new MapField<int, SignInChallenge>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SignInChallenge.Parser), 18u);

	private readonly MapField<int, SignInChallenge> challengeInfos_ = new MapField<int, SignInChallenge>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SignInGroup> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[257];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SignInChallenge> ChallengeInfos => challengeInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SignInGroup()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SignInGroup(SignInGroup other)
		: this()
	{
		groupId_ = other.groupId_;
		challengeInfos_ = other.challengeInfos_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SignInGroup Clone()
	{
		return new SignInGroup(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SignInGroup);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SignInGroup other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (!ChallengeInfos.Equals(other.ChallengeInfos))
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		num ^= ChallengeInfos.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GroupId);
		}
		challengeInfos_.WriteTo(ref output, _map_challengeInfos_codec);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		num += challengeInfos_.CalculateSize(_map_challengeInfos_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SignInGroup other)
	{
		if (other != null)
		{
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			challengeInfos_.Add(other.challengeInfos_);
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
				GroupId = input.ReadInt32();
				break;
			case 18u:
				challengeInfos_.AddEntriesFrom(ref input, _map_challengeInfos_codec);
				break;
			}
		}
	}
}
