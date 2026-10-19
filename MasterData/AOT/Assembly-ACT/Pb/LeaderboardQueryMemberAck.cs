using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class LeaderboardQueryMemberAck : IMessage<LeaderboardQueryMemberAck>, IMessage, IEquatable<LeaderboardQueryMemberAck>, IDeepCloneable<LeaderboardQueryMemberAck>, IBufferMessage
{
	private static readonly MessageParser<LeaderboardQueryMemberAck> _parser = new MessageParser<LeaderboardQueryMemberAck>(() => new LeaderboardQueryMemberAck());

	private UnknownFieldSet _unknownFields;

	public const int SelfInfoFieldNumber = 1;

	private RankInfo selfInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<LeaderboardQueryMemberAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[133];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RankInfo SelfInfo
	{
		get
		{
			return selfInfo_;
		}
		set
		{
			selfInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LeaderboardQueryMemberAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LeaderboardQueryMemberAck(LeaderboardQueryMemberAck other)
		: this()
	{
		selfInfo_ = ((other.selfInfo_ != null) ? other.selfInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public LeaderboardQueryMemberAck Clone()
	{
		return new LeaderboardQueryMemberAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as LeaderboardQueryMemberAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(LeaderboardQueryMemberAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(SelfInfo, other.SelfInfo))
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
		if (selfInfo_ != null)
		{
			num ^= SelfInfo.GetHashCode();
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
		if (selfInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(SelfInfo);
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
		if (selfInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SelfInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(LeaderboardQueryMemberAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.selfInfo_ != null)
		{
			if (selfInfo_ == null)
			{
				SelfInfo = new RankInfo();
			}
			SelfInfo.MergeFrom(other.SelfInfo);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (selfInfo_ == null)
			{
				SelfInfo = new RankInfo();
			}
			input.ReadMessage(SelfInfo);
		}
	}
}
