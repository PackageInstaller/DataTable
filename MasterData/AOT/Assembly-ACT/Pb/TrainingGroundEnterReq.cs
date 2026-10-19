using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class TrainingGroundEnterReq : IMessage<TrainingGroundEnterReq>, IMessage, IEquatable<TrainingGroundEnterReq>, IDeepCloneable<TrainingGroundEnterReq>, IBufferMessage
{
	private static readonly MessageParser<TrainingGroundEnterReq> _parser = new MessageParser<TrainingGroundEnterReq>(() => new TrainingGroundEnterReq());

	private UnknownFieldSet _unknownFields;

	public const int SceneParamFieldNumber = 1;

	private ScenePosParam sceneParam_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TrainingGroundEnterReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TraininggroundReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ScenePosParam SceneParam
	{
		get
		{
			return sceneParam_;
		}
		set
		{
			sceneParam_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TrainingGroundEnterReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TrainingGroundEnterReq(TrainingGroundEnterReq other)
		: this()
	{
		sceneParam_ = ((other.sceneParam_ != null) ? other.sceneParam_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TrainingGroundEnterReq Clone()
	{
		return new TrainingGroundEnterReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TrainingGroundEnterReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TrainingGroundEnterReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(SceneParam, other.SceneParam))
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
		if (sceneParam_ != null)
		{
			num ^= SceneParam.GetHashCode();
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
		if (sceneParam_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(SceneParam);
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
		if (sceneParam_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SceneParam);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TrainingGroundEnterReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.sceneParam_ != null)
		{
			if (sceneParam_ == null)
			{
				SceneParam = new ScenePosParam();
			}
			SceneParam.MergeFrom(other.SceneParam);
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
			if (sceneParam_ == null)
			{
				SceneParam = new ScenePosParam();
			}
			input.ReadMessage(SceneParam);
		}
	}
}
