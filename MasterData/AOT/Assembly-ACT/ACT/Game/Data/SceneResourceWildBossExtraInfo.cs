using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SceneResourceWildBossExtraInfo : IMessage<SceneResourceWildBossExtraInfo>, IMessage, IEquatable<SceneResourceWildBossExtraInfo>, IDeepCloneable<SceneResourceWildBossExtraInfo>, IBufferMessage
{
	private static readonly MessageParser<SceneResourceWildBossExtraInfo> _parser = new MessageParser<SceneResourceWildBossExtraInfo>(() => new SceneResourceWildBossExtraInfo());

	private UnknownFieldSet _unknownFields;

	public const int PlayerWorldLvOnDiedFieldNumber = 1;

	private int playerWorldLvOnDied_;

	public const int WildBossMonsterPointIDFieldNumber = 2;

	private int wildBossMonsterPointID_;

	public const int WildBossMonsterPointUIDFieldNumber = 3;

	private int wildBossMonsterPointUID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneResourceWildBossExtraInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[190];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PlayerWorldLvOnDied
	{
		get
		{
			return playerWorldLvOnDied_;
		}
		set
		{
			playerWorldLvOnDied_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WildBossMonsterPointID
	{
		get
		{
			return wildBossMonsterPointID_;
		}
		set
		{
			wildBossMonsterPointID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WildBossMonsterPointUID
	{
		get
		{
			return wildBossMonsterPointUID_;
		}
		set
		{
			wildBossMonsterPointUID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneResourceWildBossExtraInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneResourceWildBossExtraInfo(SceneResourceWildBossExtraInfo other)
		: this()
	{
		playerWorldLvOnDied_ = other.playerWorldLvOnDied_;
		wildBossMonsterPointID_ = other.wildBossMonsterPointID_;
		wildBossMonsterPointUID_ = other.wildBossMonsterPointUID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneResourceWildBossExtraInfo Clone()
	{
		return new SceneResourceWildBossExtraInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneResourceWildBossExtraInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneResourceWildBossExtraInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PlayerWorldLvOnDied != other.PlayerWorldLvOnDied)
		{
			return false;
		}
		if (WildBossMonsterPointID != other.WildBossMonsterPointID)
		{
			return false;
		}
		if (WildBossMonsterPointUID != other.WildBossMonsterPointUID)
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
		if (PlayerWorldLvOnDied != 0)
		{
			num ^= PlayerWorldLvOnDied.GetHashCode();
		}
		if (WildBossMonsterPointID != 0)
		{
			num ^= WildBossMonsterPointID.GetHashCode();
		}
		if (WildBossMonsterPointUID != 0)
		{
			num ^= WildBossMonsterPointUID.GetHashCode();
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
		if (PlayerWorldLvOnDied != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PlayerWorldLvOnDied);
		}
		if (WildBossMonsterPointID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(WildBossMonsterPointID);
		}
		if (WildBossMonsterPointUID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WildBossMonsterPointUID);
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
		if (PlayerWorldLvOnDied != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerWorldLvOnDied);
		}
		if (WildBossMonsterPointID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WildBossMonsterPointID);
		}
		if (WildBossMonsterPointUID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WildBossMonsterPointUID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneResourceWildBossExtraInfo other)
	{
		if (other != null)
		{
			if (other.PlayerWorldLvOnDied != 0)
			{
				PlayerWorldLvOnDied = other.PlayerWorldLvOnDied;
			}
			if (other.WildBossMonsterPointID != 0)
			{
				WildBossMonsterPointID = other.WildBossMonsterPointID;
			}
			if (other.WildBossMonsterPointUID != 0)
			{
				WildBossMonsterPointUID = other.WildBossMonsterPointUID;
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
				PlayerWorldLvOnDied = input.ReadInt32();
				break;
			case 16u:
				WildBossMonsterPointID = input.ReadInt32();
				break;
			case 24u:
				WildBossMonsterPointUID = input.ReadInt32();
				break;
			}
		}
	}
}
