using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10799)]
[MemoryPackable(GenerateType.Object)]
public class GetActivityRankProgressResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetActivityRankProgressResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetActivityRankProgressResponseFormatter : MemoryPackFormatter<GetActivityRankProgressResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetActivityRankProgressResponse value)
		{
			GetActivityRankProgressResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetActivityRankProgressResponse value)
		{
			GetActivityRankProgressResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(1)]
	public List<PbActivityRankStateData> RankData { get; set; } = new List<PbActivityRankStateData>();

	public static GetActivityRankProgressResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetActivityRankProgressResponse)) as GetActivityRankProgressResponse;
		}
		return new GetActivityRankProgressResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RankData.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetActivityRankProgressResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetActivityRankProgressResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetActivityRankProgressResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetActivityRankProgressResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetActivityRankProgressResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityRankStateData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityRankStateData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetActivityRankProgressResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityRankStateData>>(value.RankData));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetActivityRankProgressResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbActivityRankStateData> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RankData;
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
			value3 = ListFormatter.DeserializePackable<PbActivityRankStateData>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetActivityRankProgressResponse), 5, memberCount);
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
				value3 = value.RankData;
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
		value = new GetActivityRankProgressResponse
		{
			IsFromPool = value2,
			RankData = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.RankData = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
