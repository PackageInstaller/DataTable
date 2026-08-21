using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10109)]
[MemoryPackable(GenerateType.Object)]
public class S2C_GetMailAttachmentResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_GetMailAttachmentResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_GetMailAttachmentResponseFormatter : MemoryPackFormatter<S2C_GetMailAttachmentResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_GetMailAttachmentResponse value)
		{
			S2C_GetMailAttachmentResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_GetMailAttachmentResponse value)
		{
			S2C_GetMailAttachmentResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<long> SuccessLids { get; set; } = new List<long>();

	[MemoryPackOrder(1)]
	public PbDropThing ItemGet { get; set; }

	[MemoryPackOrder(2)]
	public List<PbThingBase> CountLimitItems { get; set; } = new List<PbThingBase>();

	[MemoryPackOrder(3)]
	public List<PbThingBase> PackageLimitItems { get; set; } = new List<PbThingBase>();

	[MemoryPackOrder(4)]
	public int Level { get; set; }

	[MemoryPackOrder(5)]
	public long AccountExp { get; set; }

	[MemoryPackOrder(6)]
	public List<PbLongIntValue> OpenPacks { get; set; } = new List<PbLongIntValue>();

	public static S2C_GetMailAttachmentResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_GetMailAttachmentResponse)) as S2C_GetMailAttachmentResponse;
		}
		return new S2C_GetMailAttachmentResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			SuccessLids.Clear();
			ItemGet = null;
			CountLimitItems.Clear();
			PackageLimitItems.Clear();
			Level = 0;
			AccountExp = 0L;
			OpenPacks.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_GetMailAttachmentResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GetMailAttachmentResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_GetMailAttachmentResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GetMailAttachmentResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_GetMailAttachmentResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbThingBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbThingBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbLongIntValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbLongIntValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_GetMailAttachmentResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(11, value.IsFromPool);
		writer.WriteValue<List<long>>(value.SuccessLids);
		writer.WritePackable<PbDropThing>(value.ItemGet);
		List<PbThingBase> source = value.CountLimitItems;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.PackageLimitItems;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int, long>(value.Level, value.AccountExp);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbLongIntValue>>(value.OpenPacks));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_GetMailAttachmentResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<long> value3;
		PbDropThing value4;
		List<PbThingBase> value5;
		List<PbThingBase> value6;
		int value7;
		long value8;
		List<PbLongIntValue> value9;
		int value10;
		int value11;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SuccessLids;
				value4 = value.ItemGet;
				value5 = value.CountLimitItems;
				value6 = value.PackageLimitItems;
				value7 = value.Level;
				value8 = value.AccountExp;
				value9 = value.OpenPacks;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadPackable(ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				ListFormatter.DeserializePackable(ref reader, ref value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				message = reader.ReadString();
				goto IL_0254;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<long>>();
			value4 = reader.ReadPackable<PbDropThing>();
			value5 = ListFormatter.DeserializePackable<PbThingBase>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbThingBase>(ref reader);
			reader.ReadUnmanaged<int, long>(out value7, out value8);
			value9 = ListFormatter.DeserializePackable<PbLongIntValue>(ref reader);
			reader.ReadUnmanaged<int, int>(out value10, out value11);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_GetMailAttachmentResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0L;
				value9 = null;
				value10 = 0;
				value11 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SuccessLids;
				value4 = value.ItemGet;
				value5 = value.CountLimitItems;
				value6 = value.PackageLimitItems;
				value7 = value.Level;
				value8 = value.AccountExp;
				value9 = value.OpenPacks;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											ListFormatter.DeserializePackable(ref reader, ref value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														message = reader.ReadString();
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
				goto IL_0254;
			}
		}
		value = new S2C_GetMailAttachmentResponse
		{
			IsFromPool = value2,
			SuccessLids = value3,
			ItemGet = value4,
			CountLimitItems = value5,
			PackageLimitItems = value6,
			Level = value7,
			AccountExp = value8,
			OpenPacks = value9,
			RpcId = value10,
			Error = value11,
			Message = message
		};
		return;
		IL_0254:
		value.IsFromPool = value2;
		value.SuccessLids = value3;
		value.ItemGet = value4;
		value.CountLimitItems = value5;
		value.PackageLimitItems = value6;
		value.Level = value7;
		value.AccountExp = value8;
		value.OpenPacks = value9;
		value.RpcId = value10;
		value.Error = value11;
		value.Message = message;
	}
}
