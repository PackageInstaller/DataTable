using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10500)]
[MemoryPackable(GenerateType.Object)]
public class H2TEAMROOM_MatchResultOptRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2TEAMROOM_MatchResultOptRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2TEAMROOM_MatchResultOptRequestFormatter : MemoryPackFormatter<H2TEAMROOM_MatchResultOptRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2TEAMROOM_MatchResultOptRequest value)
		{
			H2TEAMROOM_MatchResultOptRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2TEAMROOM_MatchResultOptRequest value)
		{
			H2TEAMROOM_MatchResultOptRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(92)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int Opt { get; set; }

	[MemoryPackOrder(1)]
	public PbCreateSettingRoomUserInfo CreateSettingRoomInfo { get; set; }

	public static H2TEAMROOM_MatchResultOptRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2TEAMROOM_MatchResultOptRequest)) as H2TEAMROOM_MatchResultOptRequest;
		}
		return new H2TEAMROOM_MatchResultOptRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Opt = 0;
			CreateSettingRoomInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2TEAMROOM_MatchResultOptRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2TEAMROOM_MatchResultOptRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2TEAMROOM_MatchResultOptRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2TEAMROOM_MatchResultOptRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2TEAMROOM_MatchResultOptRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2TEAMROOM_MatchResultOptRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(6, value.IsFromPool, value.Opt);
		writer.WritePackable<PbCreateSettingRoomUserInfo>(value.CreateSettingRoomInfo);
		writer.WriteUnmanaged<int, long, long>(value.RpcId, value.ActorId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2TEAMROOM_MatchResultOptRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbCreateSettingRoomUserInfo value4;
		int value5;
		long value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Opt;
				value4 = value.CreateSettingRoomInfo;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbCreateSettingRoomUserInfo>();
			reader.ReadUnmanaged<int, long, long>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2TEAMROOM_MatchResultOptRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Opt;
				value4 = value.CreateSettingRoomInfo;
				value5 = value.RpcId;
				value6 = value.ActorId;
				value7 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new H2TEAMROOM_MatchResultOptRequest
		{
			IsFromPool = value2,
			Opt = value3,
			CreateSettingRoomInfo = value4,
			RpcId = value5,
			ActorId = value6,
			UserId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.Opt = value3;
		value.CreateSettingRoomInfo = value4;
		value.RpcId = value5;
		value.ActorId = value6;
		value.UserId = value7;
	}
}
