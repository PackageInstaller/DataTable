using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10559)]
[MemoryPackable(GenerateType.Object)]
public class GetFarmInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetFarmInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFarmInfoResponseFormatter : MemoryPackFormatter<GetFarmInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFarmInfoResponse value)
		{
			GetFarmInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFarmInfoResponse value)
		{
			GetFarmInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbFarmGridInfo> Grids { get; set; } = new List<PbFarmGridInfo>();

	[MemoryPackOrder(1)]
	public List<PbFriendFarmGridState> FriendFarmStates { get; set; } = new List<PbFriendFarmGridState>();

	[MemoryPackOrder(2)]
	public int UnlockedFarmSeedList { get; set; }

	[MemoryPackOrder(3)]
	public int TodayFriendIncreaseCount { get; set; }

	[MemoryPackOrder(4)]
	public int TodayFriendHarvestCount { get; set; }

	public static GetFarmInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFarmInfoResponse)) as GetFarmInfoResponse;
		}
		return new GetFarmInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Grids.Clear();
			FriendFarmStates.Clear();
			UnlockedFarmSeedList = 0;
			TodayFriendIncreaseCount = 0;
			TodayFriendHarvestCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFarmInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFarmInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetFarmInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFarmInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFarmInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFarmGridInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFarmGridInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendFarmGridState>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendFarmGridState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFarmInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(9, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFarmGridInfo>>(value.Grids));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendFarmGridState>>(value.FriendFarmStates));
		writer.WriteUnmanaged<int, int, int, int, int>(value.UnlockedFarmSeedList, value.TodayFriendIncreaseCount, value.TodayFriendHarvestCount, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFarmInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbFarmGridInfo> value3;
		List<PbFriendFarmGridState> value4;
		int value5;
		int value6;
		int value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Grids;
				value4 = value.FriendFarmStates;
				value5 = value.UnlockedFarmSeedList;
				value6 = value.TodayFriendIncreaseCount;
				value7 = value.TodayFriendHarvestCount;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01e0;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbFarmGridInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbFriendFarmGridState>(ref reader);
			reader.ReadUnmanaged<int, int, int, int, int>(out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFarmInfoResponse), 9, memberCount);
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
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Grids;
				value4 = value.FriendFarmStates;
				value5 = value.UnlockedFarmSeedList;
				value6 = value.TodayFriendIncreaseCount;
				value7 = value.TodayFriendHarvestCount;
				value8 = value.RpcId;
				value9 = value.Error;
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
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
												_ = 9;
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
				goto IL_01e0;
			}
		}
		value = new GetFarmInfoResponse
		{
			IsFromPool = value2,
			Grids = value3,
			FriendFarmStates = value4,
			UnlockedFarmSeedList = value5,
			TodayFriendIncreaseCount = value6,
			TodayFriendHarvestCount = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01e0:
		value.IsFromPool = value2;
		value.Grids = value3;
		value.FriendFarmStates = value4;
		value.UnlockedFarmSeedList = value5;
		value.TodayFriendIncreaseCount = value6;
		value.TodayFriendHarvestCount = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
