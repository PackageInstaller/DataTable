using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10846)]
[MemoryPackable(GenerateType.Object)]
public class C2H_SetRaceCopyTroopRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_SetRaceCopyTroopRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_SetRaceCopyTroopRequestFormatter : MemoryPackFormatter<C2H_SetRaceCopyTroopRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_SetRaceCopyTroopRequest value)
		{
			C2H_SetRaceCopyTroopRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_SetRaceCopyTroopRequest value)
		{
			C2H_SetRaceCopyTroopRequest.Deserialize(ref reader, ref value);
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
	public int TypeId { get; set; }

	[MemoryPackOrder(1)]
	public int TroopId { get; set; }

	[MemoryPackOrder(2)]
	public string TroopName { get; set; }

	[MemoryPackOrder(3)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public int BuffId { get; set; }

	[MemoryPackOrder(5)]
	public bool Block { get; set; }

	[MemoryPackOrder(9)]
	public string param1 { get; set; }

	public static C2H_SetRaceCopyTroopRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_SetRaceCopyTroopRequest)) as C2H_SetRaceCopyTroopRequest;
		}
		return new C2H_SetRaceCopyTroopRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			TypeId = 0;
			TroopId = 0;
			TroopName = null;
			RoleIds.Clear();
			BuffId = 0;
			Block = false;
			param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_SetRaceCopyTroopRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_SetRaceCopyTroopRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_SetRaceCopyTroopRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_SetRaceCopyTroopRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_SetRaceCopyTroopRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_SetRaceCopyTroopRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(12, value.IsFromPool, value.TypeId, value.TroopId);
		writer.WriteString(value.TroopName);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<int, bool>(value.BuffId, value.Block);
		writer.WriteString(value.param1);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_SetRaceCopyTroopRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<int> value5;
		int value6;
		bool value7;
		int value8;
		long value9;
		int value10;
		long value11;
		string troopName;
		string text;
		if (memberCount == 12)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TypeId;
				value4 = value.TroopId;
				troopName = value.TroopName;
				value5 = value.RoleIds;
				value6 = value.BuffId;
				value7 = value.Block;
				text = value.param1;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				troopName = reader.ReadString();
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<bool>(out value7);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0274;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			troopName = reader.ReadString();
			value5 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, bool>(out value6, out value7);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 12)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_SetRaceCopyTroopRequest), 12, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				troopName = null;
				value5 = null;
				value6 = 0;
				value7 = false;
				text = null;
				value8 = 0;
				value9 = 0L;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TypeId;
				value4 = value.TroopId;
				troopName = value.TroopName;
				value5 = value.RoleIds;
				value6 = value.BuffId;
				value7 = value.Block;
				text = value.param1;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
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
							troopName = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadValue(ref value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<bool>(out value7);
										if (memberCount != 7)
										{
											text = reader.ReadString();
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value8);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value9);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value10);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<long>(out value11);
															_ = 12;
														}
													}
												}
											}
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
				goto IL_0274;
			}
		}
		value = new C2H_SetRaceCopyTroopRequest
		{
			IsFromPool = value2,
			TypeId = value3,
			TroopId = value4,
			TroopName = troopName,
			RoleIds = value5,
			BuffId = value6,
			Block = value7,
			param1 = text,
			LoginServerId = value8,
			LoginSecretKey = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_0274:
		value.IsFromPool = value2;
		value.TypeId = value3;
		value.TroopId = value4;
		value.TroopName = troopName;
		value.RoleIds = value5;
		value.BuffId = value6;
		value.Block = value7;
		value.param1 = text;
		value.LoginServerId = value8;
		value.LoginSecretKey = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}
