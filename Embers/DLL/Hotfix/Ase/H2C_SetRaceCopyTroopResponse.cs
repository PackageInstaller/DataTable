using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10847)]
[MemoryPackable(GenerateType.Object)]
public class H2C_SetRaceCopyTroopResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_SetRaceCopyTroopResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_SetRaceCopyTroopResponseFormatter : MemoryPackFormatter<H2C_SetRaceCopyTroopResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_SetRaceCopyTroopResponse value)
		{
			H2C_SetRaceCopyTroopResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_SetRaceCopyTroopResponse value)
		{
			H2C_SetRaceCopyTroopResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool RankChange { get; set; }

	[MemoryPackOrder(1)]
	public List<PbRaceCopyTroopInfo> Troops { get; set; } = new List<PbRaceCopyTroopInfo>();

	[MemoryPackOrder(2)]
	public List<PbRaceCopyInfo> CurCopyInfos { get; set; } = new List<PbRaceCopyInfo>();

	[MemoryPackOrder(9)]
	public string param1 { get; set; }

	public static H2C_SetRaceCopyTroopResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_SetRaceCopyTroopResponse)) as H2C_SetRaceCopyTroopResponse;
		}
		return new H2C_SetRaceCopyTroopResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RankChange = false;
			Troops.Clear();
			CurCopyInfos.Clear();
			param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_SetRaceCopyTroopResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_SetRaceCopyTroopResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_SetRaceCopyTroopResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_SetRaceCopyTroopResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_SetRaceCopyTroopResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRaceCopyTroopInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRaceCopyTroopInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRaceCopyInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRaceCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_SetRaceCopyTroopResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool>(8, value.IsFromPool, value.RankChange);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRaceCopyTroopInfo>>(value.Troops));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRaceCopyInfo>>(value.CurCopyInfos));
		writer.WriteString(value.param1);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_SetRaceCopyTroopResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		List<PbRaceCopyTroopInfo> value4;
		List<PbRaceCopyInfo> value5;
		int value6;
		int value7;
		string text;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RankChange;
				value4 = value.Troops;
				value5 = value.CurCopyInfos;
				text = value.param1;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_01b8;
			}
			reader.ReadUnmanaged<bool, bool>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbRaceCopyTroopInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbRaceCopyInfo>(ref reader);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_SetRaceCopyTroopResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
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
				value3 = value.RankChange;
				value4 = value.Troops;
				value5 = value.CurCopyInfos;
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
					reader.ReadUnmanaged<bool>(out value3);
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
				goto IL_01b8;
			}
		}
		value = new H2C_SetRaceCopyTroopResponse
		{
			IsFromPool = value2,
			RankChange = value3,
			Troops = value4,
			CurCopyInfos = value5,
			param1 = text,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_01b8:
		value.IsFromPool = value2;
		value.RankChange = value3;
		value.Troops = value4;
		value.CurCopyInfos = value5;
		value.param1 = text;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
