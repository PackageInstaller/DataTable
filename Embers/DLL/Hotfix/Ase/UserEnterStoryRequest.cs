using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10312)]
[MemoryPackable(GenerateType.Object)]
public class UserEnterStoryRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<UserEnterStoryRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserEnterStoryRequestFormatter : MemoryPackFormatter<UserEnterStoryRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserEnterStoryRequest value)
		{
			UserEnterStoryRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserEnterStoryRequest value)
		{
			UserEnterStoryRequest.Deserialize(ref reader, ref value);
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
	public int State { get; set; }

	[MemoryPackOrder(1)]
	public int MapId { get; set; }

	[MemoryPackOrder(2)]
	public List<PbItem> SelectedBattleProps { get; set; } = new List<PbItem>();

	public static UserEnterStoryRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserEnterStoryRequest)) as UserEnterStoryRequest;
		}
		return new UserEnterStoryRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			State = 0;
			MapId = 0;
			SelectedBattleProps.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserEnterStoryRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserEnterStoryRequest>())
		{
			MemoryPackFormatterProvider.Register(new UserEnterStoryRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserEnterStoryRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserEnterStoryRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserEnterStoryRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(8, value.IsFromPool, value.State, value.MapId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItem>>(value.SelectedBattleProps));
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserEnterStoryRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<PbItem> value5;
		int value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.State;
				value4 = value.MapId;
				value5 = value.SelectedBattleProps;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbItem>(ref reader);
			reader.ReadUnmanaged<int, long, int, long>(out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserEnterStoryRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.State;
				value4 = value.MapId;
				value5 = value.SelectedBattleProps;
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
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
				goto IL_01a9;
			}
		}
		value = new UserEnterStoryRequest
		{
			IsFromPool = value2,
			State = value3,
			MapId = value4,
			SelectedBattleProps = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.State = value3;
		value.MapId = value4;
		value.SelectedBattleProps = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
