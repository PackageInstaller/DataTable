using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1128)]
[MemoryPackable(GenerateType.Object)]
public class InnerRegisterServerRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerRegisterServerRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerRegisterServerRequestFormatter : MemoryPackFormatter<InnerRegisterServerRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerRegisterServerRequest value)
		{
			InnerRegisterServerRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerRegisterServerRequest value)
		{
			InnerRegisterServerRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public int ServerId { get; set; }

	[MemoryPackOrder(1)]
	public int AreaId { get; set; }

	[MemoryPackOrder(2)]
	public int MaxUserCount { get; set; }

	[MemoryPackOrder(3)]
	public int ServerType { get; set; }

	[MemoryPackOrder(4)]
	public string InnerAddress { get; set; }

	[MemoryPackOrder(5)]
	public string OutAddress { get; set; }

	public static InnerRegisterServerRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerRegisterServerRequest)) as InnerRegisterServerRequest;
		}
		return new InnerRegisterServerRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ServerId = 0;
			AreaId = 0;
			MaxUserCount = 0;
			ServerType = 0;
			InnerAddress = null;
			OutAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerRegisterServerRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRegisterServerRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerRegisterServerRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRegisterServerRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerRegisterServerRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerRegisterServerRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(8, value.IsFromPool, value.ServerId, value.AreaId, value.MaxUserCount, value.ServerType);
		writer.WriteString(value.InnerAddress);
		writer.WriteString(value.OutAddress);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerRegisterServerRequest? value)
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
		string innerAddress;
		string outAddress;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ServerId;
				value4 = value.AreaId;
				value5 = value.MaxUserCount;
				value6 = value.ServerType;
				innerAddress = value.InnerAddress;
				outAddress = value.OutAddress;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				innerAddress = reader.ReadString();
				outAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value7);
				goto IL_01ad;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			innerAddress = reader.ReadString();
			outAddress = reader.ReadString();
			reader.ReadUnmanaged<int>(out value7);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerRegisterServerRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				innerAddress = null;
				outAddress = null;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ServerId;
				value4 = value.AreaId;
				value5 = value.MaxUserCount;
				value6 = value.ServerType;
				innerAddress = value.InnerAddress;
				outAddress = value.OutAddress;
				value7 = value.RpcId;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									innerAddress = reader.ReadString();
									if (memberCount != 6)
									{
										outAddress = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value7);
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
				goto IL_01ad;
			}
		}
		value = new InnerRegisterServerRequest
		{
			IsFromPool = value2,
			ServerId = value3,
			AreaId = value4,
			MaxUserCount = value5,
			ServerType = value6,
			InnerAddress = innerAddress,
			OutAddress = outAddress,
			RpcId = value7
		};
		return;
		IL_01ad:
		value.IsFromPool = value2;
		value.ServerId = value3;
		value.AreaId = value4;
		value.MaxUserCount = value5;
		value.ServerType = value6;
		value.InnerAddress = innerAddress;
		value.OutAddress = outAddress;
		value.RpcId = value7;
	}
}
