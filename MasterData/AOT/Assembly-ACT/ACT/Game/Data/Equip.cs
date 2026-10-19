using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.UI.DataProxy;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;
using UnityEngine;

namespace ACT.Game.Data;

public sealed class Equip : IMessage<Equip>, IMessage, IEquatable<Equip>, IDeepCloneable<Equip>, IBufferMessage, IMargeFrom<Equip>, IBagItem, IFeature, IItemChangeEvent
{
	private static readonly MessageParser<Equip> _parser = new MessageParser<Equip>(() => new Equip());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int IdFieldNumber = 2;

	private int id_;

	public const int IsLockFieldNumber = 3;

	private bool isLock_;

	public const int WearCharacterFieldNumber = 4;

	private int wearCharacter_;

	public const int TypeFieldNumber = 5;

	private EquipType type_;

	public const int QualityFieldNumber = 6;

	private int quality_;

	public const int LevelFieldNumber = 7;

	private int level_;

	public const int AttributesFieldNumber = 8;

	private static readonly FieldCodec<EquipAttr> _repeated_attributes_codec = FieldCodec.ForMessage(66u, EquipAttr.Parser);

	private readonly RepeatedField<EquipAttr> attributes_ = new RepeatedField<EquipAttr>();

	public const int FeaturesFieldNumber = 9;

	private static readonly FieldCodec<EquipFeature> _repeated_features_codec = FieldCodec.ForMessage(74u, EquipFeature.Parser);

	private readonly RepeatedField<EquipFeature> features_ = new RepeatedField<EquipFeature>();

	public const int GemSlotsFieldNumber = 10;

	private static readonly FieldCodec<GemSlot> _repeated_gemSlots_codec = FieldCodec.ForMessage(82u, GemSlot.Parser);

	private readonly RepeatedField<GemSlot> gemSlots_ = new RepeatedField<GemSlot>();

	public const int SourceFieldNumber = 11;

	private ItemsWays source_;

	internal Dictionary<int, List<FeatureData>> m_AllFeatures = new Dictionary<int, List<FeatureData>>();

