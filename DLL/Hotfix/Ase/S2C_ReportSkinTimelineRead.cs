using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10934)]
[MemoryPackable(GenerateType.Object)]
public class S2C_ReportSkinTimelineRead : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_ReportSkinTimelineRead>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_ReportSkinTimelineReadFormatter : MemoryPackFormatter<S2C_ReportSkinTimelineRead>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_ReportSkinTimelineRead value)
		{
			S2C_ReportSkinTimelineRead.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_ReportSkinTimelineRead value)
		{
			S2C_ReportSkinTimelineRead.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	public static S2C_ReportSkinTimelineRead Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_ReportSkinTimelineRead)) as S2C_ReportSkinTimelineRead;
		}
		return new S2C_ReportSkinTimelineRead();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_ReportSkinTimelineRead()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_ReportSkinTimelineRead>())
		{
			MemoryPackFormatterProvider.Register(new S2C_ReportSkinTimelineReadFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_ReportSkinTimelineRead[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_ReportSkinTimelineRead>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_ReportSkinTimelineRead? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(4, value.IsFromPool, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_ReportSkinTimelineRead? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string message;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				goto IL_00ef;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_ReportSkinTimelineRead), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.Error;
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
							message = reader.ReadString();
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ef;
			}
		}
		value = new S2C_ReportSkinTimelineRead
		{
			IsFromPool = value2,
			RpcId = value3,
			Error = value4,
			Message = message
		};
		return;
		IL_00ef:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
	}
}
