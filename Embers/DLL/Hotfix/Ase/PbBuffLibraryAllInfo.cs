using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(434)]
[MemoryPackable(GenerateType.Object)]
public class PbBuffLibraryAllInfo : MessageObject, IMemoryPackable<PbBuffLibraryAllInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBuffLibraryAllInfoFormatter : MemoryPackFormatter<PbBuffLibraryAllInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBuffLibraryAllInfo value)
		{
			PbBuffLibraryAllInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBuffLibraryAllInfo value)
		{
			PbBuffLibraryAllInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<int> CollectedBuffIds { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<int> ChosenBuffIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public List<PbBuffLibraryTaskInfo> TaskInfos { get; set; } = new List<PbBuffLibraryTaskInfo>();

	public static PbBuffLibraryAllInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBuffLibraryAllInfo)) as PbBuffLibraryAllInfo;
		}
		return new PbBuffLibraryAllInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CollectedBuffIds.Clear();
			ChosenBuffIds.Clear();
			TaskInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBuffLibraryAllInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBuffLibraryAllInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbBuffLibraryAllInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBuffLibraryAllInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBuffLibraryAllInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBuffLibraryTaskInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBuffLibraryTaskInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBuffLibraryAllInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WriteValue<List<int>>(value.CollectedBuffIds);
		writer.WriteValue<List<int>>(value.ChosenBuffIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBuffLibraryTaskInfo>>(value.TaskInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBuffLibraryAllInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		List<int> value4;
		List<PbBuffLibraryTaskInfo> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CollectedBuffIds;
				value4 = value.ChosenBuffIds;
				value5 = value.TaskInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadValue(ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_00f9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = reader.ReadValue<List<int>>();
			value5 = ListFormatter.DeserializePackable<PbBuffLibraryTaskInfo>(ref reader);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBuffLibraryAllInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CollectedBuffIds;
				value4 = value.ChosenBuffIds;
				value5 = value.TaskInfos;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f9;
			}
		}
		value = new PbBuffLibraryAllInfo
		{
			IsFromPool = value2,
			CollectedBuffIds = value3,
			ChosenBuffIds = value4,
			TaskInfos = value5
		};
		return;
		IL_00f9:
		value.IsFromPool = value2;
		value.CollectedBuffIds = value3;
		value.ChosenBuffIds = value4;
		value.TaskInfos = value5;
	}
}
