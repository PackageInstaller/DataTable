using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaPoolShareDataChangeNtf : IMessage<GachaPoolShareDataChangeNtf>, IMessage, IEquatable<GachaPoolShareDataChangeNtf>, IDeepCloneable<GachaPoolShareDataChangeNtf>, IBufferMessage
{
	private static readonly MessageParser<GachaPoolShareDataChangeNtf> _parser = new MessageParser<GachaPoolShareDataChangeNtf>(() => new GachaPoolShareDataChangeNtf());

	private UnknownFieldSet _unknownFields;

	public const int ChangeDataFieldNumber = 1;

	private GachaPoolShareData changeData_;

	public const int PoolUniqueFieldNumber = 2;

	private GachaPoolUniqueData poolUnique_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaPoolShareDataChangeNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareData ChangeData
	{
		get
		{
			return changeData_;
		}
		set
		{
			changeData_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolUniqueData PoolUnique
	{
		get
		{
			return poolUnique_;
		}
		set
		{
			poolUnique_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareDataChangeNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareDataChangeNtf(GachaPoolShareDataChangeNtf other)
		: this()
	{
		changeData_ = ((other.changeData_ != null) ? other.changeData_.Clone() : null);
		poolUnique_ = ((other.poolUnique_ != null) ? other.poolUnique_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolShareDataChangeNtf Clone()
	{
		return new GachaPoolShareDataChangeNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPoolShareDataChangeNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaPoolShareDataChangeNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(ChangeData, other.ChangeData))
		{
			return false;
		}
		if (!object.Equals(PoolUnique, other.PoolUnique))
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
		if (changeData_ != null)
		{
			num ^= ChangeData.GetHashCode();
		}
		if (poolUnique_ != null)
		{
			num ^= PoolUnique.GetHashCode();
		}
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
		if (changeData_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(ChangeData);
		}
		if (poolUnique_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(PoolUnique);
		}
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
		if (changeData_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ChangeData);
		}
		if (poolUnique_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(PoolUnique);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaPoolShareDataChangeNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.changeData_ != null)
		{
			if (changeData_ == null)
			{
				ChangeData = new GachaPoolShareData();
			}
			ChangeData.MergeFrom(other.ChangeData);
		}
		if (other.poolUnique_ != null)
		{
			if (poolUnique_ == null)
			{
				PoolUnique = new GachaPoolUniqueData();
			}
			PoolUnique.MergeFrom(other.PoolUnique);
		}
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
				if (changeData_ == null)
				{
					ChangeData = new GachaPoolShareData();
				}
				input.ReadMessage(ChangeData);
				break;
			case 18u:
				if (poolUnique_ == null)
				{
					PoolUnique = new GachaPoolUniqueData();
				}
				input.ReadMessage(PoolUnique);
				break;
			}
		}
	}
}
