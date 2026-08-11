using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10613)]
[MemoryPackable(GenerateType.Object)]
public class GetCopyEnterLimitResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetCopyEnterLimitResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetCopyEnterLimitResponseFormatter : MemoryPackFormatter<GetCopyEnterLimitResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetCopyEnterLimitResponse value)
		{
			GetCopyEnterLimitResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetCopyEnterLimitResponse value)
		{
			GetCopyEnterLimitResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbCopyEnterLimit CopyEnterLimit { get; set; }

	[MemoryPackOrder(1)]
	public List<PbSuitboxCopyInfo> SuitboxCopyInfos { get; set; } = new List<PbSuitboxCopyInfo>();

	public static GetCopyEnterLimitResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetCopyEnterLimitResponse)) as GetCopyEnterLimitResponse;
		}
		return new GetCopyEnterLimitResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			CopyEnterLimit = null;
			SuitboxCopyInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetCopyEnterLimitResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetCopyEnterLimitResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetCopyEnterLimitResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetCopyEnterLimitResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetCopyEnterLimitResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSuitboxCopyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSuitboxCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetCopyEnterLimitResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbCopyEnterLimit>(value.CopyEnterLimit);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyInfo>>(value.SuitboxCopyInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetCopyEnterLimitResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbCopyEnterLimit value3;
		List<PbSuitboxCopyInfo> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyEnterLimit;
				value4 = value.SuitboxCopyInfos;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbCopyEnterLimit>();
			value4 = ListFormatter.DeserializePackable<PbSuitboxCopyInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetCopyEnterLimitResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyEnterLimit;
				value4 = value.SuitboxCopyInfos;
				value5 = value.RpcId;
				value6 = value.Error;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
				goto IL_015b;
			}
		}
		value = new GetCopyEnterLimitResponse
		{
			IsFromPool = value2,
			CopyEnterLimit = value3,
			SuitboxCopyInfos = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.CopyEnterLimit = value3;
		value.SuitboxCopyInfos = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
