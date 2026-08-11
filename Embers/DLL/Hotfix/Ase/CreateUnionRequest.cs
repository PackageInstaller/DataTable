using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10650)]
[MemoryPackable(GenerateType.Object)]
public class CreateUnionRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<CreateUnionRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CreateUnionRequestFormatter : MemoryPackFormatter<CreateUnionRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CreateUnionRequest value)
		{
			CreateUnionRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CreateUnionRequest value)
		{
			CreateUnionRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(0)]
	public string Name { get; set; }

	[MemoryPackOrder(1)]
	public int Flag { get; set; }

	[MemoryPackOrder(2)]
	public int Icon { get; set; }

	[MemoryPackOrder(3)]
	public string Declaration { get; set; }

	[MemoryPackOrder(4)]
	public int LevelLimit { get; set; }

	[MemoryPackOrder(5)]
	public int Examine { get; set; }

	public static CreateUnionRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CreateUnionRequest)) as CreateUnionRequest;
		}
		return new CreateUnionRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Name = null;
			Flag = 0;
			Icon = 0;
			Declaration = null;
			LevelLimit = 0;
			Examine = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CreateUnionRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CreateUnionRequest>())
		{
			MemoryPackFormatterProvider.Register(new CreateUnionRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CreateUnionRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CreateUnionRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CreateUnionRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(11, value.IsFromPool);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int>(value.Flag, value.Icon);
		writer.WriteString(value.Declaration);
		writer.WriteUnmanaged<int, int, int, long, int, long>(value.LevelLimit, value.Examine, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CreateUnionRequest? value)
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
		int value7;
		long value8;
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
				value3 = value.Flag;
				value4 = value.Icon;
				declaration = value.Declaration;
				value5 = value.LevelLimit;
				value6 = value.Examine;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				declaration = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_023c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
			declaration = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, long, int, long>(out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CreateUnionRequest), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				name = null;
				value3 = 0;
				value4 = 0;
				declaration = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				name = value.Name;
				value3 = value.Flag;
				value4 = value.Icon;
				declaration = value.Declaration;
				value5 = value.LevelLimit;
				value6 = value.Examine;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
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
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								declaration = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value7);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value8);
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
				goto IL_023c;
			}
		}
		value = new CreateUnionRequest
		{
			IsFromPool = value2,
			Name = name,
			Flag = value3,
			Icon = value4,
			Declaration = declaration,
			LevelLimit = value5,
			Examine = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_023c:
		value.IsFromPool = value2;
		value.Name = name;
		value.Flag = value3;
		value.Icon = value4;
		value.Declaration = declaration;
		value.LevelLimit = value5;
		value.Examine = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
