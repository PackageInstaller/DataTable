using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10898)]
[MemoryPackable(GenerateType.Object)]
public class S2CGetBuffLibraryInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2CGetBuffLibraryInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2CGetBuffLibraryInfoResponseFormatter : MemoryPackFormatter<S2CGetBuffLibraryInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2CGetBuffLibraryInfoResponse value)
		{
			S2CGetBuffLibraryInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2CGetBuffLibraryInfoResponse value)
		{
			S2CGetBuffLibraryInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbBuffLibraryAllInfo AllInfo { get; set; }

	public static S2CGetBuffLibraryInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2CGetBuffLibraryInfoResponse)) as S2CGetBuffLibraryInfoResponse;
		}
		return new S2CGetBuffLibraryInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			AllInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2CGetBuffLibraryInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetBuffLibraryInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2CGetBuffLibraryInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetBuffLibraryInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2CGetBuffLibraryInfoResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2CGetBuffLibraryInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<PbBuffLibraryAllInfo>(value.AllInfo);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2CGetBuffLibraryInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbBuffLibraryAllInfo value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.AllInfo;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbBuffLibraryAllInfo>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2CGetBuffLibraryInfoResponse), 5, memberCount);
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
				value3 = value.AllInfo;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
		value = new S2CGetBuffLibraryInfoResponse
		{
			IsFromPool = value2,
			AllInfo = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.AllInfo = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
