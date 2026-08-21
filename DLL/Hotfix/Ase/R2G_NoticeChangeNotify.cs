using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10318)]
[MemoryPackable(GenerateType.Object)]
public class R2G_NoticeChangeNotify : MessageObject, IMessage, IMemoryPackable<R2G_NoticeChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class R2G_NoticeChangeNotifyFormatter : MemoryPackFormatter<R2G_NoticeChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref R2G_NoticeChangeNotify value)
		{
			R2G_NoticeChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref R2G_NoticeChangeNotify value)
		{
			R2G_NoticeChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<PbNotice> PbNotices { get; set; } = new List<PbNotice>();

	public static R2G_NoticeChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(R2G_NoticeChangeNotify)) as R2G_NoticeChangeNotify;
		}
		return new R2G_NoticeChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PbNotices.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static R2G_NoticeChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<R2G_NoticeChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new R2G_NoticeChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<R2G_NoticeChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<R2G_NoticeChangeNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNotice>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNotice>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref R2G_NoticeChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(2, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNotice>>(value.PbNotices));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref R2G_NoticeChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbNotice> value3;
		if (memberCount == 2)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PbNotices;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				goto IL_009b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbNotice>(ref reader);
		}
		else
		{
			if (memberCount > 2)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(R2G_NoticeChangeNotify), 2, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PbNotices;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					_ = 2;
				}
			}
			if (value != null)
			{
				goto IL_009b;
			}
		}
		value = new R2G_NoticeChangeNotify
		{
			IsFromPool = value2,
			PbNotices = value3
		};
		return;
		IL_009b:
		value.IsFromPool = value2;
		value.PbNotices = value3;
	}
}
