using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10922)]
[MemoryPackable(GenerateType.Object)]
public class S2C_ApplyPresetEquipment : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_ApplyPresetEquipment>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_ApplyPresetEquipmentFormatter : MemoryPackFormatter<S2C_ApplyPresetEquipment>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_ApplyPresetEquipment value)
		{
			S2C_ApplyPresetEquipment.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_ApplyPresetEquipment value)
		{
			S2C_ApplyPresetEquipment.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbPresetEquipmentConflictInfo> Conflicts { get; set; } = new List<PbPresetEquipmentConflictInfo>();

	[MemoryPackOrder(1)]
	public List<PbNormalRoleInfo> RoleInfos { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(2)]
	public List<PbEquipBase> EquipInfos { get; set; } = new List<PbEquipBase>();

	public static S2C_ApplyPresetEquipment Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_ApplyPresetEquipment)) as S2C_ApplyPresetEquipment;
		}
		return new S2C_ApplyPresetEquipment();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Conflicts.Clear();
			RoleInfos.Clear();
			EquipInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_ApplyPresetEquipment()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_ApplyPresetEquipment>())
		{
			MemoryPackFormatterProvider.Register(new S2C_ApplyPresetEquipmentFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_ApplyPresetEquipment[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_ApplyPresetEquipment>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbPresetEquipmentConflictInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbPresetEquipmentConflictInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_ApplyPresetEquipment? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbPresetEquipmentConflictInfo>>(value.Conflicts));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.RoleInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.EquipInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_ApplyPresetEquipment? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbPresetEquipmentConflictInfo> value3;
		List<PbNormalRoleInfo> value4;
		List<PbEquipBase> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Conflicts;
				value4 = value.RoleInfos;
				value5 = value.EquipInfos;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbPresetEquipmentConflictInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_ApplyPresetEquipment), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Conflicts;
				value4 = value.RoleInfos;
				value5 = value.EquipInfos;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
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
				goto IL_018c;
			}
		}
		value = new S2C_ApplyPresetEquipment
		{
			IsFromPool = value2,
			Conflicts = value3,
			RoleInfos = value4,
			EquipInfos = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.Conflicts = value3;
		value.RoleInfos = value4;
		value.EquipInfos = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
