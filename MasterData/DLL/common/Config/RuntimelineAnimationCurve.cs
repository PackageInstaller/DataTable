using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class RuntimelineAnimationCurve : IMessage<RuntimelineAnimationCurve>, IMessage, IEquatable<RuntimelineAnimationCurve>, IDeepCloneable<RuntimelineAnimationCurve>
{
	private static readonly MessageParser<RuntimelineAnimationCurve> _parser = new MessageParser<RuntimelineAnimationCurve>(() => new RuntimelineAnimationCurve());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int IsLoopFieldNumber = 2;

	private bool isLoop_;

	public const int XCurveFieldNumber = 3;

	private static readonly FieldCodec<Keyframe> _repeated_xCurve_codec = FieldCodec.ForMessage(26u, Keyframe.Parser);

	private readonly RepeatedField<Keyframe> xCurve_ = new RepeatedField<Keyframe>();

	public const int YCurveFieldNumber = 4;

	private static readonly FieldCodec<Keyframe> _repeated_yCurve_codec = FieldCodec.ForMessage(34u, Keyframe.Parser);

	private readonly RepeatedField<Keyframe> yCurve_ = new RepeatedField<Keyframe>();

	public const int ZCurveFieldNumber = 5;

	private static readonly FieldCodec<Keyframe> _repeated_zCurve_codec = FieldCodec.ForMessage(42u, Keyframe.Parser);

	private readonly RepeatedField<Keyframe> zCurve_ = new RepeatedField<Keyframe>();

	[DebuggerNonUserCode]
	public static MessageParser<RuntimelineAnimationCurve> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[50];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsLoop
	{
		get
		{
			return isLoop_;
		}
		set
		{
			isLoop_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<Keyframe> XCurve => xCurve_;

	[DebuggerNonUserCode]
	public RepeatedField<Keyframe> YCurve => yCurve_;

	[DebuggerNonUserCode]
	public RepeatedField<Keyframe> ZCurve => zCurve_;

	[DebuggerNonUserCode]
	public RuntimelineAnimationCurve()
	{
	}

	[DebuggerNonUserCode]
	public RuntimelineAnimationCurve(RuntimelineAnimationCurve other)
		: this()
	{
		iD_ = other.iD_;
		isLoop_ = other.isLoop_;
		xCurve_ = other.xCurve_.Clone();
		yCurve_ = other.yCurve_.Clone();
		zCurve_ = other.zCurve_.Clone();
	}

	[DebuggerNonUserCode]
	public RuntimelineAnimationCurve Clone()
	{
		return new RuntimelineAnimationCurve(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RuntimelineAnimationCurve);
	}

	[DebuggerNonUserCode]
	public bool Equals(RuntimelineAnimationCurve other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (IsLoop != other.IsLoop)
		{
			return false;
		}
		if (!xCurve_.Equals(other.xCurve_))
		{
			return false;
		}
		if (!yCurve_.Equals(other.yCurve_))
		{
			return false;
		}
		if (!zCurve_.Equals(other.zCurve_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (IsLoop)
		{
			num ^= IsLoop.GetHashCode();
		}
		num ^= xCurve_.GetHashCode();
		num ^= yCurve_.GetHashCode();
		return num ^ zCurve_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (IsLoop)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsLoop);
		}
		xCurve_.WriteTo(output, _repeated_xCurve_codec);
		yCurve_.WriteTo(output, _repeated_yCurve_codec);
		zCurve_.WriteTo(output, _repeated_zCurve_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (IsLoop)
		{
			num += 2;
		}
		num += xCurve_.CalculateSize(_repeated_xCurve_codec);
		num += yCurve_.CalculateSize(_repeated_yCurve_codec);
		return num + zCurve_.CalculateSize(_repeated_zCurve_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RuntimelineAnimationCurve other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.IsLoop)
			{
				IsLoop = other.IsLoop;
			}
			xCurve_.Add(other.xCurve_);
			yCurve_.Add(other.yCurve_);
			zCurve_.Add(other.zCurve_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				IsLoop = input.ReadBool();
				break;
			case 26u:
				xCurve_.AddEntriesFrom(input, _repeated_xCurve_codec);
				break;
			case 34u:
				yCurve_.AddEntriesFrom(input, _repeated_yCurve_codec);
				break;
			case 42u:
				zCurve_.AddEntriesFrom(input, _repeated_zCurve_codec);
				break;
			}
		}
	}
}
