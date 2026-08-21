using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10154)]
[MemoryPackable(GenerateType.Object)]
public class InnerRewardsChangeResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerRewardsChangeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerRewardsChangeResponseFormatter : MemoryPackFormatter<InnerRewardsChangeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerRewardsChangeResponse value)
		{
			InnerRewardsChangeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerRewardsChangeResponse value)
		{
			InnerRewardsChangeResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int AccountLevel { get; set; }

	[MemoryPackOrder(2)]
	public long AccountExp { get; set; }

	[MemoryPackOrder(3)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	public static InnerRewardsChangeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerRewardsChangeResponse)) as InnerRewardsChangeResponse;
		}
		return new InnerRewardsChangeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			AccountLevel = 0;
			AccountExp = 0L;
			Roles.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerRewardsChangeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRewardsChangeResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerRewardsChangeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRewardsChangeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerRewardsChangeResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerRewardsChangeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(8, value.IsFromPool, value.UserId, value.AccountLevel, value.AccountExp);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerRewardsChangeResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		List<PbNormalRoleInfo> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.AccountLevel;
				value5 = value.AccountExp;
				value6 = value.Roles;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01af;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerRewardsChangeResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.AccountLevel;
				value5 = value.AccountExp;
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
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_01af;
			}
		}
		value = new InnerRewardsChangeResponse
		{
			IsFromPool = value2,
			UserId = value3,
			AccountLevel = value4,
			AccountExp = value5,
			Roles = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01af:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.AccountLevel = value4;
		value.AccountExp = value5;
		value.Roles = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
