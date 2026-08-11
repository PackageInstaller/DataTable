using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10831)]
[MemoryPackable(GenerateType.Object)]
public class ProtoDefaultNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ProtoDefaultNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ProtoDefaultNotifyFormatter : MemoryPackFormatter<ProtoDefaultNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ProtoDefaultNotify value)
		{
			ProtoDefaultNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ProtoDefaultNotify value)
		{
			ProtoDefaultNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<int> SpareIdInts { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<string> SpareStrings { get; set; } = new List<string>();

	[MemoryPackOrder(2)]
	public List<PbDropThing> Things { get; set; } = new List<PbDropThing>();

	public static ProtoDefaultNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ProtoDefaultNotify)) as ProtoDefaultNotify;
		}
		return new ProtoDefaultNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			SpareIdInts.Clear();
			SpareStrings.Clear();
			Things.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ProtoDefaultNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ProtoDefaultNotify>())
		{
			MemoryPackFormatterProvider.Register(new ProtoDefaultNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ProtoDefaultNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ProtoDefaultNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbDropThing>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbDropThing>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ProtoDefaultNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteValue<List<int>>(value.SpareIdInts);
		writer.WriteValue<List<string>>(value.SpareStrings);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbDropThing>>(value.Things));
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ProtoDefaultNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		List<string> value4;
		List<PbDropThing> value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SpareIdInts;
				value4 = value.SpareStrings;
				value5 = value.Things;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadValue(ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0131;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = reader.ReadValue<List<string>>();
			value5 = ListFormatter.DeserializePackable<PbDropThing>(ref reader);
			reader.ReadUnmanaged<long>(out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ProtoDefaultNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SpareIdInts;
				value4 = value.SpareStrings;
				value5 = value.Things;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
				goto IL_0131;
			}
		}
		value = new ProtoDefaultNotify
		{
			IsFromPool = value2,
			SpareIdInts = value3,
			SpareStrings = value4,
			Things = value5,
			ActorId = value6
		};
		return;
		IL_0131:
		value.IsFromPool = value2;
		value.SpareIdInts = value3;
		value.SpareStrings = value4;
		value.Things = value5;
		value.ActorId = value6;
	}
}
