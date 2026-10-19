using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssCompleteSubStageAck : IMessage<AbyssCompleteSubStageAck>, IMessage, IEquatable<AbyssCompleteSubStageAck>, IDeepCloneable<AbyssCompleteSubStageAck>, IBufferMessage
{
	private static readonly MessageParser<AbyssCompleteSubStageAck> _parser = new MessageParser<AbyssCompleteSubStageAck>(() => new AbyssCompleteSubStageAck());

	private UnknownFieldSet _unknownFields;

	public const int ErrMsgFieldNumber = 1;

	private string errMsg_ = "";

	public const int CompletedAllFieldNumber = 2;

	private bool completedAll_;

	public const int CompletedStageInfoFieldNumber = 3;

	private AbyssStage completedStageInfo_;

	public const int UnlockNewStageFieldNumber = 4;

	private bool unlockNewStage_;

	public const int TransNoFieldNumber = 6;

	private string transNo_ = "";

	public const int AbyssDataFieldNumber = 7;

	private Abyss abyssData_;

	public const int StageRewardsFieldNumber = 8;

	private static readonly FieldCodec<UniversalItem> _repeated_stageRewards_codec = FieldCodec.ForMessage(66u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> stageRewards_ = new RepeatedField<UniversalItem>();

	public const int QuickStageRewardsFieldNumber = 9;

	private static readonly FieldCodec<UniversalItem> _repeated_quickStageRewards_codec = FieldCodec.ForMessage(74u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> quickStageRewards_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssCompleteSubStageAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string ErrMsg
	{
		get
		{
			return errMsg_;
		}
		set
		{
			errMsg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool CompletedAll
	{
		get
		{
			return completedAll_;
		}
		set
		{
			completedAll_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssStage CompletedStageInfo
	{
		get
		{
			return completedStageInfo_;
		}
		set
		{
			completedStageInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool UnlockNewStage
	{
		get
		{
			return unlockNewStage_;
		}
		set
		{
			unlockNewStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string TransNo
	{
		get
		{
			return transNo_;
		}
		set
		{
			transNo_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abyss AbyssData
	{
		get
		{
			return abyssData_;
		}
		set
		{
			abyssData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> StageRewards => stageRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> QuickStageRewards => quickStageRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssCompleteSubStageAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssCompleteSubStageAck(AbyssCompleteSubStageAck other)
		: this()
	{
		errMsg_ = other.errMsg_;
		completedAll_ = other.completedAll_;
		completedStageInfo_ = ((other.completedStageInfo_ != null) ? other.completedStageInfo_.Clone() : null);
		unlockNewStage_ = other.unlockNewStage_;
		transNo_ = other.transNo_;
		abyssData_ = ((other.abyssData_ != null) ? other.abyssData_.Clone() : null);
		stageRewards_ = other.stageRewards_.Clone();
		quickStageRewards_ = other.quickStageRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssCompleteSubStageAck Clone()
	{
		return new AbyssCompleteSubStageAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssCompleteSubStageAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssCompleteSubStageAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ErrMsg != other.ErrMsg)
		{
			return false;
		}
		if (CompletedAll != other.CompletedAll)
		{
			return false;
		}
		if (!object.Equals(CompletedStageInfo, other.CompletedStageInfo))
		{
			return false;
		}
		if (UnlockNewStage != other.UnlockNewStage)
		{
			return false;
		}
		if (TransNo != other.TransNo)
		{
			return false;
		}
		if (!object.Equals(AbyssData, other.AbyssData))
		{
			return false;
		}
		if (!stageRewards_.Equals(other.stageRewards_))
		{
			return false;
		}
		if (!quickStageRewards_.Equals(other.quickStageRewards_))
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
		if (ErrMsg.Length != 0)
		{
			num ^= ErrMsg.GetHashCode();
		}
		if (CompletedAll)
		{
			num ^= CompletedAll.GetHashCode();
		}
		if (completedStageInfo_ != null)
		{
			num ^= CompletedStageInfo.GetHashCode();
		}
		if (UnlockNewStage)
		{
			num ^= UnlockNewStage.GetHashCode();
		}
		if (TransNo.Length != 0)
		{
			num ^= TransNo.GetHashCode();
		}
		if (abyssData_ != null)
		{
			num ^= AbyssData.GetHashCode();
		}
		num ^= stageRewards_.GetHashCode();
		num ^= quickStageRewards_.GetHashCode();
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
		if (ErrMsg.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(ErrMsg);
		}
		if (CompletedAll)
		{
			output.WriteRawTag(16);
			output.WriteBool(CompletedAll);
		}
		if (completedStageInfo_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(CompletedStageInfo);
		}
		if (UnlockNewStage)
		{
			output.WriteRawTag(32);
			output.WriteBool(UnlockNewStage);
		}
		if (TransNo.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(TransNo);
		}
		if (abyssData_ != null)
		{
			output.WriteRawTag(58);
			output.WriteMessage(AbyssData);
		}
		stageRewards_.WriteTo(ref output, _repeated_stageRewards_codec);
		quickStageRewards_.WriteTo(ref output, _repeated_quickStageRewards_codec);
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
		if (ErrMsg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ErrMsg);
		}
		if (CompletedAll)
		{
			num += 2;
		}
		if (completedStageInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(CompletedStageInfo);
		}
		if (UnlockNewStage)
		{
			num += 2;
		}
		if (TransNo.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TransNo);
		}
		if (abyssData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AbyssData);
		}
		num += stageRewards_.CalculateSize(_repeated_stageRewards_codec);
		num += quickStageRewards_.CalculateSize(_repeated_quickStageRewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssCompleteSubStageAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.ErrMsg.Length != 0)
		{
			ErrMsg = other.ErrMsg;
		}
		if (other.CompletedAll)
		{
			CompletedAll = other.CompletedAll;
		}
		if (other.completedStageInfo_ != null)
		{
			if (completedStageInfo_ == null)
			{
				CompletedStageInfo = new AbyssStage();
			}
			CompletedStageInfo.MergeFrom(other.CompletedStageInfo);
		}
		if (other.UnlockNewStage)
		{
			UnlockNewStage = other.UnlockNewStage;
		}
		if (other.TransNo.Length != 0)
		{
			TransNo = other.TransNo;
		}
		if (other.abyssData_ != null)
		{
			if (abyssData_ == null)
			{
				AbyssData = new Abyss();
			}
			AbyssData.MergeFrom(other.AbyssData);
		}
		stageRewards_.Add(other.stageRewards_);
		quickStageRewards_.Add(other.quickStageRewards_);
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
				ErrMsg = input.ReadString();
				break;
			case 16u:
				CompletedAll = input.ReadBool();
				break;
			case 26u:
				if (completedStageInfo_ == null)
				{
					CompletedStageInfo = new AbyssStage();
				}
				input.ReadMessage(CompletedStageInfo);
				break;
			case 32u:
				UnlockNewStage = input.ReadBool();
				break;
			case 50u:
				TransNo = input.ReadString();
				break;
			case 58u:
				if (abyssData_ == null)
				{
					AbyssData = new Abyss();
				}
				input.ReadMessage(AbyssData);
				break;
			case 66u:
				stageRewards_.AddEntriesFrom(ref input, _repeated_stageRewards_codec);
				break;
			case 74u:
				quickStageRewards_.AddEntriesFrom(ref input, _repeated_quickStageRewards_codec);
				break;
			}
		}
	}
}
