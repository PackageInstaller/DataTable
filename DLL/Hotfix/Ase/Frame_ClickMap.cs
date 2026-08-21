using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5009)]
[MemoryPackable(GenerateType.Object)]
public class Frame_ClickMap : MessageObject, IActorLocationMessage, IActorRequest, IRequest, IMessage, IMemoryPackable<Frame_ClickMap>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class Frame_ClickMapFormatter : MemoryPackFormatter<Frame_ClickMap>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref Frame_ClickMap value)
		{
			Frame_ClickMap.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref Frame_ClickMap value)
		{
			Frame_ClickMap.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(93)]
	public long Id { get; set; }

	[MemoryPackOrder(0)]
	public float X { get; set; }

	[MemoryPackOrder(1)]
	public float Y { get; set; }

	[MemoryPackOrder(2)]
	public float Z { get; set; }

	public static Frame_ClickMap Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(Frame_ClickMap)) as Frame_ClickMap;
		}
		return new Frame_ClickMap();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Id = 0L;
			X = 0f;
			Y = 0f;
			Z = 0f;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static Frame_ClickMap()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<Frame_ClickMap>())
		{
			MemoryPackFormatterProvider.Register(new Frame_ClickMapFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<Frame_ClickMap[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<Frame_ClickMap>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref Frame_ClickMap? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, float, float, float, int, long, long>(7, value.IsFromPool, value.X, value.Y, value.Z, value.RpcId, value.ActorId, value.Id);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref Frame_ClickMap? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		float value3;
		float value4;
		float value5;
		int value6;
		long value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.X;
				value4 = value.Y;
				value5 = value.Z;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.Id;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<float>(out value3);
				reader.ReadUnmanaged<float>(out value4);
				reader.ReadUnmanaged<float>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool, float, float, float, int, long, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(Frame_ClickMap), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0f;
				value4 = 0f;
				value5 = 0f;
				value6 = 0;
				value7 = 0L;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.X;
				value4 = value.Y;
				value5 = value.Z;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.Id;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<float>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<float>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<float>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_017e;
			}
		}
		value = new Frame_ClickMap
		{
			IsFromPool = value2,
			X = value3,
			Y = value4,
			Z = value5,
			RpcId = value6,
			ActorId = value7,
			Id = value8
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.X = value3;
		value.Y = value4;
		value.Z = value5;
		value.RpcId = value6;
		value.ActorId = value7;
		value.Id = value8;
	}
}
