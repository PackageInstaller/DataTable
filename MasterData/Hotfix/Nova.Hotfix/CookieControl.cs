using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CookieControl : IMessage<CookieControl>, IMessage, IEquatable<CookieControl>, IDeepCloneable<CookieControl>
{
	private static readonly MessageParser<CookieControl> _parser = new MessageParser<CookieControl>(() => new CookieControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int UIAssetsFieldNumber = 2;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 3;

	private string ctrlName_ = "";

	public const int RewardsShowFieldNumber = 4;

	private string rewardsShow_ = "";

	public const int DesTextFieldNumber = 5;

	private string desText_ = "";

	public const int NotifyMailDaysBeforeCloseFieldNumber = 6;

	private int notifyMailDaysBeforeClose_;

	public const int BGMFieldNumber = 7;

	private string bGM_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CookieControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(216);

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
	public string RewardsShow
	{
		get
		{
			return rewardsShow_;
		}
		set
		{
			rewardsShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public int NotifyMailDaysBeforeClose
	{
		get
		{
			return notifyMailDaysBeforeClose_;
		}
		set
		{
			notifyMailDaysBeforeClose_ = value;
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
	public CookieControl()
	{
	}

	[DebuggerNonUserCode]
	public CookieControl(CookieControl other)
		: this()
	{
		id_ = other.id_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		rewardsShow_ = other.rewardsShow_;
		desText_ = other.desText_;
		notifyMailDaysBeforeClose_ = other.notifyMailDaysBeforeClose_;
		bGM_ = other.bGM_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CookieControl Clone()
	{
		return new CookieControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CookieControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(CookieControl other)
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
		if (RewardsShow != other.RewardsShow)
		{
			return false;
		}
		if (DesText != other.DesText)
		{
			return false;
		}
		if (NotifyMailDaysBeforeClose != other.NotifyMailDaysBeforeClose)
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
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (RewardsShow.Length != 0)
		{
			num ^= RewardsShow.GetHashCode();
		}
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
		}
		if (NotifyMailDaysBeforeClose != 0)
		{
			num ^= NotifyMailDaysBeforeClose.GetHashCode();
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
		if (RewardsShow.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(RewardsShow);
		}
		if (DesText.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DesText);
		}
		if (NotifyMailDaysBeforeClose != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(NotifyMailDaysBeforeClose);
		}
		if (BGM.Length != 0)
		{
			output.WriteRawTag(58);
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
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (RewardsShow.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardsShow);
		}
		if (DesText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (NotifyMailDaysBeforeClose != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NotifyMailDaysBeforeClose);
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
	public void MergeFrom(CookieControl other)
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
			if (other.RewardsShow.Length != 0)
			{
				RewardsShow = other.RewardsShow;
			}
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
			}
			if (other.NotifyMailDaysBeforeClose != 0)
			{
				NotifyMailDaysBeforeClose = other.NotifyMailDaysBeforeClose;
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
			case 18u:
				UIAssets = input.ReadString();
				break;
			case 26u:
				CtrlName = input.ReadString();
				break;
			case 34u:
				RewardsShow = input.ReadString();
				break;
			case 42u:
				DesText = input.ReadString();
				break;
			case 48u:
				NotifyMailDaysBeforeClose = input.ReadInt32();
				break;
			case 58u:
				BGM = input.ReadString();
				break;
			}
		}
	}
}
