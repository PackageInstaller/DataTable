using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssRechallengeReq : IMessage<AbyssRechallengeReq>, IMessage, IEquatable<AbyssRechallengeReq>, IDeepCloneable<AbyssRechallengeReq>, IBufferMessage
{
	private static readonly MessageParser<AbyssRechallengeReq> _parser = new MessageParser<AbyssRechallengeReq>(() => new AbyssRechallengeReq());

	private UnknownFieldSet _unknownFields;

	public const int OnlyCurrentLayerFieldNumber = 1;

	private bool onlyCurrentLayer_;

	public const int SettleInfoFieldNumber = 2;

	private StageSettleInfo settleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssRechallengeReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool OnlyCurrentLayer
	{
		get
		{
			return onlyCurrentLayer_;
		}
		set
		{
			onlyCurrentLayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleInfo SettleInfo
	{
		get
		{
			return settleInfo_;
		}
		set
		{
			settleInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssRechallengeReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssRechallengeReq(AbyssRechallengeReq other)
		: this()
	{
		onlyCurrentLayer_ = other.onlyCurrentLayer_;
		settleInfo_ = ((other.settleInfo_ != null) ? other.settleInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssRechallengeReq Clone()
	{
		return new AbyssRechallengeReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssRechallengeReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssRechallengeReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (OnlyCurrentLayer != other.OnlyCurrentLayer)
		{
			return false;
		}
		if (!object.Equals(SettleInfo, other.SettleInfo))
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
		if (OnlyCurrentLayer)
		{
			num ^= OnlyCurrentLayer.GetHashCode();
		}
		if (settleInfo_ != null)
		{
			num ^= SettleInfo.GetHashCode();
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
		if (OnlyCurrentLayer)
		{
			output.WriteRawTag(8);
			output.WriteBool(OnlyCurrentLayer);
		}
		if (settleInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(SettleInfo);
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
		if (OnlyCurrentLayer)
		{
			num += 2;
		}
		if (settleInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SettleInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssRechallengeReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.OnlyCurrentLayer)
		{
			OnlyCurrentLayer = other.OnlyCurrentLayer;
		}
		if (other.settleInfo_ != null)
		{
			if (settleInfo_ == null)
			{
				SettleInfo = new StageSettleInfo();
			}
			SettleInfo.MergeFrom(other.SettleInfo);
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
				OnlyCurrentLayer = input.ReadBool();
				break;
			case 18u:
				if (settleInfo_ == null)
				{
					SettleInfo = new StageSettleInfo();
				}
				input.ReadMessage(SettleInfo);
				break;
			}
		}
	}
}
