using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionExpireNtf : IMessage<MissionExpireNtf>, IMessage, IEquatable<MissionExpireNtf>, IDeepCloneable<MissionExpireNtf>, IBufferMessage
{
	private static readonly MessageParser<MissionExpireNtf> _parser = new MessageParser<MissionExpireNtf>(() => new MissionExpireNtf());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDListFieldNumber = 1;

	private static readonly FieldCodec<long> _repeated_missionIDList_codec = FieldCodec.ForInt64(10u);

	private readonly RepeatedField<long> missionIDList_ = new RepeatedField<long>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionExpireNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<long> MissionIDList => missionIDList_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionExpireNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionExpireNtf(MissionExpireNtf other)
		: this()
	{
		missionIDList_ = other.missionIDList_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionExpireNtf Clone()
	{
		return new MissionExpireNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionExpireNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionExpireNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!missionIDList_.Equals(other.missionIDList_))
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
		num ^= missionIDList_.GetHashCode();
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
		missionIDList_.WriteTo(ref output, _repeated_missionIDList_codec);
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
		num += missionIDList_.CalculateSize(_repeated_missionIDList_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionExpireNtf other)
	{
		if (other != null)
		{
			missionIDList_.Add(other.missionIDList_);
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
			if (num != 8 && num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				missionIDList_.AddEntriesFrom(ref input, _repeated_missionIDList_codec);
			}
		}
	}
}
