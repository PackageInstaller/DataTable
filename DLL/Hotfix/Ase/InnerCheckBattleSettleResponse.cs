using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1074)]
[MemoryPackable(GenerateType.Object)]
public class InnerCheckBattleSettleResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerCheckBattleSettleResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerCheckBattleSettleResponseFormatter : MemoryPackFormatter<InnerCheckBattleSettleResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerCheckBattleSettleResponse value)
		{
			InnerCheckBattleSettleResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerCheckBattleSettleResponse value)
		{
			InnerCheckBattleSettleResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool Succ { get; set; }

	[MemoryPackOrder(1)]
	public List<long> QuitUsers { get; set; } = new List<long>();

	public static InnerCheckBattleSettleResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerCheckBattleSettleResponse)) as InnerCheckBattleSettleResponse;
		}
		return new InnerCheckBattleSettleResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Succ = false;
			QuitUsers.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerCheckBattleSettleResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCheckBattleSettleResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerCheckBattleSettleResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCheckBattleSettleResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerCheckBattleSettleResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerCheckBattleSettleResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool>(6, value.IsFromPool, value.Succ);
		writer.WriteValue<List<long>>(value.QuitUsers);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerCheckBattleSettleResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		List<long> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Succ;
				value4 = value.QuitUsers;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool, bool>(out value2, out value3);
			value4 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerCheckBattleSettleResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Succ;
				value4 = value.QuitUsers;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<bool>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0156;
			}
		}
		value = new InnerCheckBattleSettleResponse
		{
			IsFromPool = value2,
			Succ = value3,
			QuitUsers = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.Succ = value3;
		value.QuitUsers = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
