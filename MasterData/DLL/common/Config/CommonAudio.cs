using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CommonAudio : IMessage<CommonAudio>, IMessage, IEquatable<CommonAudio>, IDeepCloneable<CommonAudio>
{
	private static readonly MessageParser<CommonAudio> _parser = new MessageParser<CommonAudio>(() => new CommonAudio());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int CueSheetFieldNumber = 2;

	private string cueSheet_ = "";

	public const int CueNameFieldNumber = 3;

	private string cueName_ = "";

	public const int UseStreamFieldNumber = 4;

	private bool useStream_;

	[DebuggerNonUserCode]
	public static MessageParser<CommonAudio> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CueSheet
	{
		get
		{
			return cueSheet_;
		}
		set
		{
			cueSheet_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CueName
	{
		get
		{
			return cueName_;
		}
		set
		{
			cueName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool UseStream
	{
		get
		{
			return useStream_;
		}
		set
		{
			useStream_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CommonAudio()
	{
	}

	[DebuggerNonUserCode]
	public CommonAudio(CommonAudio other)
		: this()
	{
		iD_ = other.iD_;
		cueSheet_ = other.cueSheet_;
		cueName_ = other.cueName_;
		useStream_ = other.useStream_;
	}

	[DebuggerNonUserCode]
	public CommonAudio Clone()
	{
		return new CommonAudio(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CommonAudio);
	}

	[DebuggerNonUserCode]
	public bool Equals(CommonAudio other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (CueSheet != other.CueSheet)
		{
			return false;
		}
		if (CueName != other.CueName)
		{
			return false;
		}
		if (UseStream != other.UseStream)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (CueSheet.Length != 0)
		{
			num ^= CueSheet.GetHashCode();
		}
		if (CueName.Length != 0)
		{
			num ^= CueName.GetHashCode();
		}
		if (UseStream)
		{
			num ^= UseStream.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (CueSheet.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(CueSheet);
		}
		if (CueName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CueName);
		}
		if (UseStream)
		{
			output.WriteRawTag(32);
			output.WriteBool(UseStream);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (CueSheet.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CueSheet);
		}
		if (CueName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CueName);
		}
		if (UseStream)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CommonAudio other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.CueSheet.Length != 0)
			{
				CueSheet = other.CueSheet;
			}
			if (other.CueName.Length != 0)
			{
				CueName = other.CueName;
			}
			if (other.UseStream)
			{
				UseStream = other.UseStream;
			}
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
			case 8u:
				ID = input.ReadInt32();
				break;
			case 18u:
				CueSheet = input.ReadString();
				break;
			case 26u:
				CueName = input.ReadString();
				break;
			case 32u:
				UseStream = input.ReadBool();
				break;
			}
		}
	}
}
