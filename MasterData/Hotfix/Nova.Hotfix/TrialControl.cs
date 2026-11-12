using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TrialControl : IMessage<TrialControl>, IMessage, IEquatable<TrialControl>, IDeepCloneable<TrialControl>
{
	private static readonly MessageParser<TrialControl> _parser = new MessageParser<TrialControl>(() => new TrialControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_groupIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> groupIds_ = new RepeatedField<int>();

	public const int GachasFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_gachas_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> gachas_ = new RepeatedField<int>();

	public const int UIAssetsFieldNumber = 4;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 5;

	private string ctrlName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TrialControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1030);

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
	public RepeatedField<int> GroupIds => groupIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Gachas => gachas_;

	[DebuggerNonUserCode]
	public string UIAssets
	{
		get
		{
			return uIAssets_;
		}
		set
		{
			uIAssets_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CtrlName
	{
		get
		{
			return ctrlName_;
		}
		set
		{
			ctrlName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TrialControl()
	{
	}

	[DebuggerNonUserCode]
	public TrialControl(TrialControl other)
		: this()
	{
		id_ = other.id_;
		groupIds_ = other.groupIds_.Clone();
		gachas_ = other.gachas_.Clone();
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TrialControl Clone()
	{
		return new TrialControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TrialControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(TrialControl other)
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
		if (!groupIds_.Equals(other.groupIds_))
		{
			return false;
		}
		if (!gachas_.Equals(other.gachas_))
		{
			return false;
		}
		if (UIAssets != other.UIAssets)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
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
		num ^= groupIds_.GetHashCode();
		num ^= gachas_.GetHashCode();
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
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
		groupIds_.WriteTo(output, _repeated_groupIds_codec);
		gachas_.WriteTo(output, _repeated_gachas_codec);
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(CtrlName);
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
		num += groupIds_.CalculateSize(_repeated_groupIds_codec);
		num += gachas_.CalculateSize(_repeated_gachas_codec);
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TrialControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			groupIds_.Add(other.groupIds_);
			gachas_.Add(other.gachas_);
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
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
			case 18u:
				groupIds_.AddEntriesFrom(input, _repeated_groupIds_codec);
				break;
			case 24u:
			case 26u:
				gachas_.AddEntriesFrom(input, _repeated_gachas_codec);
				break;
			case 34u:
				UIAssets = input.ReadString();
				break;
			case 42u:
				CtrlName = input.ReadString();
				break;
			}
		}
	}
}
