using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10665)]
[MemoryPackable(GenerateType.Object)]
public class HandleUnionApplicationResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<HandleUnionApplicationResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HandleUnionApplicationResponseFormatter : MemoryPackFormatter<HandleUnionApplicationResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HandleUnionApplicationResponse value)
		{
			HandleUnionApplicationResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HandleUnionApplicationResponse value)
		{
			HandleUnionApplicationResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<long> RemoveUserIds { get; set; } = new List<long>();

	public static HandleUnionApplicationResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HandleUnionApplicationResponse)) as HandleUnionApplicationResponse;
		}
		return new HandleUnionApplicationResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RemoveUserIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HandleUnionApplicationResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HandleUnionApplicationResponse>())
		{
			MemoryPackFormatterProvider.Register(new HandleUnionApplicationResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HandleUnionApplicationResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HandleUnionApplicationResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HandleUnionApplicationResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteValue<List<long>>(value.RemoveUserIds);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HandleUnionApplicationResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<long> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RemoveUserIds;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HandleUnionApplicationResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RemoveUserIds;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
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
				goto IL_012b;
			}
		}
		value = new HandleUnionApplicationResponse
		{
			IsFromPool = value2,
			RemoveUserIds = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.RemoveUserIds = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
