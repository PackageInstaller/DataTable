using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10027)]
[MemoryPackable(GenerateType.Object)]
public class OneBattleFrameMessage : MessageObject, IFrameMessage, IMessage, IMemoryPackable<OneBattleFrameMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class OneBattleFrameMessageFormatter : MemoryPackFormatter<OneBattleFrameMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref OneBattleFrameMessage value)
		{
			OneBattleFrameMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref OneBattleFrameMessage value)
		{
			OneBattleFrameMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(93)]
	public long Id { get; set; }

	[MemoryPackOrder(0)]
	public int Tick { get; set; }

	[MemoryPackOrder(1)]
	public int Actor { get; set; }

	[MemoryPackOrder(2)]
	public List<float> inputUV { get; set; } = new List<float>();

	[MemoryPackOrder(3)]
	public int optionCode { get; set; }

	[MemoryPackOrder(4)]
	public List<float> skillJoyUv { get; set; } = new List<float>();

	[MemoryPackOrder(5)]
	public int SkillState { get; set; }

	[MemoryPackOrder(6)]
	public bool AutoFight { get; set; }

	[MemoryPackOrder(7)]
	public bool AutoUseProp { get; set; }

	public static OneBattleFrameMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(OneBattleFrameMessage)) as OneBattleFrameMessage;
		}
		return new OneBattleFrameMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0L;
			Tick = 0;
			Actor = 0;
			inputUV.Clear();
			optionCode = 0;
			skillJoyUv.Clear();
			SkillState = 0;
			AutoFight = false;
			AutoUseProp = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static OneBattleFrameMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<OneBattleFrameMessage>())
		{
			MemoryPackFormatterProvider.Register(new OneBattleFrameMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<OneBattleFrameMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<OneBattleFrameMessage>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<float>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<float>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref OneBattleFrameMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(10, value.IsFromPool, value.Tick, value.Actor);
		writer.WriteValue<List<float>>(value.inputUV);
		writer.WriteUnmanaged<int>(value.optionCode);
		writer.WriteValue<List<float>>(value.skillJoyUv);
		writer.WriteUnmanaged<int, bool, bool, long>(value.SkillState, value.AutoFight, value.AutoUseProp, value.Id);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref OneBattleFrameMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<float> value5;
		int value6;
		List<float> value7;
		int value8;
		bool value9;
		bool value10;
		long value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Tick;
				value4 = value.Actor;
				value5 = value.inputUV;
				value6 = value.optionCode;
				value7 = value.skillJoyUv;
				value8 = value.SkillState;
				value9 = value.AutoFight;
				value10 = value.AutoUseProp;
				value11 = value.Id;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<bool>(out value9);
				reader.ReadUnmanaged<bool>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_020f;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<float>>();
			reader.ReadUnmanaged<int>(out value6);
			value7 = reader.ReadValue<List<float>>();
			reader.ReadUnmanaged<int, bool, bool, long>(out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(OneBattleFrameMessage), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = false;
				value10 = false;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Tick;
				value4 = value.Actor;
				value5 = value.inputUV;
				value6 = value.optionCode;
				value7 = value.skillJoyUv;
				value8 = value.SkillState;
				value9 = value.AutoFight;
				value10 = value.AutoUseProp;
				value11 = value.Id;
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
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<bool>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<bool>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value11);
													_ = 10;
												}
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
				goto IL_020f;
			}
		}
		value = new OneBattleFrameMessage
		{
			IsFromPool = value2,
			Tick = value3,
			Actor = value4,
			inputUV = value5,
			optionCode = value6,
			skillJoyUv = value7,
			SkillState = value8,
			AutoFight = value9,
			AutoUseProp = value10,
			Id = value11
		};
		return;
		IL_020f:
		value.IsFromPool = value2;
		value.Tick = value3;
		value.Actor = value4;
		value.inputUV = value5;
		value.optionCode = value6;
		value.skillJoyUv = value7;
		value.SkillState = value8;
		value.AutoFight = value9;
		value.AutoUseProp = value10;
		value.Id = value11;
	}
}
