using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Achievements : IMessage<Achievements>, IMessage, IEquatable<Achievements>, IDeepCloneable<Achievements>, IBufferMessage
{
	private static readonly MessageParser<Achievements> _parser = new MessageParser<Achievements>(() => new Achievements());

	private UnknownFieldSet _unknownFields;

	public const int ProgressDataFieldNumber = 1;

	private AchievementProgressData progressData_;

	public const int InfoFieldNumber = 2;

	private AchievementInfo info_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Achievements> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[223];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementProgressData ProgressData
	{
		get
		{
			return progressData_;
		}
		set
		{
			progressData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementInfo Info
	{
		get
		{
			return info_;
		}
		set
		{
			info_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Achievements()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Achievements(Achievements other)
		: this()
	{
		progressData_ = ((other.progressData_ != null) ? other.progressData_.Clone() : null);
		info_ = ((other.info_ != null) ? other.info_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Achievements Clone()
	{
		return new Achievements(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Achievements);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Achievements other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ProgressData, other.ProgressData))
		{
			return false;
		}
		if (!object.Equals(Info, other.Info))
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
		if (progressData_ != null)
		{
			num ^= ProgressData.GetHashCode();
		}
		if (info_ != null)
		{
			num ^= Info.GetHashCode();
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
		if (progressData_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ProgressData);
		}
		if (info_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Info);
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
		if (progressData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ProgressData);
		}
		if (info_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Info);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Achievements other)
	{
		if (other == null)
		{
			return;
		}
		if (other.progressData_ != null)
		{
			if (progressData_ == null)
			{
				ProgressData = new AchievementProgressData();
			}
			ProgressData.MergeFrom(other.ProgressData);
		}
		if (other.info_ != null)
		{
			if (info_ == null)
			{
				Info = new AchievementInfo();
			}
			Info.MergeFrom(other.Info);
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
				if (progressData_ == null)
				{
					ProgressData = new AchievementProgressData();
				}
				input.ReadMessage(ProgressData);
				break;
			case 18u:
				if (info_ == null)
				{
					Info = new AchievementInfo();
				}
				input.ReadMessage(Info);
				break;
			}
		}
	}
}
