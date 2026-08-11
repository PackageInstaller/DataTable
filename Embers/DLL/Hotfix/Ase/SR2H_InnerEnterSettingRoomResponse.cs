using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10470)]
[MemoryPackable(GenerateType.Object)]
public class SR2H_InnerEnterSettingRoomResponse : MessageObject, IResponse, IMessage, IMemoryPackable<SR2H_InnerEnterSettingRoomResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SR2H_InnerEnterSettingRoomResponseFormatter : MemoryPackFormatter<SR2H_InnerEnterSettingRoomResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SR2H_InnerEnterSettingRoomResponse value)
		{
			SR2H_InnerEnterSettingRoomResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SR2H_InnerEnterSettingRoomResponse value)
		{
			SR2H_InnerEnterSettingRoomResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbRoomInfo RoomInfo { get; set; }

	[MemoryPackOrder(1)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(2)]
	public int UseEnergy { get; set; }

	public static SR2H_InnerEnterSettingRoomResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SR2H_InnerEnterSettingRoomResponse)) as SR2H_InnerEnterSettingRoomResponse;
		}
		return new SR2H_InnerEnterSettingRoomResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoomInfo = null;
			SelectModel = 0;
			UseEnergy = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SR2H_InnerEnterSettingRoomResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SR2H_InnerEnterSettingRoomResponse>())
		{
			MemoryPackFormatterProvider.Register(new SR2H_InnerEnterSettingRoomResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SR2H_InnerEnterSettingRoomResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SR2H_InnerEnterSettingRoomResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SR2H_InnerEnterSettingRoomResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbRoomInfo>(value.RoomInfo);
		writer.WriteUnmanaged<int, int, int, int>(value.SelectModel, value.UseEnergy, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SR2H_InnerEnterSettingRoomResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbRoomInfo value3;
		int value4;
		int value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomInfo;
				value4 = value.SelectModel;
				value5 = value.UseEnergy;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0181;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbRoomInfo>();
			reader.ReadUnmanaged<int, int, int, int>(out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SR2H_InnerEnterSettingRoomResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomInfo;
				value4 = value.SelectModel;
				value5 = value.UseEnergy;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
										message = reader.ReadString();
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0181;
			}
		}
		value = new SR2H_InnerEnterSettingRoomResponse
		{
			IsFromPool = value2,
			RoomInfo = value3,
			SelectModel = value4,
			UseEnergy = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0181:
		value.IsFromPool = value2;
		value.RoomInfo = value3;
		value.SelectModel = value4;
		value.UseEnergy = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
