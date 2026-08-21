using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10871)]
[MemoryPackable(GenerateType.Object)]
public class GetChallengeCopyPlayerRankInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetChallengeCopyPlayerRankInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetChallengeCopyPlayerRankInfoResponseFormatter : MemoryPackFormatter<GetChallengeCopyPlayerRankInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetChallengeCopyPlayerRankInfoResponse value)
		{
			GetChallengeCopyPlayerRankInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetChallengeCopyPlayerRankInfoResponse value)
		{
			GetChallengeCopyPlayerRankInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int ZoomId { get; set; }

	[MemoryPackOrder(1)]
	public int TotalScore { get; set; }

	[MemoryPackOrder(2)]
	public int TotalScoreRank { get; set; }

	[MemoryPackOrder(3)]
	public List<PbChallengeCopyPlayerScoreInfo> CopyScores { get; set; } = new List<PbChallengeCopyPlayerScoreInfo>();

	public static GetChallengeCopyPlayerRankInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetChallengeCopyPlayerRankInfoResponse)) as GetChallengeCopyPlayerRankInfoResponse;
		}
		return new GetChallengeCopyPlayerRankInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ZoomId = 0;
			TotalScore = 0;
			TotalScoreRank = 0;
			CopyScores.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetChallengeCopyPlayerRankInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetChallengeCopyPlayerRankInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetChallengeCopyPlayerRankInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetChallengeCopyPlayerRankInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetChallengeCopyPlayerRankInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbChallengeCopyPlayerScoreInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbChallengeCopyPlayerScoreInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetChallengeCopyPlayerRankInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(8, value.IsFromPool, value.ZoomId, value.TotalScore, value.TotalScoreRank);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbChallengeCopyPlayerScoreInfo>>(value.CopyScores));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetChallengeCopyPlayerRankInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		List<PbChallengeCopyPlayerScoreInfo> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ZoomId;
				value4 = value.TotalScore;
				value5 = value.TotalScoreRank;
				value6 = value.CopyScores;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01ad;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbChallengeCopyPlayerScoreInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetChallengeCopyPlayerRankInfoResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ZoomId;
				value4 = value.TotalScore;
				value5 = value.TotalScoreRank;
				value6 = value.CopyScores;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											_ = 8;
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
				goto IL_01ad;
			}
		}
		value = new GetChallengeCopyPlayerRankInfoResponse
		{
			IsFromPool = value2,
			ZoomId = value3,
			TotalScore = value4,
			TotalScoreRank = value5,
			CopyScores = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01ad:
		value.IsFromPool = value2;
		value.ZoomId = value3;
		value.TotalScore = value4;
		value.TotalScoreRank = value5;
		value.CopyScores = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
