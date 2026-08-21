using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(50009)]
[MemoryPackable(GenerateType.Object)]
public class KiifLoginHallResponse : MessageObject, IResponse, IMessage, IMemoryPackable<KiifLoginHallResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class KiifLoginHallResponseFormatter : MemoryPackFormatter<KiifLoginHallResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref KiifLoginHallResponse value)
		{
			KiifLoginHallResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref KiifLoginHallResponse value)
		{
			KiifLoginHallResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(92)]
	public int TargetServerId { get; set; }

	[MemoryPackOrder(93)]
	public long SecretKey { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public UserBaseInfo UserBaseInfo { get; set; }

	[MemoryPackOrder(2)]
	public long ServerTime { get; set; }

	[MemoryPackOrder(3)]
	public long ReloginKey { get; set; }

	[MemoryPackOrder(4)]
	public long ServerOpneTime { get; set; }

	public static KiifLoginHallResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(KiifLoginHallResponse)) as KiifLoginHallResponse;
		}
		return new KiifLoginHallResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			TargetServerId = 0;
			SecretKey = 0L;
			UserId = 0L;
			UserBaseInfo = null;
			ServerTime = 0L;
			ReloginKey = 0L;
			ServerOpneTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static KiifLoginHallResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<KiifLoginHallResponse>())
		{
			MemoryPackFormatterProvider.Register(new KiifLoginHallResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<KiifLoginHallResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<KiifLoginHallResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref KiifLoginHallResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(11, value.IsFromPool, value.UserId);
		writer.WritePackable<UserBaseInfo>(value.UserBaseInfo);
		writer.WriteUnmanaged<long, long, long, int, int>(value.ServerTime, value.ReloginKey, value.ServerOpneTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<int, long>(value.TargetServerId, value.SecretKey);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref KiifLoginHallResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		UserBaseInfo value4;
		long value5;
		long value6;
		long value7;
		int value8;
		int value9;
		int value10;
		long value11;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.ServerTime;
				value6 = value.ReloginKey;
				value7 = value.ServerOpneTime;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				value10 = value.TargetServerId;
				value11 = value.SecretKey;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0241;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<UserBaseInfo>();
			reader.ReadUnmanaged<long, long, long, int, int>(out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value10, out value11);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(KiifLoginHallResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0L;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				message = null;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.ServerTime;
				value6 = value.ReloginKey;
				value7 = value.ServerOpneTime;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				value10 = value.TargetServerId;
				value11 = value.SecretKey;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value11);
														_ = 11;
													}
												}
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
				goto IL_0241;
			}
		}
		value = new KiifLoginHallResponse
		{
			IsFromPool = value2,
			UserId = value3,
			UserBaseInfo = value4,
			ServerTime = value5,
			ReloginKey = value6,
			ServerOpneTime = value7,
			RpcId = value8,
			Error = value9,
			Message = message,
			TargetServerId = value10,
			SecretKey = value11
		};
		return;
		IL_0241:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserBaseInfo = value4;
		value.ServerTime = value5;
		value.ReloginKey = value6;
		value.ServerOpneTime = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
		value.TargetServerId = value10;
		value.SecretKey = value11;
	}
}
