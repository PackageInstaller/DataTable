using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1033)]
[MemoryPackable(GenerateType.Object)]
public class BFRoleInfo : MessageObject, IMemoryPackable<BFRoleInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BFRoleInfoFormatter : MemoryPackFormatter<BFRoleInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BFRoleInfo value)
		{
			BFRoleInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BFRoleInfo value)
		{
			BFRoleInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(2)]
	public int CapFlag { get; set; }

	public static BFRoleInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BFRoleInfo)) as BFRoleInfo;
		}
		return new BFRoleInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoleId = 0;
			CapFlag = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BFRoleInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BFRoleInfo>())
		{
			MemoryPackFormatterProvider.Register(new BFRoleInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BFRoleInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BFRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BFRoleInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.RoleId, value.CapFlag, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BFRoleInfo? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.CapFlag;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BFRoleInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.CapFlag;
				value5 = value.RpcId;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new BFRoleInfo
		{
			IsFromPool = value2,
			RoleId = value3,
			CapFlag = value4,
			RpcId = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.CapFlag = value4;
		value.RpcId = value5;
	}
}
