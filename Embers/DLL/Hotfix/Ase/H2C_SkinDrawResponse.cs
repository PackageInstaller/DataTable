using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10843)]
[MemoryPackable(GenerateType.Object)]
public class H2C_SkinDrawResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_SkinDrawResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_SkinDrawResponseFormatter : MemoryPackFormatter<H2C_SkinDrawResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_SkinDrawResponse value)
		{
			H2C_SkinDrawResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_SkinDrawResponse value)
		{
			H2C_SkinDrawResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(1)]
	public List<PbItemChange> ItemChange { get; set; } = new List<PbItemChange>();

	[MemoryPackOrder(2)]
	public PbLotteryDropThing dropThings { get; set; }

	[MemoryPackOrder(3)]
	public int AllTimes { get; set; }

	[MemoryPackOrder(4)]
	public int Pos { get; set; }

	[MemoryPackOrder(5)]
	public long DrawState { get; set; }

	[MemoryPackOrder(6)]
	public int RewardConfigId { get; set; }

	[MemoryPackOrder(9)]
	public string Param1 { get; set; }

	public static H2C_SkinDrawResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_SkinDrawResponse)) as H2C_SkinDrawResponse;
		}
		return new H2C_SkinDrawResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ItemChange.Clear();
			dropThings = null;
			AllTimes = 0;
			Pos = 0;
			DrawState = 0L;
			RewardConfigId = 0;
			Param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_SkinDrawResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_SkinDrawResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_SkinDrawResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_SkinDrawResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_SkinDrawResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_SkinDrawResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(11, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemChange));
		writer.WritePackable<PbLotteryDropThing>(value.dropThings);
		writer.WriteUnmanaged<int, int, long, int>(value.AllTimes, value.Pos, value.DrawState, value.RewardConfigId);
		writer.WriteString(value.Param1);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_SkinDrawResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbItemChange> value3;
		PbLotteryDropThing value4;
		int value5;
		int value6;
		long value7;
		int value8;
		int value9;
		int value10;
		string param;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ItemChange;
				value4 = value.dropThings;
				value5 = value.AllTimes;
				value6 = value.Pos;
				value7 = value.DrawState;
				value8 = value.RewardConfigId;
				param = value.Param1;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				param = reader.ReadString();
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_0248;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			value4 = reader.ReadPackable<PbLotteryDropThing>();
			reader.ReadUnmanaged<int, int, long, int>(out value5, out value6, out value7, out value8);
			param = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_SkinDrawResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				param = null;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ItemChange;
				value4 = value.dropThings;
				value5 = value.AllTimes;
				value6 = value.Pos;
				value7 = value.DrawState;
				value8 = value.RewardConfigId;
				param = value.Param1;
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
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											param = reader.ReadString();
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													if (memberCount != 10)
													{
														message = reader.ReadString();
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_0248;
			}
		}
		value = new H2C_SkinDrawResponse
		{
			IsFromPool = value2,
			ItemChange = value3,
			dropThings = value4,
			AllTimes = value5,
			Pos = value6,
			DrawState = value7,
			RewardConfigId = value8,
			Param1 = param,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_0248:
		value.IsFromPool = value2;
		value.ItemChange = value3;
		value.dropThings = value4;
		value.AllTimes = value5;
		value.Pos = value6;
		value.DrawState = value7;
		value.RewardConfigId = value8;
		value.Param1 = param;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
