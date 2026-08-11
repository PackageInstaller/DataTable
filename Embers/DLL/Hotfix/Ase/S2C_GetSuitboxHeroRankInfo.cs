using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10908)]
[MemoryPackable(GenerateType.Object)]
public class S2C_GetSuitboxHeroRankInfo : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_GetSuitboxHeroRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_GetSuitboxHeroRankInfoFormatter : MemoryPackFormatter<S2C_GetSuitboxHeroRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_GetSuitboxHeroRankInfo value)
		{
			S2C_GetSuitboxHeroRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_GetSuitboxHeroRankInfo value)
		{
			S2C_GetSuitboxHeroRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbHeroRankInfo> HeroRankInfos { get; set; } = new List<PbHeroRankInfo>();

	[MemoryPackOrder(1)]
	public PbSelfHeroRankInfo SelfRanks { get; set; }

	public static S2C_GetSuitboxHeroRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_GetSuitboxHeroRankInfo)) as S2C_GetSuitboxHeroRankInfo;
		}
		return new S2C_GetSuitboxHeroRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			HeroRankInfos.Clear();
			SelfRanks = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_GetSuitboxHeroRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GetSuitboxHeroRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new S2C_GetSuitboxHeroRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GetSuitboxHeroRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_GetSuitboxHeroRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbHeroRankInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbHeroRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_GetSuitboxHeroRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHeroRankInfo>>(value.HeroRankInfos));
		writer.WritePackable<PbSelfHeroRankInfo>(value.SelfRanks);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_GetSuitboxHeroRankInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbHeroRankInfo> value3;
		PbSelfHeroRankInfo value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.HeroRankInfos;
				value4 = value.SelfRanks;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbHeroRankInfo>(ref reader);
			value4 = reader.ReadPackable<PbSelfHeroRankInfo>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_GetSuitboxHeroRankInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.HeroRankInfos;
				value4 = value.SelfRanks;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
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
				goto IL_015b;
			}
		}
		value = new S2C_GetSuitboxHeroRankInfo
		{
			IsFromPool = value2,
			HeroRankInfos = value3,
			SelfRanks = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.HeroRankInfos = value3;
		value.SelfRanks = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
