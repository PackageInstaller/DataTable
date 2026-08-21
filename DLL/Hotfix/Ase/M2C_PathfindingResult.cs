using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5010)]
[MemoryPackable(GenerateType.Object)]
public class M2C_PathfindingResult : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<M2C_PathfindingResult>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2C_PathfindingResultFormatter : MemoryPackFormatter<M2C_PathfindingResult>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2C_PathfindingResult value)
		{
			M2C_PathfindingResult.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2C_PathfindingResult value)
		{
			M2C_PathfindingResult.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long Id { get; set; }

	[MemoryPackOrder(1)]
	public float X { get; set; }

	[MemoryPackOrder(2)]
	public float Y { get; set; }

	[MemoryPackOrder(3)]
	public float Z { get; set; }

	[MemoryPackOrder(4)]
	public List<float> Xs { get; set; } = new List<float>();

	[MemoryPackOrder(5)]
	public List<float> Ys { get; set; } = new List<float>();

	[MemoryPackOrder(6)]
	public List<float> Zs { get; set; } = new List<float>();

	public static M2C_PathfindingResult Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2C_PathfindingResult)) as M2C_PathfindingResult;
		}
		return new M2C_PathfindingResult();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			Id = 0L;
			X = 0f;
			Y = 0f;
			Z = 0f;
			Xs.Clear();
			Ys.Clear();
			Zs.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2C_PathfindingResult()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_PathfindingResult>())
		{
			MemoryPackFormatterProvider.Register(new M2C_PathfindingResultFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_PathfindingResult[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2C_PathfindingResult>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<float>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<float>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2C_PathfindingResult? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, float, float, float>(9, value.IsFromPool, value.Id, value.X, value.Y, value.Z);
		writer.WriteValue<List<float>>(value.Xs);
		writer.WriteValue<List<float>>(value.Ys);
		writer.WriteValue<List<float>>(value.Zs);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2C_PathfindingResult? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		float value4;
		float value5;
		float value6;
		List<float> value7;
		List<float> value8;
		List<float> value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.X;
				value5 = value.Y;
				value6 = value.Z;
				value7 = value.Xs;
				value8 = value.Ys;
				value9 = value.Zs;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<float>(out value4);
				reader.ReadUnmanaged<float>(out value5);
				reader.ReadUnmanaged<float>(out value6);
				reader.ReadValue(ref value7);
				reader.ReadValue(ref value8);
				reader.ReadValue(ref value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01f0;
			}
			reader.ReadUnmanaged<bool, long, float, float, float>(out value2, out value3, out value4, out value5, out value6);
			value7 = reader.ReadValue<List<float>>();
			value8 = reader.ReadValue<List<float>>();
			value9 = reader.ReadValue<List<float>>();
			reader.ReadUnmanaged<long>(out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2C_PathfindingResult), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0f;
				value5 = 0f;
				value6 = 0f;
				value7 = null;
				value8 = null;
				value9 = null;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.X;
				value5 = value.Y;
				value6 = value.Z;
				value7 = value.Xs;
				value8 = value.Ys;
				value9 = value.Zs;
				value10 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<float>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<float>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<float>(out value6);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value7);
									if (memberCount != 6)
									{
										reader.ReadValue(ref value8);
										if (memberCount != 7)
										{
											reader.ReadValue(ref value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
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
				goto IL_01f0;
			}
		}
		value = new M2C_PathfindingResult
		{
			IsFromPool = value2,
			Id = value3,
			X = value4,
			Y = value5,
			Z = value6,
			Xs = value7,
			Ys = value8,
			Zs = value9,
			ActorId = value10
		};
		return;
		IL_01f0:
		value.IsFromPool = value2;
		value.Id = value3;
		value.X = value4;
		value.Y = value5;
		value.Z = value6;
		value.Xs = value7;
		value.Ys = value8;
		value.Zs = value9;
		value.ActorId = value10;
	}
}
