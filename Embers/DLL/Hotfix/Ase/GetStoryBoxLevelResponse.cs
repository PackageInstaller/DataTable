using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10755)]
[MemoryPackable(GenerateType.Object)]
public class GetStoryBoxLevelResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetStoryBoxLevelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetStoryBoxLevelResponseFormatter : MemoryPackFormatter<GetStoryBoxLevelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetStoryBoxLevelResponse value)
		{
			GetStoryBoxLevelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetStoryBoxLevelResponse value)
		{
			GetStoryBoxLevelResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbIdValue> OpenCounts { get; set; } = new List<PbIdValue>();

	[MemoryPackOrder(1)]
	public int Collection { get; set; }

	public static GetStoryBoxLevelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetStoryBoxLevelResponse)) as GetStoryBoxLevelResponse;
		}
		return new GetStoryBoxLevelResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			OpenCounts.Clear();
			Collection = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetStoryBoxLevelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetStoryBoxLevelResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetStoryBoxLevelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetStoryBoxLevelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetStoryBoxLevelResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbIdValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbIdValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetStoryBoxLevelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbIdValue>>(value.OpenCounts));
		writer.WriteUnmanaged<int, int, int>(value.Collection, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetStoryBoxLevelResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbIdValue> value3;
		int value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.OpenCounts;
				value4 = value.Collection;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetStoryBoxLevelResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.OpenCounts;
				value4 = value.Collection;
				value5 = value.RpcId;
				value6 = value.Error;
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
				goto IL_0156;
			}
		}
		value = new GetStoryBoxLevelResponse
		{
			IsFromPool = value2,
			OpenCounts = value3,
			Collection = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.OpenCounts = value3;
		value.Collection = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
