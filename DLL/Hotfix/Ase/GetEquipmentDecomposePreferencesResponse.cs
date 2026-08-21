using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10869)]
[MemoryPackable(GenerateType.Object)]
public class GetEquipmentDecomposePreferencesResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetEquipmentDecomposePreferencesResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetEquipmentDecomposePreferencesResponseFormatter : MemoryPackFormatter<GetEquipmentDecomposePreferencesResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetEquipmentDecomposePreferencesResponse value)
		{
			GetEquipmentDecomposePreferencesResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetEquipmentDecomposePreferencesResponse value)
		{
			GetEquipmentDecomposePreferencesResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<int> Preferences { get; set; }

	public static GetEquipmentDecomposePreferencesResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetEquipmentDecomposePreferencesResponse)) as GetEquipmentDecomposePreferencesResponse;
		}
		return new GetEquipmentDecomposePreferencesResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Preferences = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetEquipmentDecomposePreferencesResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetEquipmentDecomposePreferencesResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetEquipmentDecomposePreferencesResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetEquipmentDecomposePreferencesResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetEquipmentDecomposePreferencesResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetEquipmentDecomposePreferencesResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteValue<List<int>>(value.Preferences);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetEquipmentDecomposePreferencesResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Preferences;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetEquipmentDecomposePreferencesResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Preferences;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_012b;
			}
		}
		value = new GetEquipmentDecomposePreferencesResponse
		{
			IsFromPool = value2,
			Preferences = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.Preferences = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
