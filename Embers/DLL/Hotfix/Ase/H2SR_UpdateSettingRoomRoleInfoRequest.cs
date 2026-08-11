using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10471)]
[MemoryPackable(GenerateType.Object)]
public class H2SR_UpdateSettingRoomRoleInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2SR_UpdateSettingRoomRoleInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2SR_UpdateSettingRoomRoleInfoRequestFormatter : MemoryPackFormatter<H2SR_UpdateSettingRoomRoleInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2SR_UpdateSettingRoomRoleInfoRequest value)
		{
			H2SR_UpdateSettingRoomRoleInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2SR_UpdateSettingRoomRoleInfoRequest value)
		{
			H2SR_UpdateSettingRoomRoleInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public PbRoomRoleInfo RoleInfo { get; set; }

	[MemoryPackOrder(2)]
	public bool ChangeRole { get; set; }

	public static H2SR_UpdateSettingRoomRoleInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2SR_UpdateSettingRoomRoleInfoRequest)) as H2SR_UpdateSettingRoomRoleInfoRequest;
		}
		return new H2SR_UpdateSettingRoomRoleInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			RoleInfo = null;
			ChangeRole = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2SR_UpdateSettingRoomRoleInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_UpdateSettingRoomRoleInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2SR_UpdateSettingRoomRoleInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_UpdateSettingRoomRoleInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2SR_UpdateSettingRoomRoleInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2SR_UpdateSettingRoomRoleInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UserId);
		writer.WritePackable<PbRoomRoleInfo>(value.RoleInfo);
		writer.WriteUnmanaged<bool, int>(value.ChangeRole, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2SR_UpdateSettingRoomRoleInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbRoomRoleInfo value4;
		bool value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoleInfo;
				value5 = value.ChangeRole;
				value6 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<bool, int>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2SR_UpdateSettingRoomRoleInfoRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = false;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoleInfo;
				value5 = value.ChangeRole;
				value6 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
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
		value = new H2SR_UpdateSettingRoomRoleInfoRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoleInfo = value4,
			ChangeRole = value5,
			RpcId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoleInfo = value4;
		value.ChangeRole = value5;
		value.RpcId = value6;
	}
}
