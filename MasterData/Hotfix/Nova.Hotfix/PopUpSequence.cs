using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PopUpSequence : IMessage<PopUpSequence>, IMessage, IEquatable<PopUpSequence>, IDeepCloneable<PopUpSequence>
{
	private static readonly MessageParser<PopUpSequence> _parser = new MessageParser<PopUpSequence>(() => new PopUpSequence());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SortIdFieldNumber = 2;

	private int sortId_;

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int PanelIdFieldNumber = 4;

	private int panelId_;

	public const int BLocalSaveFieldNumber = 5;

	private bool bLocalSave_;

	[DebuggerNonUserCode]
	public static MessageParser<PopUpSequence> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(656);

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
	public int SortId
	{
		get
		{
			return sortId_;
		}
		set
		{
			sortId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PanelId
	{
		get
		{
			return panelId_;
		}
		set
		{
			panelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool BLocalSave
	{
		get
		{
			return bLocalSave_;
		}
		set
		{
			bLocalSave_ = value;
		}
	}

	[DebuggerNonUserCode]
	public PopUpSequence()
	{
	}

	[DebuggerNonUserCode]
	public PopUpSequence(PopUpSequence other)
		: this()
	{
		id_ = other.id_;
		sortId_ = other.sortId_;
		type_ = other.type_;
		panelId_ = other.panelId_;
		bLocalSave_ = other.bLocalSave_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PopUpSequence Clone()
	{
		return new PopUpSequence(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PopUpSequence);
	}

	[DebuggerNonUserCode]
	public bool Equals(PopUpSequence other)
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
		if (SortId != other.SortId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (PanelId != other.PanelId)
		{
			return false;
		}
		if (BLocalSave != other.BLocalSave)
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
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (PanelId != 0)
		{
			num ^= PanelId.GetHashCode();
		}
		if (BLocalSave)
		{
			num ^= BLocalSave.GetHashCode();
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
		if (SortId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SortId);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (PanelId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PanelId);
		}
		if (BLocalSave)
		{
			output.WriteRawTag(40);
			output.WriteBool(BLocalSave);
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
		if (SortId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (PanelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PanelId);
		}
		if (BLocalSave)
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
	public void MergeFrom(PopUpSequence other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.PanelId != 0)
			{
				PanelId = other.PanelId;
			}
			if (other.BLocalSave)
			{
				BLocalSave = other.BLocalSave;
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
				SortId = input.ReadInt32();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 32u:
				PanelId = input.ReadInt32();
				break;
			case 40u:
				BLocalSave = input.ReadBool();
				break;
			}
		}
	}
}
