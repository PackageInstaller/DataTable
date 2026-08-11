using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1085)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetUnionInfoResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerGetUnionInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetUnionInfoResponseFormatter : MemoryPackFormatter<InnerGetUnionInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionInfoResponse value)
		{
			InnerGetUnionInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionInfoResponse value)
		{
			InnerGetUnionInfoResponse.Deserialize(ref reader, ref value);
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

	public static InnerGetUnionInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetUnionInfoResponse)) as InnerGetUnionInfoResponse;
		}
		return new InnerGetUnionInfoResponse();
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
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetUnionInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetUnionInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetUnionInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionMemberInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionMemberInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbUnionInfo>(value.UnionInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionMemberInfo>>(value.Members));
		writer.WriteValue<List<int>>(value.DailyTaskIds);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionInfoResponse? value)
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
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.Members;
				value5 = value.DailyTaskIds;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionInfo>();
			value4 = ListFormatter.DeserializePackable<PbUnionMemberInfo>(ref reader);
			value5 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetUnionInfoResponse), 7, memberCount);
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
				value3 = value.UnionInfo;
				value4 = value.Members;
				value5 = value.DailyTaskIds;
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
		value = new InnerGetUnionInfoResponse
		{
			IsFromPool = value2,
			UnionInfo = value3,
			Members = value4,
			DailyTaskIds = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.Members = value4;
		value.DailyTaskIds = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
