using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10888)]
[MemoryPackable(GenerateType.Object)]
public class GetHomeComeInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetHomeComeInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetHomeComeInfoResponseFormatter : MemoryPackFormatter<GetHomeComeInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetHomeComeInfoResponse value)
		{
			GetHomeComeInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetHomeComeInfoResponse value)
		{
			GetHomeComeInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool IsInReturn { get; set; }

	[MemoryPackOrder(1)]
	public long ReturnStartTime { get; set; }

	[MemoryPackOrder(2)]
	public bool GiftClaimed { get; set; }

	[MemoryPackOrder(3)]
	public List<int> SignedIds { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public List<PbHomeComeTaskProgress> TaskProgress { get; set; } = new List<PbHomeComeTaskProgress>();

	[MemoryPackOrder(5)]
	public List<int> TaskClaimed { get; set; } = new List<int>();

	[MemoryPackOrder(6)]
	public int SignDays { get; set; }

	public static GetHomeComeInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetHomeComeInfoResponse)) as GetHomeComeInfoResponse;
		}
		return new GetHomeComeInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			IsInReturn = false;
			ReturnStartTime = 0L;
			GiftClaimed = false;
			SignedIds.Clear();
			TaskProgress.Clear();
			TaskClaimed.Clear();
			SignDays = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetHomeComeInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetHomeComeInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetHomeComeInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetHomeComeInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetHomeComeInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbHomeComeTaskProgress>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbHomeComeTaskProgress>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetHomeComeInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool, long, bool>(11, value.IsFromPool, value.IsInReturn, value.ReturnStartTime, value.GiftClaimed);
		writer.WriteValue<List<int>>(value.SignedIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHomeComeTaskProgress>>(value.TaskProgress));
		writer.WriteValue<List<int>>(value.TaskClaimed);
		writer.WriteUnmanaged<int, int, int>(value.SignDays, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetHomeComeInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		long value4;
		bool value5;
		List<int> value6;
		List<PbHomeComeTaskProgress> value7;
		List<int> value8;
		int value9;
		int value10;
		int value11;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.IsInReturn;
				value4 = value.ReturnStartTime;
				value5 = value.GiftClaimed;
				value6 = value.SignedIds;
				value7 = value.TaskProgress;
				value8 = value.TaskClaimed;
				value9 = value.SignDays;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadValue(ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadValue(ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				message = reader.ReadString();
				goto IL_0244;
			}
			reader.ReadUnmanaged<bool, bool, long, bool>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadValue<List<int>>();
			value7 = ListFormatter.DeserializePackable<PbHomeComeTaskProgress>(ref reader);
			value8 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, int>(out value9, out value10, out value11);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetHomeComeInfoResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				value4 = 0L;
				value5 = false;
				value6 = null;
				value7 = null;
				value8 = null;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.IsInReturn;
				value4 = value.ReturnStartTime;
				value5 = value.GiftClaimed;
				value6 = value.SignedIds;
				value7 = value.TaskProgress;
				value8 = value.TaskClaimed;
				value9 = value.SignDays;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<bool>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadValue(ref value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														message = reader.ReadString();
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_0244;
			}
		}
		value = new GetHomeComeInfoResponse
		{
			IsFromPool = value2,
			IsInReturn = value3,
			ReturnStartTime = value4,
			GiftClaimed = value5,
			SignedIds = value6,
			TaskProgress = value7,
			TaskClaimed = value8,
			SignDays = value9,
			RpcId = value10,
			Error = value11,
			Message = message
		};
		return;
		IL_0244:
		value.IsFromPool = value2;
		value.IsInReturn = value3;
		value.ReturnStartTime = value4;
		value.GiftClaimed = value5;
		value.SignedIds = value6;
		value.TaskProgress = value7;
		value.TaskClaimed = value8;
		value.SignDays = value9;
		value.RpcId = value10;
		value.Error = value11;
		value.Message = message;
	}
}
