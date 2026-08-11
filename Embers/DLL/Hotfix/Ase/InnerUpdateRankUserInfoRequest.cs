using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1120)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateRankUserInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpdateRankUserInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateRankUserInfoRequestFormatter : MemoryPackFormatter<InnerUpdateRankUserInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateRankUserInfoRequest value)
		{
			InnerUpdateRankUserInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateRankUserInfoRequest value)
		{
			InnerUpdateRankUserInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public string Username { get; set; }

	[MemoryPackOrder(1)]
	public int Title { get; set; }

	[MemoryPackOrder(2)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(3)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public int Icon { get; set; }

	public static InnerUpdateRankUserInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateRankUserInfoRequest)) as InnerUpdateRankUserInfoRequest;
		}
		return new InnerUpdateRankUserInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Username = null;
			Title = 0;
			IconFrame = 0;
			Level = 0;
			Icon = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateRankUserInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateRankUserInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateRankUserInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateRankUserInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateRankUserInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateRankUserInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteString(value.Username);
		writer.WriteUnmanaged<int, int, int, int, int, long>(value.Title, value.IconFrame, value.Level, value.Icon, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateRankUserInfoRequest? value)
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
		int value7;
		long value8;
		string username;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				username = value.Username;
				value3 = value.Title;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.Icon;
				value7 = value.RpcId;
				value8 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				username = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01a5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			username = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int, long>(out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateRankUserInfoRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				username = null;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				username = value.Username;
				value3 = value.Title;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.Icon;
				value7 = value.RpcId;
				value8 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					username = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01a5;
			}
		}
		value = new InnerUpdateRankUserInfoRequest
		{
			IsFromPool = value2,
			Username = username,
			Title = value3,
			IconFrame = value4,
			Level = value5,
			Icon = value6,
			RpcId = value7,
			UserId = value8
		};
		return;
		IL_01a5:
		value.IsFromPool = value2;
		value.Username = username;
		value.Title = value3;
		value.IconFrame = value4;
		value.Level = value5;
		value.Icon = value6;
		value.RpcId = value7;
		value.UserId = value8;
	}
}
