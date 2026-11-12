using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Drop : IMessage<Drop>, IMessage, IEquatable<Drop>, IDeepCloneable<Drop>
{
	private static readonly MessageParser<Drop> _parser = new MessageParser<Drop>(() => new Drop());

	private UnknownFieldSet _unknownFields;

	public const int DropIdFieldNumber = 1;

	private int dropId_;

	public const int PkgIdFieldNumber = 2;

	private int pkgId_;

	[DebuggerNonUserCode]
	public static MessageParser<Drop> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(316);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int DropId
	{
		get
		{
			return dropId_;
		}
		set
		{
			dropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PkgId
	{
		get
		{
			return pkgId_;
		}
		set
		{
			pkgId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Drop()
	{
	}

	[DebuggerNonUserCode]
	public Drop(Drop other)
		: this()
	{
		dropId_ = other.dropId_;
		pkgId_ = other.pkgId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Drop Clone()
	{
		return new Drop(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Drop);
	}

	[DebuggerNonUserCode]
	public bool Equals(Drop other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (DropId != other.DropId)
		{
			return false;
		}
		if (PkgId != other.PkgId)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (DropId != 0)
		{
			num ^= DropId.GetHashCode();
		}
		if (PkgId != 0)
		{
			num ^= PkgId.GetHashCode();
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
		if (DropId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(DropId);
		}
		if (PkgId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PkgId);
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
		if (DropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropId);
		}
		if (PkgId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PkgId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Drop other)
	{
		if (other != null)
		{
			if (other.DropId != 0)
			{
				DropId = other.DropId;
			}
			if (other.PkgId != 0)
			{
				PkgId = other.PkgId;
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
				DropId = input.ReadInt32();
				break;
			case 16u:
				PkgId = input.ReadInt32();
				break;
			}
		}
	}
}
