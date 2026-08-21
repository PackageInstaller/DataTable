using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10719)]
[MemoryPackable(GenerateType.Object)]
public class GetUnionBaseInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetUnionBaseInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetUnionBaseInfoResponseFormatter : MemoryPackFormatter<GetUnionBaseInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetUnionBaseInfoResponse value)
		{
			GetUnionBaseInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetUnionBaseInfoResponse value)
		{
			GetUnionBaseInfoResponse.Deserialize(ref reader, ref value);
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
	public PbUserUnionInfo UserUnionInfo { get; set; }

	[MemoryPackOrder(2)]
	public List<PbUnionMemberInfo> Members { get; set; } = new List<PbUnionMemberInfo>();

	public static GetUnionBaseInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetUnionBaseInfoResponse)) as GetUnionBaseInfoResponse;
		}
		return new GetUnionBaseInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionInfo = null;
			UserUnionInfo = null;
			Members.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetUnionBaseInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetUnionBaseInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetUnionBaseInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetUnionBaseInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetUnionBaseInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionMemberInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionMemberInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetUnionBaseInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbUnionInfo>(value.UnionInfo);
		writer.WritePackable<PbUserUnionInfo>(value.UserUnionInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionMemberInfo>>(value.Members));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetUnionBaseInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbUnionInfo value3;
		PbUserUnionInfo value4;
		List<PbUnionMemberInfo> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.UserUnionInfo;
				value5 = value.Members;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionInfo>();
			value4 = reader.ReadPackable<PbUserUnionInfo>();
			value5 = ListFormatter.DeserializePackable<PbUnionMemberInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetUnionBaseInfoResponse), 7, memberCount);
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
				value4 = value.UserUnionInfo;
				value5 = value.Members;
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
						reader.ReadPackable(ref value4);
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
		value = new GetUnionBaseInfoResponse
		{
			IsFromPool = value2,
			UnionInfo = value3,
			UserUnionInfo = value4,
			Members = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.UserUnionInfo = value4;
		value.Members = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
