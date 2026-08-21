using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1122)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetRankListResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerGetRankListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetRankListResponseFormatter : MemoryPackFormatter<InnerGetRankListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetRankListResponse value)
		{
			InnerGetRankListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetRankListResponse value)
		{
			InnerGetRankListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(1)]
	public List<PbRaceCopyRankInfo> RaceCopyRankInfos { get; set; } = new List<PbRaceCopyRankInfo>();

	[MemoryPackOrder(2)]
	public List<PbSuitboxCopyRankInfo> SuitboxCopyRankInfos { get; set; } = new List<PbSuitboxCopyRankInfo>();

	[MemoryPackOrder(3)]
	public List<PbHeroRankInfo> HeroRankInfos { get; set; } = new List<PbHeroRankInfo>();

	public static InnerGetRankListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetRankListResponse)) as InnerGetRankListResponse;
		}
		return new InnerGetRankListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RaceCopyRankInfos.Clear();
			SuitboxCopyRankInfos.Clear();
			HeroRankInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetRankListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetRankListResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetRankListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetRankListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetRankListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRaceCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRaceCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSuitboxCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSuitboxCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbHeroRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbHeroRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetRankListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRaceCopyRankInfo>>(value.RaceCopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyRankInfo>>(value.SuitboxCopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHeroRankInfo>>(value.HeroRankInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetRankListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbRaceCopyRankInfo> value3;
		List<PbSuitboxCopyRankInfo> value4;
		List<PbHeroRankInfo> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RaceCopyRankInfos;
				value4 = value.SuitboxCopyRankInfos;
				value5 = value.HeroRankInfos;
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
			value3 = ListFormatter.DeserializePackable<PbRaceCopyRankInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbSuitboxCopyRankInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbHeroRankInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetRankListResponse), 7, memberCount);
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
				value3 = value.RaceCopyRankInfos;
				value4 = value.SuitboxCopyRankInfos;
				value5 = value.HeroRankInfos;
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
		value = new InnerGetRankListResponse
		{
			IsFromPool = value2,
			RaceCopyRankInfos = value3,
			SuitboxCopyRankInfos = value4,
			HeroRankInfos = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.RaceCopyRankInfos = value3;
		value.SuitboxCopyRankInfos = value4;
		value.HeroRankInfos = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
