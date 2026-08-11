using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10819)]
[MemoryPackable(GenerateType.Object)]
public class S2CGetUnionCopyInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2CGetUnionCopyInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2CGetUnionCopyInfoResponseFormatter : MemoryPackFormatter<S2CGetUnionCopyInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2CGetUnionCopyInfoResponse value)
		{
			S2CGetUnionCopyInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2CGetUnionCopyInfoResponse value)
		{
			S2CGetUnionCopyInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int ChallengeNum { get; set; }

	[MemoryPackOrder(1)]
	public List<PbUnionCopyInfo> CopyInfos { get; set; } = new List<PbUnionCopyInfo>();

	[MemoryPackOrder(2)]
	public long Score { get; set; }

	public static S2CGetUnionCopyInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2CGetUnionCopyInfoResponse)) as S2CGetUnionCopyInfoResponse;
		}
		return new S2CGetUnionCopyInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ChallengeNum = 0;
			CopyInfos.Clear();
			Score = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2CGetUnionCopyInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetUnionCopyInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2CGetUnionCopyInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetUnionCopyInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2CGetUnionCopyInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbUnionCopyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbUnionCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2CGetUnionCopyInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(7, value.IsFromPool, value.ChallengeNum);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbUnionCopyInfo>>(value.CopyInfos));
		writer.WriteUnmanaged<long, int, int>(value.Score, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2CGetUnionCopyInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbUnionCopyInfo> value4;
		long value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ChallengeNum;
				value4 = value.CopyInfos;
				value5 = value.Score;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0182;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbUnionCopyInfo>(ref reader);
			reader.ReadUnmanaged<long, int, int>(out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2CGetUnionCopyInfoResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ChallengeNum;
				value4 = value.CopyInfos;
				value5 = value.Score;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_0182;
			}
		}
		value = new S2CGetUnionCopyInfoResponse
		{
			IsFromPool = value2,
			ChallengeNum = value3,
			CopyInfos = value4,
			Score = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0182:
		value.IsFromPool = value2;
		value.ChallengeNum = value3;
		value.CopyInfos = value4;
		value.Score = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
