using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10503)]
[MemoryPackable(GenerateType.Object)]
public class ClientCatchUpFrameNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ClientCatchUpFrameNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ClientCatchUpFrameNotifyFormatter : MemoryPackFormatter<ClientCatchUpFrameNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ClientCatchUpFrameNotify value)
		{
			ClientCatchUpFrameNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ClientCatchUpFrameNotify value)
		{
			ClientCatchUpFrameNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<GlobalBattleFrame> ClientFrames { get; set; } = new List<GlobalBattleFrame>();

	public static ClientCatchUpFrameNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ClientCatchUpFrameNotify)) as ClientCatchUpFrameNotify;
		}
		return new ClientCatchUpFrameNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			ClientFrames.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ClientCatchUpFrameNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ClientCatchUpFrameNotify>())
		{
			MemoryPackFormatterProvider.Register(new ClientCatchUpFrameNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ClientCatchUpFrameNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ClientCatchUpFrameNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<GlobalBattleFrame>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<GlobalBattleFrame>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ClientCatchUpFrameNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<GlobalBattleFrame>>(value.ClientFrames));
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ClientCatchUpFrameNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<GlobalBattleFrame> value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ClientFrames;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00ca;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<GlobalBattleFrame>(ref reader);
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ClientCatchUpFrameNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ClientFrames;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00ca;
			}
		}
		value = new ClientCatchUpFrameNotify
		{
			IsFromPool = value2,
			ClientFrames = value3,
			ActorId = value4
		};
		return;
		IL_00ca:
		value.IsFromPool = value2;
		value.ClientFrames = value3;
		value.ActorId = value4;
	}
}
