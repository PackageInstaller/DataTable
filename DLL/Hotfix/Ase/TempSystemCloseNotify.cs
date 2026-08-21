using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10815)]
[MemoryPackable(GenerateType.Object)]
public class TempSystemCloseNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<TempSystemCloseNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TempSystemCloseNotifyFormatter : MemoryPackFormatter<TempSystemCloseNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TempSystemCloseNotify value)
		{
			TempSystemCloseNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TempSystemCloseNotify value)
		{
			TempSystemCloseNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<TempSystemCloseInfo> Closeinfos { get; set; } = new List<TempSystemCloseInfo>();

	public static TempSystemCloseNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TempSystemCloseNotify)) as TempSystemCloseNotify;
		}
		return new TempSystemCloseNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Closeinfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TempSystemCloseNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TempSystemCloseNotify>())
		{
			MemoryPackFormatterProvider.Register(new TempSystemCloseNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TempSystemCloseNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TempSystemCloseNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<TempSystemCloseInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<TempSystemCloseInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TempSystemCloseNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<TempSystemCloseInfo>>(value.Closeinfos));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TempSystemCloseNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<TempSystemCloseInfo> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Closeinfos;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<TempSystemCloseInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TempSystemCloseNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Closeinfos;
				value4 = value.RpcId;
				value5 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new TempSystemCloseNotify
		{
			IsFromPool = value2,
			Closeinfos = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.Closeinfos = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
