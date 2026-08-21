using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1051)]
[MemoryPackable(GenerateType.Object)]
public class GMSetDataRequest : MessageObject, IRequest, IMessage, IMemoryPackable<GMSetDataRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GMSetDataRequestFormatter : MemoryPackFormatter<GMSetDataRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GMSetDataRequest value)
		{
			GMSetDataRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GMSetDataRequest value)
		{
			GMSetDataRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	[MemoryPackOrder(2)]
	public int Type { get; set; }

	[MemoryPackOrder(3)]
	public string Value { get; set; }

	public static GMSetDataRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GMSetDataRequest)) as GMSetDataRequest;
		}
		return new GMSetDataRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Type = 0;
			Value = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GMSetDataRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GMSetDataRequest>())
		{
			MemoryPackFormatterProvider.Register(new GMSetDataRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GMSetDataRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GMSetDataRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GMSetDataRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(6, value.IsFromPool, value.UserId, value.Type);
		writer.WriteString(value.Value);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GMSetDataRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value6;
		long value7;
		string value5;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Type;
				value5 = value.Value;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				value5 = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0153;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			value5 = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GMSetDataRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Type;
				value5 = value.Value;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							value5 = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0153;
			}
		}
		value = new GMSetDataRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Type = value4,
			Value = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0153:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Type = value4;
		value.Value = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
