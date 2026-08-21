using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10733)]
[MemoryPackable(GenerateType.Object)]
public class GetRaceCopyInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetRaceCopyInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetRaceCopyInfoResponseFormatter : MemoryPackFormatter<GetRaceCopyInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetRaceCopyInfoResponse value)
		{
			GetRaceCopyInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetRaceCopyInfoResponse value)
		{
			GetRaceCopyInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbRaceCopyInfo> CopyInfos { get; set; } = new List<PbRaceCopyInfo>();

	[MemoryPackOrder(1)]
	public List<PbRaceCopyInfo> CurCopyInfos { get; set; } = new List<PbRaceCopyInfo>();

	[MemoryPackOrder(2)]
	public List<PbRaceCopyTroopInfo> Troops { get; set; } = new List<PbRaceCopyTroopInfo>();

	[MemoryPackOrder(9)]
	public string param1 { get; set; }

	public static GetRaceCopyInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetRaceCopyInfoResponse)) as GetRaceCopyInfoResponse;
		}
		return new GetRaceCopyInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			CopyInfos.Clear();
			CurCopyInfos.Clear();
			Troops.Clear();
			param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetRaceCopyInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetRaceCopyInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetRaceCopyInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetRaceCopyInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetRaceCopyInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRaceCopyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRaceCopyInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRaceCopyTroopInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRaceCopyTroopInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetRaceCopyInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		List<PbRaceCopyInfo> source = value.CopyInfos;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.CurCopyInfos;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRaceCopyTroopInfo>>(value.Troops));
		writer.WriteString(value.param1);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetRaceCopyInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbRaceCopyInfo> value3;
		List<PbRaceCopyInfo> value4;
		List<PbRaceCopyTroopInfo> value5;
		int value6;
		int value7;
		string text;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyInfos;
				value4 = value.CurCopyInfos;
				value5 = value.Troops;
				text = value.param1;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_01bd;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbRaceCopyInfo>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbRaceCopyInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbRaceCopyTroopInfo>(ref reader);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetRaceCopyInfoResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				text = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyInfos;
				value4 = value.CurCopyInfos;
				value5 = value.Troops;
				text = value.param1;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								text = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											_ = 8;
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
				goto IL_01bd;
			}
		}
		value = new GetRaceCopyInfoResponse
		{
			IsFromPool = value2,
			CopyInfos = value3,
			CurCopyInfos = value4,
			Troops = value5,
			param1 = text,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_01bd:
		value.IsFromPool = value2;
		value.CopyInfos = value3;
		value.CurCopyInfos = value4;
		value.Troops = value5;
		value.param1 = text;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
