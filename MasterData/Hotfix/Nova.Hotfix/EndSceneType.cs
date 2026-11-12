using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EndSceneType : IMessage<EndSceneType>, IMessage, IEquatable<EndSceneType>, IDeepCloneable<EndSceneType>
{
	private static readonly MessageParser<EndSceneType> _parser = new MessageParser<EndSceneType>(() => new EndSceneType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ThemeFieldNumber = 2;

	private int theme_;

	public const int EndSceneNameFieldNumber = 3;

	private string endSceneName_ = "";

	public const int BGMFieldNumber = 4;

	private string bGM_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<EndSceneType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(332);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Theme
	{
		get
		{
			return theme_;
		}
		set
		{
			theme_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string EndSceneName
	{
		get
		{
			return endSceneName_;
		}
		set
		{
			endSceneName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BGM
	{
		get
		{
			return bGM_;
		}
		set
		{
			bGM_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public EndSceneType()
	{
	}

	[DebuggerNonUserCode]
	public EndSceneType(EndSceneType other)
		: this()
	{
		id_ = other.id_;
		theme_ = other.theme_;
		endSceneName_ = other.endSceneName_;
		bGM_ = other.bGM_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EndSceneType Clone()
	{
		return new EndSceneType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EndSceneType);
	}

	[DebuggerNonUserCode]
	public bool Equals(EndSceneType other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Theme != other.Theme)
		{
			return false;
		}
		if (EndSceneName != other.EndSceneName)
		{
			return false;
		}
		if (BGM != other.BGM)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Theme != 0)
		{
			num ^= Theme.GetHashCode();
		}
		if (EndSceneName.Length != 0)
		{
			num ^= EndSceneName.GetHashCode();
		}
		if (BGM.Length != 0)
		{
			num ^= BGM.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Theme != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Theme);
		}
		if (EndSceneName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(EndSceneName);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(BGM);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Theme != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Theme);
		}
		if (EndSceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndSceneName);
		}
		if (BGM.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BGM);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EndSceneType other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Theme != 0)
			{
				Theme = other.Theme;
			}
			if (other.EndSceneName.Length != 0)
			{
				EndSceneName = other.EndSceneName;
			}
			if (other.BGM.Length != 0)
			{
				BGM = other.BGM;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				Theme = input.ReadInt32();
				break;
			case 26u:
				EndSceneName = input.ReadString();
				break;
			case 34u:
				BGM = input.ReadString();
				break;
			}
		}
	}
}
