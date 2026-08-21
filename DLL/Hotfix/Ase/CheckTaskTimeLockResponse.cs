using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10529)]
[MemoryPackable(GenerateType.Object)]
public class CheckTaskTimeLockResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<CheckTaskTimeLockResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CheckTaskTimeLockResponseFormatter : MemoryPackFormatter<CheckTaskTimeLockResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CheckTaskTimeLockResponse value)
		{
			CheckTaskTimeLockResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CheckTaskTimeLockResponse value)
		{
			CheckTaskTimeLockResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool Valid { get; set; }

	public static CheckTaskTimeLockResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CheckTaskTimeLockResponse)) as CheckTaskTimeLockResponse;
		}
		return new CheckTaskTimeLockResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Valid = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CheckTaskTimeLockResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CheckTaskTimeLockResponse>())
		{
			MemoryPackFormatterProvider.Register(new CheckTaskTimeLockResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CheckTaskTimeLockResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CheckTaskTimeLockResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CheckTaskTimeLockResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool, int, int>(5, value.IsFromPool, value.Valid, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CheckTaskTimeLockResponse? value)
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
				value3 = value.Valid;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CheckTaskTimeLockResponse), 5, memberCount);
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
				value3 = value.Valid;
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
		value = new CheckTaskTimeLockResponse
		{
			IsFromPool = value2,
			Valid = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_011d:
		value.IsFromPool = value2;
		value.Valid = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
