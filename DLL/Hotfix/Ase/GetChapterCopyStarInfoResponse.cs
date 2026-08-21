using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10283)]
[MemoryPackable(GenerateType.Object)]
public class GetChapterCopyStarInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetChapterCopyStarInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetChapterCopyStarInfoResponseFormatter : MemoryPackFormatter<GetChapterCopyStarInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetChapterCopyStarInfoResponse value)
		{
			GetChapterCopyStarInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetChapterCopyStarInfoResponse value)
		{
			GetChapterCopyStarInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(92)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbChapterCopyStarInfo> PurpleStarInfos { get; set; } = new List<PbChapterCopyStarInfo>();

	[MemoryPackOrder(1)]
	public List<PbChapterCopyStarInfo> GoldStarInfos { get; set; } = new List<PbChapterCopyStarInfo>();

	[MemoryPackOrder(2)]
	public int WeekRank { get; set; }

	public static GetChapterCopyStarInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetChapterCopyStarInfoResponse)) as GetChapterCopyStarInfoResponse;
		}
		return new GetChapterCopyStarInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			PurpleStarInfos.Clear();
			GoldStarInfos.Clear();
			WeekRank = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetChapterCopyStarInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetChapterCopyStarInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetChapterCopyStarInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetChapterCopyStarInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetChapterCopyStarInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbChapterCopyStarInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbChapterCopyStarInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetChapterCopyStarInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		List<PbChapterCopyStarInfo> source = value.PurpleStarInfos;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.GoldStarInfos;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int, int, int>(value.WeekRank, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetChapterCopyStarInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbChapterCopyStarInfo> value3;
		List<PbChapterCopyStarInfo> value4;
		int value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PurpleStarInfos;
				value4 = value.GoldStarInfos;
				value5 = value.WeekRank;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0186;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbChapterCopyStarInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbChapterCopyStarInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetChapterCopyStarInfoResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PurpleStarInfos;
				value4 = value.GoldStarInfos;
				value5 = value.WeekRank;
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
							reader.ReadUnmanaged<int>(out value5);
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
				goto IL_0186;
			}
		}
		value = new GetChapterCopyStarInfoResponse
		{
			IsFromPool = value2,
			PurpleStarInfos = value3,
			GoldStarInfos = value4,
			WeekRank = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0186:
		value.IsFromPool = value2;
		value.PurpleStarInfos = value3;
		value.GoldStarInfos = value4;
		value.WeekRank = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
