using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Missions : IMessage<Missions>, IMessage, IEquatable<Missions>, IDeepCloneable<Missions>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public sealed class TypeMissions : IMessage<TypeMissions>, IMessage, IEquatable<TypeMissions>, IDeepCloneable<TypeMissions>, IBufferMessage
		{
			private static readonly MessageParser<TypeMissions> _parser = new MessageParser<TypeMissions>(() => new TypeMissions());

			private UnknownFieldSet _unknownFields;

			public const int ValuesFieldNumber = 1;

			private static readonly MapField<int, Mission>.Codec _map_values_codec = new MapField<int, Mission>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Mission.Parser), 10u);

			private readonly MapField<int, Mission> values_ = new MapField<int, Mission>();

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageParser<TypeMissions> Parser => _parser;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public static MessageDescriptor Descriptor => Missions.Descriptor.NestedTypes[0];

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			MessageDescriptor IMessage.Descriptor => Descriptor;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public MapField<int, Mission> Values => values_;

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public TypeMissions()
			{
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public TypeMissions(TypeMissions other)
				: this()
			{
				values_ = other.values_.Clone();
				_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public TypeMissions Clone()
			{
				return new TypeMissions(this);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public override bool Equals(object other)
			{
				return Equals(other as TypeMissions);
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public bool Equals(TypeMissions other)
			{
				if (other == null)
				{
					return false;
				}
				if (other == this)
				{
					return true;
				}
				if (!Values.Equals(other.Values))
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
				num ^= Values.GetHashCode();
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
				values_.WriteTo(ref output, _map_values_codec);
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
				num += values_.CalculateSize(_map_values_codec);
				if (_unknownFields != null)
				{
					num += _unknownFields.CalculateSize();
				}
				return num;
			}

			[DebuggerNonUserCode]
			[GeneratedCode("protoc", null)]
			public void MergeFrom(TypeMissions other)
			{
				if (other != null)
				{
					values_.Add(other.values_);
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
						values_.AddEntriesFrom(ref input, _map_values_codec);
					}
				}
			}
		}
	}

	private static readonly MessageParser<Missions> _parser = new MessageParser<Missions>(() => new Missions());

	private UnknownFieldSet _unknownFields;

	public const int ValuesFieldNumber = 1;

	private static readonly MapField<int, Types.TypeMissions>.Codec _map_values_codec = new MapField<int, Types.TypeMissions>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Types.TypeMissions.Parser), 10u);

	private readonly MapField<int, Types.TypeMissions> values_ = new MapField<int, Types.TypeMissions>();

	public const int LastGenDailyMissionTSFieldNumber = 2;

	private int lastGenDailyMissionTS_;

	public const int AllMissionFieldNumber = 3;

	private static readonly MapField<long, MissionR>.Codec _map_allMission_codec = new MapField<long, MissionR>.Codec(FieldCodec.ForInt64(8u, 0L), FieldCodec.ForMessage(18u, MissionR.Parser), 26u);

	private readonly MapField<long, MissionR> allMission_ = new MapField<long, MissionR>();

	public const int TrackingMissionFieldNumber = 4;

	private long trackingMission_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Missions> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[188];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Types.TypeMissions> Values => values_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastGenDailyMissionTS
	{
		get
		{
			return lastGenDailyMissionTS_;
		}
		set
		{
			lastGenDailyMissionTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<long, MissionR> AllMission => allMission_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long TrackingMission
	{
		get
		{
			return trackingMission_;
		}
		set
		{
			trackingMission_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Missions()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Missions(Missions other)
		: this()
	{
		values_ = other.values_.Clone();
		lastGenDailyMissionTS_ = other.lastGenDailyMissionTS_;
		allMission_ = other.allMission_.Clone();
		trackingMission_ = other.trackingMission_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Missions Clone()
	{
		return new Missions(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Missions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Missions other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Values.Equals(other.Values))
		{
			return false;
		}
		if (LastGenDailyMissionTS != other.LastGenDailyMissionTS)
		{
			return false;
		}
		if (!AllMission.Equals(other.AllMission))
		{
			return false;
		}
		if (TrackingMission != other.TrackingMission)
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
		num ^= Values.GetHashCode();
		if (LastGenDailyMissionTS != 0)
		{
			num ^= LastGenDailyMissionTS.GetHashCode();
		}
		num ^= AllMission.GetHashCode();
		if (TrackingMission != 0L)
		{
			num ^= TrackingMission.GetHashCode();
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
		values_.WriteTo(ref output, _map_values_codec);
		if (LastGenDailyMissionTS != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LastGenDailyMissionTS);
		}
		allMission_.WriteTo(ref output, _map_allMission_codec);
		if (TrackingMission != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(TrackingMission);
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
		num += values_.CalculateSize(_map_values_codec);
		if (LastGenDailyMissionTS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastGenDailyMissionTS);
		}
		num += allMission_.CalculateSize(_map_allMission_codec);
		if (TrackingMission != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(TrackingMission);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Missions other)
	{
		if (other != null)
		{
			values_.Add(other.values_);
			if (other.LastGenDailyMissionTS != 0)
			{
				LastGenDailyMissionTS = other.LastGenDailyMissionTS;
			}
			allMission_.Add(other.allMission_);
			if (other.TrackingMission != 0L)
			{
				TrackingMission = other.TrackingMission;
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
			case 10u:
				values_.AddEntriesFrom(ref input, _map_values_codec);
				break;
			case 16u:
				LastGenDailyMissionTS = input.ReadInt32();
				break;
			case 26u:
				allMission_.AddEntriesFrom(ref input, _map_allMission_codec);
				break;
			case 32u:
				TrackingMission = input.ReadInt64();
				break;
			}
		}
	}
}
