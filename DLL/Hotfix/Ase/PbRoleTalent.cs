using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(356)]
[MemoryPackable(GenerateType.Object)]
public class PbRoleTalent : MessageObject, IMemoryPackable<PbRoleTalent>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRoleTalentFormatter : MemoryPackFormatter<PbRoleTalent>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRoleTalent value)
		{
			PbRoleTalent.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRoleTalent value)
		{
			PbRoleTalent.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int SkillId { get; set; }

	[MemoryPackOrder(1)]
	public int SkillLevel { get; set; }

	[MemoryPackOrder(2)]
	public int MaxOrderId { get; set; }

	public static PbRoleTalent Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRoleTalent)) as PbRoleTalent;
		}
		return new PbRoleTalent();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			SkillId = 0;
			SkillLevel = 0;
			MaxOrderId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRoleTalent()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoleTalent>())
		{
			MemoryPackFormatterProvider.Register(new PbRoleTalentFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoleTalent[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRoleTalent>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRoleTalent? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.SkillId, value.SkillLevel, value.MaxOrderId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRoleTalent? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SkillId;
				value4 = value.SkillLevel;
				value5 = value.MaxOrderId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRoleTalent), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SkillId;
				value4 = value.SkillLevel;
				value5 = value.MaxOrderId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbRoleTalent
		{
			IsFromPool = value2,
			SkillId = value3,
			SkillLevel = value4,
			MaxOrderId = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.SkillId = value3;
		value.SkillLevel = value4;
		value.MaxOrderId = value5;
	}
}
