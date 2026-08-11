using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10707)]
[MemoryPackable(GenerateType.Object)]
public class SetFloorCopySettingRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<SetFloorCopySettingRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SetFloorCopySettingRequestFormatter : MemoryPackFormatter<SetFloorCopySettingRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SetFloorCopySettingRequest value)
		{
			SetFloorCopySettingRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SetFloorCopySettingRequest value)
		{
			SetFloorCopySettingRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbSetFloorCopyRoleSetting> CopyRoleSettingInfo { get; set; } = new List<PbSetFloorCopyRoleSetting>();

	public static SetFloorCopySettingRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SetFloorCopySettingRequest)) as SetFloorCopySettingRequest;
		}
		return new SetFloorCopySettingRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			CopyRoleSettingInfo.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SetFloorCopySettingRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SetFloorCopySettingRequest>())
		{
			MemoryPackFormatterProvider.Register(new SetFloorCopySettingRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SetFloorCopySettingRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SetFloorCopySettingRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSetFloorCopyRoleSetting>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSetFloorCopyRoleSetting>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SetFloorCopySettingRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSetFloorCopyRoleSetting>>(value.CopyRoleSettingInfo));
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SetFloorCopySettingRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbSetFloorCopyRoleSetting> value3;
		int value4;
		long value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyRoleSettingInfo;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbSetFloorCopyRoleSetting>(ref reader);
			reader.ReadUnmanaged<int, long, int, long>(out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SetFloorCopySettingRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyRoleSettingInfo;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
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
		value = new SetFloorCopySettingRequest
		{
			IsFromPool = value2,
			CopyRoleSettingInfo = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.CopyRoleSettingInfo = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
