using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

public sealed class ProtoMapdata : IMessage<ProtoMapdata>, IMessage, IEquatable<ProtoMapdata>, IDeepCloneable<ProtoMapdata>
{
	private static readonly MessageParser<ProtoMapdata> _parser = new MessageParser<ProtoMapdata>(() => new ProtoMapdata());

	public const int MapdataNameFieldNumber = 1;

	private string mapdataName_ = "";

	public const int EntityDatasFieldNumber = 2;

	private static readonly FieldCodec<ProtoEntityData> _repeated_entityDatas_codec = FieldCodec.ForMessage(18u, ProtoEntityData.Parser);

	private readonly RepeatedField<ProtoEntityData> entityDatas_ = new RepeatedField<ProtoEntityData>();

	[DebuggerNonUserCode]
	public static MessageParser<ProtoMapdata> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[12];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string MapdataName
	{
		get
		{
			return mapdataName_;
		}
		set
		{
			mapdataName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<ProtoEntityData> EntityDatas => entityDatas_;

	[DebuggerNonUserCode]
	public ProtoMapdata()
	{
	}

	[DebuggerNonUserCode]
	public ProtoMapdata(ProtoMapdata other)
		: this()
	{
		mapdataName_ = other.mapdataName_;
		entityDatas_ = other.entityDatas_.Clone();
	}

	[DebuggerNonUserCode]
	public ProtoMapdata Clone()
	{
		return new ProtoMapdata(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoMapdata);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoMapdata other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MapdataName != other.MapdataName)
		{
			return false;
		}
		if (!entityDatas_.Equals(other.entityDatas_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (MapdataName.Length != 0)
		{
			num ^= MapdataName.GetHashCode();
		}
		return num ^ entityDatas_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (MapdataName.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(MapdataName);
		}
		entityDatas_.WriteTo(output, _repeated_entityDatas_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (MapdataName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MapdataName);
		}
		return num + entityDatas_.CalculateSize(_repeated_entityDatas_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ProtoMapdata other)
	{
		if (other != null)
		{
			if (other.MapdataName.Length != 0)
			{
				MapdataName = other.MapdataName;
			}
			entityDatas_.Add(other.entityDatas_);
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
				input.SkipLastField();
				break;
			case 10u:
				MapdataName = input.ReadString();
				break;
			case 18u:
				entityDatas_.AddEntriesFrom(input, _repeated_entityDatas_codec);
				break;
			}
		}
	}
}
