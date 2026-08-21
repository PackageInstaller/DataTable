using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1121)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetRankListRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerGetRankListRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetRankListRequestFormatter : MemoryPackFormatter<InnerGetRankListRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetRankListRequest value)
		{
			InnerGetRankListRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetRankListRequest value)
		{
			InnerGetRankListRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int SubType { get; set; }

	[MemoryPackOrder(2)]
	public int SeasonId { get; set; }

	public static InnerGetRankListRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetRankListRequest)) as InnerGetRankListRequest;
		}
		return new InnerGetRankListRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Type = 0;
			SubType = 0;
			SeasonId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetRankListRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetRankListRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetRankListRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetRankListRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetRankListRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetRankListRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, long>(6, value.IsFromPool, value.Type, value.SubType, value.SeasonId, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetRankListRequest? value)
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
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.SubType;
				value5 = value.SeasonId;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0146;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetRankListRequest), 6, memberCount);
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
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.SubType;
				value5 = value.SeasonId;
				value6 = value.RpcId;
				value7 = value.UserId;
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
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0146;
			}
		}
		value = new InnerGetRankListRequest
		{
			IsFromPool = value2,
			Type = value3,
			SubType = value4,
			SeasonId = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_0146:
		value.IsFromPool = value2;
		value.Type = value3;
		value.SubType = value4;
		value.SeasonId = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
