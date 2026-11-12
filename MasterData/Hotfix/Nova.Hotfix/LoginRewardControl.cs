using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class LoginRewardControl : IMessage<LoginRewardControl>, IMessage, IEquatable<LoginRewardControl>, IDeepCloneable<LoginRewardControl>
{
	private static readonly MessageParser<LoginRewardControl> _parser = new MessageParser<LoginRewardControl>(() => new LoginRewardControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RewardsGroupFieldNumber = 2;

	private int rewardsGroup_;

	public const int DesTextFieldNumber = 3;

	private string desText_ = "";

	public const int UIAssetsFieldNumber = 4;

	private string uIAssets_ = "";

	public const int CtrlNameFieldNumber = 5;

	private string ctrlName_ = "";

	public const int PopUpUIAssetsFieldNumber = 6;

	private string popUpUIAssets_ = "";

	public const int IsMoveFieldNumber = 7;

	private bool isMove_;

	[DebuggerNonUserCode]
	public static MessageParser<LoginRewardControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(498);

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
	public int RewardsGroup
	{
		get
		{
			return rewardsGroup_;
		}
		set
		{
			rewardsGroup_ = value;
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
	public string PopUpUIAssets
	{
		get
		{
			return popUpUIAssets_;
		}
		set
		{
			popUpUIAssets_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsMove
	{
		get
		{
			return isMove_;
		}
		set
		{
			isMove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public LoginRewardControl()
	{
	}

	[DebuggerNonUserCode]
	public LoginRewardControl(LoginRewardControl other)
		: this()
	{
		id_ = other.id_;
		rewardsGroup_ = other.rewardsGroup_;
		desText_ = other.desText_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		popUpUIAssets_ = other.popUpUIAssets_;
		isMove_ = other.isMove_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public LoginRewardControl Clone()
	{
		return new LoginRewardControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LoginRewardControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(LoginRewardControl other)
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
		if (RewardsGroup != other.RewardsGroup)
		{
			return false;
		}
		if (DesText != other.DesText)
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
		if (PopUpUIAssets != other.PopUpUIAssets)
		{
			return false;
		}
		if (IsMove != other.IsMove)
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
		if (RewardsGroup != 0)
		{
			num ^= RewardsGroup.GetHashCode();
		}
		if (DesText.Length != 0)
		{
			num ^= DesText.GetHashCode();
		}
		if (UIAssets.Length != 0)
		{
			num ^= UIAssets.GetHashCode();
		}
		if (CtrlName.Length != 0)
		{
			num ^= CtrlName.GetHashCode();
		}
		if (PopUpUIAssets.Length != 0)
		{
			num ^= PopUpUIAssets.GetHashCode();
		}
		if (IsMove)
		{
			num ^= IsMove.GetHashCode();
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
		if (RewardsGroup != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RewardsGroup);
		}
		if (DesText.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(DesText);
		}
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
		if (PopUpUIAssets.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(PopUpUIAssets);
		}
		if (IsMove)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsMove);
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
		if (RewardsGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardsGroup);
		}
		if (DesText.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DesText);
		}
		if (UIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UIAssets);
		}
		if (CtrlName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CtrlName);
		}
		if (PopUpUIAssets.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PopUpUIAssets);
		}
		if (IsMove)
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
	public void MergeFrom(LoginRewardControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RewardsGroup != 0)
			{
				RewardsGroup = other.RewardsGroup;
			}
			if (other.DesText.Length != 0)
			{
				DesText = other.DesText;
			}
			if (other.UIAssets.Length != 0)
			{
				UIAssets = other.UIAssets;
			}
			if (other.CtrlName.Length != 0)
			{
				CtrlName = other.CtrlName;
			}
			if (other.PopUpUIAssets.Length != 0)
			{
				PopUpUIAssets = other.PopUpUIAssets;
			}
			if (other.IsMove)
			{
				IsMove = other.IsMove;
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
				RewardsGroup = input.ReadInt32();
				break;
			case 26u:
				DesText = input.ReadString();
				break;
			case 34u:
				UIAssets = input.ReadString();
				break;
			case 42u:
				CtrlName = input.ReadString();
				break;
			case 50u:
				PopUpUIAssets = input.ReadString();
				break;
			case 56u:
				IsMove = input.ReadBool();
				break;
			}
		}
	}
}
