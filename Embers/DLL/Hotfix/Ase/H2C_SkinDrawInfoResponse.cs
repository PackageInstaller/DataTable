using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10845)]
[MemoryPackable(GenerateType.Object)]
public class H2C_SkinDrawInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_SkinDrawInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_SkinDrawInfoResponseFormatter : MemoryPackFormatter<H2C_SkinDrawInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_SkinDrawInfoResponse value)
		{
			H2C_SkinDrawInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_SkinDrawInfoResponse value)
		{
			H2C_SkinDrawInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int AllTimes { get; set; }

	[MemoryPackOrder(1)]
	public long DrawState { get; set; }

	[MemoryPackOrder(2)]
	public List<PbPositionReward> PositionRewards { get; set; } = new List<PbPositionReward>();

	[MemoryPackOrder(9)]
	public string Param1 { get; set; }

	public static H2C_SkinDrawInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_SkinDrawInfoResponse)) as H2C_SkinDrawInfoResponse;
		}
		return new H2C_SkinDrawInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			AllTimes = 0;
			DrawState = 0L;
			PositionRewards.Clear();
			Param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_SkinDrawInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_SkinDrawInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_SkinDrawInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_SkinDrawInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_SkinDrawInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbPositionReward>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbPositionReward>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_SkinDrawInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(8, value.IsFromPool, value.AllTimes, value.DrawState);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbPositionReward>>(value.PositionRewards));
		writer.WriteString(value.Param1);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_SkinDrawInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		List<PbPositionReward> value5;
		int value6;
		int value7;
		string param;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.AllTimes;
				value4 = value.DrawState;
				value5 = value.PositionRewards;
				param = value.Param1;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				param = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_01b4;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbPositionReward>(ref reader);
			param = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_SkinDrawInfoResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = null;
				param = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.AllTimes;
				value4 = value.DrawState;
				value5 = value.PositionRewards;
				param = value.Param1;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								param = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
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
				goto IL_01b4;
			}
		}
		value = new H2C_SkinDrawInfoResponse
		{
			IsFromPool = value2,
			AllTimes = value3,
			DrawState = value4,
			PositionRewards = value5,
			Param1 = param,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_01b4:
		value.IsFromPool = value2;
		value.AllTimes = value3;
		value.DrawState = value4;
		value.PositionRewards = value5;
		value.Param1 = param;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
