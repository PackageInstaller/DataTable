using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10085)]
[MemoryPackable(GenerateType.Object)]
public class H2C_LotteryDrawResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_LotteryDrawResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_LotteryDrawResponseFormatter : MemoryPackFormatter<H2C_LotteryDrawResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_LotteryDrawResponse value)
		{
			H2C_LotteryDrawResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_LotteryDrawResponse value)
		{
			H2C_LotteryDrawResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbLotteryResult> Result { get; set; } = new List<PbLotteryResult>();

	[MemoryPackOrder(1)]
	public List<PbItemChange> ItemChange { get; set; } = new List<PbItemChange>();

	[MemoryPackOrder(2)]
	public PbLotteryDropThing dropThings { get; set; }

	[MemoryPackOrder(3)]
	public int DailyLotteryCount { get; set; }

	[MemoryPackOrder(4)]
	public int TotalLotteryCount { get; set; }

	[MemoryPackOrder(5)]
	public int UpTriggerCount { get; set; }

	public static H2C_LotteryDrawResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_LotteryDrawResponse)) as H2C_LotteryDrawResponse;
		}
		return new H2C_LotteryDrawResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Result.Clear();
			ItemChange.Clear();
			dropThings = null;
			DailyLotteryCount = 0;
			TotalLotteryCount = 0;
			UpTriggerCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_LotteryDrawResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_LotteryDrawResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_LotteryDrawResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_LotteryDrawResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_LotteryDrawResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbLotteryResult>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbLotteryResult>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_LotteryDrawResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbLotteryResult>>(value.Result));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemChange));
		writer.WritePackable<PbLotteryDropThing>(value.dropThings);
		writer.WriteUnmanaged<int, int, int, int, int>(value.DailyLotteryCount, value.TotalLotteryCount, value.UpTriggerCount, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_LotteryDrawResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbLotteryResult> value3;
		List<PbItemChange> value4;
		PbLotteryDropThing value5;
		int value6;
		int value7;
		int value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Result;
				value4 = value.ItemChange;
				value5 = value.dropThings;
				value6 = value.DailyLotteryCount;
				value7 = value.TotalLotteryCount;
				value8 = value.UpTriggerCount;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_0212;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbLotteryResult>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			value5 = reader.ReadPackable<PbLotteryDropThing>();
			reader.ReadUnmanaged<int, int, int, int, int>(out value6, out value7, out value8, out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_LotteryDrawResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Result;
				value4 = value.ItemChange;
				value5 = value.dropThings;
				value6 = value.DailyLotteryCount;
				value7 = value.TotalLotteryCount;
				value8 = value.UpTriggerCount;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
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
				goto IL_0212;
			}
		}
		value = new H2C_LotteryDrawResponse
		{
			IsFromPool = value2,
			Result = value3,
			ItemChange = value4,
			dropThings = value5,
			DailyLotteryCount = value6,
			TotalLotteryCount = value7,
			UpTriggerCount = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_0212:
		value.IsFromPool = value2;
		value.Result = value3;
		value.ItemChange = value4;
		value.dropThings = value5;
		value.DailyLotteryCount = value6;
		value.TotalLotteryCount = value7;
		value.UpTriggerCount = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
