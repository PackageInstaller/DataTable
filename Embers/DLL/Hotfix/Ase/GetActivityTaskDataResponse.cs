using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10171)]
[MemoryPackable(GenerateType.Object)]
public class GetActivityTaskDataResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetActivityTaskDataResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetActivityTaskDataResponseFormatter : MemoryPackFormatter<GetActivityTaskDataResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetActivityTaskDataResponse value)
		{
			GetActivityTaskDataResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetActivityTaskDataResponse value)
		{
			GetActivityTaskDataResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbActivityTypeAllData> Datas { get; set; } = new List<PbActivityTypeAllData>();

	[MemoryPackOrder(1)]
	public int ActivePoint { get; set; }

	[MemoryPackOrder(2)]
	public List<PbItem> ActivityGoodsInfos { get; set; } = new List<PbItem>();

	[MemoryPackOrder(3)]
	public List<int> OpenActivityIds { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public List<PbActivityVersionData> ActivityVersionData { get; set; } = new List<PbActivityVersionData>();

	[MemoryPackOrder(5)]
	public List<PbCopyInfo> CopyInfos { get; set; } = new List<PbCopyInfo>();

	public static GetActivityTaskDataResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetActivityTaskDataResponse)) as GetActivityTaskDataResponse;
		}
		return new GetActivityTaskDataResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Datas.Clear();
			ActivePoint = 0;
			ActivityGoodsInfos.Clear();
			OpenActivityIds.Clear();
			ActivityVersionData.Clear();
			CopyInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetActivityTaskDataResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetActivityTaskDataResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetActivityTaskDataResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetActivityTaskDataResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetActivityTaskDataResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityTypeAllData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityTypeAllData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItem>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityVersionData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityVersionData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetActivityTaskDataResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityTypeAllData>>(value.Datas));
		writer.WriteUnmanaged<int>(value.ActivePoint);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItem>>(value.ActivityGoodsInfos));
		writer.WriteValue<List<int>>(value.OpenActivityIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityVersionData>>(value.ActivityVersionData));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyInfo>>(value.CopyInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetActivityTaskDataResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbActivityTypeAllData> value3;
		int value4;
		List<PbItem> value5;
		List<int> value6;
		List<PbActivityVersionData> value7;
		List<PbCopyInfo> value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Datas;
				value4 = value.ActivePoint;
				value5 = value.ActivityGoodsInfos;
				value6 = value.OpenActivityIds;
				value7 = value.ActivityVersionData;
				value8 = value.CopyInfos;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadValue(ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				ListFormatter.DeserializePackable(ref reader, ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_0225;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbActivityTypeAllData>(ref reader);
			reader.ReadUnmanaged<int>(out value4);
			value5 = ListFormatter.DeserializePackable<PbItem>(ref reader);
			value6 = reader.ReadValue<List<int>>();
			value7 = ListFormatter.DeserializePackable<PbActivityVersionData>(ref reader);
			value8 = ListFormatter.DeserializePackable<PbCopyInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetActivityTaskDataResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = null;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Datas;
				value4 = value.ActivePoint;
				value5 = value.ActivityGoodsInfos;
				value6 = value.OpenActivityIds;
				value7 = value.ActivityVersionData;
				value8 = value.CopyInfos;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										ListFormatter.DeserializePackable(ref reader, ref value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													message = reader.ReadString();
													_ = 10;
												}
											}
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
				goto IL_0225;
			}
		}
		value = new GetActivityTaskDataResponse
		{
			IsFromPool = value2,
			Datas = value3,
			ActivePoint = value4,
			ActivityGoodsInfos = value5,
			OpenActivityIds = value6,
			ActivityVersionData = value7,
			CopyInfos = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_0225:
		value.IsFromPool = value2;
		value.Datas = value3;
		value.ActivePoint = value4;
		value.ActivityGoodsInfos = value5;
		value.OpenActivityIds = value6;
		value.ActivityVersionData = value7;
		value.CopyInfos = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
