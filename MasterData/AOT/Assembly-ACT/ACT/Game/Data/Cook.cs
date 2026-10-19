using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Cook : IMessage<Cook>, IMessage, IEquatable<Cook>, IDeepCloneable<Cook>, IBufferMessage
{
	private static readonly MessageParser<Cook> _parser = new MessageParser<Cook>(() => new Cook());

	private UnknownFieldSet _unknownFields;

	public const int PotLevelFieldNumber = 1;

	private int potLevel_;

	public const int UnlockedMenusFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_unlockedMenus_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> unlockedMenus_ = new MapField<int, bool>();

	public const int CustomMenusFieldNumber = 3;

	private static readonly FieldCodec<CookMenu> _repeated_customMenus_codec = FieldCodec.ForMessage(26u, CookMenu.Parser);

	private readonly RepeatedField<CookMenu> customMenus_ = new RepeatedField<CookMenu>();

	public const int CookItemInfosFieldNumber = 4;

	private static readonly MapField<int, CookItemInfo>.Codec _map_cookItemInfos_codec = new MapField<int, CookItemInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, CookItemInfo.Parser), 34u);

	private readonly MapField<int, CookItemInfo> cookItemInfos_ = new MapField<int, CookItemInfo>();

	public const int CurRecommendTemplateFieldNumber = 5;

	private int curRecommendTemplate_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Cook> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[143];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PotLevel
	{
		get
		{
			return potLevel_;
		}
		set
		{
			potLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> UnlockedMenus => unlockedMenus_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<CookMenu> CustomMenus => customMenus_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, CookItemInfo> CookItemInfos => cookItemInfos_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurRecommendTemplate
	{
		get
		{
			return curRecommendTemplate_;
		}
		set
		{
			curRecommendTemplate_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Cook()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Cook(Cook other)
		: this()
	{
		potLevel_ = other.potLevel_;
		unlockedMenus_ = other.unlockedMenus_.Clone();
		customMenus_ = other.customMenus_.Clone();
		cookItemInfos_ = other.cookItemInfos_.Clone();
		curRecommendTemplate_ = other.curRecommendTemplate_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Cook Clone()
	{
		return new Cook(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Cook);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Cook other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PotLevel != other.PotLevel)
		{
			return false;
		}
		if (!UnlockedMenus.Equals(other.UnlockedMenus))
		{
			return false;
		}
		if (!customMenus_.Equals(other.customMenus_))
		{
			return false;
		}
		if (!CookItemInfos.Equals(other.CookItemInfos))
		{
			return false;
		}
		if (CurRecommendTemplate != other.CurRecommendTemplate)
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
		if (PotLevel != 0)
		{
			num ^= PotLevel.GetHashCode();
		}
		num ^= UnlockedMenus.GetHashCode();
		num ^= customMenus_.GetHashCode();
		num ^= CookItemInfos.GetHashCode();
		if (CurRecommendTemplate != 0)
		{
			num ^= CurRecommendTemplate.GetHashCode();
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
		if (PotLevel != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PotLevel);
		}
		unlockedMenus_.WriteTo(ref output, _map_unlockedMenus_codec);
		customMenus_.WriteTo(ref output, _repeated_customMenus_codec);
		cookItemInfos_.WriteTo(ref output, _map_cookItemInfos_codec);
		if (CurRecommendTemplate != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CurRecommendTemplate);
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
		if (PotLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PotLevel);
		}
		num += unlockedMenus_.CalculateSize(_map_unlockedMenus_codec);
		num += customMenus_.CalculateSize(_repeated_customMenus_codec);
		num += cookItemInfos_.CalculateSize(_map_cookItemInfos_codec);
		if (CurRecommendTemplate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurRecommendTemplate);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Cook other)
	{
		if (other != null)
		{
			if (other.PotLevel != 0)
			{
				PotLevel = other.PotLevel;
			}
			unlockedMenus_.Add(other.unlockedMenus_);
			customMenus_.Add(other.customMenus_);
			cookItemInfos_.Add(other.cookItemInfos_);
			if (other.CurRecommendTemplate != 0)
			{
				CurRecommendTemplate = other.CurRecommendTemplate;
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
				PotLevel = input.ReadInt32();
				break;
			case 18u:
				unlockedMenus_.AddEntriesFrom(ref input, _map_unlockedMenus_codec);
				break;
			case 26u:
				customMenus_.AddEntriesFrom(ref input, _repeated_customMenus_codec);
				break;
			case 34u:
				cookItemInfos_.AddEntriesFrom(ref input, _map_cookItemInfos_codec);
				break;
			case 40u:
				CurRecommendTemplate = input.ReadInt32();
				break;
			}
		}
	}

	public void CopyFrom(Cook change)
	{
		if (change.PotLevel != 0)
		{
			PotLevel = change.PotLevel;
		}
		foreach (KeyValuePair<int, bool> item in change.unlockedMenus_)
		{
			unlockedMenus_[item.Key] = item.Value;
		}
		foreach (CookMenu item2 in change.customMenus_)
		{
			int num = customMenus_.IndexOf(item2);
			if (num != -1)
			{
				customMenus_[num] = item2;
			}
			else
			{
				customMenus_.Add(item2);
			}
		}
		foreach (KeyValuePair<int, CookItemInfo> item3 in change.cookItemInfos_)
		{
			cookItemInfos_[item3.Key] = item3.Value;
		}
		curRecommendTemplate_ = change.curRecommendTemplate_;
	}
}
