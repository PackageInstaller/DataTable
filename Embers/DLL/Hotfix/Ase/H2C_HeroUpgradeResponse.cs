using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10062)]
[MemoryPackable(GenerateType.Object)]
public class H2C_HeroUpgradeResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_HeroUpgradeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_HeroUpgradeResponseFormatter : MemoryPackFormatter<H2C_HeroUpgradeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_HeroUpgradeResponse value)
		{
			H2C_HeroUpgradeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_HeroUpgradeResponse value)
		{
			H2C_HeroUpgradeResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int HeroLevel { get; set; }

	[MemoryPackOrder(1)]
	public long HeroExp { get; set; }

	[MemoryPackOrder(2)]
	public long GoldCost { get; set; }

	[MemoryPackOrder(3)]
	public List<PbItemChange> ItemLeft { get; set; } = new List<PbItemChange>();

	public static H2C_HeroUpgradeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_HeroUpgradeResponse)) as H2C_HeroUpgradeResponse;
		}
		return new H2C_HeroUpgradeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			HeroLevel = 0;
			HeroExp = 0L;
			GoldCost = 0L;
			ItemLeft.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_HeroUpgradeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_HeroUpgradeResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_HeroUpgradeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_HeroUpgradeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_HeroUpgradeResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_HeroUpgradeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long, long>(8, value.IsFromPool, value.HeroLevel, value.HeroExp, value.GoldCost);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.ItemLeft));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_HeroUpgradeResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		List<PbItemChange> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.HeroLevel;
				value4 = value.HeroExp;
				value5 = value.GoldCost;
				value6 = value.ItemLeft;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01af;
			}
			reader.ReadUnmanaged<bool, int, long, long>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_HeroUpgradeResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.HeroLevel;
				value4 = value.HeroExp;
				value5 = value.GoldCost;
				value6 = value.ItemLeft;
				value7 = value.RpcId;
				value8 = value.Error;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
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
				goto IL_01af;
			}
		}
		value = new H2C_HeroUpgradeResponse
		{
			IsFromPool = value2,
			HeroLevel = value3,
			HeroExp = value4,
			GoldCost = value5,
			ItemLeft = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01af:
		value.IsFromPool = value2;
		value.HeroLevel = value3;
		value.HeroExp = value4;
		value.GoldCost = value5;
		value.ItemLeft = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
