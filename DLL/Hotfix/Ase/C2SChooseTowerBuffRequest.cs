using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10881)]
[MemoryPackable(GenerateType.Object)]
public class C2SChooseTowerBuffRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2SChooseTowerBuffRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2SChooseTowerBuffRequestFormatter : MemoryPackFormatter<C2SChooseTowerBuffRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2SChooseTowerBuffRequest value)
		{
			C2SChooseTowerBuffRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2SChooseTowerBuffRequest value)
		{
			C2SChooseTowerBuffRequest.Deserialize(ref reader, ref value);
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
	public int RefreshTimes { get; set; }

	[MemoryPackOrder(1)]
	public List<int> RoguelikeBuffId { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public int EndlessLayer { get; set; }

	public static C2SChooseTowerBuffRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2SChooseTowerBuffRequest)) as C2SChooseTowerBuffRequest;
		}
		return new C2SChooseTowerBuffRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			RefreshTimes = 0;
			RoguelikeBuffId.Clear();
			EndlessLayer = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2SChooseTowerBuffRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2SChooseTowerBuffRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2SChooseTowerBuffRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2SChooseTowerBuffRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2SChooseTowerBuffRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2SChooseTowerBuffRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(8, value.IsFromPool, value.RefreshTimes);
		writer.WriteValue<List<int>>(value.RoguelikeBuffId);
		writer.WriteUnmanaged<int, int, long, int, long>(value.EndlessLayer, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2SChooseTowerBuffRequest? value)
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
				value3 = value.RefreshTimes;
				value4 = value.RoguelikeBuffId;
				value5 = value.EndlessLayer;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2SChooseTowerBuffRequest), 8, memberCount);
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
				value3 = value.RefreshTimes;
				value4 = value.RoguelikeBuffId;
				value5 = value.EndlessLayer;
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
		value = new C2SChooseTowerBuffRequest
		{
			IsFromPool = value2,
			RefreshTimes = value3,
			RoguelikeBuffId = value4,
			EndlessLayer = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01a8:
		value.IsFromPool = value2;
		value.RefreshTimes = value3;
		value.RoguelikeBuffId = value4;
		value.EndlessLayer = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
