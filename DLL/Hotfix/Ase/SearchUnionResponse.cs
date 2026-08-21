using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10655)]
[MemoryPackable(GenerateType.Object)]
public class SearchUnionResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<SearchUnionResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SearchUnionResponseFormatter : MemoryPackFormatter<SearchUnionResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SearchUnionResponse value)
		{
			SearchUnionResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SearchUnionResponse value)
		{
			SearchUnionResponse.Deserialize(ref reader, ref value);
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

	public static SearchUnionResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SearchUnionResponse)) as SearchUnionResponse;
		}
		return new SearchUnionResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SearchUnionResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SearchUnionResponse>())
		{
			MemoryPackFormatterProvider.Register(new SearchUnionResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SearchUnionResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SearchUnionResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SearchUnionResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<PbUnionBaseInfo>(value.UnionInfo);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SearchUnionResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbUnionBaseInfo value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionBaseInfo>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SearchUnionResponse), 5, memberCount);
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
				value3 = value.UnionInfo;
				value4 = value.RpcId;
				value5 = value.Error;
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
		value = new SearchUnionResponse
		{
			IsFromPool = value2,
			UnionInfo = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