	public CharacterDependSnapshot m_snapshot;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Equip> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[50];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

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
	public bool IsLock
	{
		get
		{
			return isLock_;
		}
		set
		{
			isLock_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WearCharacter
	{
		get
		{
			return wearCharacter_;
		}
		set
		{
			wearCharacter_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EquipType Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Quality
	{
		get
		{
			return quality_;
		}
		set
		{
			quality_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<EquipAttr> Attributes => attributes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<EquipFeature> Features => features_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<GemSlot> GemSlots => gemSlots_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemsWays Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = value;
		}
	}

	public PropertySource GetPropertySource => PropertySource.Equip;

	public CharacterDependSnapshot Snapshot => m_snapshot;

	public int AvailableSlotCount => Enumerable.Count(gemSlots_, (GemSlot x) => x.SlotLevel > 0);

	public static int MaxLevel => 20;

	public int TypeIndex { get; private set; }

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Equip()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Equip(Equip other)
		: this()
	{
		uid_ = other.uid_;
		id_ = other.id_;
		isLock_ = other.isLock_;
		wearCharacter_ = other.wearCharacter_;
		type_ = other.type_;
		quality_ = other.quality_;
		level_ = other.level_;
		attributes_ = other.attributes_.Clone();
		features_ = other.features_.Clone();
		gemSlots_ = other.gemSlots_.Clone();
		source_ = other.source_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Equip Clone()
	{
		return new Equip(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Equip);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Equip other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (IsLock != other.IsLock)
		{
			return false;
		}
		if (WearCharacter != other.WearCharacter)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Quality != other.Quality)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (!attributes_.Equals(other.attributes_))
		{
			return false;
		}
		if (!features_.Equals(other.features_))
		{
			return false;
		}
		if (!gemSlots_.Equals(other.gemSlots_))
		{
			return false;
		}
		if (Source != other.Source)
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
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (IsLock)
		{
			num ^= IsLock.GetHashCode();
		}
		if (WearCharacter != 0)
		{
			num ^= WearCharacter.GetHashCode();
		}
		if (Type != EquipType.Null)
		{
			num ^= Type.GetHashCode();
		}
		if (Quality != 0)
		{
			num ^= Quality.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		num ^= attributes_.GetHashCode();
		num ^= features_.GetHashCode();
		num ^= gemSlots_.GetHashCode();
		if (Source != ItemsWays.ItemswayEntergame)
		{
			num ^= Source.GetHashCode();
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
		if (Uid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Uid);
		}
		if (Id != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Id);
		}
		if (IsLock)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsLock);
		}
		if (WearCharacter != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(WearCharacter);
		}
		if (Type != EquipType.Null)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)Type);
		}
		if (Quality != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Quality);
		}
		if (Level != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Level);
		}
		attributes_.WriteTo(ref output, _repeated_attributes_codec);
		features_.WriteTo(ref output, _repeated_features_codec);
		gemSlots_.WriteTo(ref output, _repeated_gemSlots_codec);
		if (Source != ItemsWays.ItemswayEntergame)
		{
			output.WriteRawTag(88);
			output.WriteEnum((int)Source);
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
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (IsLock)
		{
			num += 2;
		}
		if (WearCharacter != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WearCharacter);
		}
		if (Type != EquipType.Null)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Type);
		}
		if (Quality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Quality);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		num += attributes_.CalculateSize(_repeated_attributes_codec);
		num += features_.CalculateSize(_repeated_features_codec);
		num += gemSlots_.CalculateSize(_repeated_gemSlots_codec);
		if (Source != ItemsWays.ItemswayEntergame)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Source);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Equip other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.IsLock)
			{
				IsLock = other.IsLock;
			}
			if (other.WearCharacter != 0)
			{
				WearCharacter = other.WearCharacter;
			}
			if (other.Type != EquipType.Null)
			{
				Type = other.Type;
			}
			if (other.Quality != 0)
			{
				Quality = other.Quality;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			attributes_.Add(other.attributes_);
			features_.Add(other.features_);
			gemSlots_.Add(other.gemSlots_);
			if (other.Source != ItemsWays.ItemswayEntergame)
			{
				Source = other.Source;
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
				Uid = input.ReadInt32();
				break;
			case 16u:
				Id = input.ReadInt32();
				break;
			case 24u:
				IsLock = input.ReadBool();
				break;
			case 32u:
				WearCharacter = input.ReadInt32();
				break;
			case 40u:
				Type = (EquipType)input.ReadEnum();
				break;
			case 48u:
				Quality = input.ReadInt32();
				break;
			case 56u:
				Level = input.ReadInt32();
				break;
			case 66u:
				attributes_.AddEntriesFrom(ref input, _repeated_attributes_codec);
				break;
			case 74u:
				features_.AddEntriesFrom(ref input, _repeated_features_codec);
				break;
			case 82u:
				gemSlots_.AddEntriesFrom(ref input, _repeated_gemSlots_codec);
				break;
			case 88u:
				Source = (ItemsWays)input.ReadEnum();
				break;
			}
		}
	}

	public void CalculateFeatureData()
	{
		try
		{
			foreach (KeyValuePair<int, List<FeatureData>> allFeature in m_AllFeatures)
			{
				allFeature.Value.Clear();
			}
			EquipStrengthenListData data = CoreUtils.GetData(CoreUtils.GetData(Id, RuntimeConfigs.data.equipDatas).strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
			foreach (ItemKv item in (level_ / 10) switch
			{
				0 => data.equipFeature0, 
				1 => data.equipFeature10, 
				2 => data.equipFeature20, 
				_ => throw new ArgumentOutOfRangeException(), 
			})
			{
				if (!m_AllFeatures.TryGetValue(item.id, out var value))
				{
					value = new List<FeatureData>();
					m_AllFeatures.TryAdd(item.id, value);
				}
				value.Clear();
				value.Add(new FeatureData
				{
					FeatureSource = FeatureData.FeatureSourceType.Equip,
					Data = item.count
				});
			}
			foreach (GemSlot item2 in gemSlots_)
			{
				if (item2.GemId == 0)
				{
					continue;
				}
				foreach (KeyValuePair<int, List<FeatureData>> allFeature2 in CharacterDependHelper.GetGemBySnapshot(item2.GemId, m_snapshot).m_AllFeatures)
				{
					if (!m_AllFeatures.TryGetValue(allFeature2.Key, out var value2))
					{
						value2 = new List<FeatureData>();
						m_AllFeatures.TryAdd(allFeature2.Key, value2);
					}
					value2.AddRange(allFeature2.Value);
				}
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"装备特性计算失败 {arg}");
			}
		}
	}

	public void SetSnapshot(CharacterDependSnapshot snapshotIndex)
	{
		m_snapshot = snapshotIndex;
	}

	public EquipMaterialData TarLevelData(int tarLevel)
	{
		return CoreUtils.GetData(CoreUtils.GetData(Id, RuntimeConfigs.data.equipDatas).GetLevelMaterialId(tarLevel), RuntimeConfigs.data.equipMaterialDatas);
	}

	private void ApplyGemSlotLevel()
	{
		try
		{
			EquipStrengthenListData data = CoreUtils.GetData(CoreUtils.GetData(Id, RuntimeConfigs.data.equipDatas).strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
			int[] array = (Level / 10) switch
			{
				0 => data.equipHoleList0, 
				1 => data.equipHoleList10, 
				2 => data.equipHoleList20, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			int i;
			for (i = 0; i < array.Length; i++)
			{
				GemSlot gemSlot = GemSlots.FirstOrDefault((GemSlot x) => x.SlotId == i);
				if (gemSlot != null)
				{
					gemSlot.SlotLevel = array[i];
				}
				else
				{
					gemSlot = new GemSlot
					{
						GemId = 0,
						SlotId = i,
						SlotLevel = array[i]
					};
					GemSlots.Add(gemSlot);
				}
				Gem gemBySnapshot = CharacterDependHelper.GetGemBySnapshot(gemSlot.GemId, m_snapshot);
				if (gemBySnapshot != null)
				{
					gemBySnapshot.InlayEquip = Uid;
				}
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"应用宝石槽失败 {arg}");
			}
		}
	}

	private void ApplyWearCharacter(MapField<int, Character> characters)
	{
		foreach (KeyValuePair<int, Character> character in characters)
		{
			if (character.Value.Equips.TryGetValue((int)Type, out var value) && value == Uid)
			{
				wearCharacter_ = character.Key;
				return;
			}
		}
		wearCharacter_ = 0;
	}

	private void ApplyFeatureData()
	{
		try
		{
			EquipStrengthenListData data = CoreUtils.GetData(CoreUtils.GetData(Id, RuntimeConfigs.data.equipDatas).strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
			List<ItemKv> featureInfos = (Level / 10) switch
			{
				0 => data.equipFeature0, 
				1 => data.equipFeature10, 
				2 => data.equipFeature20, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			int i;
			for (i = 0; i < featureInfos.Count; i++)
			{
				EquipFeature equipFeature = features_.FirstOrDefault((EquipFeature x) => x.Id == featureInfos[i].id);
				if (equipFeature != null)
				{
					equipFeature.Level = featureInfos[i].count;
					continue;
				}
				features_.Add(new EquipFeature
				{
					Id = featureInfos[i].id,
					Level = featureInfos[i].count
				});
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"计算特性数据失败 {arg}");
			}
		}
	}

	public void Refresh()
	{
		EquipData data = CoreUtils.GetData(Id, RuntimeConfigs.data.equipDatas);
		if (data != null)
		{
			TypeIndex = data.equipType;
			ApplyGemSlotLevel();
			ApplyFeatureData();
			CalculateFeatureData();
		}
	}

	public void MargeFrom(Equip other)
	{
		if (this == other || other == null)
		{
			return;
		}
		uid_ = other.Uid;
		id_ = other.Id;
		type_ = other.Type;
		quality_ = other.Quality;
		level_ = other.Level;
		source_ = other.Source;
		isLock_ = other.IsLock;
		if (attributes_ != other.attributes_)
		{
			attributes_.Clear();
			foreach (EquipAttr attribute in other.Attributes)
			{
				attributes_.Add(attribute.Clone());
			}
		}
		if (features_ != other.features_)
		{
			features_.Clear();
			foreach (EquipFeature feature in other.Features)
			{
				features_.Add(feature.Clone());
			}
		}
		if (gemSlots_ != other.gemSlots_)
		{
			gemSlots_.Clear();
			foreach (GemSlot gemSlot in other.GemSlots)
			{
				gemSlots_.Add(gemSlot.Clone());
			}
		}
		Refresh();
	}

	public int GetId()
	{
		return Id;
	}

	public int GetUid()
	{
		return Uid;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		return CoreUtils.GetData(Id, RuntimeConfigs.data.itemDatas)?.quality ?? 0;
	}

	public int GetLocalizationName()
	{
		return CoreUtils.GetData(Id, RuntimeConfigs.data.itemDatas)?.nameLocal ?? 0;
	}

	public int GetFeatureData(int featureID, bool clamp = true)
	{
		int num = 0;
		if (!m_AllFeatures.TryGetValue(featureID, out var value))
		{
			return num;
		}
		foreach (FeatureData item in value)
		{
			num += item.Data;
		}
		return num;
	}

	public int GetFeatureData(int featureID, FeatureData.FeatureSourceType sourceType, bool clamp = true)
	{
		int num = 0;
		if (!m_AllFeatures.TryGetValue(featureID, out var value))
		{
			return num;
		}
		foreach (FeatureData item in value)
		{
			if ((item.FeatureSource & sourceType) > (FeatureData.FeatureSourceType)0)
			{
				num += item.Data;
			}
		}
		return num;
	}

	public void GetAllFeatureIDs(List<int> output)
	{
		foreach (KeyValuePair<int, List<FeatureData>> allFeature in m_AllFeatures)
		{
			if (!output.Contains(allFeature.Key))
			{
				output.Add(allFeature.Key);
			}
		}
	}

	public void TakeOff(MapField<int, Character> characters, CharacterDependSnapshot depend)
	{
		if (WearCharacter != 0)
		{
			CharacterChangeEquipEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterChangeEquipEvt>();
			evt.character = characters[WearCharacter];
			evt.addEquip = null;
			evt.removeEquip = this;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_ChangeEquip, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		ApplyWearCharacter(characters);
	}

	public void Wear(MapField<int, Character> characters, CharacterDependSnapshot depend)
	{
		ApplyWearCharacter(characters);
		if (WearCharacter != 0)
		{
			CharacterChangeEquipEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterChangeEquipEvt>();
			evt.character = characters[WearCharacter];
			evt.addEquip = this;
			evt.removeEquip = null;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_ChangeEquip, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void RefreshItemInfo()
	{
		ItemChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
		evt.ItemProxies = ListPool<ItemUnifierProxy>.Get();
		evt.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(this));
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt);
		ItemUnifierProxy.ItemUnifierPool.Release(evt.ItemProxies);
		ListPool<ItemUnifierProxy>.Release(evt.ItemProxies);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
