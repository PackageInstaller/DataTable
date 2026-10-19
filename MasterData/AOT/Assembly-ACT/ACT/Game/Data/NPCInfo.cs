using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class NPCInfo : IMessage<NPCInfo>, IMessage, IEquatable<NPCInfo>, IDeepCloneable<NPCInfo>, IBufferMessage
{
	private static readonly MessageParser<NPCInfo> _parser = new MessageParser<NPCInfo>(() => new NPCInfo());

	private UnknownFieldSet _unknownFields;

	public const int NpcIdFieldNumber = 1;

	private int npcId_;

	public const int OverrideStateIdFieldNumber = 2;

	private int overrideStateId_;

	public const int OverrideMissionIdFieldNumber = 3;

	private int overrideMissionId_;

	public const int BaseStateIdFieldNumber = 4;

	private int baseStateId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<NPCInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[80];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int NpcId
	{
		get
		{
			return npcId_;
		}
		set
		{
			npcId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OverrideStateId
	{
		get
		{
			return overrideStateId_;
		}
		set
		{
			overrideStateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OverrideMissionId
	{
		get
		{
			return overrideMissionId_;
		}
		set
		{
			overrideMissionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BaseStateId
	{
		get
		{
			return baseStateId_;
		}
		set
		{
			baseStateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NPCInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NPCInfo(NPCInfo other)
		: this()
	{
		npcId_ = other.npcId_;
		overrideStateId_ = other.overrideStateId_;
		overrideMissionId_ = other.overrideMissionId_;
		baseStateId_ = other.baseStateId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public NPCInfo Clone()
	{
		return new NPCInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as NPCInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(NPCInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (NpcId != other.NpcId)
		{
			return false;
		}
		if (OverrideStateId != other.OverrideStateId)
		{
			return false;
		}
		if (OverrideMissionId != other.OverrideMissionId)
		{
			return false;
		}
		if (BaseStateId != other.BaseStateId)
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
		if (NpcId != 0)
		{
			num ^= NpcId.GetHashCode();
		}
		if (OverrideStateId != 0)
		{
			num ^= OverrideStateId.GetHashCode();
		}
		if (OverrideMissionId != 0)
		{
			num ^= OverrideMissionId.GetHashCode();
		}
		if (BaseStateId != 0)
		{
			num ^= BaseStateId.GetHashCode();
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
		if (NpcId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(NpcId);
		}
		if (OverrideStateId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(OverrideStateId);
		}
		if (OverrideMissionId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(OverrideMissionId);
		}
		if (BaseStateId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BaseStateId);
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
		if (NpcId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NpcId);
		}
		if (OverrideStateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverrideStateId);
		}
		if (OverrideMissionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OverrideMissionId);
		}
		if (BaseStateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseStateId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(NPCInfo other)
	{
		if (other != null)
		{
			if (other.NpcId != 0)
			{
				NpcId = other.NpcId;
			}
			if (other.OverrideStateId != 0)
			{
				OverrideStateId = other.OverrideStateId;
			}
			if (other.OverrideMissionId != 0)
			{
				OverrideMissionId = other.OverrideMissionId;
			}
			if (other.BaseStateId != 0)
			{
				BaseStateId = other.BaseStateId;
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
				NpcId = input.ReadInt32();
				break;
			case 16u:
				OverrideStateId = input.ReadInt32();
				break;
			case 24u:
				OverrideMissionId = input.ReadInt32();
				break;
			case 32u:
				BaseStateId = input.ReadInt32();
				break;
			}
		}
	}

	public int GetState()
	{
		if (overrideStateId_ != 0)
		{
			return overrideStateId_;
		}
		return baseStateId_;
	}

	public void SetState(int overrideMissionId, int newStateId)
	{
		if (overrideMissionId != 0)
		{
			overrideMissionId_ = overrideMissionId;
			overrideStateId_ = newStateId;
		}
		else
		{
			baseStateId_ = newStateId;
		}
	}

	public void ClearOverride()
	{
		overrideMissionId_ = 0;
		overrideStateId_ = 0;
	}
}
