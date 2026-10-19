using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TempArchiveManagement : IMessage<TempArchiveManagement>, IMessage, IEquatable<TempArchiveManagement>, IDeepCloneable<TempArchiveManagement>, IBufferMessage
{
	private static readonly MessageParser<TempArchiveManagement> _parser = new MessageParser<TempArchiveManagement>(() => new TempArchiveManagement());

	private UnknownFieldSet _unknownFields;

	public const int EnabledFieldNumber = 1;

	private bool enabled_;

	public const int BackupDataFieldNumber = 2;

	private static readonly FieldCodec<TempArchiveBackupData> _repeated_backupData_codec = FieldCodec.ForMessage(18u, TempArchiveBackupData.Parser);

	private readonly RepeatedField<TempArchiveBackupData> backupData_ = new RepeatedField<TempArchiveBackupData>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempArchiveManagement> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[180];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Enabled
	{
		get
		{
			return enabled_;
		}
		set
		{
			enabled_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<TempArchiveBackupData> BackupData => backupData_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveManagement()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveManagement(TempArchiveManagement other)
		: this()
	{
		enabled_ = other.enabled_;
		backupData_ = other.backupData_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveManagement Clone()
	{
		return new TempArchiveManagement(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempArchiveManagement);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempArchiveManagement other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Enabled != other.Enabled)
		{
			return false;
		}
		if (!backupData_.Equals(other.backupData_))
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
		if (Enabled)
		{
			num ^= Enabled.GetHashCode();
		}
		num ^= backupData_.GetHashCode();
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
		if (Enabled)
		{
			output.WriteRawTag(8);
			output.WriteBool(Enabled);
		}
		backupData_.WriteTo(ref output, _repeated_backupData_codec);
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
		if (Enabled)
		{
			num += 2;
		}
		num += backupData_.CalculateSize(_repeated_backupData_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempArchiveManagement other)
	{
		if (other != null)
		{
			if (other.Enabled)
			{
				Enabled = other.Enabled;
			}
			backupData_.Add(other.backupData_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
			case 8u:
				Enabled = input.ReadBool();
				break;
			case 18u:
				backupData_.AddEntriesFrom(ref input, _repeated_backupData_codec);
				break;
			}
		}
	}
}
