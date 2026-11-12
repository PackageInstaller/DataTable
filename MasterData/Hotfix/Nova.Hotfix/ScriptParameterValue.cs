using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ScriptParameterValue : IMessage<ScriptParameterValue>, IMessage, IEquatable<ScriptParameterValue>, IDeepCloneable<ScriptParameterValue>
{
	private static readonly MessageParser<ScriptParameterValue> _parser = new MessageParser<ScriptParameterValue>(() => new ScriptParameterValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CommonDataFieldNumber = 2;

	private int commonData_;

	[DebuggerNonUserCode]
	public static MessageParser<ScriptParameterValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(710);

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
	public int CommonData
	{
		get
		{
			return commonData_;
		}
		set
		{
			commonData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ScriptParameterValue()
	{
	}

	[DebuggerNonUserCode]
	public ScriptParameterValue(ScriptParameterValue other)
		: this()
	{
		id_ = other.id_;
		commonData_ = other.commonData_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ScriptParameterValue Clone()
	{
		return new ScriptParameterValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ScriptParameterValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(ScriptParameterValue other)
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
		if (CommonData != other.CommonData)
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
		if (CommonData != 0)
		{
			num ^= CommonData.GetHashCode();
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
		if (CommonData != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CommonData);
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
		if (CommonData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CommonData);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ScriptParameterValue other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CommonData != 0)
			{
				CommonData = other.CommonData;
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
				CommonData = input.ReadInt32();
				break;
			}
		}
	}
}
