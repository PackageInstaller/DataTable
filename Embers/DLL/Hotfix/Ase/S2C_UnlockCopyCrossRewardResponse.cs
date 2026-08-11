using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10095)]
[MemoryPackable(GenerateType.Object)]
public class S2C_UnlockCopyCrossRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_UnlockCopyCrossRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_UnlockCopyCrossRewardResponseFormatter : MemoryPackFormatter<S2C_UnlockCopyCrossRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_UnlockCopyCrossRewardResponse value)
		{
			S2C_UnlockCopyCrossRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_UnlockCopyCrossRewardResponse value)
		{
			S2C_UnlockCopyCrossRewardResponse.Deserialize(ref reader, ref value);
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
	public PbDropThing LockedDrops { get; set; }

	[MemoryPackOrder(3)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	public static S2C_UnlockCopyCrossRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_UnlockCopyCrossRewardResponse)) as S2C_UnlockCopyCrossRewardResponse;
		}
		return new S2C_UnlockCopyCrossRewardResponse();
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
			LockedDrops = null;
			Roles.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_UnlockCopyCrossRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_UnlockCopyCrossRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_UnlockCopyCrossRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_UnlockCopyCrossRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_UnlockCopyCrossRewardResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_UnlockCopyCrossRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(8, value.IsFromPool, value.Level, value.Exp);
		writer.WritePackable<PbDropThing>(value.LockedDrops);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_UnlockCopyCrossRewardResponse? value)
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
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.Exp;
				value5 = value.LockedDrops;
				value6 = value.Roles;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadPackable(ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01b3;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbDropThing>();
			value6 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_UnlockCopyCrossRewardResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.Exp;
				value5 = value.LockedDrops;
				value6 = value.Roles;
				value7 = value.RpcId;
				value8 = value.Error;
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
				goto IL_01b3;
			}
		}
		value = new S2C_UnlockCopyCrossRewardResponse
		{
			IsFromPool = value2,
			Level = value3,
			Exp = value4,
			LockedDrops = value5,
			Roles = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01b3:
		value.IsFromPool = value2;
		value.Level = value3;
		value.Exp = value4;
		value.LockedDrops = value5;
		value.Roles = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
