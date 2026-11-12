using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DropPkg : IMessage<DropPkg>, IMessage, IEquatable<DropPkg>, IDeepCloneable<DropPkg>
{
	private static readonly MessageParser<DropPkg> _parser = new MessageParser<DropPkg>(() => new DropPkg());

	private UnknownFieldSet _unknownFields;

	public const int PkgIdFieldNumber = 1;

	private int pkgId_;

	public const int ItemIdFieldNumber = 2;

	private int itemId_;

	[DebuggerNonUserCode]
	public static MessageParser<DropPkg> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(324);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DropPkg()
	{
	}

	[DebuggerNonUserCode]
	public DropPkg(DropPkg other)
		: this()
	{
		pkgId_ = other.pkgId_;
		itemId_ = other.itemId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DropPkg Clone()
	{
		return new DropPkg(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DropPkg);
	}

	[DebuggerNonUserCode]
	public bool Equals(DropPkg other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PkgId != other.PkgId)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PkgId != 0)
		{
			num ^= PkgId.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
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
		if (PkgId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PkgId);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ItemId);
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
		if (PkgId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PkgId);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DropPkg other)
	{
		if (other != null)
		{
			if (other.PkgId != 0)
			{
				PkgId = other.PkgId;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
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
				PkgId = input.ReadInt32();
				break;
			case 16u:
				ItemId = input.ReadInt32();
				break;
			}
		}
	}
}
