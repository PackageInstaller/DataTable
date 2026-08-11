using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10308)]
[MemoryPackable(GenerateType.Object)]
public class GetAllActivityTaskRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetAllActivityTaskRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetAllActivityTaskRewardResponseFormatter : MemoryPackFormatter<GetAllActivityTaskRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetAllActivityTaskRewardResponse value)
		{
			GetAllActivityTaskRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetAllActivityTaskRewardResponse value)
		{
			GetAllActivityTaskRewardResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(1)]
	public List<PbActivityTaskData> Datas { get; set; } = new List<PbActivityTaskData>();

	public static GetAllActivityTaskRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetAllActivityTaskRewardResponse)) as GetAllActivityTaskRewardResponse;
		}
		return new GetAllActivityTaskRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rewards = null;
			Datas.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetAllActivityTaskRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetAllActivityTaskRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetAllActivityTaskRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetAllActivityTaskRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetAllActivityTaskRewardResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityTaskData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityTaskData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetAllActivityTaskRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityTaskData>>(value.Datas));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetAllActivityTaskRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		List<PbActivityTaskData> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.Datas;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			value4 = ListFormatter.DeserializePackable<PbActivityTaskData>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetAllActivityTaskRewardResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.Datas;
				value5 = value.RpcId;
				value6 = value.Error;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_015b;
			}
		}
		value = new GetAllActivityTaskRewardResponse
		{
			IsFromPool = value2,
			Rewards = value3,
			Datas = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.Datas = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
