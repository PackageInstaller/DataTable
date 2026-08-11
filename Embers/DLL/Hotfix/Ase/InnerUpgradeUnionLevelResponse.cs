using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1091)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpgradeUnionLevelResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerUpgradeUnionLevelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpgradeUnionLevelResponseFormatter : MemoryPackFormatter<InnerUpgradeUnionLevelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpgradeUnionLevelResponse value)
		{
			InnerUpgradeUnionLevelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpgradeUnionLevelResponse value)
		{
			InnerUpgradeUnionLevelResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int Level { get; set; }

	[MemoryPackOrder(1)]
	public int UnionMoney { get; set; }

	[MemoryPackOrder(2)]
	public long UnionId { get; set; }

	public static InnerUpgradeUnionLevelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpgradeUnionLevelResponse)) as InnerUpgradeUnionLevelResponse;
		}
		return new InnerUpgradeUnionLevelResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Level = 0;
			UnionMoney = 0;
			UnionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpgradeUnionLevelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpgradeUnionLevelResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpgradeUnionLevelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpgradeUnionLevelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpgradeUnionLevelResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpgradeUnionLevelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, int>(7, value.IsFromPool, value.Level, value.UnionMoney, value.UnionId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpgradeUnionLevelResponse? value)
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
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.UnionMoney;
				value5 = value.UnionId;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0177;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpgradeUnionLevelResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.UnionMoney;
				value5 = value.UnionId;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
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
									reader.ReadUnmanaged<int>(out value7);
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
				goto IL_0177;
			}
		}
		value = new InnerUpgradeUnionLevelResponse
		{
			IsFromPool = value2,
			Level = value3,
			UnionMoney = value4,
			UnionId = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0177:
		value.IsFromPool = value2;
		value.Level = value3;
		value.UnionMoney = value4;
		value.UnionId = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
