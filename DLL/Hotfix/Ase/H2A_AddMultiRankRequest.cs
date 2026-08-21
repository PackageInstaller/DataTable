using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1060)]
[MemoryPackable(GenerateType.Object)]
public class H2A_AddMultiRankRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2A_AddMultiRankRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2A_AddMultiRankRequestFormatter : MemoryPackFormatter<H2A_AddMultiRankRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2A_AddMultiRankRequest value)
		{
			H2A_AddMultiRankRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2A_AddMultiRankRequest value)
		{
			H2A_AddMultiRankRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(3)]
	public int CopyId { get; set; }

	[MemoryPackOrder(4)]
	public int PassTime { get; set; }

	[MemoryPackOrder(5)]
	public List<PbInnerRankTeamInfo> TeamInfos { get; set; } = new List<PbInnerRankTeamInfo>();

	public static H2A_AddMultiRankRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2A_AddMultiRankRequest)) as H2A_AddMultiRankRequest;
		}
		return new H2A_AddMultiRankRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoomId = 0L;
			CopyId = 0;
			PassTime = 0;
			TeamInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2A_AddMultiRankRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2A_AddMultiRankRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2A_AddMultiRankRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2A_AddMultiRankRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2A_AddMultiRankRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbInnerRankTeamInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbInnerRankTeamInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2A_AddMultiRankRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(6, value.IsFromPool, value.RoomId, value.CopyId, value.PassTime);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbInnerRankTeamInfo>>(value.TeamInfos));
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2A_AddMultiRankRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		List<PbInnerRankTeamInfo> value6;
		int value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.CopyId;
				value5 = value.PassTime;
				value6 = value.TeamInfos;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbInnerRankTeamInfo>(ref reader);
			reader.ReadUnmanaged<int>(out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2A_AddMultiRankRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.CopyId;
				value5 = value.PassTime;
				value6 = value.TeamInfos;
				value7 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
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
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new H2A_AddMultiRankRequest
		{
			IsFromPool = value2,
			RoomId = value3,
			CopyId = value4,
			PassTime = value5,
			TeamInfos = value6,
			RpcId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.CopyId = value4;
		value.PassTime = value5;
		value.TeamInfos = value6;
		value.RpcId = value7;
	}
}
