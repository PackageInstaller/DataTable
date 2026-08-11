using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1081)]
[MemoryPackable(GenerateType.Object)]
public class InnerMatchSuccessEnterRoomNotify : MessageObject, IRequest, IMessage, IMemoryPackable<InnerMatchSuccessEnterRoomNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerMatchSuccessEnterRoomNotifyFormatter : MemoryPackFormatter<InnerMatchSuccessEnterRoomNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerMatchSuccessEnterRoomNotify value)
		{
			InnerMatchSuccessEnterRoomNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerMatchSuccessEnterRoomNotify value)
		{
			InnerMatchSuccessEnterRoomNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long FinalRoomId { get; set; }

	[MemoryPackOrder(1)]
	public string FinalAddress { get; set; }

	[MemoryPackOrder(2)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(3)]
	public int SelectRoleId { get; set; }

	[MemoryPackOrder(4)]
	public int CopyId { get; set; }

	public static InnerMatchSuccessEnterRoomNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerMatchSuccessEnterRoomNotify)) as InnerMatchSuccessEnterRoomNotify;
		}
		return new InnerMatchSuccessEnterRoomNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			FinalRoomId = 0L;
			FinalAddress = null;
			SelectModel = 0;
			SelectRoleId = 0;
			CopyId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerMatchSuccessEnterRoomNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMatchSuccessEnterRoomNotify>())
		{
			MemoryPackFormatterProvider.Register(new InnerMatchSuccessEnterRoomNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMatchSuccessEnterRoomNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerMatchSuccessEnterRoomNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerMatchSuccessEnterRoomNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(8, value.IsFromPool, value.FinalRoomId);
		writer.WriteString(value.FinalAddress);
		writer.WriteUnmanaged<int, int, int, int, long>(value.SelectModel, value.SelectRoleId, value.CopyId, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerMatchSuccessEnterRoomNotify? value)
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
		long value8;
		string finalAddress;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FinalRoomId;
				finalAddress = value.FinalAddress;
				value4 = value.SelectModel;
				value5 = value.SelectRoleId;
				value6 = value.CopyId;
				value7 = value.RpcId;
				value8 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				finalAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01a6;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			finalAddress = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, long>(out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerMatchSuccessEnterRoomNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				finalAddress = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FinalRoomId;
				finalAddress = value.FinalAddress;
				value4 = value.SelectModel;
				value5 = value.SelectRoleId;
				value6 = value.CopyId;
				value7 = value.RpcId;
				value8 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						finalAddress = reader.ReadString();
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
				goto IL_01a6;
			}
		}
		value = new InnerMatchSuccessEnterRoomNotify
		{
			IsFromPool = value2,
			FinalRoomId = value3,
			FinalAddress = finalAddress,
			SelectModel = value4,
			SelectRoleId = value5,
			CopyId = value6,
			RpcId = value7,
			UserId = value8
		};
		return;
		IL_01a6:
		value.IsFromPool = value2;
		value.FinalRoomId = value3;
		value.FinalAddress = finalAddress;
		value.SelectModel = value4;
		value.SelectRoleId = value5;
		value.CopyId = value6;
		value.RpcId = value7;
		value.UserId = value8;
	}
}
