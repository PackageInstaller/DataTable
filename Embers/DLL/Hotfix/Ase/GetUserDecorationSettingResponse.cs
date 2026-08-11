using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10860)]
[MemoryPackable(GenerateType.Object)]
public class GetUserDecorationSettingResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetUserDecorationSettingResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetUserDecorationSettingResponseFormatter : MemoryPackFormatter<GetUserDecorationSettingResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetUserDecorationSettingResponse value)
		{
			GetUserDecorationSettingResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetUserDecorationSettingResponse value)
		{
			GetUserDecorationSettingResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<int> HeroCardFrames { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public int Bubble { get; set; }

	[MemoryPackOrder(2)]
	public int Indicator { get; set; }

	public static GetUserDecorationSettingResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetUserDecorationSettingResponse)) as GetUserDecorationSettingResponse;
		}
		return new GetUserDecorationSettingResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			HeroCardFrames.Clear();
			Bubble = 0;
			Indicator = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetUserDecorationSettingResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetUserDecorationSettingResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetUserDecorationSettingResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetUserDecorationSettingResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetUserDecorationSettingResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetUserDecorationSettingResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteValue<List<int>>(value.HeroCardFrames);
		writer.WriteUnmanaged<int, int, int, int>(value.Bubble, value.Indicator, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetUserDecorationSettingResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
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
				value3 = value.HeroCardFrames;
				value4 = value.Bubble;
				value5 = value.Indicator;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0181;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, int, int>(out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetUserDecorationSettingResponse), 7, memberCount);
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
				value3 = value.HeroCardFrames;
				value4 = value.Bubble;
				value5 = value.Indicator;
				value6 = value.RpcId;
				value7 = value.Error;
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
		value = new GetUserDecorationSettingResponse
		{
			IsFromPool = value2,
			HeroCardFrames = value3,
			Bubble = value4,
			Indicator = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0181:
		value.IsFromPool = value2;
		value.HeroCardFrames = value3;
		value.Bubble = value4;
		value.Indicator = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
