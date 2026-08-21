using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1062)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateSuitboxCopyRankInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpdateSuitboxCopyRankInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateSuitboxCopyRankInfoRequestFormatter : MemoryPackFormatter<InnerUpdateSuitboxCopyRankInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateSuitboxCopyRankInfoRequest value)
		{
			InnerUpdateSuitboxCopyRankInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateSuitboxCopyRankInfoRequest value)
		{
			InnerUpdateSuitboxCopyRankInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public int CopyType { get; set; }

	[MemoryPackOrder(1)]
	public List<PbSuitboxCopyRankSingleUserInfo> UserInfos { get; set; } = new List<PbSuitboxCopyRankSingleUserInfo>();

	[MemoryPackOrder(2)]
	public int Score { get; set; }

	[MemoryPackOrder(3)]
	public long TeamId { get; set; }

	public static InnerUpdateSuitboxCopyRankInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateSuitboxCopyRankInfoRequest)) as InnerUpdateSuitboxCopyRankInfoRequest;
		}
		return new InnerUpdateSuitboxCopyRankInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			CopyType = 0;
			UserInfos.Clear();
			Score = 0;
			TeamId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateSuitboxCopyRankInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateSuitboxCopyRankInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateSuitboxCopyRankInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateSuitboxCopyRankInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateSuitboxCopyRankInfoRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSuitboxCopyRankSingleUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSuitboxCopyRankSingleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateSuitboxCopyRankInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(6, value.IsFromPool, value.CopyType);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyRankSingleUserInfo>>(value.UserInfos));
		writer.WriteUnmanaged<int, long, int>(value.Score, value.TeamId, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateSuitboxCopyRankInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbSuitboxCopyRankSingleUserInfo> value4;
		int value5;
		long value6;
		int value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyType;
				value4 = value.UserInfos;
				value5 = value.Score;
				value6 = value.TeamId;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_0151;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbSuitboxCopyRankSingleUserInfo>(ref reader);
			reader.ReadUnmanaged<int, long, int>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateSuitboxCopyRankInfoRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyType;
				value4 = value.UserInfos;
				value5 = value.Score;
				value6 = value.TeamId;
				value7 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0151;
			}
		}
		value = new InnerUpdateSuitboxCopyRankInfoRequest
		{
			IsFromPool = value2,
			CopyType = value3,
			UserInfos = value4,
			Score = value5,
			TeamId = value6,
			RpcId = value7
		};
		return;
		IL_0151:
		value.IsFromPool = value2;
		value.CopyType = value3;
		value.UserInfos = value4;
		value.Score = value5;
		value.TeamId = value6;
		value.RpcId = value7;
	}
}
