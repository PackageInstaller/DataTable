using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10064)]
[MemoryPackable(GenerateType.Object)]
public class S2C_KillMonsterDropResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_KillMonsterDropResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_KillMonsterDropResponseFormatter : MemoryPackFormatter<S2C_KillMonsterDropResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_KillMonsterDropResponse value)
		{
			S2C_KillMonsterDropResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_KillMonsterDropResponse value)
		{
			S2C_KillMonsterDropResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Drops { get; set; }

	[MemoryPackOrder(1)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(3)]
	public int Exp { get; set; }

	public static S2C_KillMonsterDropResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_KillMonsterDropResponse)) as S2C_KillMonsterDropResponse;
		}
		return new S2C_KillMonsterDropResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Drops = null;
			Roles.Clear();
			Level = 0;
			Exp = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_KillMonsterDropResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_KillMonsterDropResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_KillMonsterDropResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_KillMonsterDropResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_KillMonsterDropResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_KillMonsterDropResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Drops);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		writer.WriteUnmanaged<int, int, int, int>(value.Level, value.Exp, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_KillMonsterDropResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		List<PbNormalRoleInfo> value4;
		int value5;
		int value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Drops;
				value4 = value.Roles;
				value5 = value.Level;
				value6 = value.Exp;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01b1;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			value4 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int, int>(out value5, out value6, out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_KillMonsterDropResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Drops;
				value4 = value.Roles;
				value5 = value.Level;
				value6 = value.Exp;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01b1;
			}
		}
		value = new S2C_KillMonsterDropResponse
		{
			IsFromPool = value2,
			Drops = value3,
			Roles = value4,
			Level = value5,
			Exp = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01b1:
		value.IsFromPool = value2;
		value.Drops = value3;
		value.Roles = value4;
		value.Level = value5;
		value.Exp = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
