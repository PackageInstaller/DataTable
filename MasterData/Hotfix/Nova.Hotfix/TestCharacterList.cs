using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TestCharacterList : IMessage<TestCharacterList>, IMessage, IEquatable<TestCharacterList>, IDeepCloneable<TestCharacterList>
{
	private static readonly MessageParser<TestCharacterList> _parser = new MessageParser<TestCharacterList>(() => new TestCharacterList());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MainControlFieldNumber = 2;

	private bool mainControl_;

	public const int MustassistantFieldNumber = 3;

	private bool mustassistant_;

	public const int AssistantFieldNumber = 4;

	private bool assistant_;

	[DebuggerNonUserCode]
	public static MessageParser<TestCharacterList> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(922);

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
	public bool MainControl
	{
		get
		{
			return mainControl_;
		}
		set
		{
			mainControl_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Mustassistant
	{
		get
		{
			return mustassistant_;
		}
		set
		{
			mustassistant_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Assistant
	{
		get
		{
			return assistant_;
		}
		set
		{
			assistant_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TestCharacterList()
	{
	}

	[DebuggerNonUserCode]
	public TestCharacterList(TestCharacterList other)
		: this()
	{
		id_ = other.id_;
		mainControl_ = other.mainControl_;
		mustassistant_ = other.mustassistant_;
		assistant_ = other.assistant_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TestCharacterList Clone()
	{
		return new TestCharacterList(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TestCharacterList);
	}

	[DebuggerNonUserCode]
	public bool Equals(TestCharacterList other)
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
		if (MainControl != other.MainControl)
		{
			return false;
		}
		if (Mustassistant != other.Mustassistant)
		{
			return false;
		}
		if (Assistant != other.Assistant)
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
		if (MainControl)
		{
			num ^= MainControl.GetHashCode();
		}
		if (Mustassistant)
		{
			num ^= Mustassistant.GetHashCode();
		}
		if (Assistant)
		{
			num ^= Assistant.GetHashCode();
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
		if (MainControl)
		{
			output.WriteRawTag(16);
			output.WriteBool(MainControl);
		}
		if (Mustassistant)
		{
			output.WriteRawTag(24);
			output.WriteBool(Mustassistant);
		}
		if (Assistant)
		{
			output.WriteRawTag(32);
			output.WriteBool(Assistant);
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
		if (MainControl)
		{
			num += 2;
		}
		if (Mustassistant)
		{
			num += 2;
		}
		if (Assistant)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TestCharacterList other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MainControl)
			{
				MainControl = other.MainControl;
			}
			if (other.Mustassistant)
			{
				Mustassistant = other.Mustassistant;
			}
			if (other.Assistant)
			{
				Assistant = other.Assistant;
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
				MainControl = input.ReadBool();
				break;
			case 24u:
				Mustassistant = input.ReadBool();
				break;
			case 32u:
				Assistant = input.ReadBool();
				break;
			}
		}
	}
}
