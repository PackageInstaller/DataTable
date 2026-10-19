using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TempArchiveBackupData : IMessage<TempArchiveBackupData>, IMessage, IEquatable<TempArchiveBackupData>, IDeepCloneable<TempArchiveBackupData>, IBufferMessage
{
	private static readonly MessageParser<TempArchiveBackupData> _parser = new MessageParser<TempArchiveBackupData>(() => new TempArchiveBackupData());

	private UnknownFieldSet _unknownFields;

	public const int PositionFieldNumber = 1;

	private PBVector3 position_;

	public const int PotionSetFieldNumber = 2;

	private static readonly MapField<int, PotionItem>.Codec _map_potionSet_codec = new MapField<int, PotionItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, PotionItem.Parser), 18u);

	private readonly MapField<int, PotionItem> potionSet_ = new MapField<int, PotionItem>();

	public const int CharacterStatusSetFieldNumber = 3;

	private static readonly MapField<int, CharacterStatus>.Codec _map_characterStatusSet_codec = new MapField<int, CharacterStatus>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, CharacterStatus.Parser), 26u);

	private readonly MapField<int, CharacterStatus> characterStatusSet_ = new MapField<int, CharacterStatus>();

	public const int SceneResourcesFieldNumber = 4;

	private static readonly FieldCodec<SceneResource> _repeated_sceneResources_codec = FieldCodec.ForMessage(34u, SceneResource.Parser);

	private readonly RepeatedField<SceneResource> sceneResources_ = new RepeatedField<SceneResource>();

	public const int ChunkIDFieldNumber = 5;

	private int chunkID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempArchiveBackupData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[179];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public PBVector3 Position
	{
		get
		{
			return position_;
		}
		set
		{
			position_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, PotionItem> PotionSet => potionSet_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, CharacterStatus> CharacterStatusSet => characterStatusSet_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<SceneResource> SceneResources => sceneResources_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChunkID
	{
		get
		{
			return chunkID_;
		}
		set
		{
			chunkID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveBackupData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveBackupData(TempArchiveBackupData other)
		: this()
	{
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		potionSet_ = other.potionSet_.Clone();
		characterStatusSet_ = other.characterStatusSet_.Clone();
		sceneResources_ = other.sceneResources_.Clone();
		chunkID_ = other.chunkID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempArchiveBackupData Clone()
	{
		return new TempArchiveBackupData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempArchiveBackupData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempArchiveBackupData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Position, other.Position))
		{
			return false;
		}
		if (!PotionSet.Equals(other.PotionSet))
		{
			return false;
		}
		if (!CharacterStatusSet.Equals(other.CharacterStatusSet))
		{
			return false;
		}
		if (!sceneResources_.Equals(other.sceneResources_))
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
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
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
		}
		num ^= PotionSet.GetHashCode();
		num ^= CharacterStatusSet.GetHashCode();
		num ^= sceneResources_.GetHashCode();
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
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
		if (position_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Position);
		}
		potionSet_.WriteTo(ref output, _map_potionSet_codec);
		characterStatusSet_.WriteTo(ref output, _map_characterStatusSet_codec);
		sceneResources_.WriteTo(ref output, _repeated_sceneResources_codec);
		if (ChunkID != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ChunkID);
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
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		num += potionSet_.CalculateSize(_map_potionSet_codec);
		num += characterStatusSet_.CalculateSize(_map_characterStatusSet_codec);
		num += sceneResources_.CalculateSize(_repeated_sceneResources_codec);
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempArchiveBackupData other)
	{
		if (other == null)
		{
			return;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector3();
			}
			Position.MergeFrom(other.Position);
		}
		potionSet_.Add(other.potionSet_);
		characterStatusSet_.Add(other.characterStatusSet_);
		sceneResources_.Add(other.sceneResources_);
		if (other.ChunkID != 0)
		{
			ChunkID = other.ChunkID;
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
				if (position_ == null)
				{
					Position = new PBVector3();
				}
				input.ReadMessage(Position);
				break;
			case 18u:
				potionSet_.AddEntriesFrom(ref input, _map_potionSet_codec);
				break;
			case 26u:
				characterStatusSet_.AddEntriesFrom(ref input, _map_characterStatusSet_codec);
				break;
			case 34u:
				sceneResources_.AddEntriesFrom(ref input, _repeated_sceneResources_codec);
				break;
			case 40u:
				ChunkID = input.ReadInt32();
				break;
			}
		}
	}
}
