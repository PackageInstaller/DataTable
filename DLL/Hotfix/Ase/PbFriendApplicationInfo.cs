using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(336)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendApplicationInfo : MessageObject, IMemoryPackable<PbFriendApplicationInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendApplicationInfoFormatter : MemoryPackFormatter<PbFriendApplicationInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendApplicationInfo value)
		{
			PbFriendApplicationInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendApplicationInfo value)
		{
			PbFriendApplicationInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public PbFriendItemInfo FriendInfo { get; set; }

	[MemoryPackOrder(1)]
	public string VertifyMessage { get; set; }

	public static PbFriendApplicationInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendApplicationInfo)) as PbFriendApplicationInfo;
		}
		return new PbFriendApplicationInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			FriendInfo = null;
			VertifyMessage = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendApplicationInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendApplicationInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendApplicationInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendApplicationInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendApplicationInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendApplicationInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		writer.WritePackable<PbFriendItemInfo>(value.FriendInfo);
		writer.WriteString(value.VertifyMessage);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendApplicationInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbFriendItemInfo value3;
		string vertifyMessage;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendInfo;
				vertifyMessage = value.VertifyMessage;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				vertifyMessage = reader.ReadString();
				goto IL_00c6;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbFriendItemInfo>();
			vertifyMessage = reader.ReadString();
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendApplicationInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				vertifyMessage = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendInfo;
				vertifyMessage = value.VertifyMessage;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						vertifyMessage = reader.ReadString();
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c6;
			}
		}
		value = new PbFriendApplicationInfo
		{
			IsFromPool = value2,
			FriendInfo = value3,
			VertifyMessage = vertifyMessage
		};
		return;
		IL_00c6:
		value.IsFromPool = value2;
		value.FriendInfo = value3;
		value.VertifyMessage = vertifyMessage;
	}
}
