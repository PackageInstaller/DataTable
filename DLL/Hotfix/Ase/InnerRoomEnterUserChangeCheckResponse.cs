using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10163)]
[MemoryPackable(GenerateType.Object)]
public class InnerRoomEnterUserChangeCheckResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerRoomEnterUserChangeCheckResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerRoomEnterUserChangeCheckResponseFormatter : MemoryPackFormatter<InnerRoomEnterUserChangeCheckResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerRoomEnterUserChangeCheckResponse value)
		{
			InnerRoomEnterUserChangeCheckResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerRoomEnterUserChangeCheckResponse value)
		{
			InnerRoomEnterUserChangeCheckResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool UserInfoChange { get; set; }

	[MemoryPackOrder(1)]
	public bool WeaponChange { get; set; }

	[MemoryPackOrder(2)]
	public bool AramorChange { get; set; }

	[MemoryPackOrder(3)]
	public bool GoodsChange { get; set; }

	[MemoryPackOrder(4)]
	public bool RoleChange { get; set; }

	public static InnerRoomEnterUserChangeCheckResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerRoomEnterUserChangeCheckResponse)) as InnerRoomEnterUserChangeCheckResponse;
		}
		return new InnerRoomEnterUserChangeCheckResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserInfoChange = false;
			WeaponChange = false;
			AramorChange = false;
			GoodsChange = false;
			RoleChange = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerRoomEnterUserChangeCheckResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRoomEnterUserChangeCheckResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerRoomEnterUserChangeCheckResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRoomEnterUserChangeCheckResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerRoomEnterUserChangeCheckResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerRoomEnterUserChangeCheckResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool, bool, bool, bool, bool, int, int>(9, value.IsFromPool, value.UserInfoChange, value.WeaponChange, value.AramorChange, value.GoodsChange, value.RoleChange, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerRoomEnterUserChangeCheckResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		bool value4;
		bool value5;
		bool value6;
		bool value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfoChange;
				value4 = value.WeaponChange;
				value5 = value.AramorChange;
				value6 = value.GoodsChange;
				value7 = value.RoleChange;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				reader.ReadUnmanaged<bool>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01d0;
			}
			reader.ReadUnmanaged<bool, bool, bool, bool, bool, bool, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerRoomEnterUserChangeCheckResponse), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				value4 = false;
				value5 = false;
				value6 = false;
				value7 = false;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserInfoChange;
				value4 = value.WeaponChange;
				value5 = value.AramorChange;
				value6 = value.GoodsChange;
				value7 = value.RoleChange;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<bool>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<bool>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
												_ = 9;
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
				goto IL_01d0;
			}
		}
		value = new InnerRoomEnterUserChangeCheckResponse
		{
			IsFromPool = value2,
			UserInfoChange = value3,
			WeaponChange = value4,
			AramorChange = value5,
			GoodsChange = value6,
			RoleChange = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01d0:
		value.IsFromPool = value2;
		value.UserInfoChange = value3;
		value.WeaponChange = value4;
		value.AramorChange = value5;
		value.GoodsChange = value6;
		value.RoleChange = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
