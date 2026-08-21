using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10902)]
[MemoryPackable(GenerateType.Object)]
public class S2CCollectBuffResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2CCollectBuffResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2CCollectBuffResponseFormatter : MemoryPackFormatter<S2CCollectBuffResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2CCollectBuffResponse value)
		{
			S2CCollectBuffResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2CCollectBuffResponse value)
		{
			S2CCollectBuffResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(1)]
	public List<PbBuffLibraryTaskInfo> TaskInfos { get; set; } = new List<PbBuffLibraryTaskInfo>();

	[MemoryPackOrder(2)]
	public List<int> NewBuffIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public List<int> NewChosenBuffId { get; set; } = new List<int>();

	public static S2CCollectBuffResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2CCollectBuffResponse)) as S2CCollectBuffResponse;
		}
		return new S2CCollectBuffResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			TaskInfos.Clear();
			NewBuffIds.Clear();
			NewChosenBuffId.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2CCollectBuffResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2CCollectBuffResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2CCollectBuffResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2CCollectBuffResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2CCollectBuffResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBuffLibraryTaskInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBuffLibraryTaskInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2CCollectBuffResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBuffLibraryTaskInfo>>(value.TaskInfos));
		writer.WriteValue<List<int>>(value.NewBuffIds);
		writer.WriteValue<List<int>>(value.NewChosenBuffId);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2CCollectBuffResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbBuffLibraryTaskInfo> value3;
		List<int> value4;
		List<int> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskInfos;
				value4 = value.NewBuffIds;
				value5 = value.NewChosenBuffId;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadValue(ref value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbBuffLibraryTaskInfo>(ref reader);
			value4 = reader.ReadValue<List<int>>();
			value5 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2CCollectBuffResponse), 7, memberCount);
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
				value3 = value.TaskInfos;
				value4 = value.NewBuffIds;
				value5 = value.NewChosenBuffId;
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
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
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
		value = new S2CCollectBuffResponse
		{
			IsFromPool = value2,
			TaskInfos = value3,
			NewBuffIds = value4,
			NewChosenBuffId = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.TaskInfos = value3;
		value.NewBuffIds = value4;
		value.NewChosenBuffId = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
