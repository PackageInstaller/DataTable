using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10674)]
[MemoryPackable(GenerateType.Object)]
public class ModifyUnionInfoRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<ModifyUnionInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ModifyUnionInfoRequestFormatter : MemoryPackFormatter<ModifyUnionInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ModifyUnionInfoRequest value)
		{
			ModifyUnionInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ModifyUnionInfoRequest value)
		{
			ModifyUnionInfoRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(88)]
	public int ChangeType { get; set; }

	[MemoryPackOrder(0)]
	public string Name { get; set; }

	[MemoryPackOrder(1)]
	public string Declaration { get; set; }

	[MemoryPackOrder(2)]
	public int LevelLimit { get; set; }

	[MemoryPackOrder(3)]
	public int Examine { get; set; }

	[MemoryPackOrder(4)]
	public int Flag { get; set; }

	public static ModifyUnionInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ModifyUnionInfoRequest)) as ModifyUnionInfoRequest;
		}
		return new ModifyUnionInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			ChangeType = 0;
			Name = null;
			Declaration = null;
			LevelLimit = 0;
			Examine = 0;
			Flag = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ModifyUnionInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ModifyUnionInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new ModifyUnionInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ModifyUnionInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ModifyUnionInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ModifyUnionInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(11, value.IsFromPool);
		writer.WriteString(value.Name);
		writer.WriteString(value.Declaration);
		writer.WriteUnmanaged<int, int, int, int, long, int, int, long>(value.LevelLimit, value.Examine, value.Flag, value.LoginServerId, value.LoginSecretKey, value.ChangeType, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ModifyUnionInfoRequest? value)
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
		int value6;
		long value7;
		int value8;
		int value9;
		long value10;
		string name;
		string declaration;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				name = value.Name;
				declaration = value.Declaration;
				value3 = value.LevelLimit;
				value4 = value.Examine;
				value5 = value.Flag;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.ChangeType;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				name = reader.ReadString();
				declaration = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_0233;
			}
			reader.ReadUnmanaged<bool>(out value2);
			name = reader.ReadString();
			declaration = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, long, int, int, long>(out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ModifyUnionInfoRequest), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				name = null;
				declaration = null;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				name = value.Name;
				declaration = value.Declaration;
				value3 = value.LevelLimit;
				value4 = value.Examine;
				value5 = value.Flag;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.ChangeType;
				value9 = value.RpcId;
				value10 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					name = reader.ReadString();
					if (memberCount != 2)
					{
						declaration = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value3);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value7);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value8);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value9);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value10);
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_0233;
			}
		}
		value = new ModifyUnionInfoRequest
		{
			IsFromPool = value2,
			Name = name,
			Declaration = declaration,
			LevelLimit = value3,
			Examine = value4,
			Flag = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			ChangeType = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_0233:
		value.IsFromPool = value2;
		value.Name = name;
		value.Declaration = declaration;
		value.LevelLimit = value3;
		value.Examine = value4;
		value.Flag = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.ChangeType = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
