using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10202)]
[MemoryPackable(GenerateType.Object)]
public class HeroBreakResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<HeroBreakResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HeroBreakResponseFormatter : MemoryPackFormatter<HeroBreakResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HeroBreakResponse value)
		{
			HeroBreakResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HeroBreakResponse value)
		{
			HeroBreakResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbNormalRoleInfo Role { get; set; }

	[MemoryPackOrder(1)]
	public long Gold { get; set; }

	[MemoryPackOrder(2)]
	public List<PbItemChange> ItemLeft { get; set; } = new List<PbItemChange>();

	public static HeroBreakResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HeroBreakResponse)) as HeroBreakResponse;
		}
		return new HeroBreakResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Role = null;
			Gold = 0L;
			ItemLeft.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HeroBreakResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HeroBreakResponse>())
		{
			MemoryPackFormatterProvider.Register(new HeroBreakResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HeroBreakResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HeroBreakResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HeroBreakResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbNormalRoleInfo>(value.Role);
		writer.WriteUnmanaged<long>(value.Gold);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemLeft));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HeroBreakResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbNormalRoleInfo value3;
		long value4;
		List<PbItemChange> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Role;
				value4 = value.Gold;
				value5 = value.ItemLeft;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbNormalRoleInfo>();
			reader.ReadUnmanaged<long>(out value4);
			value5 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HeroBreakResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Role;
				value4 = value.Gold;
				value5 = value.ItemLeft;
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
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_018e;
			}
		}
		value = new HeroBreakResponse
		{
			IsFromPool = value2,
			Role = value3,
			Gold = value4,
			ItemLeft = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018e:
		value.IsFromPool = value2;
		value.Role = value3;
		value.Gold = value4;
		value.ItemLeft = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
