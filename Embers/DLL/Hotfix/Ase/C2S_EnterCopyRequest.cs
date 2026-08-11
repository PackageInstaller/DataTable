using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10096)]
[MemoryPackable(GenerateType.Object)]
public class C2S_EnterCopyRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_EnterCopyRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_EnterCopyRequestFormatter : MemoryPackFormatter<C2S_EnterCopyRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_EnterCopyRequest value)
		{
			C2S_EnterCopyRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_EnterCopyRequest value)
		{
			C2S_EnterCopyRequest.Deserialize(ref reader, ref value);
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
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int Difficulty { get; set; }

	[MemoryPackOrder(2)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public int Type { get; set; }

	[MemoryPackOrder(4)]
	public int DropType { get; set; }

	[MemoryPackOrder(3)]
	public List<int> TryRoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public List<int> BattlePropIds { get; set; } = new List<int>();

	[MemoryPackOrder(5)]
	public List<PbIdValue> PosRoleIdInfos { get; set; } = new List<PbIdValue>();

	[MemoryPackOrder(6)]
	public int RewardTimes { get; set; }

	public static C2S_EnterCopyRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_EnterCopyRequest)) as C2S_EnterCopyRequest;
		}
		return new C2S_EnterCopyRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			CopyId = 0;
			Difficulty = 0;
			RoleIds.Clear();
			Type = 0;
			DropType = 0;
			TryRoleIds.Clear();
			BattlePropIds.Clear();
			PosRoleIdInfos.Clear();
			RewardTimes = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_EnterCopyRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_EnterCopyRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2S_EnterCopyRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_EnterCopyRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_EnterCopyRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbIdValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbIdValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_EnterCopyRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(14, value.IsFromPool, value.CopyId, value.Difficulty);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<int>(value.Type);
		writer.WriteValue<List<int>>(value.TryRoleIds);
		writer.WriteUnmanaged<int>(value.DropType);
		writer.WriteValue<List<int>>(value.BattlePropIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbIdValue>>(value.PosRoleIdInfos));
		writer.WriteUnmanaged<int, int, long, int, long>(value.RewardTimes, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_EnterCopyRequest? value)
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
		List<int> value7;
		int value8;
		List<int> value9;
		List<PbIdValue> value10;
		int value11;
		int value12;
		long value13;
		int value14;
		long value15;
		if (memberCount == 14)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.RoleIds;
				value6 = value.Type;
				value7 = value.TryRoleIds;
				value8 = value.DropType;
				value9 = value.BattlePropIds;
				value10 = value.PosRoleIdInfos;
				value11 = value.RewardTimes;
				value12 = value.LoginServerId;
				value13 = value.LoginSecretKey;
				value14 = value.RpcId;
				value15 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadValue(ref value9);
				ListFormatter.DeserializePackable(ref reader, ref value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				reader.ReadUnmanaged<long>(out value13);
				reader.ReadUnmanaged<int>(out value14);
				reader.ReadUnmanaged<long>(out value15);
				goto IL_02de;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int>(out value6);
			value7 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int>(out value8);
			value9 = reader.ReadValue<List<int>>();
			value10 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
			reader.ReadUnmanaged<int, int, long, int, long>(out value11, out value12, out value13, out value14, out value15);
		}
		else
		{
			if (memberCount > 14)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_EnterCopyRequest), 14, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = null;
				value10 = null;
				value11 = 0;
				value12 = 0;
				value13 = 0L;
				value14 = 0;
				value15 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.RoleIds;
				value6 = value.Type;
				value7 = value.TryRoleIds;
				value8 = value.DropType;
				value9 = value.BattlePropIds;
				value10 = value.PosRoleIdInfos;
				value11 = value.RewardTimes;
				value12 = value.LoginServerId;
				value13 = value.LoginSecretKey;
				value14 = value.RpcId;
				value15 = value.ActorId;
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
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadValue(ref value9);
											if (memberCount != 8)
											{
												ListFormatter.DeserializePackable(ref reader, ref value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<long>(out value13);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<int>(out value14);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<long>(out value15);
																	_ = 14;
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
				}
			}
			if (value != null)
			{
				goto IL_02de;
			}
		}
		value = new C2S_EnterCopyRequest
		{
			IsFromPool = value2,
			CopyId = value3,
			Difficulty = value4,
			RoleIds = value5,
			Type = value6,
			TryRoleIds = value7,
			DropType = value8,
			BattlePropIds = value9,
			PosRoleIdInfos = value10,
			RewardTimes = value11,
			LoginServerId = value12,
			LoginSecretKey = value13,
			RpcId = value14,
			ActorId = value15
		};
		return;
		IL_02de:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Difficulty = value4;
		value.RoleIds = value5;
		value.Type = value6;
		value.TryRoleIds = value7;
		value.DropType = value8;
		value.BattlePropIds = value9;
		value.PosRoleIdInfos = value10;
		value.RewardTimes = value11;
		value.LoginServerId = value12;
		value.LoginSecretKey = value13;
		value.RpcId = value14;
		value.ActorId = value15;
	}
}
