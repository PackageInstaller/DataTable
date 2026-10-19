using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaPoolDataNtf : IMessage<GachaPoolDataNtf>, IMessage, IEquatable<GachaPoolDataNtf>, IDeepCloneable<GachaPoolDataNtf>, IBufferMessage
{
	private static readonly MessageParser<GachaPoolDataNtf> _parser = new MessageParser<GachaPoolDataNtf>(() => new GachaPoolDataNtf());

	private UnknownFieldSet _unknownFields;

	public const int PoolShareDataFieldNumber = 1;

	private GachaPoolShareData poolShareData_;

	public const int PoolUniqueDataFieldNumber = 2;

	private static readonly MapField<int, GachaPoolUniqueData>.Codec _map_poolUniqueData_codec = new MapField<int, GachaPoolUniqueData>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, GachaPoolUniqueData.Parser), 18u);

	private readonly MapField<int, GachaPoolUniqueData> poolUniqueData_ = new MapField<int, GachaPoolUniqueData>();

	public const int OpenPoolIdsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_openPoolIds_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> openPoolIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaPoolDataNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[18];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareData PoolShareData
	{
		get
		{
			return poolShareData_;
		}
		set
		{
			poolShareData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, GachaPoolUniqueData> PoolUniqueData => poolUniqueData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> OpenPoolIds => openPoolIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolDataNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolDataNtf(GachaPoolDataNtf other)
		: this()
	{
		poolShareData_ = ((other.poolShareData_ != null) ? other.poolShareData_.Clone() : null);
		poolUniqueData_ = other.poolUniqueData_.Clone();
		openPoolIds_ = other.openPoolIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolDataNtf Clone()
	{
		return new GachaPoolDataNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPoolDataNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaPoolDataNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(PoolShareData, other.PoolShareData))
		{
			return false;
		}
		if (!PoolUniqueData.Equals(other.PoolUniqueData))
		{
			return false;
		}
		if (!openPoolIds_.Equals(other.openPoolIds_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (poolShareData_ != null)
		{
			num ^= PoolShareData.GetHashCode();
		}
		num ^= PoolUniqueData.GetHashCode();
		num ^= openPoolIds_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (poolShareData_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(PoolShareData);
		}
		poolUniqueData_.WriteTo(ref output, _map_poolUniqueData_codec);
		openPoolIds_.WriteTo(ref output, _repeated_openPoolIds_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (poolShareData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(PoolShareData);
		}
		num += poolUniqueData_.CalculateSize(_map_poolUniqueData_codec);
		num += openPoolIds_.CalculateSize(_repeated_openPoolIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaPoolDataNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.poolShareData_ != null)
		{
			if (poolShareData_ == null)
			{
				PoolShareData = new GachaPoolShareData();
			}
			PoolShareData.MergeFrom(other.PoolShareData);
		}
		poolUniqueData_.Add(other.poolUniqueData_);
		openPoolIds_.Add(other.openPoolIds_);
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 10u:
				if (poolShareData_ == null)
				{
					PoolShareData = new GachaPoolShareData();
				}
				input.ReadMessage(PoolShareData);
				break;
			case 18u:
				poolUniqueData_.AddEntriesFrom(ref input, _map_poolUniqueData_codec);
				break;
			case 24u:
			case 26u:
				openPoolIds_.AddEntriesFrom(ref input, _repeated_openPoolIds_codec);
				break;
			}
		}
	}
}
