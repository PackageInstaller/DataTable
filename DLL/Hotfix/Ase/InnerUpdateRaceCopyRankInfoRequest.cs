using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1063)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateRaceCopyRankInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpdateRaceCopyRankInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateRaceCopyRankInfoRequestFormatter : MemoryPackFormatter<InnerUpdateRaceCopyRankInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateRaceCopyRankInfoRequest value)
		{
			InnerUpdateRaceCopyRankInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateRaceCopyRankInfoRequest value)
		{
			InnerUpdateRaceCopyRankInfoRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(4)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(5)]
	public int CopyType { get; set; }

	[MemoryPackOrder(6)]
	public int Score { get; set; }

	[MemoryPackOrder(7)]
	public int TotalScore { get; set; }

	[MemoryPackOrder(8)]
	public string UserName { get; set; }

	[MemoryPackOrder(9)]
	public int Title { get; set; }

	public static InnerUpdateRaceCopyRankInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateRaceCopyRankInfoRequest)) as InnerUpdateRaceCopyRankInfoRequest;
		}
		return new InnerUpdateRaceCopyRankInfoRequest();
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
			RoleIds.Clear();
			CopyType = 0;
			Score = 0;
			TotalScore = 0;
			UserName = null;
			Title = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateRaceCopyRankInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateRaceCopyRankInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateRaceCopyRankInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateRaceCopyRankInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateRaceCopyRankInfoRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateRaceCopyRankInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int>(12, value.IsFromPool, value.UserId, value.Level, value.Icon, value.IconFrame);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<int, int, int>(value.CopyType, value.Score, value.TotalScore);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int>(value.Title, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateRaceCopyRankInfoRequest? value)
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
		List<int> value7;
		int value8;
		int value9;
		int value10;
		int value11;
		int value12;
		string userName;
		if (memberCount == 12)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Level;
				value5 = value.Icon;
				value6 = value.IconFrame;
				value7 = value.RoleIds;
				value8 = value.CopyType;
				value9 = value.Score;
				value10 = value.TotalScore;
				userName = value.UserName;
				value11 = value.Title;
				value12 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				goto IL_026d;
			}
			reader.ReadUnmanaged<bool, long, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			value7 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, int>(out value8, out value9, out value10);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value11, out value12);
		}
		else
		{
			if (memberCount > 12)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateRaceCopyRankInfoRequest), 12, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				userName = null;
				value11 = 0;
				value12 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Level;
				value5 = value.Icon;
				value6 = value.IconFrame;
				value7 = value.RoleIds;
				value8 = value.CopyType;
				value9 = value.Score;
				value10 = value.TotalScore;
				userName = value.UserName;
				value11 = value.Title;
				value12 = value.RpcId;
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
									reader.ReadValue(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													userName = reader.ReadString();
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value11);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value12);
															_ = 12;
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
				}
			}
			if (value != null)
			{
				goto IL_026d;
			}
		}
		value = new InnerUpdateRaceCopyRankInfoRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Level = value4,
			Icon = value5,
			IconFrame = value6,
			RoleIds = value7,
			CopyType = value8,
			Score = value9,
			TotalScore = value10,
			UserName = userName,
			Title = value11,
			RpcId = value12
		};
		return;
		IL_026d:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Level = value4;
		value.Icon = value5;
		value.IconFrame = value6;
		value.RoleIds = value7;
		value.CopyType = value8;
		value.Score = value9;
		value.TotalScore = value10;
		value.UserName = userName;
		value.Title = value11;
		value.RpcId = value12;
	}
}
