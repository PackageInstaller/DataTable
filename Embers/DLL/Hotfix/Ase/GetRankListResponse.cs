using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10178)]
[MemoryPackable(GenerateType.Object)]
public class GetRankListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetRankListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetRankListResponseFormatter : MemoryPackFormatter<GetRankListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetRankListResponse value)
		{
			GetRankListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetRankListResponse value)
		{
			GetRankListResponse.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(4)]
	public int ZoomId { get; set; }

	[MemoryPackOrder(5)]
	public List<PbChallengeCopyRankInfo> ChallengeCopyRankInfos { get; set; } = new List<PbChallengeCopyRankInfo>();

	[MemoryPackOrder(10)]
	public int TotalPage { get; set; }

	public static GetRankListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetRankListResponse)) as GetRankListResponse;
		}
		return new GetRankListResponse();
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
			ZoomId = 0;
			ChallengeCopyRankInfos.Clear();
			TotalPage = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetRankListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetRankListResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetRankListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetRankListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetRankListResponse>());
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
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbChallengeCopyRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbChallengeCopyRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetRankListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRaceCopyRankInfo>>(value.RaceCopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyRankInfo>>(value.SuitboxCopyRankInfos));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHeroRankInfo>>(value.HeroRankInfos));
		writer.WriteUnmanaged<int>(value.ZoomId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbChallengeCopyRankInfo>>(value.ChallengeCopyRankInfos));
		writer.WriteUnmanaged<int, int, int>(value.TotalPage, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetRankListResponse? value)
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
		List<PbChallengeCopyRankInfo> value7;
		int value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RaceCopyRankInfos;
				value4 = value.SuitboxCopyRankInfos;
				value5 = value.HeroRankInfos;
				value6 = value.ZoomId;
				value7 = value.ChallengeCopyRankInfos;
				value8 = value.TotalPage;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_021e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbRaceCopyRankInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbSuitboxCopyRankInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbHeroRankInfo>(ref reader);
			reader.ReadUnmanaged<int>(out value6);
			value7 = ListFormatter.DeserializePackable<PbChallengeCopyRankInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value8, out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetRankListResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RaceCopyRankInfos;
				value4 = value.SuitboxCopyRankInfos;
				value5 = value.HeroRankInfos;
				value6 = value.ZoomId;
				value7 = value.ChallengeCopyRankInfos;
				value8 = value.TotalPage;
				value9 = value.RpcId;
				value10 = value.Error;
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
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													message = reader.ReadString();
													_ = 10;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_021e;
			}
		}
		value = new GetRankListResponse
		{
			IsFromPool = value2,
			RaceCopyRankInfos = value3,
			SuitboxCopyRankInfos = value4,
			HeroRankInfos = value5,
			ZoomId = value6,
			ChallengeCopyRankInfos = value7,
			TotalPage = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_021e:
		value.IsFromPool = value2;
		value.RaceCopyRankInfos = value3;
		value.SuitboxCopyRankInfos = value4;
		value.HeroRankInfos = value5;
		value.ZoomId = value6;
		value.ChallengeCopyRankInfos = value7;
		value.TotalPage = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
