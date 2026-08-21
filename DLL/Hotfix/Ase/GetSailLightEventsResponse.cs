using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10596)]
[MemoryPackable(GenerateType.Object)]
public class GetSailLightEventsResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetSailLightEventsResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetSailLightEventsResponseFormatter : MemoryPackFormatter<GetSailLightEventsResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetSailLightEventsResponse value)
		{
			GetSailLightEventsResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetSailLightEventsResponse value)
		{
			GetSailLightEventsResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<int> EventIds { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<PbSailLightDispatchInfo> OldDispatchInfos { get; set; } = new List<PbSailLightDispatchInfo>();

	[MemoryPackOrder(2)]
	public List<PbSailLightDispatchInfo> TodayDispatchInfos { get; set; } = new List<PbSailLightDispatchInfo>();

	[MemoryPackOrder(3)]
	public List<int> SailingHeroIds { get; set; } = new List<int>();

	public static GetSailLightEventsResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetSailLightEventsResponse)) as GetSailLightEventsResponse;
		}
		return new GetSailLightEventsResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			EventIds.Clear();
			OldDispatchInfos.Clear();
			TodayDispatchInfos.Clear();
			SailingHeroIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetSailLightEventsResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetSailLightEventsResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetSailLightEventsResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetSailLightEventsResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetSailLightEventsResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSailLightDispatchInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSailLightDispatchInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetSailLightEventsResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteValue<List<int>>(value.EventIds);
		List<PbSailLightDispatchInfo> source = value.OldDispatchInfos;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.TodayDispatchInfos;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteValue<List<int>>(value.SailingHeroIds);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetSailLightEventsResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		List<PbSailLightDispatchInfo> value4;
		List<PbSailLightDispatchInfo> value5;
		List<int> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EventIds;
				value4 = value.OldDispatchInfos;
				value5 = value.TodayDispatchInfos;
				value6 = value.SailingHeroIds;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01bd;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = ListFormatter.DeserializePackable<PbSailLightDispatchInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbSailLightDispatchInfo>(ref reader);
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetSailLightEventsResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EventIds;
				value4 = value.OldDispatchInfos;
				value5 = value.TodayDispatchInfos;
				value6 = value.SailingHeroIds;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01bd;
			}
		}
		value = new GetSailLightEventsResponse
		{
			IsFromPool = value2,
			EventIds = value3,
			OldDispatchInfos = value4,
			TodayDispatchInfos = value5,
			SailingHeroIds = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01bd:
		value.IsFromPool = value2;
		value.EventIds = value3;
		value.OldDispatchInfos = value4;
		value.TodayDispatchInfos = value5;
		value.SailingHeroIds = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
