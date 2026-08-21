using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10624)]
[MemoryPackable(GenerateType.Object)]
public class SelectSuitboxMakeIndexResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<SelectSuitboxMakeIndexResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SelectSuitboxMakeIndexResponseFormatter : MemoryPackFormatter<SelectSuitboxMakeIndexResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SelectSuitboxMakeIndexResponse value)
		{
			SelectSuitboxMakeIndexResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SelectSuitboxMakeIndexResponse value)
		{
			SelectSuitboxMakeIndexResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbEquipBase NewSuitbox { get; set; }

	public static SelectSuitboxMakeIndexResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SelectSuitboxMakeIndexResponse)) as SelectSuitboxMakeIndexResponse;
		}
		return new SelectSuitboxMakeIndexResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			NewSuitbox = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SelectSuitboxMakeIndexResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SelectSuitboxMakeIndexResponse>())
		{
			MemoryPackFormatterProvider.Register(new SelectSuitboxMakeIndexResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SelectSuitboxMakeIndexResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SelectSuitboxMakeIndexResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SelectSuitboxMakeIndexResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<PbEquipBase>(value.NewSuitbox);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SelectSuitboxMakeIndexResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbEquipBase value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.NewSuitbox;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbEquipBase>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SelectSuitboxMakeIndexResponse), 5, memberCount);
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
				value3 = value.NewSuitbox;
				value4 = value.RpcId;
				value5 = value.Error;
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
		value = new SelectSuitboxMakeIndexResponse
		{
			IsFromPool = value2,
			NewSuitbox = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.NewSuitbox = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
