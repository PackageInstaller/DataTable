using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10691)]
[MemoryPackable(GenerateType.Object)]
public class GetUnionInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetUnionInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetUnionInfoResponseFormatter : MemoryPackFormatter<GetUnionInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetUnionInfoResponse value)
		{
			GetUnionInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetUnionInfoResponse value)
		{
			GetUnionInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbUnionInfo UnionInfo { get; set; }

	[MemoryPackOrder(1)]
	public List<PbUnionMemberInfo> Members { get; set; } = new List<PbUnionMemberInfo>();

	[MemoryPackOrder(2)]
	public List<int> DailyTaskIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public List<PbState> UserDailyTaskDoneValues { get; set; } = new List<PbState>();

	[MemoryPackOrder(4)]
	public int DailyActiveRewardState { get; set; }

	[MemoryPackOrder(5)]
	public PbUserUnionInfo UserUnionInfo { get; set; }

	public static GetUnionInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetUnionInfoResponse)) as GetUnionInfoResponse;
		}
		return new GetUnionInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionInfo = null;
			Members.Clear();
			DailyTaskIds.Clear();
			UserDailyTaskDoneValues.Clear();
			DailyActiveRewardState = 0;
			UserUnionInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetUnionInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetUnionInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetUnionInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetUnionInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetUnionInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionMemberInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionMemberInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbState>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetUnionInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		writer.WritePackable<PbUnionInfo>(value.UnionInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionMemberInfo>>(value.Members));
		writer.WriteValue<List<int>>(value.DailyTaskIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbState>>(value.UserDailyTaskDoneValues));
		writer.WriteUnmanaged<int>(value.DailyActiveRewardState);
		writer.WritePackable<PbUserUnionInfo>(value.UserUnionInfo);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetUnionInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbUnionInfo value3;
		List<PbUnionMemberInfo> value4;
		List<int> value5;
		List<PbState> value6;
		int value7;
		PbUserUnionInfo value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.Members;
				value5 = value.DailyTaskIds;
				value6 = value.UserDailyTaskDoneValues;
				value7 = value.DailyActiveRewardState;
				value8 = value.UserUnionInfo;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadValue(ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadPackable(ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_0224;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionInfo>();
			value4 = ListFormatter.DeserializePackable<PbUnionMemberInfo>(ref reader);
			value5 = reader.ReadValue<List<int>>();
			value6 = ListFormatter.DeserializePackable<PbState>(ref reader);
			reader.ReadUnmanaged<int>(out value7);
			value8 = reader.ReadPackable<PbUserUnionInfo>();
			reader.ReadUnmanaged<int, int>(out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetUnionInfoResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = null;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.Members;
				value5 = value.DailyTaskIds;
				value6 = value.UserDailyTaskDoneValues;
				value7 = value.DailyActiveRewardState;
				value8 = value.UserUnionInfo;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadPackable(ref value8);
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
				goto IL_0224;
			}
		}
		value = new GetUnionInfoResponse
		{
			IsFromPool = value2,
			UnionInfo = value3,
			Members = value4,
			DailyTaskIds = value5,
			UserDailyTaskDoneValues = value6,
			DailyActiveRewardState = value7,
			UserUnionInfo = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_0224:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.Members = value4;
		value.DailyTaskIds = value5;
		value.UserDailyTaskDoneValues = value6;
		value.DailyActiveRewardState = value7;
		value.UserUnionInfo = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
