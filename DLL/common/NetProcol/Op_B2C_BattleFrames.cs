using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(136)]
public sealed class Op_B2C_BattleFrames : IMessage<Op_B2C_BattleFrames>, IMessage, IEquatable<Op_B2C_BattleFrames>, IDeepCloneable<Op_B2C_BattleFrames>
{
	private static readonly MessageParser<Op_B2C_BattleFrames> _parser = new MessageParser<Op_B2C_BattleFrames>(() => new Op_B2C_BattleFrames());

	public const int FramesFieldNumber = 1;

	private ByteString frames_ = ByteString.Empty;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_BattleFrames> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[41];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public ByteString Frames
	{
		get
		{
			return frames_;
		}
		set
		{
			frames_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Op_B2C_BattleFrames()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_BattleFrames(Op_B2C_BattleFrames other)
		: this()
	{
		frames_ = other.frames_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_BattleFrames Clone()
	{
		return new Op_B2C_BattleFrames(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_BattleFrames);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_BattleFrames other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Frames != other.Frames)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Frames.Length != 0)
		{
			num ^= Frames.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Frames.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteBytes(Frames);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Frames.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeBytesSize(Frames);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_BattleFrames other)
	{
		if (other != null && other.Frames.Length != 0)
		{
			Frames = other.Frames;
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				Frames = input.ReadBytes();
			}
		}
	}
}
