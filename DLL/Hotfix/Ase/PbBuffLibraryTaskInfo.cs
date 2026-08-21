using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(433)]
[MemoryPackable(GenerateType.Object)]
public class PbBuffLibraryTaskInfo : MessageObject, IMemoryPackable<PbBuffLibraryTaskInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBuffLibraryTaskInfoFormatter : MemoryPackFormatter<PbBuffLibraryTaskInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBuffLibraryTaskInfo value)
		{
			PbBuffLibraryTaskInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBuffLibraryTaskInfo value)
		{
			PbBuffLibraryTaskInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public int Progress { get; set; }

	[MemoryPackOrder(2)]
	public int RequireValue { get; set; }

	[MemoryPackOrder(3)]
	public bool IsCompleted { get; set; }

	[MemoryPackOrder(4)]
	public bool IsClaimed { get; set; }

	public static PbBuffLibraryTaskInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBuffLibraryTaskInfo)) as PbBuffLibraryTaskInfo;
		}
		return new PbBuffLibraryTaskInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			TaskId = 0;
			Progress = 0;
			RequireValue = 0;
			IsCompleted = false;
			IsClaimed = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBuffLibraryTaskInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBuffLibraryTaskInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbBuffLibraryTaskInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBuffLibraryTaskInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBuffLibraryTaskInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBuffLibraryTaskInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, bool, bool>(6, value.IsFromPool, value.TaskId, value.Progress, value.RequireValue, value.IsCompleted, value.IsClaimed);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBuffLibraryTaskInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		bool value6;
		bool value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Progress;
				value5 = value.RequireValue;
				value6 = value.IsCompleted;
				value7 = value.IsClaimed;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				reader.ReadUnmanaged<bool>(out value7);
				goto IL_0145;
			}
			reader.ReadUnmanaged<bool, int, int, int, bool, bool>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBuffLibraryTaskInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = false;
				value7 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Progress;
				value5 = value.RequireValue;
				value6 = value.IsCompleted;
				value7 = value.IsClaimed;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<bool>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0145;
			}
		}
		value = new PbBuffLibraryTaskInfo
		{
			IsFromPool = value2,
			TaskId = value3,
			Progress = value4,
			RequireValue = value5,
			IsCompleted = value6,
			IsClaimed = value7
		};
		return;
		IL_0145:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.Progress = value4;
		value.RequireValue = value5;
		value.IsCompleted = value6;
		value.IsClaimed = value7;
	}
}
