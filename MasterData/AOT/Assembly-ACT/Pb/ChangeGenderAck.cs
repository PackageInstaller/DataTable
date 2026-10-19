using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ChangeGenderAck : IMessage<ChangeGenderAck>, IMessage, IEquatable<ChangeGenderAck>, IDeepCloneable<ChangeGenderAck>, IBufferMessage
{
	private static readonly MessageParser<ChangeGenderAck> _parser = new MessageParser<ChangeGenderAck>(() => new ChangeGenderAck());

	private UnknownFieldSet _unknownFields;

	public const int CurAvatarIdFieldNumber = 1;

	private int curAvatarId_;

	public const int AvatarIdsFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_avatarIds_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> avatarIds_ = new MapField<int, bool>();

	public const int ChangeTSFieldNumber = 3;

	private int changeTS_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ChangeGenderAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ProfileReflection.Descriptor.MessageTypes[28];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurAvatarId
	{
		get
		{
			return curAvatarId_;
		}
		set
		{
			curAvatarId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> AvatarIds => avatarIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChangeTS
	{
		get
		{
			return changeTS_;
		}
		set
		{
			changeTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChangeGenderAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChangeGenderAck(ChangeGenderAck other)
		: this()
	{
		curAvatarId_ = other.curAvatarId_;
		avatarIds_ = other.avatarIds_.Clone();
		changeTS_ = other.changeTS_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChangeGenderAck Clone()
	{
		return new ChangeGenderAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ChangeGenderAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ChangeGenderAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CurAvatarId != other.CurAvatarId)
		{
			return false;
		}
		if (!AvatarIds.Equals(other.AvatarIds))
		{
			return false;
		}
		if (ChangeTS != other.ChangeTS)
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
		if (CurAvatarId != 0)
		{
			num ^= CurAvatarId.GetHashCode();
		}
		num ^= AvatarIds.GetHashCode();
		if (ChangeTS != 0)
		{
			num ^= ChangeTS.GetHashCode();
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
		if (CurAvatarId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CurAvatarId);
		}
		avatarIds_.WriteTo(ref output, _map_avatarIds_codec);
		if (ChangeTS != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ChangeTS);
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
		if (CurAvatarId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurAvatarId);
		}
		num += avatarIds_.CalculateSize(_map_avatarIds_codec);
		if (ChangeTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChangeTS);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ChangeGenderAck other)
	{
		if (other != null)
		{
			if (other.CurAvatarId != 0)
			{
				CurAvatarId = other.CurAvatarId;
			}
			avatarIds_.Add(other.avatarIds_);
			if (other.ChangeTS != 0)
			{
				ChangeTS = other.ChangeTS;
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
				CurAvatarId = input.ReadInt32();
				break;
			case 18u:
				avatarIds_.AddEntriesFrom(ref input, _map_avatarIds_codec);
				break;
			case 24u:
				ChangeTS = input.ReadInt32();
				break;
			}
		}
	}
}
