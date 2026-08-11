using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10040)]
[MemoryPackable(GenerateType.Object)]
public class H2C_GetDropGoodsResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_GetDropGoodsResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_GetDropGoodsResponseFormatter : MemoryPackFormatter<H2C_GetDropGoodsResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_GetDropGoodsResponse value)
		{
			H2C_GetDropGoodsResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_GetDropGoodsResponse value)
		{
			H2C_GetDropGoodsResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int Level { get; set; }

	[MemoryPackOrder(1)]
	public int Exp { get; set; }

	[MemoryPackOrder(2)]
	public PbDropThing Drops { get; set; }

	[MemoryPackOrder(3)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(4)]
	public PbDropThing LockedDrops { get; set; }

	public static H2C_GetDropGoodsResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_GetDropGoodsResponse)) as H2C_GetDropGoodsResponse;
		}
		return new H2C_GetDropGoodsResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Level = 0;
			Exp = 0;
			Drops = null;
			Roles.Clear();
			LockedDrops = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_GetDropGoodsResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetDropGoodsResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_GetDropGoodsResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetDropGoodsResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_GetDropGoodsResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_GetDropGoodsResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(9, value.IsFromPool, value.Level, value.Exp);
		writer.WritePackable<PbDropThing>(value.Drops);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		writer.WritePackable<PbDropThing>(value.LockedDrops);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_GetDropGoodsResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		PbDropThing value5;
		List<PbNormalRoleInfo> value6;
		PbDropThing value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.Exp;
				value5 = value.Drops;
				value6 = value.Roles;
				value7 = value.LockedDrops;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadPackable(ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadPackable(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01e8;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbDropThing>();
			value6 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			value7 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, int>(out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_GetDropGoodsResponse), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.Exp;
				value5 = value.Drops;
				value6 = value.Roles;
				value7 = value.LockedDrops;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
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
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadPackable(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
												_ = 9;
											}
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
				goto IL_01e8;
			}
		}
		value = new H2C_GetDropGoodsResponse
		{
			IsFromPool = value2,
			Level = value3,
			Exp = value4,
			Drops = value5,
			Roles = value6,
			LockedDrops = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01e8:
		value.IsFromPool = value2;
		value.Level = value3;
		value.Exp = value4;
		value.Drops = value5;
		value.Roles = value6;
		value.LockedDrops = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
