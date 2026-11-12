using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyObstacle : IMessage<GoldenSpyObstacle>, IMessage, IEquatable<GoldenSpyObstacle>, IDeepCloneable<GoldenSpyObstacle>
{
	private static readonly MessageParser<GoldenSpyObstacle> _parser = new MessageParser<GoldenSpyObstacle>(() => new GoldenSpyObstacle());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GoldenSpyObstacle_FieldNumber = 2;

	private int goldenSpyObstacle_;

	public const int ParamsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_params_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> params_ = new RepeatedField<int>();

	public const int PrefabNameFieldNumber = 4;

	private string prefabName_ = "";

	public const int LuaCtrlFieldNumber = 5;

	private string luaCtrl_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyObstacle> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(406);

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
	public int GoldenSpyObstacle_
	{
		get
		{
			return goldenSpyObstacle_;
		}
		set
		{
			goldenSpyObstacle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Params => params_;

	[DebuggerNonUserCode]
	public string PrefabName
	{
		get
		{
			return prefabName_;
		}
		set
		{
			prefabName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LuaCtrl
	{
		get
		{
			return luaCtrl_;
		}
		set
		{
			luaCtrl_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public GoldenSpyObstacle()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyObstacle(GoldenSpyObstacle other)
		: this()
	{
		id_ = other.id_;
		goldenSpyObstacle_ = other.goldenSpyObstacle_;
		params_ = other.params_.Clone();
		prefabName_ = other.prefabName_;
		luaCtrl_ = other.luaCtrl_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyObstacle Clone()
	{
		return new GoldenSpyObstacle(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyObstacle);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyObstacle other)
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
		if (GoldenSpyObstacle_ != other.GoldenSpyObstacle_)
		{
			return false;
		}
		if (!params_.Equals(other.params_))
		{
			return false;
		}
		if (PrefabName != other.PrefabName)
		{
			return false;
		}
		if (LuaCtrl != other.LuaCtrl)
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
		if (GoldenSpyObstacle_ != 0)
		{
			num ^= GoldenSpyObstacle_.GetHashCode();
		}
		num ^= params_.GetHashCode();
		if (PrefabName.Length != 0)
		{
			num ^= PrefabName.GetHashCode();
		}
		if (LuaCtrl.Length != 0)
		{
			num ^= LuaCtrl.GetHashCode();
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
		if (GoldenSpyObstacle_ != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GoldenSpyObstacle_);
		}
		params_.WriteTo(output, _repeated_params_codec);
		if (PrefabName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(PrefabName);
		}
		if (LuaCtrl.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(LuaCtrl);
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
		if (GoldenSpyObstacle_ != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GoldenSpyObstacle_);
		}
		num += params_.CalculateSize(_repeated_params_codec);
		if (PrefabName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PrefabName);
		}
		if (LuaCtrl.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LuaCtrl);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpyObstacle other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GoldenSpyObstacle_ != 0)
			{
				GoldenSpyObstacle_ = other.GoldenSpyObstacle_;
			}
			params_.Add(other.params_);
			if (other.PrefabName.Length != 0)
			{
				PrefabName = other.PrefabName;
			}
			if (other.LuaCtrl.Length != 0)
			{
				LuaCtrl = other.LuaCtrl;
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
				GoldenSpyObstacle_ = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				params_.AddEntriesFrom(input, _repeated_params_codec);
				break;
			case 34u:
				PrefabName = input.ReadString();
				break;
			case 42u:
				LuaCtrl = input.ReadString();
				break;
			}
		}
	}
}
