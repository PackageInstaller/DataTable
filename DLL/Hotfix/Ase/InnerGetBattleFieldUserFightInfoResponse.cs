using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1077)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetBattleFieldUserFightInfoResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerGetBattleFieldUserFightInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetBattleFieldUserFightInfoResponseFormatter : MemoryPackFormatter<InnerGetBattleFieldUserFightInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetBattleFieldUserFightInfoResponse value)
		{
			InnerGetBattleFieldUserFightInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetBattleFieldUserFightInfoResponse value)
		{
			InnerGetBattleFieldUserFightInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbBattleFiledUserInfo> Users { get; set; } = new List<PbBattleFiledUserInfo>();

	[MemoryPackOrder(1)]
	public long CheckCode { get; set; }

	[MemoryPackOrder(2)]
	public int Seed { get; set; }

	[MemoryPackOrder(3)]
	public long RoomId { get; set; }

	[MemoryPackOrder(4)]
	public int CopyId { get; set; }

	[MemoryPackOrder(5)]
	public int Difficult { get; set; }

	public static InnerGetBattleFieldUserFightInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetBattleFieldUserFightInfoResponse)) as InnerGetBattleFieldUserFightInfoResponse;
		}
		return new InnerGetBattleFieldUserFightInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ActorId = 0L;
			Users.Clear();
			CheckCode = 0L;
			Seed = 0;
			RoomId = 0L;
			CopyId = 0;
			Difficult = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetBattleFieldUserFightInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetBattleFieldUserFightInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetBattleFieldUserFightInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetBattleFieldUserFightInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetBattleFieldUserFightInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleFiledUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleFiledUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetBattleFieldUserFightInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(11, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleFiledUserInfo>>(value.Users));
		writer.WriteUnmanaged<long, int, long, int, int, int, int>(value.CheckCode, value.Seed, value.RoomId, value.CopyId, value.Difficult, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetBattleFieldUserFightInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbBattleFiledUserInfo> value3;
		long value4;
		int value5;
		long value6;
		int value7;
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
				value3 = value.Users;
				value4 = value.CheckCode;
				value5 = value.Seed;
				value6 = value.RoomId;
				value7 = value.CopyId;
				value8 = value.Difficult;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				reader.ReadUnmanaged<long>(out value11);
				goto IL_023f;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbBattleFiledUserInfo>(ref reader);
			reader.ReadUnmanaged<long, int, long, int, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9, out value10);
			message = reader.ReadString();
			reader.ReadUnmanaged<long>(out value11);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetBattleFieldUserFightInfoResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				message = null;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				value4 = value.CheckCode;
				value5 = value.Seed;
				value6 = value.RoomId;
				value7 = value.CopyId;
				value8 = value.Difficult;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				value11 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													message = reader.ReadString();
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
				goto IL_023f;
			}
		}
		value = new InnerGetBattleFieldUserFightInfoResponse
		{
			IsFromPool = value2,
			Users = value3,
			CheckCode = value4,
			Seed = value5,
			RoomId = value6,
			CopyId = value7,
			Difficult = value8,
			RpcId = value9,
			Error = value10,
			Message = message,
			ActorId = value11
		};
		return;
		IL_023f:
		value.IsFromPool = value2;
		value.Users = value3;
		value.CheckCode = value4;
		value.Seed = value5;
		value.RoomId = value6;
		value.CopyId = value7;
		value.Difficult = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
		value.ActorId = value11;
	}
}
