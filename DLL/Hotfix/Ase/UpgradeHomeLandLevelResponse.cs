using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10557)]
[MemoryPackable(GenerateType.Object)]
public class UpgradeHomeLandLevelResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<UpgradeHomeLandLevelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UpgradeHomeLandLevelResponseFormatter : MemoryPackFormatter<UpgradeHomeLandLevelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UpgradeHomeLandLevelResponse value)
		{
			UpgradeHomeLandLevelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UpgradeHomeLandLevelResponse value)
		{
			UpgradeHomeLandLevelResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbBuildingInfo Building { get; set; }

	[MemoryPackOrder(1)]
	public List<PbItemChange> CostItems { get; set; } = new List<PbItemChange>();

	public static UpgradeHomeLandLevelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UpgradeHomeLandLevelResponse)) as UpgradeHomeLandLevelResponse;
		}
		return new UpgradeHomeLandLevelResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Building = null;
			CostItems.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UpgradeHomeLandLevelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UpgradeHomeLandLevelResponse>())
		{
			MemoryPackFormatterProvider.Register(new UpgradeHomeLandLevelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UpgradeHomeLandLevelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UpgradeHomeLandLevelResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemChange>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemChange>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UpgradeHomeLandLevelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbBuildingInfo>(value.Building);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemChange>>(value.CostItems));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UpgradeHomeLandLevelResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbBuildingInfo value3;
		List<PbItemChange> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Building;
				value4 = value.CostItems;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbBuildingInfo>();
			value4 = ListFormatter.DeserializePackable<PbItemChange>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UpgradeHomeLandLevelResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Building;
				value4 = value.CostItems;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
				goto IL_015b;
			}
		}
		value = new UpgradeHomeLandLevelResponse
		{
			IsFromPool = value2,
			Building = value3,
			CostItems = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.Building = value3;
		value.CostItems = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
