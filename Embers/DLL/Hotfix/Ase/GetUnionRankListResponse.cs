using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10686)]
[MemoryPackable(GenerateType.Object)]
public class GetUnionRankListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetUnionRankListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetUnionRankListResponseFormatter : MemoryPackFormatter<GetUnionRankListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetUnionRankListResponse value)
		{
			GetUnionRankListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetUnionRankListResponse value)
		{
			GetUnionRankListResponse.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(1)]
	public List<PbUnionCopyRankInfo> CopyRankInfos { get; set; } = new List<PbUnionCopyRankInfo>();

	[MemoryPackOrder(2)]
	public List<PbUnionMemberRankInfo> MemberRankInfos { get; set; } = new List<PbUnionMemberRankInfo>();

	public static GetUnionRankListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetUnionRankListResponse)) as GetUnionRankListResponse;
		}
		return new GetUnionRankListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionRankInfos.Clear();
			CopyRankInfos.Clear();
			MemberRankInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetUnionRankListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetUnionRankListResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetUnionRankListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetUnionRankListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetUnionRankListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionMemberRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionMemberRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetUnionRankListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionRankInfo>>(value.UnionRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionCopyRankInfo>>(value.CopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionMemberRankInfo>>(value.MemberRankInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetUnionRankListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbUnionRankInfo> value3;
		List<PbUnionCopyRankInfo> value4;
		List<PbUnionMemberRankInfo> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionRankInfos;
				value4 = value.CopyRankInfos;
				value5 = value.MemberRankInfos;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbUnionRankInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbUnionCopyRankInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbUnionMemberRankInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetUnionRankListResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionRankInfos;
				value4 = value.CopyRankInfos;
				value5 = value.MemberRankInfos;
				value6 = value.RpcId;
				value7 = value.Error;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
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
				goto IL_018c;
			}
		}
		value = new GetUnionRankListResponse
		{
			IsFromPool = value2,
			UnionRankInfos = value3,
			CopyRankInfos = value4,
			MemberRankInfos = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.UnionRankInfos = value3;
		value.CopyRankInfos = value4;
		value.MemberRankInfos = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
