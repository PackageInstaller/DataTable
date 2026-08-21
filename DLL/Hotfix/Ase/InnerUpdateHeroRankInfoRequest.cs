using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1064)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateHeroRankInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpdateHeroRankInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateHeroRankInfoRequestFormatter : MemoryPackFormatter<InnerUpdateHeroRankInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateHeroRankInfoRequest value)
		{
			InnerUpdateHeroRankInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateHeroRankInfoRequest value)
		{
			InnerUpdateHeroRankInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Level { get; set; }

	[MemoryPackOrder(2)]
	public int Icon { get; set; }

	[MemoryPackOrder(3)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(5)]
	public int HeroId { get; set; }

	[MemoryPackOrder(6)]
	public int Score { get; set; }

	[MemoryPackOrder(8)]
	public string UserName { get; set; }

	[MemoryPackOrder(9)]
	public int Title { get; set; }

	public static InnerUpdateHeroRankInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateHeroRankInfoRequest)) as InnerUpdateHeroRankInfoRequest;
		}
		return new InnerUpdateHeroRankInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Level = 0;
			Icon = 0;
			IconFrame = 0;
			HeroId = 0;
			Score = 0;
			UserName = null;
			Title = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateHeroRankInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateHeroRankInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateHeroRankInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateHeroRankInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateHeroRankInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateHeroRankInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, int, int>(10, value.IsFromPool, value.UserId, value.Level, value.Icon, value.IconFrame, value.HeroId, value.Score);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int>(value.Title, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateHeroRankInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		int value7;
		int value8;
		int value9;
		int value10;
		string userName;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Level;
				value5 = value.Icon;
				value6 = value.IconFrame;
				value7 = value.HeroId;
				value8 = value.Score;
				userName = value.UserName;
				value9 = value.Title;
				value10 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				goto IL_0203;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateHeroRankInfoRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				userName = null;
				value9 = 0;
				value10 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Level;
				value5 = value.Icon;
				value6 = value.IconFrame;
				value7 = value.HeroId;
				value8 = value.Score;
				userName = value.UserName;
				value9 = value.Title;
				value10 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
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
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											userName = reader.ReadString();
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													_ = 10;
												}
											}
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
				goto IL_0203;
			}
		}
		value = new InnerUpdateHeroRankInfoRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Level = value4,
			Icon = value5,
			IconFrame = value6,
			HeroId = value7,
			Score = value8,
			UserName = userName,
			Title = value9,
			RpcId = value10
		};
		return;
		IL_0203:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Level = value4;
		value.Icon = value5;
		value.IconFrame = value6;
		value.HeroId = value7;
		value.Score = value8;
		value.UserName = userName;
		value.Title = value9;
		value.RpcId = value10;
	}
}
