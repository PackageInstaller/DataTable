using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10094)]
[MemoryPackable(GenerateType.Object)]
public class C2S_UnlockCopyCrossRewardRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_UnlockCopyCrossRewardRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_UnlockCopyCrossRewardRequestFormatter : MemoryPackFormatter<C2S_UnlockCopyCrossRewardRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_UnlockCopyCrossRewardRequest value)
		{
			C2S_UnlockCopyCrossRewardRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_UnlockCopyCrossRewardRequest value)
		{
			C2S_UnlockCopyCrossRewardRequest.Deserialize(ref reader, ref value);
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
	public int CheckCode { get; set; }

	public static C2S_UnlockCopyCrossRewardRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_UnlockCopyCrossRewardRequest)) as C2S_UnlockCopyCrossRewardRequest;
		}
		return new C2S_UnlockCopyCrossRewardRequest();
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
			CheckCode = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_UnlockCopyCrossRewardRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_UnlockCopyCrossRewardRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2S_UnlockCopyCrossRewardRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_UnlockCopyCrossRewardRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_UnlockCopyCrossRewardRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_UnlockCopyCrossRewardRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(9, value.IsFromPool, value.CopyId, value.Difficulty);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<int, int, long, int, long>(value.CheckCode, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_UnlockCopyCrossRewardRequest? value)
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
		int value7;
		long value8;
		int value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.RoleIds;
				value6 = value.CheckCode;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01d8;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, long, int, long>(out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_UnlockCopyCrossRewardRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.RoleIds;
				value6 = value.CheckCode;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												_ = 9;
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
				goto IL_01d8;
			}
		}
		value = new C2S_UnlockCopyCrossRewardRequest
		{
			IsFromPool = value2,
			CopyId = value3,
			Difficulty = value4,
			RoleIds = value5,
			CheckCode = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01d8:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Difficulty = value4;
		value.RoleIds = value5;
		value.CheckCode = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
