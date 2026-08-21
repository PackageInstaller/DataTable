using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10199)]
[MemoryPackable(GenerateType.Object)]
public class S2C_RefineUpEquipmentResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_RefineUpEquipmentResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_RefineUpEquipmentResponseFormatter : MemoryPackFormatter<S2C_RefineUpEquipmentResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_RefineUpEquipmentResponse value)
		{
			S2C_RefineUpEquipmentResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_RefineUpEquipmentResponse value)
		{
			S2C_RefineUpEquipmentResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int EquipRefine { get; set; }

	[MemoryPackOrder(1)]
	public List<PbEquipBase> EquipChange { get; set; } = new List<PbEquipBase>();

	public static S2C_RefineUpEquipmentResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_RefineUpEquipmentResponse)) as S2C_RefineUpEquipmentResponse;
		}
		return new S2C_RefineUpEquipmentResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			EquipRefine = 0;
			EquipChange.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_RefineUpEquipmentResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_RefineUpEquipmentResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_RefineUpEquipmentResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_RefineUpEquipmentResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_RefineUpEquipmentResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_RefineUpEquipmentResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(6, value.IsFromPool, value.EquipRefine);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.EquipChange));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_RefineUpEquipmentResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbEquipBase> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipRefine;
				value4 = value.EquipChange;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_RefineUpEquipmentResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EquipRefine;
				value4 = value.EquipChange;
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
				goto IL_0156;
			}
		}
		value = new S2C_RefineUpEquipmentResponse
		{
			IsFromPool = value2,
			EquipRefine = value3,
			EquipChange = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.EquipRefine = value3;
		value.EquipChange = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
