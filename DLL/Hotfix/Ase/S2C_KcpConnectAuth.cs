using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10032)]
[MemoryPackable(GenerateType.Object)]
public class S2C_KcpConnectAuth : MessageObject, IResponse, IMessage, IMemoryPackable<S2C_KcpConnectAuth>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_KcpConnectAuthFormatter : MemoryPackFormatter<S2C_KcpConnectAuth>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_KcpConnectAuth value)
		{
			S2C_KcpConnectAuth.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_KcpConnectAuth value)
		{
			S2C_KcpConnectAuth.Deserialize(ref reader, ref value);
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

	public static S2C_KcpConnectAuth Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_KcpConnectAuth)) as S2C_KcpConnectAuth;
		}
		return new S2C_KcpConnectAuth();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Succ = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_KcpConnectAuth()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_KcpConnectAuth>())
		{
			MemoryPackFormatterProvider.Register(new S2C_KcpConnectAuthFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_KcpConnectAuth[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_KcpConnectAuth>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_KcpConnectAuth? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool, int, int>(5, value.IsFromPool, value.Succ, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_KcpConnectAuth? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Succ;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_011d;
			}
			reader.ReadUnmanaged<bool, bool, int, int>(out value2, out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_KcpConnectAuth), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Succ;
				value4 = value.RpcId;
				value5 = value.Error;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011d;
			}
		}
		value = new S2C_KcpConnectAuth
		{
			IsFromPool = value2,
			Succ = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_011d:
		value.IsFromPool = value2;
		value.Succ = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
