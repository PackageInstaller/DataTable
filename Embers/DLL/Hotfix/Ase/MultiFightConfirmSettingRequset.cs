using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10497)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightConfirmSettingRequset : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightConfirmSettingRequset>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightConfirmSettingRequsetFormatter : MemoryPackFormatter<MultiFightConfirmSettingRequset>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightConfirmSettingRequset value)
		{
			MultiFightConfirmSettingRequset.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightConfirmSettingRequset value)
		{
			MultiFightConfirmSettingRequset.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(91)]
	public long UserId { get; set; }

	[MemoryPackOrder(92)]
	public int ClientFlag { get; set; }

	[MemoryPackOrder(0)]
	public int Ope { get; set; }

	public static MultiFightConfirmSettingRequset Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightConfirmSettingRequset)) as MultiFightConfirmSettingRequset;
		}
		return new MultiFightConfirmSettingRequset();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ClientFlag = 0;
			Ope = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightConfirmSettingRequset()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightConfirmSettingRequset>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightConfirmSettingRequsetFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightConfirmSettingRequset[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightConfirmSettingRequset>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightConfirmSettingRequset? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, long, long, int>(8, value.IsFromPool, value.Ope, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserId, value.ClientFlag);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightConfirmSettingRequset? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		int value6;
		long value7;
		long value8;
		int value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Ope;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.UserId;
				value9 = value.ClientFlag;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				goto IL_019e;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, long, long, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightConfirmSettingRequset), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				value8 = 0L;
				value9 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Ope;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.UserId;
				value9 = value.ClientFlag;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
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
				goto IL_019e;
			}
		}
		value = new MultiFightConfirmSettingRequset
		{
			IsFromPool = value2,
			Ope = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7,
			UserId = value8,
			ClientFlag = value9
		};
		return;
		IL_019e:
		value.IsFromPool = value2;
		value.Ope = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
		value.UserId = value8;
		value.ClientFlag = value9;
	}
}
