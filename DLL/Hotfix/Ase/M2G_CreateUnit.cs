using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1020)]
[MemoryPackable(GenerateType.Object)]
public class M2G_CreateUnit : MessageObject, IResponse, IMessage, IMemoryPackable<M2G_CreateUnit>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2G_CreateUnitFormatter : MemoryPackFormatter<M2G_CreateUnit>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2G_CreateUnit value)
		{
			M2G_CreateUnit.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2G_CreateUnit value)
		{
			M2G_CreateUnit.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UnitId { get; set; }

	[MemoryPackOrder(1)]
	public int Count { get; set; }

	[MemoryPackOrder(2)]
	public string name { get; set; }

	public static M2G_CreateUnit Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2G_CreateUnit)) as M2G_CreateUnit;
		}
		return new M2G_CreateUnit();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnitId = 0L;
			Count = 0;
			name = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2G_CreateUnit()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2G_CreateUnit>())
		{
			MemoryPackFormatterProvider.Register(new M2G_CreateUnitFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2G_CreateUnit[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2G_CreateUnit>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2G_CreateUnit? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(7, value.IsFromPool, value.UnitId, value.Count);
		writer.WriteString(value.name);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2G_CreateUnit? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		string text;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.Count;
				text = value.name;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				text = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0183;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			text = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2G_CreateUnit), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				text = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.Count;
				text = value.name;
				value5 = value.RpcId;
				value6 = value.Error;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							text = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
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
				goto IL_0183;
			}
		}
		value = new M2G_CreateUnit
		{
			IsFromPool = value2,
			UnitId = value3,
			Count = value4,
			name = text,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0183:
		value.IsFromPool = value2;
		value.UnitId = value3;
		value.Count = value4;
		value.name = text;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
