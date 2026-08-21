using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10319)]
[MemoryPackable(GenerateType.Object)]
public class ShopRefreshNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ShopRefreshNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ShopRefreshNotifyFormatter : MemoryPackFormatter<ShopRefreshNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ShopRefreshNotify value)
		{
			ShopRefreshNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ShopRefreshNotify value)
		{
			ShopRefreshNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public List<PbShopInfo> ShopInfos { get; set; } = new List<PbShopInfo>();

	public static ShopRefreshNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ShopRefreshNotify)) as ShopRefreshNotify;
		}
		return new ShopRefreshNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Type = 0;
			ShopInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ShopRefreshNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ShopRefreshNotify>())
		{
			MemoryPackFormatterProvider.Register(new ShopRefreshNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ShopRefreshNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ShopRefreshNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbShopInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbShopInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ShopRefreshNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(5, value.IsFromPool, value.Type);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbShopInfo>>(value.ShopInfos));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ShopRefreshNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbShopInfo> value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.ShopInfos;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbShopInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ShopRefreshNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.ShopInfos;
				value5 = value.RpcId;
				value6 = value.ActorId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0123;
			}
		}
		value = new ShopRefreshNotify
		{
			IsFromPool = value2,
			Type = value3,
			ShopInfos = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.Type = value3;
		value.ShopInfos = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
