using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class SceneBGM : IMessage<SceneBGM>, IMessage, IEquatable<SceneBGM>, IDeepCloneable<SceneBGM>
{
	private static readonly MessageParser<SceneBGM> _parser = new MessageParser<SceneBGM>(() => new SceneBGM());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int SceneNameFieldNumber = 2;

	private string sceneName_ = "";

	public const int AudioIDFieldNumber = 3;

	private int audioID_;

	[DebuggerNonUserCode]
	public static MessageParser<SceneBGM> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[51];

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
	public string SceneName
	{
		get
		{
			return sceneName_;
		}
		set
		{
			sceneName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AudioID
	{
		get
		{
			return audioID_;
		}
		set
		{
			audioID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SceneBGM()
	{
	}

	[DebuggerNonUserCode]
	public SceneBGM(SceneBGM other)
		: this()
	{
		iD_ = other.iD_;
		sceneName_ = other.sceneName_;
		audioID_ = other.audioID_;
	}

	[DebuggerNonUserCode]
	public SceneBGM Clone()
	{
		return new SceneBGM(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SceneBGM);
	}

	[DebuggerNonUserCode]
	public bool Equals(SceneBGM other)
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
		if (SceneName != other.SceneName)
		{
			return false;
		}
		if (AudioID != other.AudioID)
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
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (AudioID != 0)
		{
			num ^= AudioID.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(SceneName);
		}
		if (AudioID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AudioID);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (AudioID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SceneBGM other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.AudioID != 0)
			{
				AudioID = other.AudioID;
			}
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
			case 18u:
				SceneName = input.ReadString();
				break;
			case 24u:
				AudioID = input.ReadInt32();
				break;
			}
		}
	}
}
