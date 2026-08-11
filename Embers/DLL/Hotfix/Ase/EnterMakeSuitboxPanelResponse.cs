using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10710)]
[MemoryPackable(GenerateType.Object)]
public class EnterMakeSuitboxPanelResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<EnterMakeSuitboxPanelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class EnterMakeSuitboxPanelResponseFormatter : MemoryPackFormatter<EnterMakeSuitboxPanelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref EnterMakeSuitboxPanelResponse value)
		{
			EnterMakeSuitboxPanelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref EnterMakeSuitboxPanelResponse value)
		{
			EnterMakeSuitboxPanelResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long SuitboxUuid { get; set; }

	[MemoryPackOrder(1)]
	public List<PbEntryBaseList> Results { get; set; } = new List<PbEntryBaseList>();

	public static EnterMakeSuitboxPanelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(EnterMakeSuitboxPanelResponse)) as EnterMakeSuitboxPanelResponse;
		}
		return new EnterMakeSuitboxPanelResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			SuitboxUuid = 0L;
			Results.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static EnterMakeSuitboxPanelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<EnterMakeSuitboxPanelResponse>())
		{
			MemoryPackFormatterProvider.Register(new EnterMakeSuitboxPanelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<EnterMakeSuitboxPanelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<EnterMakeSuitboxPanelResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEntryBaseList>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEntryBaseList>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref EnterMakeSuitboxPanelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.SuitboxUuid);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEntryBaseList>>(value.Results));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref EnterMakeSuitboxPanelResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbEntryBaseList> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SuitboxUuid;
				value4 = value.Results;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbEntryBaseList>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(EnterMakeSuitboxPanelResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SuitboxUuid;
				value4 = value.Results;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
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
				goto IL_0157;
			}
		}
		value = new EnterMakeSuitboxPanelResponse
		{
			IsFromPool = value2,
			SuitboxUuid = value3,
			Results = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.SuitboxUuid = value3;
		value.Results = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
