using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10456)]
[MemoryPackable(GenerateType.Object)]
public class MR2MATCH_InnerMatchServerStartMatchRequest : MessageObject, IRequest, IMessage, IMemoryPackable<MR2MATCH_InnerMatchServerStartMatchRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MR2MATCH_InnerMatchServerStartMatchRequestFormatter : MemoryPackFormatter<MR2MATCH_InnerMatchServerStartMatchRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MR2MATCH_InnerMatchServerStartMatchRequest value)
		{
			MR2MATCH_InnerMatchServerStartMatchRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MR2MATCH_InnerMatchServerStartMatchRequest value)
		{
			MR2MATCH_InnerMatchServerStartMatchRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbMatchTeamUserInfo> TeamUserInfos { get; set; } = new List<PbMatchTeamUserInfo>();

	[MemoryPackOrder(3)]
	public string FromAddress { get; set; }

	[MemoryPackOrder(4)]
	public int CopyId { get; set; }

	[MemoryPackOrder(5)]
	public int Difficulty { get; set; }

	[MemoryPackOrder(6)]
	public int CopyKind { get; set; }

	[MemoryPackOrder(7)]
	public int CopyType { get; set; }

	[MemoryPackOrder(8)]
	public int RewardTimes { get; set; }

	public static MR2MATCH_InnerMatchServerStartMatchRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MR2MATCH_InnerMatchServerStartMatchRequest)) as MR2MATCH_InnerMatchServerStartMatchRequest;
		}
		return new MR2MATCH_InnerMatchServerStartMatchRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			TeamUserInfos.Clear();
			FromAddress = null;
			CopyId = 0;
			Difficulty = 0;
			CopyKind = 0;
			CopyType = 0;
			RewardTimes = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MR2MATCH_InnerMatchServerStartMatchRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MR2MATCH_InnerMatchServerStartMatchRequest>())
		{
			MemoryPackFormatterProvider.Register(new MR2MATCH_InnerMatchServerStartMatchRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MR2MATCH_InnerMatchServerStartMatchRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MR2MATCH_InnerMatchServerStartMatchRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMatchTeamUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMatchTeamUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MR2MATCH_InnerMatchServerStartMatchRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(11, value.IsFromPool, value.RoomId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMatchTeamUserInfo>>(value.TeamUserInfos));
		writer.WriteString(value.FromAddress);
		writer.WriteUnmanaged<int, int, int, int, int, int, long>(value.CopyId, value.Difficulty, value.CopyKind, value.CopyType, value.RewardTimes, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MR2MATCH_InnerMatchServerStartMatchRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbMatchTeamUserInfo> value4;
		int value5;
		int value6;
		int value7;
		int value8;
		int value9;
		int value10;
		long value11;
		string fromAddress;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.TeamUserInfos;
				fromAddress = value.FromAddress;
				value5 = value.CopyId;
				value6 = value.Difficulty;
				value7 = value.CopyKind;
				value8 = value.CopyType;
				value9 = value.RewardTimes;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				fromAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0238;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbMatchTeamUserInfo>(ref reader);
			fromAddress = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int, int, long>(out value5, out value6, out value7, out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MR2MATCH_InnerMatchServerStartMatchRequest), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				fromAddress = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.TeamUserInfos;
				fromAddress = value.FromAddress;
				value5 = value.CopyId;
				value6 = value.Difficulty;
				value7 = value.CopyKind;
				value8 = value.CopyType;
				value9 = value.RewardTimes;
				value10 = value.RpcId;
				value11 = value.ActorId;
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
							fromAddress = reader.ReadString();
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
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value11);
														_ = 11;
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
				goto IL_0238;
			}
		}
		value = new MR2MATCH_InnerMatchServerStartMatchRequest
		{
			IsFromPool = value2,
			RoomId = value3,
			TeamUserInfos = value4,
			FromAddress = fromAddress,
			CopyId = value5,
			Difficulty = value6,
			CopyKind = value7,
			CopyType = value8,
			RewardTimes = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_0238:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.TeamUserInfos = value4;
		value.FromAddress = fromAddress;
		value.CopyId = value5;
		value.Difficulty = value6;
		value.CopyKind = value7;
		value.CopyType = value8;
		value.RewardTimes = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}
