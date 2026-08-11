using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(9900)]
[MemoryPackable(GenerateType.Object)]
public class C2S_TestComandRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_TestComandRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_TestComandRequestFormatter : MemoryPackFormatter<C2S_TestComandRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_TestComandRequest value)
		{
			C2S_TestComandRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_TestComandRequest value)
		{
			C2S_TestComandRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public string Command { get; set; }

	[MemoryPackOrder(1)]
	public List<string> Paramlist { get; set; } = new List<string>();

	public static C2S_TestComandRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_TestComandRequest)) as C2S_TestComandRequest;
		}
		return new C2S_TestComandRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Command = null;
			Paramlist.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_TestComandRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_TestComandRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2S_TestComandRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_TestComandRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_TestComandRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_TestComandRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteString(value.Command);
		writer.WriteValue<List<string>>(value.Paramlist);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_TestComandRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<string> value3;
		int value4;
		long value5;
		int value6;
		long value7;
		string command;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				command = value.Command;
				value3 = value.Paramlist;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				command = reader.ReadString();
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0180;
			}
			reader.ReadUnmanaged<bool>(out value2);
			command = reader.ReadString();
			value3 = reader.ReadValue<List<string>>();
			reader.ReadUnmanaged<int, long, int, long>(out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_TestComandRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				command = null;
				value3 = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				command = value.Command;
				value3 = value.Paramlist;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					command = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadValue(ref value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value7);
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
				goto IL_0180;
			}
		}
		value = new C2S_TestComandRequest
		{
			IsFromPool = value2,
			Command = command,
			Paramlist = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0180:
		value.IsFromPool = value2;
		value.Command = command;
		value.Paramlist = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
