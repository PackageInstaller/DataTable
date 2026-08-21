using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10788)]
[MemoryPackable(GenerateType.Object)]
public class GetSingleActivityTaskDataResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetSingleActivityTaskDataResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetSingleActivityTaskDataResponseFormatter : MemoryPackFormatter<GetSingleActivityTaskDataResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetSingleActivityTaskDataResponse value)
		{
			GetSingleActivityTaskDataResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetSingleActivityTaskDataResponse value)
		{
			GetSingleActivityTaskDataResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbActivityTypeAllData TaskDatas { get; set; }

	[MemoryPackOrder(1)]
	public List<PbActivityVersionData> ActivityVersionData { get; set; } = new List<PbActivityVersionData>();

	[MemoryPackOrder(2)]
	public List<PbCopyInfo> CopyInfos { get; set; } = new List<PbCopyInfo>();

	public static GetSingleActivityTaskDataResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetSingleActivityTaskDataResponse)) as GetSingleActivityTaskDataResponse;
		}
		return new GetSingleActivityTaskDataResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			TaskDatas = null;
			ActivityVersionData.Clear();
			CopyInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetSingleActivityTaskDataResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetSingleActivityTaskDataResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetSingleActivityTaskDataResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetSingleActivityTaskDataResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetSingleActivityTaskDataResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityVersionData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityVersionData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetSingleActivityTaskDataResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbActivityTypeAllData>(value.TaskDatas);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityVersionData>>(value.ActivityVersionData));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyInfo>>(value.CopyInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetSingleActivityTaskDataResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbActivityTypeAllData value3;
		List<PbActivityVersionData> value4;
		List<PbCopyInfo> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskDatas;
				value4 = value.ActivityVersionData;
				value5 = value.CopyInfos;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbActivityTypeAllData>();
			value4 = ListFormatter.DeserializePackable<PbActivityVersionData>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbCopyInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetSingleActivityTaskDataResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskDatas;
				value4 = value.ActivityVersionData;
				value5 = value.CopyInfos;
				value6 = value.RpcId;
				value7 = value.Error;
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
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
				goto IL_018c;
			}
		}
		value = new GetSingleActivityTaskDataResponse
		{
			IsFromPool = value2,
			TaskDatas = value3,
			ActivityVersionData = value4,
			CopyInfos = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.TaskDatas = value3;
		value.ActivityVersionData = value4;
		value.CopyInfos = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
