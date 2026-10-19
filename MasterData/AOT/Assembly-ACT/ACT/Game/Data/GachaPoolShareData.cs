using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaPoolShareData : IMessage<GachaPoolShareData>, IMessage, IEquatable<GachaPoolShareData>, IDeepCloneable<GachaPoolShareData>, IBufferMessage
{
	private static readonly MessageParser<GachaPoolShareData> _parser = new MessageParser<GachaPoolShareData>(() => new GachaPoolShareData());

	private UnknownFieldSet _unknownFields;

	public const int LimitedGuaranteedPoolFieldNumber = 1;

	private GachaLimitedGuaranteedPool limitedGuaranteedPool_;

	public const int LimitedUpPoolFieldNumber = 2;

	private GachaLimitedUpPool limitedUpPool_;

	public const int ResidentPoolFieldNumber = 3;

	private GachaResidentPool residentPool_;

	public const int TestRoundTwoPoolFieldNumber = 4;

	private GachaTestRoundTwoPool testRoundTwoPool_;

	public const int NewbiePoolFieldNumber = 5;

	private GachaNewbiePool newbiePool_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaPoolShareData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[156];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaLimitedGuaranteedPool LimitedGuaranteedPool
	{
		get
		{
			return limitedGuaranteedPool_;
		}
		set
		{
			limitedGuaranteedPool_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaLimitedUpPool LimitedUpPool
	{
		get
		{
			return limitedUpPool_;
		}
		set
		{
			limitedUpPool_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaResidentPool ResidentPool
	{
		get
		{
			return residentPool_;
		}
		set
		{
			residentPool_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaTestRoundTwoPool TestRoundTwoPool
	{
		get
		{
			return testRoundTwoPool_;
		}
		set
		{
			testRoundTwoPool_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaNewbiePool NewbiePool
	{
		get
		{
			return newbiePool_;
		}
		set
		{
			newbiePool_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareData(GachaPoolShareData other)
		: this()
	{
		limitedGuaranteedPool_ = ((other.limitedGuaranteedPool_ != null) ? other.limitedGuaranteedPool_.Clone() : null);
		limitedUpPool_ = ((other.limitedUpPool_ != null) ? other.limitedUpPool_.Clone() : null);
		residentPool_ = ((other.residentPool_ != null) ? other.residentPool_.Clone() : null);
		testRoundTwoPool_ = ((other.testRoundTwoPool_ != null) ? other.testRoundTwoPool_.Clone() : null);
		newbiePool_ = ((other.newbiePool_ != null) ? other.newbiePool_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareData Clone()
	{
		return new GachaPoolShareData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPoolShareData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaPoolShareData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(LimitedGuaranteedPool, other.LimitedGuaranteedPool))
		{
			return false;
		}
		if (!object.Equals(LimitedUpPool, other.LimitedUpPool))
		{
			return false;
		}
		if (!object.Equals(ResidentPool, other.ResidentPool))
		{
			return false;
		}
		if (!object.Equals(TestRoundTwoPool, other.TestRoundTwoPool))
		{
			return false;
		}
		if (!object.Equals(NewbiePool, other.NewbiePool))
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
		if (limitedGuaranteedPool_ != null)
		{
			num ^= LimitedGuaranteedPool.GetHashCode();
		}
		if (limitedUpPool_ != null)
		{
			num ^= LimitedUpPool.GetHashCode();
		}
		if (residentPool_ != null)
		{
			num ^= ResidentPool.GetHashCode();
		}
		if (testRoundTwoPool_ != null)
		{
			num ^= TestRoundTwoPool.GetHashCode();
		}
		if (newbiePool_ != null)
		{
			num ^= NewbiePool.GetHashCode();
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
		if (limitedGuaranteedPool_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(LimitedGuaranteedPool);
		}
		if (limitedUpPool_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(LimitedUpPool);
		}
		if (residentPool_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(ResidentPool);
		}
		if (testRoundTwoPool_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(TestRoundTwoPool);
		}
		if (newbiePool_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(NewbiePool);
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
		if (limitedGuaranteedPool_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LimitedGuaranteedPool);
		}
		if (limitedUpPool_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LimitedUpPool);
		}
		if (residentPool_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ResidentPool);
		}
		if (testRoundTwoPool_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(TestRoundTwoPool);
		}
		if (newbiePool_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(NewbiePool);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaPoolShareData other)
	{
		if (other == null)
		{
			return;
		}
		if (other.limitedGuaranteedPool_ != null)
		{
			if (limitedGuaranteedPool_ == null)
			{
				LimitedGuaranteedPool = new GachaLimitedGuaranteedPool();
			}
			LimitedGuaranteedPool.MergeFrom(other.LimitedGuaranteedPool);
		}
		if (other.limitedUpPool_ != null)
		{
			if (limitedUpPool_ == null)
			{
				LimitedUpPool = new GachaLimitedUpPool();
			}
			LimitedUpPool.MergeFrom(other.LimitedUpPool);
		}
		if (other.residentPool_ != null)
		{
			if (residentPool_ == null)
			{
				ResidentPool = new GachaResidentPool();
			}
			ResidentPool.MergeFrom(other.ResidentPool);
		}
		if (other.testRoundTwoPool_ != null)
		{
			if (testRoundTwoPool_ == null)
			{
				TestRoundTwoPool = new GachaTestRoundTwoPool();
			}
			TestRoundTwoPool.MergeFrom(other.TestRoundTwoPool);
		}
		if (other.newbiePool_ != null)
		{
			if (newbiePool_ == null)
			{
				NewbiePool = new GachaNewbiePool();
			}
			NewbiePool.MergeFrom(other.NewbiePool);
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
			case 10u:
				if (limitedGuaranteedPool_ == null)
				{
					LimitedGuaranteedPool = new GachaLimitedGuaranteedPool();
				}
				input.ReadMessage(LimitedGuaranteedPool);
				break;
			case 18u:
				if (limitedUpPool_ == null)
				{
					LimitedUpPool = new GachaLimitedUpPool();
				}
				input.ReadMessage(LimitedUpPool);
				break;
			case 26u:
				if (residentPool_ == null)
				{
					ResidentPool = new GachaResidentPool();
				}
				input.ReadMessage(ResidentPool);
				break;
			case 34u:
				if (testRoundTwoPool_ == null)
				{
					TestRoundTwoPool = new GachaTestRoundTwoPool();
				}
				input.ReadMessage(TestRoundTwoPool);
				break;
			case 42u:
				if (newbiePool_ == null)
				{
					NewbiePool = new GachaNewbiePool();
				}
				input.ReadMessage(NewbiePool);
				break;
			}
		}
	}
}
