using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1109)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetUnionRankListResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerGetUnionRankListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetUnionRankListResponseFormatter : MemoryPackFormatter<InnerGetUnionRankListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionRankListResponse value)
		{
			InnerGetUnionRankListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionRankListResponse value)
		{
			InnerGetUnionRankListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbUnionRankInfo> UnionRankInfos { get; set; } = new List<PbUnionRankInfo>();

	public static InnerGetUnionRankListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetUnionRankListResponse)) as InnerGetUnionRankListResponse;
		}
		return new InnerGetUnionRankListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionRankInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetUnionRankListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionRankListResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetUnionRankListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionRankListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetUnionRankListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionRankListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionRankInfo>>(value.UnionRankInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionRankListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbUnionRankInfo> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionRankInfos;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbUnionRankInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetUnionRankListResponse), 5, memberCount);
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
				value3 = value.UnionRankInfos;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
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
		value = new InnerGetUnionRankListResponse
		{
			IsFromPool = value2,
			UnionRankInfos = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.UnionRankInfos = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
