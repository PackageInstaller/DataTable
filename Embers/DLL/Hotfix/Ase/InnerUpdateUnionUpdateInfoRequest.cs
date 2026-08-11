using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1094)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateUnionUpdateInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpdateUnionUpdateInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateUnionUpdateInfoRequestFormatter : MemoryPackFormatter<InnerUpdateUnionUpdateInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateUnionUpdateInfoRequest value)
		{
			InnerUpdateUnionUpdateInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateUnionUpdateInfoRequest value)
		{
			InnerUpdateUnionUpdateInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public int FundChange { get; set; }

	[MemoryPackOrder(2)]
	public int ActivePointChange { get; set; }

	[MemoryPackOrder(3)]
	public int UserTotalActivePoint { get; set; }

	[MemoryPackOrder(4)]
	public int UserWeeklyActivePoint { get; set; }

	public static InnerUpdateUnionUpdateInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateUnionUpdateInfoRequest)) as InnerUpdateUnionUpdateInfoRequest;
		}
		return new InnerUpdateUnionUpdateInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			FundChange = 0;
			ActivePointChange = 0;
			UserTotalActivePoint = 0;
			UserWeeklyActivePoint = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateUnionUpdateInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateUnionUpdateInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateUnionUpdateInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateUnionUpdateInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateUnionUpdateInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateUnionUpdateInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, int, int, long>(8, value.IsFromPool, value.UnionId, value.FundChange, value.ActivePointChange, value.UserTotalActivePoint, value.UserWeeklyActivePoint, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateUnionUpdateInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		int value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.FundChange;
				value5 = value.ActivePointChange;
				value6 = value.UserTotalActivePoint;
				value7 = value.UserWeeklyActivePoint;
				value8 = value.RpcId;
				value9 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_019d;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateUnionUpdateInfoRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.FundChange;
				value5 = value.ActivePointChange;
				value6 = value.UserTotalActivePoint;
				value7 = value.UserWeeklyActivePoint;
				value8 = value.RpcId;
				value9 = value.UserId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
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
		value = new InnerUpdateUnionUpdateInfoRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			FundChange = value4,
			ActivePointChange = value5,
			UserTotalActivePoint = value6,
			UserWeeklyActivePoint = value7,
			RpcId = value8,
			UserId = value9
		};
		return;
		IL_019d:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.FundChange = value4;
		value.ActivePointChange = value5;
		value.UserTotalActivePoint = value6;
		value.UserWeeklyActivePoint = value7;
		value.RpcId = value8;
		value.UserId = value9;
	}
}
