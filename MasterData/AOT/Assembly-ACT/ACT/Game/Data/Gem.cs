using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
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

public sealed class Gem : IMessage<Gem>, IMessage, IEquatable<Gem>, IDeepCloneable<Gem>, IBufferMessage, IMargeFrom<Gem>, IBagItem, IFeature, IItemChangeEvent
{
	private static readonly MessageParser<Gem> _parser = new MessageParser<Gem>(() => new Gem());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int IdFieldNumber = 2;

	private int id_;

	public const int IsLockFieldNumber = 3;

	private bool isLock_;

	public const int LevelFieldNumber = 4;

	private int level_;

	public const int InlayEquipFieldNumber = 5;

	private int inlayEquip_;

	public const int FeaturesFieldNumber = 6;

	private static readonly FieldCodec<EquipFeature> _repeated_features_codec = FieldCodec.ForMessage(50u, EquipFeature.Parser);

	private readonly RepeatedField<EquipFeature> features_ = new RepeatedField<EquipFeature>();

	public const int SourceFieldNumber = 7;

	private ItemsWays source_;

	internal Dictionary<int, List<FeatureData>> m_AllFeatures = new Dictionary<int, List<FeatureData>>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Gem> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[54];

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
	public int InlayEquip
	{
		get
		{
			return inlayEquip_;
		}
		set
		{
			inlayEquip_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<EquipFeature> Features => features_;

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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Gem()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Gem(Gem other)
		: this()
	{
		uid_ = other.uid_;
		id_ = other.id_;
		isLock_ = other.isLock_;
		level_ = other.level_;
		inlayEquip_ = other.inlayEquip_;
		features_ = other.features_.Clone();
		source_ = other.source_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Gem Clone()
	{
		return new Gem(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Gem);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Gem other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (InlayEquip != other.InlayEquip)
		{
			return false;
		}
		if (!features_.Equals(other.features_))
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
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (InlayEquip != 0)
		{
			num ^= InlayEquip.GetHashCode();
		}
		num ^= features_.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Level);
		}
		if (InlayEquip != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(InlayEquip);
		}
		features_.WriteTo(ref output, _repeated_features_codec);
		if (Source != ItemsWays.ItemswayEntergame)
		{
			output.WriteRawTag(56);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (InlayEquip != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InlayEquip);
		}
		num += features_.CalculateSize(_repeated_features_codec);
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
	public void MergeFrom(Gem other)
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
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.InlayEquip != 0)
			{
				InlayEquip = other.InlayEquip;
			}
			features_.Add(other.features_);
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
				Level = input.ReadInt32();
				break;
			case 40u:
				InlayEquip = input.ReadInt32();
				break;
			case 50u:
				features_.AddEntriesFrom(ref input, _repeated_features_codec);
				break;
			case 56u:
				Source = (ItemsWays)input.ReadEnum();
				break;
			}
		}
	}

	private void CalculateFeatureData()
	{
		try
		{
			foreach (KeyValuePair<int, List<FeatureData>> allFeature in m_AllFeatures)
			{
				allFeature.Value.Clear();
			}
			foreach (ItemKv item in CoreUtils.GetData(Id, RuntimeConfigs.data.equipGemDatas).equipFeature)
			{
				if (!m_AllFeatures.TryGetValue(item.id, out var value))
				{
					value = new List<FeatureData>();
					m_AllFeatures.TryAdd(item.id, value);
				}
				value.Add(new FeatureData
				{
					FeatureSource = FeatureData.FeatureSourceType.Gem,
					Data = item.count
				});
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"宝石特性计算失败 {arg}");
			}
		}
	}

	private void ApplyInlayEquip(MapField<int, Equip> equips)
	{
		foreach (KeyValuePair<int, Equip> equip in equips)
		{
			foreach (GemSlot gemSlot in equip.Value.GemSlots)
			{
				if (gemSlot.GemId == uid_)
				{
					InlayEquip = equip.Value.Uid;
					return;
				}
			}
		}
		InlayEquip = 0;
	}

	public void MargeFrom(Gem other)
	{
		if (this != other && other != null)
		{
			Uid = other.Uid;
			Id = other.Id;
			IsLock = other.IsLock;
			Level = CoreUtils.GetData(Id, RuntimeConfigs.data.equipGemDatas).quality;
			if (features_ != other.features_)
			{
				features_.Clear();
				features_.Add(other.features_);
			}
			Source = other.Source;
			Refresh();
		}
	}

	public void TakeOff(MapField<int, Character> characters, CharacterDependSnapshot depend)
	{
		if (InlayEquip != 0)
		{
			Equip equip = depend.EquipSnapshot[InlayEquip];
			CharacterChangeGemEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterChangeGemEvt>();
			if (equip.WearCharacter != 0)
			{
				evt.character = characters[equip.WearCharacter];
			}
			evt.Equip = equip;
			evt.addGem = null;
			evt.removeGem = this;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_ChangeGem, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		ApplyInlayEquip(depend.EquipSnapshot);
	}

	public void Wear(MapField<int, Character> characters, CharacterDependSnapshot depend)
	{
		ApplyInlayEquip(depend.EquipSnapshot);
		if (InlayEquip != 0)
		{
			Equip equip = depend.EquipSnapshot[InlayEquip];
			CharacterChangeGemEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterChangeGemEvt>();
			if (equip.WearCharacter != 0)
			{
				evt.character = characters[equip.WearCharacter];
			}
			evt.Equip = equip;
			evt.addGem = this;
			evt.removeGem = null;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_ChangeGem, evt);
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

	public void Refresh()
	{
		CalculateFeatureData();
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
			if (item.FeatureSource == sourceType)
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
}
