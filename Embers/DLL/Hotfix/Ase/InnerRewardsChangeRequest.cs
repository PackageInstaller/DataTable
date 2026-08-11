using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10153)]
[MemoryPackable(GenerateType.Object)]
public class InnerRewardsChangeRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerRewardsChangeRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerRewardsChangeRequestFormatter : MemoryPackFormatter<InnerRewardsChangeRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerRewardsChangeRequest value)
		{
			InnerRewardsChangeRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerRewardsChangeRequest value)
		{
			InnerRewardsChangeRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public List<PbItemBase> Rewards { get; set; } = new List<PbItemBase>();

	[MemoryPackOrder(3)]
	public int CopyId { get; set; }

	[MemoryPackOrder(4)]
	public int Difficult { get; set; }

	[MemoryPackOrder(5)]
	public int Star { get; set; }

	public static InnerRewardsChangeRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerRewardsChangeRequest)) as InnerRewardsChangeRequest;
		}
		return new InnerRewardsChangeRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			RoleIds.Clear();
			Rewards.Clear();
			CopyId = 0;
			Difficult = 0;
			Star = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerRewardsChangeRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRewardsChangeRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerRewardsChangeRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRewardsChangeRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerRewardsChangeRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerRewardsChangeRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(8, value.IsFromPool, value.UserId);
		writer.WriteValue<List<int>>(value.RoleIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemBase>>(value.Rewards));
		writer.WriteUnmanaged<int, int, int, int>(value.CopyId, value.Difficult, value.Star, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerRewardsChangeRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<int> value4;
		List<PbItemBase> value5;
		int value6;
		int value7;
		int value8;
		int value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoleIds;
				value5 = value.Rewards;
				value6 = value.CopyId;
				value7 = value.Difficult;
				value8 = value.Star;
				value9 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadValue(ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				goto IL_01ad;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadValue<List<int>>();
			value5 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
			reader.ReadUnmanaged<int, int, int, int>(out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerRewardsChangeRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoleIds;
				value5 = value.Rewards;
				value6 = value.CopyId;
				value7 = value.Difficult;
				value8 = value.Star;
				value9 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
											reader.ReadUnmanaged<int>(out value9);
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
				goto IL_01ad;
			}
		}
		value = new InnerRewardsChangeRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoleIds = value4,
			Rewards = value5,
			CopyId = value6,
			Difficult = value7,
			Star = value8,
			RpcId = value9
		};
		return;
		IL_01ad:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoleIds = value4;
		value.Rewards = value5;
		value.CopyId = value6;
		value.Difficult = value7;
		value.Star = value8;
		value.RpcId = value9;
	}
}
