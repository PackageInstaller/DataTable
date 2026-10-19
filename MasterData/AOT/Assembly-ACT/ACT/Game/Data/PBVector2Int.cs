using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;
using UnityEngine;

namespace ACT.Game.Data;

public sealed class PBVector2Int : IMessage<PBVector2Int>, IMessage, IEquatable<PBVector2Int>, IDeepCloneable<PBVector2Int>, IBufferMessage
{
	private static readonly MessageParser<PBVector2Int> _parser = new MessageParser<PBVector2Int>(() => new PBVector2Int());

	private UnknownFieldSet _unknownFields;

	public const int XFieldNumber = 1;

	private int x_;

	public const int YFieldNumber = 2;

	private int y_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<PBVector2Int> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[36];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int X
	{
		get
		{
			return x_;
		}
		set
		{
			x_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Y
	{
		get
		{
			return y_;
		}
		set
		{
			y_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector2Int()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector2Int(PBVector2Int other)
		: this()
	{
		x_ = other.x_;
		y_ = other.y_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector2Int Clone()
	{
		return new PBVector2Int(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as PBVector2Int);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(PBVector2Int other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (X != other.X)
		{
			return false;
		}
		if (Y != other.Y)
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
		if (X != 0)
		{
			num ^= X.GetHashCode();
		}
		if (Y != 0)
		{
			num ^= Y.GetHashCode();
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
		if (X != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(X);
		}
		if (Y != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Y);
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
		if (X != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(X);
		}
		if (Y != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Y);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(PBVector2Int other)
	{
		if (other != null)
		{
			if (other.X != 0)
			{
				X = other.X;
			}
			if (other.Y != 0)
			{
				Y = other.Y;
			}
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				X = input.ReadInt32();
				break;
			case 16u:
				Y = input.ReadInt32();
				break;
			}
		}
	}

	public static implicit operator Vector2Int(PBVector2Int pbVector2Int)
	{
		return new Vector2Int(pbVector2Int.X, pbVector2Int.Y);
	}

	public static implicit operator Vector2(PBVector2Int pbVector2Int)
	{
		return new Vector2(pbVector2Int.X, pbVector2Int.Y);
	}

	public static implicit operator PBVector2Int(Vector2Int vector2Int)
	{
		return new PBVector2Int
		{
			X = vector2Int.x,
			Y = vector2Int.y
		};
	}

	public static implicit operator PBVector2Int(Vector2 vector2)
	{
		return new PBVector2Int
		{
			X = Mathf.FloorToInt(vector2.x),
			Y = Mathf.FloorToInt(vector2.y)
		};
	}
}
