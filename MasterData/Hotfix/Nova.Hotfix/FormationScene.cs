using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class FormationScene : IMessage<FormationScene>, IMessage, IEquatable<FormationScene>, IDeepCloneable<FormationScene>
{
	private static readonly MessageParser<FormationScene> _parser = new MessageParser<FormationScene>(() => new FormationScene());

	private UnknownFieldSet _unknownFields;

	public const int SceneNameFieldNumber = 1;

	private string sceneName_ = "";

	public const int PathFieldNumber = 2;

	private string path_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<FormationScene> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(360);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public string Path
	{
		get
		{
			return path_;
		}
		set
		{
			path_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public FormationScene()
	{
	}

	[DebuggerNonUserCode]
	public FormationScene(FormationScene other)
		: this()
	{
		sceneName_ = other.sceneName_;
		path_ = other.path_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public FormationScene Clone()
	{
		return new FormationScene(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FormationScene);
	}

	[DebuggerNonUserCode]
	public bool Equals(FormationScene other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SceneName != other.SceneName)
		{
			return false;
		}
		if (Path != other.Path)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (SceneName.Length != 0)
		{
			num ^= SceneName.GetHashCode();
		}
		if (Path.Length != 0)
		{
			num ^= Path.GetHashCode();
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
		if (SceneName.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(SceneName);
		}
		if (Path.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Path);
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
		if (SceneName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SceneName);
		}
		if (Path.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Path);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(FormationScene other)
	{
		if (other != null)
		{
			if (other.SceneName.Length != 0)
			{
				SceneName = other.SceneName;
			}
			if (other.Path.Length != 0)
			{
				Path = other.Path;
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
			case 10u:
				SceneName = input.ReadString();
				break;
			case 18u:
				Path = input.ReadString();
				break;
			}
		}
	}
}
