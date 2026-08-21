using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10132)]
[MemoryPackable(GenerateType.Object)]
public class G2B_CreateBattleFieldRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<G2B_CreateBattleFieldRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2B_CreateBattleFieldRoomRequestFormatter : MemoryPackFormatter<G2B_CreateBattleFieldRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2B_CreateBattleFieldRoomRequest value)
		{
			G2B_CreateBattleFieldRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2B_CreateBattleFieldRoomRequest value)
		{
			G2B_CreateBattleFieldRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbCreateBattleUserInfo> Users { get; set; } = new List<PbCreateBattleUserInfo>();

	[MemoryPackOrder(1)]
	public string SettingAddress { get; set; }

	[MemoryPackOrder(2)]
	public long SettingRoomId { get; set; }

	public static G2B_CreateBattleFieldRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2B_CreateBattleFieldRoomRequest)) as G2B_CreateBattleFieldRoomRequest;
		}
		return new G2B_CreateBattleFieldRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Users.Clear();
			SettingAddress = null;
			SettingRoomId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2B_CreateBattleFieldRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2B_CreateBattleFieldRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new G2B_CreateBattleFieldRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2B_CreateBattleFieldRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2B_CreateBattleFieldRoomRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCreateBattleUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCreateBattleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2B_CreateBattleFieldRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCreateBattleUserInfo>>(value.Users));
		writer.WriteString(value.SettingAddress);
		writer.WriteUnmanaged<long, int>(value.SettingRoomId, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2B_CreateBattleFieldRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbCreateBattleUserInfo> value3;
		long value4;
		int value5;
		string settingAddress;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				settingAddress = value.SettingAddress;
				value4 = value.SettingRoomId;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				settingAddress = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_0126;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbCreateBattleUserInfo>(ref reader);
			settingAddress = reader.ReadString();
			reader.ReadUnmanaged<long, int>(out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2B_CreateBattleFieldRoomRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				settingAddress = null;
				value4 = 0L;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				settingAddress = value.SettingAddress;
				value4 = value.SettingRoomId;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						settingAddress = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0126;
			}
		}
		value = new G2B_CreateBattleFieldRoomRequest
		{
			IsFromPool = value2,
			Users = value3,
			SettingAddress = settingAddress,
			SettingRoomId = value4,
			RpcId = value5
		};
		return;
		IL_0126:
		value.IsFromPool = value2;
		value.Users = value3;
		value.SettingAddress = settingAddress;
		value.SettingRoomId = value4;
		value.RpcId = value5;
	}
}
