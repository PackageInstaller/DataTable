using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(390)]
[MemoryPackable(GenerateType.Object)]
public class PbSetFloorCopyRoleSetting : MessageObject, IMemoryPackable<PbSetFloorCopyRoleSetting>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSetFloorCopyRoleSettingFormatter : MemoryPackFormatter<PbSetFloorCopyRoleSetting>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSetFloorCopyRoleSetting value)
		{
			PbSetFloorCopyRoleSetting.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSetFloorCopyRoleSetting value)
		{
			PbSetFloorCopyRoleSetting.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public List<int> RoleIds { get; set; } = new List<int>();

	public static PbSetFloorCopyRoleSetting Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSetFloorCopyRoleSetting)) as PbSetFloorCopyRoleSetting;
		}
		return new PbSetFloorCopyRoleSetting();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyId = 0;
			RoleIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSetFloorCopyRoleSetting()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSetFloorCopyRoleSetting>())
		{
			MemoryPackFormatterProvider.Register(new PbSetFloorCopyRoleSettingFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSetFloorCopyRoleSetting[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSetFloorCopyRoleSetting>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSetFloorCopyRoleSetting? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.CopyId);
		writer.WriteValue<List<int>>(value.RoleIds);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSetFloorCopyRoleSetting? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<int> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.RoleIds;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadValue(ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadValue<List<int>>();
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSetFloorCopyRoleSetting), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.RoleIds;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new PbSetFloorCopyRoleSetting
		{
			IsFromPool = value2,
			CopyId = value3,
			RoleIds = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.RoleIds = value4;
	}
}
