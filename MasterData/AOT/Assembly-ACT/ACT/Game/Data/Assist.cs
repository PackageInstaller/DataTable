using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using ACT.Core;
using ACT.MultiPlayer;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Assist : IMessage<Assist>, IMessage, IEquatable<Assist>, IDeepCloneable<Assist>, IBufferMessage, IMargeFrom<Assist>, ICharacterSource
{
	private static readonly MessageParser<Assist> _parser = new MessageParser<Assist>(() => new Assist());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SkinsFieldNumber = 2;

	private static readonly MapField<int, AssistSkin>.Codec _map_skins_codec = new MapField<int, AssistSkin>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, AssistSkin.Parser), 18u);

	private readonly MapField<int, AssistSkin> skins_ = new MapField<int, AssistSkin>();

	public const int SkinFieldNumber = 3;

	private int skin_;

	public uint ecsId;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Assist> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[82];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public MapField<int, AssistSkin> Skins => skins_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Skin
	{
		get
		{
			return skin_;
		}
		set
		{
			skin_ = value;
		}
	}

	public bool IsTrailCharacter { get; }

	public bool IsSnapshotCharacter { get; }

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Assist()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Assist(Assist other)
		: this()
	{
		id_ = other.id_;
		skins_ = other.skins_.Clone();
		skin_ = other.skin_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Assist Clone()
	{
		return new Assist(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Assist);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Assist other)
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
		if (!Skins.Equals(other.Skins))
		{
			return false;
		}
		if (Skin != other.Skin)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		num ^= Skins.GetHashCode();
		if (Skin != 0)
		{
			num ^= Skin.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		skins_.WriteTo(ref output, _map_skins_codec);
		if (Skin != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Skin);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		num += skins_.CalculateSize(_map_skins_codec);
		if (Skin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Skin);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Assist other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			skins_.Add(other.skins_);
			if (other.Skin != 0)
			{
				Skin = other.Skin;
			}
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
				Id = input.ReadInt32();
				break;
			case 18u:
				skins_.AddEntriesFrom(ref input, _map_skins_codec);
				break;
			case 24u:
				Skin = input.ReadInt32();
				break;
			}
		}
	}

	public void Refresh()
	{
	}

	public int GetId()
	{
		return id_;
	}

	public void MargeFrom(Assist other)
	{
		if (this != other && other != null)
		{
			skins_.MargeFrom(other.skins_);
			skin_ = other.skin_;
		}
	}

	public bool isContain(int skinId)
	{
		return skins_.ContainsKey(skinId);
	}

	public AssistSkin GetAssistSkin(int assistSkinId)
	{
		return skins_[assistSkinId];
	}

	public int GetEquipId(int index)
	{
		throw new NotImplementedException();
	}

	public byte GetSkillGroupEventualLevel(int groupId)
	{
		throw new NotImplementedException();
	}

	public int ColorId()
	{
		return skins_[skin_].Color;
	}

	public byte GetSkillGroupEventualLevel(int groupId, List<int> addSources)
	{
		throw new NotImplementedException();
	}

	public int GetCharacterSkinId()
	{
		return skin_;
	}

	public void SetSkin(int skinId, int colorId)
	{
		skin_ = skinId;
		skins_[skin_].Color = colorId;
	}

	public void BindEcsId(uint ecsId)
	{
		this.ecsId = ecsId;
	}

	public int Stage()
	{
		throw new NotImplementedException();
	}

	public CharacterIdentify GetCharacterIndentify()
	{
		throw new NotImplementedException();
	}

	public uint EcsId()
	{
		return ecsId;
	}

	CharacterUID ICharacterSource.GetUID()
	{
		return new CharacterUID(id_, IsTrailCharacter);
	}

	int ICharacterSource.Id()
	{
		return id_;
	}

	public MPSkill GetUpgradeSkill(int index)
	{
		throw new NotImplementedException();
	}

	public int Level()
	{
		throw new NotImplementedException();
	}

	public MPChip GetChip(int index)
	{
		throw new NotImplementedException();
	}

	public Equip GetEquip(int index)
	{
		throw new NotImplementedException();
	}

	public Gem GetGem(int index)
	{
		throw new NotImplementedException();
	}

	public void GetConstellationStates(List<int> states)
	{
		throw new NotImplementedException();
	}

	public byte GetSkillGroupLevel(int groupId)
	{
		throw new NotImplementedException();
	}
}
