using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10289)]
[MemoryPackable(GenerateType.Object)]
public class H2C_GetLotteryPoolResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_GetLotteryPoolResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_GetLotteryPoolResponseFormatter : MemoryPackFormatter<H2C_GetLotteryPoolResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_GetLotteryPoolResponse value)
		{
			H2C_GetLotteryPoolResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_GetLotteryPoolResponse value)
		{
			H2C_GetLotteryPoolResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int DailyLotteryCount { get; set; }

	[MemoryPackOrder(1)]
	public List<PbLotteryPoolInfo> PoolInfo { get; set; } = new List<PbLotteryPoolInfo>();

	[MemoryPackOrder(2)]
	public List<PbLotteryResult> lastResult { get; set; } = new List<PbLotteryResult>();

	public static H2C_GetLotteryPoolResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_GetLotteryPoolResponse)) as H2C_GetLotteryPoolResponse;
		}
		return new H2C_GetLotteryPoolResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			DailyLotteryCount = 0;
			PoolInfo.Clear();
			lastResult.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_GetLotteryPoolResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetLotteryPoolResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_GetLotteryPoolResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetLotteryPoolResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_GetLotteryPoolResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbLotteryPoolInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbLotteryPoolInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbLotteryResult>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbLotteryResult>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_GetLotteryPoolResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(7, value.IsFromPool, value.DailyLotteryCount);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbLotteryPoolInfo>>(value.PoolInfo));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbLotteryResult>>(value.lastResult));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_GetLotteryPoolResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbLotteryPoolInfo> value4;
		List<PbLotteryResult> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.DailyLotteryCount;
				value4 = value.PoolInfo;
				value5 = value.lastResult;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0187;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbLotteryPoolInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbLotteryResult>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_GetLotteryPoolResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.DailyLotteryCount;
				value4 = value.PoolInfo;
				value5 = value.lastResult;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0187;
			}
		}
		value = new H2C_GetLotteryPoolResponse
		{
			IsFromPool = value2,
			DailyLotteryCount = value3,
			PoolInfo = value4,
			lastResult = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0187:
		value.IsFromPool = value2;
		value.DailyLotteryCount = value3;
		value.PoolInfo = value4;
		value.lastResult = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
