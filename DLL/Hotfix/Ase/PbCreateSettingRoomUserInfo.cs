using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(344)]
[MemoryPackable(GenerateType.Object)]
public class PbCreateSettingRoomUserInfo : MessageObject, IMemoryPackable<PbCreateSettingRoomUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCreateSettingRoomUserInfoFormatter : MemoryPackFormatter<PbCreateSettingRoomUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCreateSettingRoomUserInfo value)
		{
			PbCreateSettingRoomUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCreateSettingRoomUserInfo value)
		{
			PbCreateSettingRoomUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int SelectRoleId { get; set; }

	[MemoryPackOrder(2)]
	public List<PbRoomRoleInfo> ReserveRoles { get; set; } = new List<PbRoomRoleInfo>();

	[MemoryPackOrder(3)]
	public PbRoomRoleInfo SelectRole { get; set; }

	[MemoryPackOrder(4)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(5)]
	public PbMultiFightUserBase UserBaseInfo { get; set; }

	public static PbCreateSettingRoomUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCreateSettingRoomUserInfo)) as PbCreateSettingRoomUserInfo;
		}
		return new PbCreateSettingRoomUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			SelectRoleId = 0;
			ReserveRoles.Clear();
			SelectRole = null;
			SelectModel = 0;
			UserBaseInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCreateSettingRoomUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCreateSettingRoomUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCreateSettingRoomUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCreateSettingRoomUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCreateSettingRoomUserInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoomRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoomRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCreateSettingRoomUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(7, value.IsFromPool, value.UserId, value.SelectRoleId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomRoleInfo>>(value.ReserveRoles));
		writer.WritePackable<PbRoomRoleInfo>(value.SelectRole);
		writer.WriteUnmanaged<int>(value.SelectModel);
		writer.WritePackable<PbMultiFightUserBase>(value.UserBaseInfo);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCreateSettingRoomUserInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		List<PbRoomRoleInfo> value5;
		PbRoomRoleInfo value6;
		int value7;
		PbMultiFightUserBase value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SelectRoleId;
				value5 = value.ReserveRoles;
				value6 = value.SelectRole;
				value7 = value.SelectModel;
				value8 = value.UserBaseInfo;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadPackable(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadPackable(ref value8);
				goto IL_0189;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbRoomRoleInfo>(ref reader);
			value6 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int>(out value7);
			value8 = reader.ReadPackable<PbMultiFightUserBase>();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCreateSettingRoomUserInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SelectRoleId;
				value5 = value.ReserveRoles;
				value6 = value.SelectRole;
				value7 = value.SelectModel;
				value8 = value.UserBaseInfo;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadPackable(ref value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0189;
			}
		}
		value = new PbCreateSettingRoomUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			SelectRoleId = value4,
			ReserveRoles = value5,
			SelectRole = value6,
			SelectModel = value7,
			UserBaseInfo = value8
		};
		return;
		IL_0189:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.SelectRoleId = value4;
		value.ReserveRoles = value5;
		value.SelectRole = value6;
		value.SelectModel = value7;
		value.UserBaseInfo = value8;
	}
}
