using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1021)]
[MemoryPackable(GenerateType.Object)]
public class G2M_SessionDisconnect : MessageObject, IActorLocationMessage, IActorRequest, IRequest, IMessage, IMemoryPackable<G2M_SessionDisconnect>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2M_SessionDisconnectFormatter : MemoryPackFormatter<G2M_SessionDisconnect>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2M_SessionDisconnect value)
		{
			G2M_SessionDisconnect.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2M_SessionDisconnect value)
		{
			G2M_SessionDisconnect.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(93)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int serverTyp { get; set; }

	public static G2M_SessionDisconnect Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2M_SessionDisconnect)) as G2M_SessionDisconnect;
		}
		return new G2M_SessionDisconnect();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			serverTyp = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2M_SessionDisconnect()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2M_SessionDisconnect>())
		{
			MemoryPackFormatterProvider.Register(new G2M_SessionDisconnectFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2M_SessionDisconnect[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2M_SessionDisconnect>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2M_SessionDisconnect? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.serverTyp, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2M_SessionDisconnect? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.serverTyp;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2M_SessionDisconnect), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.serverTyp;
				value4 = value.RpcId;
				value5 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new G2M_SessionDisconnect
		{
			IsFromPool = value2,
			serverTyp = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.serverTyp = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
