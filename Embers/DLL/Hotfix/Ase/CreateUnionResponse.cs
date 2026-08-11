using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10651)]
[MemoryPackable(GenerateType.Object)]
public class CreateUnionResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<CreateUnionResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CreateUnionResponseFormatter : MemoryPackFormatter<CreateUnionResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CreateUnionResponse value)
		{
			CreateUnionResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CreateUnionResponse value)
		{
			CreateUnionResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbUnionBaseInfo UnionInfo { get; set; }

	[MemoryPackOrder(1)]
	public PbItemChange CostItem { get; set; }

	[MemoryPackOrder(2)]
	public List<int> DailyTaskIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public PbUnionMemberInfo Member { get; set; }

	[MemoryPackOrder(4)]
	public List<PbState> UserDailyTaskDoneValues { get; set; } = new List<PbState>();

	[MemoryPackOrder(5)]
	public int DailyActiveRewardState { get; set; }

	public static CreateUnionResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CreateUnionResponse)) as CreateUnionResponse;
		}
		return new CreateUnionResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionInfo = null;
			CostItem = null;
			DailyTaskIds.Clear();
			Member = null;
			UserDailyTaskDoneValues.Clear();
			DailyActiveRewardState = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CreateUnionResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CreateUnionResponse>())
		{
			MemoryPackFormatterProvider.Register(new CreateUnionResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CreateUnionResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CreateUnionResponse>());
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
	public static void Serialize(ref MemoryPackWriter writer, ref CreateUnionResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		writer.WritePackable<PbUnionBaseInfo>(value.UnionInfo);
		writer.WritePackable<PbItemChange>(value.CostItem);
		writer.WriteValue<List<int>>(value.DailyTaskIds);
		writer.WritePackable<PbUnionMemberInfo>(value.Member);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbState>>(value.UserDailyTaskDoneValues));
		writer.WriteUnmanaged<int, int, int>(value.DailyActiveRewardState, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CreateUnionResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbUnionBaseInfo value3;
		PbItemChange value4;
		List<int> value5;
		PbUnionMemberInfo value6;
		List<PbState> value7;
		int value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.CostItem;
				value5 = value.DailyTaskIds;
				value6 = value.Member;
				value7 = value.UserDailyTaskDoneValues;
				value8 = value.DailyActiveRewardState;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadValue(ref value5);
				reader.ReadPackable(ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_021e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionBaseInfo>();
			value4 = reader.ReadPackable<PbItemChange>();
			value5 = reader.ReadValue<List<int>>();
			value6 = reader.ReadPackable<PbUnionMemberInfo>();
			value7 = ListFormatter.DeserializePackable<PbState>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value8, out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CreateUnionResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.CostItem;
				value5 = value.DailyTaskIds;
				value6 = value.Member;
				value7 = value.UserDailyTaskDoneValues;
				value8 = value.DailyActiveRewardState;
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
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
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
		value = new CreateUnionResponse
		{
			IsFromPool = value2,
			UnionInfo = value3,
			CostItem = value4,
			DailyTaskIds = value5,
			Member = value6,
			UserDailyTaskDoneValues = value7,
			DailyActiveRewardState = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_021e:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.CostItem = value4;
		value.DailyTaskIds = value5;
		value.Member = value6;
		value.UserDailyTaskDoneValues = value7;
		value.DailyActiveRewardState = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
