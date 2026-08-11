using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10125)]
[MemoryPackable(GenerateType.Object)]
public class SendTaskCompleteStateRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<SendTaskCompleteStateRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SendTaskCompleteStateRequestFormatter : MemoryPackFormatter<SendTaskCompleteStateRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SendTaskCompleteStateRequest value)
		{
			SendTaskCompleteStateRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SendTaskCompleteStateRequest value)
		{
			SendTaskCompleteStateRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public int Count { get; set; }

	[MemoryPackOrder(2)]
	public int LevelId { get; set; }

	[MemoryPackOrder(3)]
	public int TaskType { get; set; }

	[MemoryPackOrder(4)]
	public List<string> IndexSaveData { get; set; } = new List<string>();

	public static SendTaskCompleteStateRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SendTaskCompleteStateRequest)) as SendTaskCompleteStateRequest;
		}
		return new SendTaskCompleteStateRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			TaskId = 0;
			Count = 0;
			LevelId = 0;
			TaskType = 0;
			IndexSaveData.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SendTaskCompleteStateRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SendTaskCompleteStateRequest>())
		{
			MemoryPackFormatterProvider.Register(new SendTaskCompleteStateRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SendTaskCompleteStateRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SendTaskCompleteStateRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SendTaskCompleteStateRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(10, value.IsFromPool, value.TaskId, value.Count, value.LevelId, value.TaskType);
		writer.WriteValue<List<string>>(value.IndexSaveData);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SendTaskCompleteStateRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		int value6;
		List<string> value7;
		int value8;
		long value9;
		int value10;
		long value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Count;
				value5 = value.LevelId;
				value6 = value.TaskType;
				value7 = value.IndexSaveData;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0204;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			value7 = reader.ReadValue<List<string>>();
			reader.ReadUnmanaged<int, long, int, long>(out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SendTaskCompleteStateRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = 0L;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Count;
				value5 = value.LevelId;
				value6 = value.TaskType;
				value7 = value.IndexSaveData;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value11);
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
				goto IL_0204;
			}
		}
		value = new SendTaskCompleteStateRequest
		{
			IsFromPool = value2,
			TaskId = value3,
			Count = value4,
			LevelId = value5,
			TaskType = value6,
			IndexSaveData = value7,
			LoginServerId = value8,
			LoginSecretKey = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_0204:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.Count = value4;
		value.LevelId = value5;
		value.TaskType = value6;
		value.IndexSaveData = value7;
		value.LoginServerId = value8;
		value.LoginSecretKey = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}
