using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterSkinPanelFace : IMessage<CharacterSkinPanelFace>, IMessage, IEquatable<CharacterSkinPanelFace>, IDeepCloneable<CharacterSkinPanelFace>
{
	private static readonly MessageParser<CharacterSkinPanelFace> _parser = new MessageParser<CharacterSkinPanelFace>(() => new CharacterSkinPanelFace());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MainViewFieldNumber = 2;

	private string mainView_ = "";

	public const int CharInfoFieldNumber = 3;

	private string charInfo_ = "";

	public const int BattelWinFieldNumber = 4;

	private string battelWin_ = "";

	public const int BattleLoseFieldNumber = 5;

	private string battleLose_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharacterSkinPanelFace> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(172);

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
	public string MainView
	{
		get
		{
			return mainView_;
		}
		set
		{
			mainView_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CharInfo
	{
		get
		{
			return charInfo_;
		}
		set
		{
			charInfo_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattelWin
	{
		get
		{
			return battelWin_;
		}
		set
		{
			battelWin_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BattleLose
	{
		get
		{
			return battleLose_;
		}
		set
		{
			battleLose_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CharacterSkinPanelFace()
	{
	}

	[DebuggerNonUserCode]
	public CharacterSkinPanelFace(CharacterSkinPanelFace other)
		: this()
	{
		id_ = other.id_;
		mainView_ = other.mainView_;
		charInfo_ = other.charInfo_;
		battelWin_ = other.battelWin_;
		battleLose_ = other.battleLose_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterSkinPanelFace Clone()
	{
		return new CharacterSkinPanelFace(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterSkinPanelFace);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterSkinPanelFace other)
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
		if (MainView != other.MainView)
		{
			return false;
		}
		if (CharInfo != other.CharInfo)
		{
			return false;
		}
		if (BattelWin != other.BattelWin)
		{
			return false;
		}
		if (BattleLose != other.BattleLose)
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
		if (MainView.Length != 0)
		{
			num ^= MainView.GetHashCode();
		}
		if (CharInfo.Length != 0)
		{
			num ^= CharInfo.GetHashCode();
		}
		if (BattelWin.Length != 0)
		{
			num ^= BattelWin.GetHashCode();
		}
		if (BattleLose.Length != 0)
		{
			num ^= BattleLose.GetHashCode();
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
		if (MainView.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(MainView);
		}
		if (CharInfo.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CharInfo);
		}
		if (BattelWin.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(BattelWin);
		}
		if (BattleLose.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(BattleLose);
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
		if (MainView.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MainView);
		}
		if (CharInfo.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharInfo);
		}
		if (BattelWin.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattelWin);
		}
		if (BattleLose.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BattleLose);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterSkinPanelFace other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MainView.Length != 0)
			{
				MainView = other.MainView;
			}
			if (other.CharInfo.Length != 0)
			{
				CharInfo = other.CharInfo;
			}
			if (other.BattelWin.Length != 0)
			{
				BattelWin = other.BattelWin;
			}
			if (other.BattleLose.Length != 0)
			{
				BattleLose = other.BattleLose;
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
				MainView = input.ReadString();
				break;
			case 26u:
				CharInfo = input.ReadString();
				break;
			case 34u:
				BattelWin = input.ReadString();
				break;
			case 42u:
				BattleLose = input.ReadString();
				break;
			}
		}
	}
}
