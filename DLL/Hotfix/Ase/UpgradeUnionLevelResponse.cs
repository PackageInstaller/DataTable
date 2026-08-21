using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10683)]
[MemoryPackable(GenerateType.Object)]
public class UpgradeUnionLevelResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<UpgradeUnionLevelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UpgradeUnionLevelResponseFormatter : MemoryPackFormatter<UpgradeUnionLevelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UpgradeUnionLevelResponse value)
		{
			UpgradeUnionLevelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UpgradeUnionLevelResponse value)
		{
			UpgradeUnionLevelResponse.Deserialize(ref reader, ref value);
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

	public static UpgradeUnionLevelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UpgradeUnionLevelResponse)) as UpgradeUnionLevelResponse;
		}
		return new UpgradeUnionLevelResponse();
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
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UpgradeUnionLevelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UpgradeUnionLevelResponse>())
		{
			MemoryPackFormatterProvider.Register(new UpgradeUnionLevelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UpgradeUnionLevelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UpgradeUnionLevelResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UpgradeUnionLevelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(6, value.IsFromPool, value.Level, value.UnionMoney, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UpgradeUnionLevelResponse? value)
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
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.UnionMoney;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014b;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UpgradeUnionLevelResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Level;
				value4 = value.UnionMoney;
				value5 = value.RpcId;
				value6 = value.Error;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014b;
			}
		}
		value = new UpgradeUnionLevelResponse
		{
			IsFromPool = value2,
			Level = value3,
			UnionMoney = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014b:
		value.IsFromPool = value2;
		value.Level = value3;
		value.UnionMoney = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
