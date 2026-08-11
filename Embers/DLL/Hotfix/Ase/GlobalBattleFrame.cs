using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10029)]
[MemoryPackable(GenerateType.Object)]
public class GlobalBattleFrame : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<GlobalBattleFrame>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GlobalBattleFrameFormatter : MemoryPackFormatter<GlobalBattleFrame>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GlobalBattleFrame value)
		{
			GlobalBattleFrame.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GlobalBattleFrame value)
		{
			GlobalBattleFrame.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Tick { get; set; }

	[MemoryPackOrder(1)]
	public List<OneBattleFrameMessage> BattleFrames { get; set; } = new List<OneBattleFrameMessage>();

	public static GlobalBattleFrame Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GlobalBattleFrame)) as GlobalBattleFrame;
		}
		return new GlobalBattleFrame();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Tick = 0;
			BattleFrames.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GlobalBattleFrame()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GlobalBattleFrame>())
		{
			MemoryPackFormatterProvider.Register(new GlobalBattleFrameFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GlobalBattleFrame[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GlobalBattleFrame>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<OneBattleFrameMessage>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<OneBattleFrameMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GlobalBattleFrame? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(5, value.IsFromPool, value.Tick);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<OneBattleFrameMessage>>(value.BattleFrames));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GlobalBattleFrame? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<OneBattleFrameMessage> value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Tick;
				value4 = value.BattleFrames;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<OneBattleFrameMessage>(ref reader);
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GlobalBattleFrame), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Tick;
				value4 = value.BattleFrames;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0123;
			}
		}
		value = new GlobalBattleFrame
		{
			IsFromPool = value2,
			Tick = value3,
			BattleFrames = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.Tick = value3;
		value.BattleFrames = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
