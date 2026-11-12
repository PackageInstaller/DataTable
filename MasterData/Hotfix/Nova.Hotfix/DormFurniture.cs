using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormFurniture : IMessage<DormFurniture>, IMessage, IEquatable<DormFurniture>, IDeepCloneable<DormFurniture>
{
	private static readonly MessageParser<DormFurniture> _parser = new MessageParser<DormFurniture>(() => new DormFurniture());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ModelPrefabFieldNumber = 2;

	private string modelPrefab_ = "";

	public const int LFieldNumber = 3;

	private int l_;

	public const int WFieldNumber = 4;

	private int w_;

	public const int HFieldNumber = 5;

	private int h_;

	public const int CanInFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_canIn_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> canIn_ = new RepeatedField<int>();

	public const int PutTypeFieldNumber = 7;

	private int putType_;

	public const int FixedFieldNumber = 8;

	private int fixed_;

	public const int ActorSDIdFieldNumber = 9;

	private int actorSDId_;

	public const int ProduceItemIdFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_produceItemId_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> produceItemId_ = new RepeatedField<int>();

	public const int TabFieldNumber = 11;

	private int tab_;

	public const int NotShowFieldNumber = 12;

	private int notShow_;

	public const int FunctionFieldNumber = 13;

	private int function_;

	public const int BubbleIconFieldNumber = 14;

	private string bubbleIcon_ = "";

	public const int CollectionValueFieldNumber = 15;

	private int collectionValue_;

	[DebuggerNonUserCode]
	public static MessageParser<DormFurniture> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(290);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
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
	public string ModelPrefab
	{
		get
		{
			return modelPrefab_;
		}
		set
		{
			modelPrefab_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int L
	{
		get
		{
			return l_;
		}
		set
		{
			l_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int W
	{
		get
		{
			return w_;
		}
		set
		{
			w_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int H
	{
		get
		{
			return h_;
		}
		set
		{
			h_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CanIn => canIn_;

	[DebuggerNonUserCode]
	public int PutType
	{
		get
		{
			return putType_;
		}
		set
		{
			putType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Fixed
	{
		get
		{
			return fixed_;
		}
		set
		{
			fixed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActorSDId
	{
		get
		{
			return actorSDId_;
		}
		set
		{
			actorSDId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ProduceItemId => produceItemId_;

	[DebuggerNonUserCode]
	public int Tab
	{
		get
		{
			return tab_;
		}
		set
		{
			tab_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NotShow
	{
		get
		{
			return notShow_;
		}
		set
		{
			notShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Function
	{
		get
		{
			return function_;
		}
		set
		{
			function_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BubbleIcon
	{
		get
		{
			return bubbleIcon_;
		}
		set
		{
			bubbleIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CollectionValue
	{
		get
		{
			return collectionValue_;
		}
		set
		{
			collectionValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DormFurniture()
	{
	}

	[DebuggerNonUserCode]
	public DormFurniture(DormFurniture other)
		: this()
	{
		id_ = other.id_;
		modelPrefab_ = other.modelPrefab_;
		l_ = other.l_;
		w_ = other.w_;
		h_ = other.h_;
		canIn_ = other.canIn_.Clone();
		putType_ = other.putType_;
		fixed_ = other.fixed_;
		actorSDId_ = other.actorSDId_;
		produceItemId_ = other.produceItemId_.Clone();
		tab_ = other.tab_;
		notShow_ = other.notShow_;
		function_ = other.function_;
		bubbleIcon_ = other.bubbleIcon_;
		collectionValue_ = other.collectionValue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormFurniture Clone()
	{
		return new DormFurniture(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormFurniture);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormFurniture other)
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
		if (ModelPrefab != other.ModelPrefab)
		{
			return false;
		}
		if (L != other.L)
		{
			return false;
		}
		if (W != other.W)
		{
			return false;
		}
		if (H != other.H)
		{
			return false;
		}
		if (!canIn_.Equals(other.canIn_))
		{
			return false;
		}
		if (PutType != other.PutType)
		{
			return false;
		}
		if (Fixed != other.Fixed)
		{
			return false;
		}
		if (ActorSDId != other.ActorSDId)
		{
			return false;
		}
		if (!produceItemId_.Equals(other.produceItemId_))
		{
			return false;
		}
		if (Tab != other.Tab)
		{
			return false;
		}
		if (NotShow != other.NotShow)
		{
			return false;
		}
		if (Function != other.Function)
		{
			return false;
		}
		if (BubbleIcon != other.BubbleIcon)
		{
			return false;
		}
		if (CollectionValue != other.CollectionValue)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (ModelPrefab.Length != 0)
		{
			num ^= ModelPrefab.GetHashCode();
		}
		if (L != 0)
		{
			num ^= L.GetHashCode();
		}
		if (W != 0)
		{
			num ^= W.GetHashCode();
		}
		if (H != 0)
		{
			num ^= H.GetHashCode();
		}
		num ^= canIn_.GetHashCode();
		if (PutType != 0)
		{
			num ^= PutType.GetHashCode();
		}
		if (Fixed != 0)
		{
			num ^= Fixed.GetHashCode();
		}
		if (ActorSDId != 0)
		{
			num ^= ActorSDId.GetHashCode();
		}
		num ^= produceItemId_.GetHashCode();
		if (Tab != 0)
		{
			num ^= Tab.GetHashCode();
		}
		if (NotShow != 0)
		{
			num ^= NotShow.GetHashCode();
		}
		if (Function != 0)
		{
			num ^= Function.GetHashCode();
		}
		if (BubbleIcon.Length != 0)
		{
			num ^= BubbleIcon.GetHashCode();
		}
		if (CollectionValue != 0)
		{
			num ^= CollectionValue.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (ModelPrefab.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ModelPrefab);
		}
		if (L != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(L);
		}
		if (W != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(W);
		}
		if (H != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(H);
		}
		canIn_.WriteTo(output, _repeated_canIn_codec);
		if (PutType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PutType);
		}
		if (Fixed != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Fixed);
		}
		if (ActorSDId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ActorSDId);
		}
		produceItemId_.WriteTo(output, _repeated_produceItemId_codec);
		if (Tab != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Tab);
		}
		if (NotShow != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(NotShow);
		}
		if (Function != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Function);
		}
		if (BubbleIcon.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(BubbleIcon);
		}
		if (CollectionValue != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(CollectionValue);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (ModelPrefab.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ModelPrefab);
		}
		if (L != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(L);
		}
		if (W != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(W);
		}
		if (H != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(H);
		}
		num += canIn_.CalculateSize(_repeated_canIn_codec);
		if (PutType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PutType);
		}
		if (Fixed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Fixed);
		}
		if (ActorSDId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActorSDId);
		}
		num += produceItemId_.CalculateSize(_repeated_produceItemId_codec);
		if (Tab != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tab);
		}
		if (NotShow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NotShow);
		}
		if (Function != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Function);
		}
		if (BubbleIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BubbleIcon);
		}
		if (CollectionValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CollectionValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormFurniture other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ModelPrefab.Length != 0)
			{
				ModelPrefab = other.ModelPrefab;
			}
			if (other.L != 0)
			{
				L = other.L;
			}
			if (other.W != 0)
			{
				W = other.W;
			}
			if (other.H != 0)
			{
				H = other.H;
			}
			canIn_.Add(other.canIn_);
			if (other.PutType != 0)
			{
				PutType = other.PutType;
			}
			if (other.Fixed != 0)
			{
				Fixed = other.Fixed;
			}
			if (other.ActorSDId != 0)
			{
				ActorSDId = other.ActorSDId;
			}
			produceItemId_.Add(other.produceItemId_);
			if (other.Tab != 0)
			{
				Tab = other.Tab;
			}
			if (other.NotShow != 0)
			{
				NotShow = other.NotShow;
			}
			if (other.Function != 0)
			{
				Function = other.Function;
			}
			if (other.BubbleIcon.Length != 0)
			{
				BubbleIcon = other.BubbleIcon;
			}
			if (other.CollectionValue != 0)
			{
				CollectionValue = other.CollectionValue;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 18u:
				ModelPrefab = input.ReadString();
				break;
			case 24u:
				L = input.ReadInt32();
				break;
			case 32u:
				W = input.ReadInt32();
				break;
			case 40u:
				H = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				canIn_.AddEntriesFrom(input, _repeated_canIn_codec);
				break;
			case 56u:
				PutType = input.ReadInt32();
				break;
			case 64u:
				Fixed = input.ReadInt32();
				break;
			case 72u:
				ActorSDId = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				produceItemId_.AddEntriesFrom(input, _repeated_produceItemId_codec);
				break;
			case 88u:
				Tab = input.ReadInt32();
				break;
			case 96u:
				NotShow = input.ReadInt32();
				break;
			case 104u:
				Function = input.ReadInt32();
				break;
			case 114u:
				BubbleIcon = input.ReadString();
				break;
			case 120u:
				CollectionValue = input.ReadInt32();
				break;
			}
		}
	}
}
