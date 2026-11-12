using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseControl : IMessage<TowerDefenseControl>, IMessage, IEquatable<TowerDefenseControl>, IDeepCloneable<TowerDefenseControl>
{
	private static readonly MessageParser<TowerDefenseControl> _parser = new MessageParser<TowerDefenseControl>(() => new TowerDefenseControl());

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

	public const int BGMFieldNumber = 6;

	private string bGM_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(952);

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
	public TowerDefenseControl()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseControl(TowerDefenseControl other)
		: this()
	{
		id_ = other.id_;
		uIAssets_ = other.uIAssets_;
		ctrlName_ = other.ctrlName_;
		rewardsShow_ = other.rewardsShow_;
		desText_ = other.desText_;
		bGM_ = other.bGM_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseControl Clone()
	{
		return new TowerDefenseControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseControl other)
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
		if (BGM.Length != 0)
		{
			output.WriteRawTag(50);
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
	public void MergeFrom(TowerDefenseControl other)
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
			case 50u:
				BGM = input.ReadString();
				break;
			}
		}
	}
}
