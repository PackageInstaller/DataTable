using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(373)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyEnterLimit : MessageObject, IMemoryPackable<PbCopyEnterLimit>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyEnterLimitFormatter : MemoryPackFormatter<PbCopyEnterLimit>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyEnterLimit value)
		{
			PbCopyEnterLimit.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyEnterLimit value)
		{
			PbCopyEnterLimit.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int PermitLevel { get; set; }

	[MemoryPackOrder(1)]
	public List<PbPermitTask> PermitTasks { get; set; } = new List<PbPermitTask>();

	[MemoryPackOrder(2)]
	public List<PbCopyDifficultyInfo> CopyDifficultyInfos { get; set; } = new List<PbCopyDifficultyInfo>();

	public static PbCopyEnterLimit Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyEnterLimit)) as PbCopyEnterLimit;
		}
		return new PbCopyEnterLimit();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PermitLevel = 0;
			PermitTasks.Clear();
			CopyDifficultyInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyEnterLimit()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyEnterLimit>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyEnterLimitFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyEnterLimit[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyEnterLimit>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbPermitTask>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbPermitTask>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyDifficultyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyDifficultyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyEnterLimit? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.PermitLevel);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbPermitTask>>(value.PermitTasks));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyDifficultyInfo>>(value.CopyDifficultyInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyEnterLimit? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbPermitTask> value4;
		List<PbCopyDifficultyInfo> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PermitLevel;
				value4 = value.PermitTasks;
				value5 = value.CopyDifficultyInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbPermitTask>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbCopyDifficultyInfo>(ref reader);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyEnterLimit), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PermitLevel;
				value4 = value.PermitTasks;
				value5 = value.CopyDifficultyInfos;
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
							ListFormatter.DeserializePackable(ref reader, ref value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f4;
			}
		}
		value = new PbCopyEnterLimit
		{
			IsFromPool = value2,
			PermitLevel = value3,
			PermitTasks = value4,
			CopyDifficultyInfos = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.PermitLevel = value3;
		value.PermitTasks = value4;
		value.CopyDifficultyInfos = value5;
	}
}
