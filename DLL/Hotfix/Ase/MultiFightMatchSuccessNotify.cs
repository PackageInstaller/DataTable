using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10452)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightMatchSuccessNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightMatchSuccessNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightMatchSuccessNotifyFormatter : MemoryPackFormatter<MultiFightMatchSuccessNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightMatchSuccessNotify value)
		{
			MultiFightMatchSuccessNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightMatchSuccessNotify value)
		{
			MultiFightMatchSuccessNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbMatchResultUserInfo> UserInfos { get; set; } = new List<PbMatchResultUserInfo>();

	public static MultiFightMatchSuccessNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightMatchSuccessNotify)) as MultiFightMatchSuccessNotify;
		}
		return new MultiFightMatchSuccessNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightMatchSuccessNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightMatchSuccessNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightMatchSuccessNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightMatchSuccessNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightMatchSuccessNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMatchResultUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMatchResultUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightMatchSuccessNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMatchResultUserInfo>>(value.UserInfos));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightMatchSuccessNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbMatchResultUserInfo> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfos;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbMatchResultUserInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightMatchSuccessNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfos;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new MultiFightMatchSuccessNotify
		{
			IsFromPool = value2,
			UserInfos = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.UserInfos = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
