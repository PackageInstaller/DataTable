using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ClientModuleComponentStateNtf : IMessage<ClientModuleComponentStateNtf>, IMessage, IEquatable<ClientModuleComponentStateNtf>, IDeepCloneable<ClientModuleComponentStateNtf>, IBufferMessage
{
	private static readonly MessageParser<ClientModuleComponentStateNtf> _parser = new MessageParser<ClientModuleComponentStateNtf>(() => new ClientModuleComponentStateNtf());

	private UnknownFieldSet _unknownFields;

	public const int ComponentsFieldNumber = 1;

	private static readonly MapField<int, ClientComponentState>.Codec _map_components_codec = new MapField<int, ClientComponentState>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ClientComponentState.Parser), 10u);

	private readonly MapField<int, ClientComponentState> components_ = new MapField<int, ClientComponentState>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ClientModuleComponentStateNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[138];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ClientComponentState> Components => components_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ClientModuleComponentStateNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ClientModuleComponentStateNtf(ClientModuleComponentStateNtf other)
		: this()
	{
		components_ = other.components_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ClientModuleComponentStateNtf Clone()
	{
		return new ClientModuleComponentStateNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ClientModuleComponentStateNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ClientModuleComponentStateNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Components.Equals(other.Components))
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
		num ^= Components.GetHashCode();
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
		components_.WriteTo(ref output, _map_components_codec);
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
		num += components_.CalculateSize(_map_components_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ClientModuleComponentStateNtf other)
	{
		if (other != null)
		{
			components_.Add(other.components_);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				components_.AddEntriesFrom(ref input, _map_components_codec);
			}
		}
	}
}
