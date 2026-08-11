using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(379)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionInfo : MessageObject, IMemoryPackable<PbUnionInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionInfoFormatter : MemoryPackFormatter<PbUnionInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionInfo value)
		{
			PbUnionInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionInfo value)
		{
			PbUnionInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public PbUnionBaseInfo BaseInfo { get; set; }

	[MemoryPackOrder(1)]
	public PbUnionUpdateInfo UpdateInfo { get; set; }

	public static PbUnionInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionInfo)) as PbUnionInfo;
		}
		return new PbUnionInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			BaseInfo = null;
			UpdateInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		writer.WritePackable<PbUnionBaseInfo>(value.BaseInfo);
		writer.WritePackable<PbUnionUpdateInfo>(value.UpdateInfo);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbUnionBaseInfo value3;
		PbUnionUpdateInfo value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BaseInfo;
				value4 = value.UpdateInfo;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				goto IL_00c8;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionBaseInfo>();
			value4 = reader.ReadPackable<PbUnionUpdateInfo>();
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BaseInfo;
				value4 = value.UpdateInfo;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c8;
			}
		}
		value = new PbUnionInfo
		{
			IsFromPool = value2,
			BaseInfo = value3,
			UpdateInfo = value4
		};
		return;
		IL_00c8:
		value.IsFromPool = value2;
		value.BaseInfo = value3;
		value.UpdateInfo = value4;
	}
}
