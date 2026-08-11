using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5001)]
[MemoryPackable(GenerateType.Object)]
public class PbAttributeBase : MessageObject, IMemoryPackable<PbAttributeBase>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbAttributeBaseFormatter : MemoryPackFormatter<PbAttributeBase>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbAttributeBase value)
		{
			PbAttributeBase.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbAttributeBase value)
		{
			PbAttributeBase.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public float Value { get; set; }

	public static PbAttributeBase Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbAttributeBase)) as PbAttributeBase;
		}
		return new PbAttributeBase();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Value = 0f;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbAttributeBase()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbAttributeBase>())
		{
			MemoryPackFormatterProvider.Register(new PbAttributeBaseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbAttributeBase[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbAttributeBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbAttributeBase? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, float>(3, value.IsFromPool, value.Id, value.Value);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbAttributeBase? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		float value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<float>(out value4);
				goto IL_00c2;
			}
			reader.ReadUnmanaged<bool, int, float>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbAttributeBase), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0f;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<float>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c2;
			}
		}
		value = new PbAttributeBase
		{
			IsFromPool = value2,
			Id = value3,
			Value = value4
		};
		return;
		IL_00c2:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Value = value4;
	}
}
