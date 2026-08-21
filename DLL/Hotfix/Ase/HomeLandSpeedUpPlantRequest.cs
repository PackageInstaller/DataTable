using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10568)]
[MemoryPackable(GenerateType.Object)]
public class HomeLandSpeedUpPlantRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<HomeLandSpeedUpPlantRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HomeLandSpeedUpPlantRequestFormatter : MemoryPackFormatter<HomeLandSpeedUpPlantRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HomeLandSpeedUpPlantRequest value)
		{
			HomeLandSpeedUpPlantRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HomeLandSpeedUpPlantRequest value)
		{
			HomeLandSpeedUpPlantRequest.Deserialize(ref reader, ref value);
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
	public int GridId { get; set; }

	[MemoryPackOrder(1)]
	public int SelectItemId { get; set; }

	[MemoryPackOrder(2)]
	public int SelectItemCount { get; set; }

	public static HomeLandSpeedUpPlantRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HomeLandSpeedUpPlantRequest)) as HomeLandSpeedUpPlantRequest;
		}
		return new HomeLandSpeedUpPlantRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			GridId = 0;
			SelectItemId = 0;
			SelectItemCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HomeLandSpeedUpPlantRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HomeLandSpeedUpPlantRequest>())
		{
			MemoryPackFormatterProvider.Register(new HomeLandSpeedUpPlantRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HomeLandSpeedUpPlantRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HomeLandSpeedUpPlantRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HomeLandSpeedUpPlantRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, long, int, long>(8, value.IsFromPool, value.GridId, value.SelectItemId, value.SelectItemCount, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HomeLandSpeedUpPlantRequest? value)
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
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.GridId;
				value4 = value.SelectItemId;
				value5 = value.SelectItemCount;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_019d;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HomeLandSpeedUpPlantRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.GridId;
				value4 = value.SelectItemId;
				value5 = value.SelectItemCount;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
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
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
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
				goto IL_019d;
			}
		}
		value = new HomeLandSpeedUpPlantRequest
		{
			IsFromPool = value2,
			GridId = value3,
			SelectItemId = value4,
			SelectItemCount = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_019d:
		value.IsFromPool = value2;
		value.GridId = value3;
		value.SelectItemId = value4;
		value.SelectItemCount = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
