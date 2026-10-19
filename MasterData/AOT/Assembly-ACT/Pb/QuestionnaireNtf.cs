using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class QuestionnaireNtf : IMessage<QuestionnaireNtf>, IMessage, IEquatable<QuestionnaireNtf>, IDeepCloneable<QuestionnaireNtf>, IBufferMessage
{
	private static readonly MessageParser<QuestionnaireNtf> _parser = new MessageParser<QuestionnaireNtf>(() => new QuestionnaireNtf());

	private UnknownFieldSet _unknownFields;

	public const int QuestionnairesFieldNumber = 1;

	private static readonly FieldCodec<QuestionnaireInfo> _repeated_questionnaires_codec = FieldCodec.ForMessage(10u, QuestionnaireInfo.Parser);

	private readonly RepeatedField<QuestionnaireInfo> questionnaires_ = new RepeatedField<QuestionnaireInfo>();

	public const int NewQuestionnaireFieldNumber = 2;

	private QuestionnaireInfo newQuestionnaire_;

	public const int ReadFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_read_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> read_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<QuestionnaireNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[115];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<QuestionnaireInfo> Questionnaires => questionnaires_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QuestionnaireInfo NewQuestionnaire
	{
		get
		{
			return newQuestionnaire_;
		}
		set
		{
			newQuestionnaire_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> Read => read_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QuestionnaireNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QuestionnaireNtf(QuestionnaireNtf other)
		: this()
	{
		questionnaires_ = other.questionnaires_.Clone();
		newQuestionnaire_ = ((other.newQuestionnaire_ != null) ? other.newQuestionnaire_.Clone() : null);
		read_ = other.read_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public QuestionnaireNtf Clone()
	{
		return new QuestionnaireNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as QuestionnaireNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(QuestionnaireNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!questionnaires_.Equals(other.questionnaires_))
		{
			return false;
		}
		if (!object.Equals(NewQuestionnaire, other.NewQuestionnaire))
		{
			return false;
		}
		if (!Read.Equals(other.Read))
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
		num ^= questionnaires_.GetHashCode();
		if (newQuestionnaire_ != null)
		{
			num ^= NewQuestionnaire.GetHashCode();
		}
		num ^= Read.GetHashCode();
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
		questionnaires_.WriteTo(ref output, _repeated_questionnaires_codec);
		if (newQuestionnaire_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(NewQuestionnaire);
		}
		read_.WriteTo(ref output, _map_read_codec);
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
		num += questionnaires_.CalculateSize(_repeated_questionnaires_codec);
		if (newQuestionnaire_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(NewQuestionnaire);
		}
		num += read_.CalculateSize(_map_read_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(QuestionnaireNtf other)
	{
		if (other == null)
		{
			return;
		}
		questionnaires_.Add(other.questionnaires_);
		if (other.newQuestionnaire_ != null)
		{
			if (newQuestionnaire_ == null)
			{
				NewQuestionnaire = new QuestionnaireInfo();
			}
			NewQuestionnaire.MergeFrom(other.NewQuestionnaire);
		}
		read_.Add(other.read_);
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
				questionnaires_.AddEntriesFrom(ref input, _repeated_questionnaires_codec);
				break;
			case 18u:
				if (newQuestionnaire_ == null)
				{
					NewQuestionnaire = new QuestionnaireInfo();
				}
				input.ReadMessage(NewQuestionnaire);
				break;
			case 26u:
				read_.AddEntriesFrom(ref input, _map_read_codec);
				break;
			}
		}
	}
}
