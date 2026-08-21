using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10883)]
[MemoryPackable(GenerateType.Object)]
public class C2SSetRoguelikeTeamRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2SSetRoguelikeTeamRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2SSetRoguelikeTeamRequestFormatter : MemoryPackFormatter<C2SSetRoguelikeTeamRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2SSetRoguelikeTeamRequest value)
		{
			C2SSetRoguelikeTeamRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2SSetRoguelikeTeamRequest value)
		{
			C2SSetRoguelikeTeamRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int TeamSetId { get; set; }

	[MemoryPackOrder(1)]
	public List<int> BattlePropIds { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public int RoleId { get; set; }

	public static C2SSetRoguelikeTeamRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2SSetRoguelikeTeamRequest)) as C2SSetRoguelikeTeamRequest;
		}
		return new C2SSetRoguelikeTeamRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			TeamSetId = 0;
			BattlePropIds.Clear();
			RoleId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2SSetRoguelikeTeamRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2SSetRoguelikeTeamRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2SSetRoguelikeTeamRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2SSetRoguelikeTeamRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2SSetRoguelikeTeamRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2SSetRoguelikeTeamRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(8, value.IsFromPool, value.TeamSetId);
		writer.WriteValue<List<int>>(value.BattlePropIds);
		writer.WriteUnmanaged<int, int, long, int, long>(value.RoleId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2SSetRoguelikeTeamRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<int> value4;
		int value5;
		int value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TeamSetId;
				value4 = value.BattlePropIds;
				value5 = value.RoleId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01a8;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, long, int, long>(out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2SSetRoguelikeTeamRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TeamSetId;
				value4 = value.BattlePropIds;
				value5 = value.RoleId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
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
				goto IL_01a8;
			}
		}
		value = new C2SSetRoguelikeTeamRequest
		{
			IsFromPool = value2,
			TeamSetId = value3,
			BattlePropIds = value4,
			RoleId = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01a8:
		value.IsFromPool = value2;
		value.TeamSetId = value3;
		value.BattlePropIds = value4;
		value.RoleId = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
