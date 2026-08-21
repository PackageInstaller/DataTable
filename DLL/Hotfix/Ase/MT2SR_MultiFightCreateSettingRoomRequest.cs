using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10467)]
[MemoryPackable(GenerateType.Object)]
public class MT2SR_MultiFightCreateSettingRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<MT2SR_MultiFightCreateSettingRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MT2SR_MultiFightCreateSettingRoomRequestFormatter : MemoryPackFormatter<MT2SR_MultiFightCreateSettingRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MT2SR_MultiFightCreateSettingRoomRequest value)
		{
			MT2SR_MultiFightCreateSettingRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MT2SR_MultiFightCreateSettingRoomRequest value)
		{
			MT2SR_MultiFightCreateSettingRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbCreateSettingRoomUserInfo> UserInfos { get; set; } = new List<PbCreateSettingRoomUserInfo>();

	[MemoryPackOrder(1)]
	public int CopyId { get; set; }

	[MemoryPackOrder(2)]
	public int Difficult { get; set; }

	public static MT2SR_MultiFightCreateSettingRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MT2SR_MultiFightCreateSettingRoomRequest)) as MT2SR_MultiFightCreateSettingRoomRequest;
		}
		return new MT2SR_MultiFightCreateSettingRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserInfos.Clear();
			CopyId = 0;
			Difficult = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MT2SR_MultiFightCreateSettingRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MT2SR_MultiFightCreateSettingRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new MT2SR_MultiFightCreateSettingRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MT2SR_MultiFightCreateSettingRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MT2SR_MultiFightCreateSettingRoomRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCreateSettingRoomUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCreateSettingRoomUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MT2SR_MultiFightCreateSettingRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCreateSettingRoomUserInfo>>(value.UserInfos));
		writer.WriteUnmanaged<int, int, int>(value.CopyId, value.Difficult, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MT2SR_MultiFightCreateSettingRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbCreateSettingRoomUserInfo> value3;
		int value4;
		int value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfos;
				value4 = value.CopyId;
				value5 = value.Difficult;
				value6 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0122;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbCreateSettingRoomUserInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MT2SR_MultiFightCreateSettingRoomRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfos;
				value4 = value.CopyId;
				value5 = value.Difficult;
				value6 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0122;
			}
		}
		value = new MT2SR_MultiFightCreateSettingRoomRequest
		{
			IsFromPool = value2,
			UserInfos = value3,
			CopyId = value4,
			Difficult = value5,
			RpcId = value6
		};
		return;
		IL_0122:
		value.IsFromPool = value2;
		value.UserInfos = value3;
		value.CopyId = value4;
		value.Difficult = value5;
		value.RpcId = value6;
	}
}
