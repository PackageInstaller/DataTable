using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerScenePrefab : IMessage<StarTowerScenePrefab>, IMessage, IEquatable<StarTowerScenePrefab>, IDeepCloneable<StarTowerScenePrefab>
{
	private static readonly MessageParser<StarTowerScenePrefab> _parser = new MessageParser<StarTowerScenePrefab>(() => new StarTowerScenePrefab());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ConfigResFieldNumber = 2;

	private string configRes_ = "";

	public const int BianQuanFieldNumber = 3;

	private string bianQuan_ = "";

	public const int GameplayTypesFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_gameplayTypes_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> gameplayTypes_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerScenePrefab> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(872);

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
	public string ConfigRes
	{
		get
		{
			return configRes_;
		}
		set
		{
			configRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BianQuan
	{
		get
		{
			return bianQuan_;
		}
		set
		{
			bianQuan_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> GameplayTypes => gameplayTypes_;

	[DebuggerNonUserCode]
	public StarTowerScenePrefab()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerScenePrefab(StarTowerScenePrefab other)
		: this()
	{
		id_ = other.id_;
		configRes_ = other.configRes_;
		bianQuan_ = other.bianQuan_;
		gameplayTypes_ = other.gameplayTypes_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerScenePrefab Clone()
	{
		return new StarTowerScenePrefab(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerScenePrefab);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerScenePrefab other)
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
		if (ConfigRes != other.ConfigRes)
		{
			return false;
		}
		if (BianQuan != other.BianQuan)
		{
			return false;
		}
		if (!gameplayTypes_.Equals(other.gameplayTypes_))
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
		if (ConfigRes.Length != 0)
		{
			num ^= ConfigRes.GetHashCode();
		}
		if (BianQuan.Length != 0)
		{
			num ^= BianQuan.GetHashCode();
		}
		num ^= gameplayTypes_.GetHashCode();
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
		if (ConfigRes.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ConfigRes);
		}
		if (BianQuan.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BianQuan);
		}
		gameplayTypes_.WriteTo(output, _repeated_gameplayTypes_codec);
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
		if (ConfigRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConfigRes);
		}
		if (BianQuan.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BianQuan);
		}
		num += gameplayTypes_.CalculateSize(_repeated_gameplayTypes_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerScenePrefab other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ConfigRes.Length != 0)
			{
				ConfigRes = other.ConfigRes;
			}
			if (other.BianQuan.Length != 0)
			{
				BianQuan = other.BianQuan;
			}
			gameplayTypes_.Add(other.gameplayTypes_);
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
				ConfigRes = input.ReadString();
				break;
			case 26u:
				BianQuan = input.ReadString();
				break;
			case 32u:
			case 34u:
				gameplayTypes_.AddEntriesFrom(input, _repeated_gameplayTypes_codec);
				break;
			}
		}
	}
}
