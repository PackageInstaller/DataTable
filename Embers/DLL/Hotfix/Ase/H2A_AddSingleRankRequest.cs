using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1059)]
[MemoryPackable(GenerateType.Object)]
public class H2A_AddSingleRankRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2A_AddSingleRankRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2A_AddSingleRankRequestFormatter : MemoryPackFormatter<H2A_AddSingleRankRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2A_AddSingleRankRequest value)
		{
			H2A_AddSingleRankRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2A_AddSingleRankRequest value)
		{
			H2A_AddSingleRankRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	[MemoryPackOrder(2)]
	public string UserName { get; set; }

	[MemoryPackOrder(3)]
	public int CopyId { get; set; }

	[MemoryPackOrder(4)]
	public int PassTime { get; set; }

	[MemoryPackOrder(5)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(6)]
	public int FightTime { get; set; }

	public static H2A_AddSingleRankRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2A_AddSingleRankRequest)) as H2A_AddSingleRankRequest;
		}
		return new H2A_AddSingleRankRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UserName = null;
			CopyId = 0;
			PassTime = 0;
			RoleIds.Clear();
			FightTime = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2A_AddSingleRankRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2A_AddSingleRankRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2A_AddSingleRankRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2A_AddSingleRankRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2A_AddSingleRankRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2A_AddSingleRankRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(8, value.IsFromPool, value.UserId);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int>(value.CopyId, value.PassTime);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<int, int>(value.FightTime, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2A_AddSingleRankRequest? value)
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
		List<int> value6;
		int value7;
		int value8;
		string userName;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.CopyId;
				value5 = value.PassTime;
				value6 = value.RoleIds;
				value7 = value.FightTime;
				value8 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_01b1;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2A_AddSingleRankRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				userName = null;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.CopyId;
				value5 = value.PassTime;
				value6 = value.RoleIds;
				value7 = value.FightTime;
				value8 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						userName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
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
				goto IL_01b1;
			}
		}
		value = new H2A_AddSingleRankRequest
		{
			IsFromPool = value2,
			UserId = value3,
			UserName = userName,
			CopyId = value4,
			PassTime = value5,
			RoleIds = value6,
			FightTime = value7,
			RpcId = value8
		};
		return;
		IL_01b1:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserName = userName;
		value.CopyId = value4;
		value.PassTime = value5;
		value.RoleIds = value6;
		value.FightTime = value7;
		value.RpcId = value8;
	}
}
