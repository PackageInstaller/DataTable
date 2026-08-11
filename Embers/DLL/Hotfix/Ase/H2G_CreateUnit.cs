using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1024)]
[MemoryPackable(GenerateType.Object)]
public class H2G_CreateUnit : MessageObject, IResponse, IMessage, IMemoryPackable<H2G_CreateUnit>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2G_CreateUnitFormatter : MemoryPackFormatter<H2G_CreateUnit>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2G_CreateUnit value)
		{
			H2G_CreateUnit.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2G_CreateUnit value)
		{
			H2G_CreateUnit.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(3)]
	public long UnitId { get; set; }

	[MemoryPackOrder(4)]
	public long Key { get; set; }

	[MemoryPackOrder(5)]
	public long UserId { get; set; }

	[MemoryPackOrder(6)]
	public int RealDisconnect { get; set; }

	[MemoryPackOrder(7)]
	public int AppId { get; set; }

	public static H2G_CreateUnit Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2G_CreateUnit)) as H2G_CreateUnit;
		}
		return new H2G_CreateUnit();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnitId = 0L;
			Key = 0L;
			UserId = 0L;
			RealDisconnect = 0;
			AppId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2G_CreateUnit()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2G_CreateUnit>())
		{
			MemoryPackFormatterProvider.Register(new H2G_CreateUnitFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2G_CreateUnit[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2G_CreateUnit>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2G_CreateUnit? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, int, int, int, int>(9, value.IsFromPool, value.UnitId, value.Key, value.UserId, value.RealDisconnect, value.AppId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2G_CreateUnit? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		long value5;
		int value6;
		int value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.Key;
				value5 = value.UserId;
				value6 = value.RealDisconnect;
				value7 = value.AppId;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01d3;
			}
			reader.ReadUnmanaged<bool, long, long, long, int, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2G_CreateUnit), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.Key;
				value5 = value.UserId;
				value6 = value.RealDisconnect;
				value7 = value.AppId;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
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
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
												_ = 9;
											}
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
				goto IL_01d3;
			}
		}
		value = new H2G_CreateUnit
		{
			IsFromPool = value2,
			UnitId = value3,
			Key = value4,
			UserId = value5,
			RealDisconnect = value6,
			AppId = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01d3:
		value.IsFromPool = value2;
		value.UnitId = value3;
		value.Key = value4;
		value.UserId = value5;
		value.RealDisconnect = value6;
		value.AppId = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
