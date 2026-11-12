using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BdConvertControl : IMessage<BdConvertControl>, IMessage, IEquatable<BdConvertControl>, IDeepCloneable<BdConvertControl>
{
	private static readonly MessageParser<BdConvertControl> _parser = new MessageParser<BdConvertControl>(() => new BdConvertControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int UIAssetsFieldNumber = 2;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 3;

	private string ctrlName_ = "";

	public const int RewardsShowFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_rewardsShow_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> rewardsShow_ = new RepeatedField<int>();

	public const int DesTextFieldNumber = 5;

	private string desText_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<BdConvertControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(126);

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
	public RepeatedField<int> RewardsShow => rewardsShow_;

	[DebuggerNonUserCode]
	public string DesText
	{
		get
		{
			return desText_;
		}
		set
		{
			desText_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public BdConvertControl()
	{
	}

	[DebuggerNonUserCode]
	public BdConvertControl(BdConvertControl other)
		: this()
	{
		id_ = other.id_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		rewardsShow_ = other.rewardsShow_.Clone();
		desText_ = other.desText_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BdConvertControl Clone()
	{
		return new BdConvertControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BdConvertControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(BdConvertControl other)
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
		if (UIAssets != other.UIAssets)
		{
			return false;
		}
		if (CtrlName != other.CtrlName)
		{
			return false;
		}
		if (!rewardsShow_.Equals(other.rewardsShow_))
		{
			return false;
		}
		if (DesText != other.DesText)
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
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		num ^= rewardsShow_.GetHashCode();
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
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
		if (UIAssets.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CtrlName);
		}
		rewardsShow_.WriteTo(output, _repeated_rewardsShow_codec);
		if (DesText.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DesText);
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
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		num += rewardsShow_.CalculateSize(_repeated_rewardsShow_codec);
		if (DesText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BdConvertControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			rewardsShow_.Add(other.rewardsShow_);
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
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
			case 18u:
				UIAssets = input.ReadString();
				break;
			case 26u:
				CtrlName = input.ReadString();
				break;
			case 32u:
			case 34u:
				rewardsShow_.AddEntriesFrom(input, _repeated_rewardsShow_codec);
				break;
			case 42u:
				DesText = input.ReadString();
				break;
			}
		}
	}
}
