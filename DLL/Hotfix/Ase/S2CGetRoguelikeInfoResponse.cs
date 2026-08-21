using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10878)]
[MemoryPackable(GenerateType.Object)]
public class S2CGetRoguelikeInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2CGetRoguelikeInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2CGetRoguelikeInfoResponseFormatter : MemoryPackFormatter<S2CGetRoguelikeInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2CGetRoguelikeInfoResponse value)
		{
			S2CGetRoguelikeInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2CGetRoguelikeInfoResponse value)
		{
			S2CGetRoguelikeInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int MaxLayer { get; set; }

	[MemoryPackOrder(1)]
	public List<int> StrengBuffId { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public List<int> BattlePropIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public int TeamSetId { get; set; }

	[MemoryPackOrder(4)]
	public int RefreshTimes { get; set; }

	[MemoryPackOrder(5)]
	public int RoleId { get; set; }

	[MemoryPackOrder(6)]
	public int EndlessLayer { get; set; }

	public static S2CGetRoguelikeInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2CGetRoguelikeInfoResponse)) as S2CGetRoguelikeInfoResponse;
		}
		return new S2CGetRoguelikeInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			MaxLayer = 0;
			StrengBuffId.Clear();
			BattlePropIds.Clear();
			TeamSetId = 0;
			RefreshTimes = 0;
			RoleId = 0;
			EndlessLayer = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2CGetRoguelikeInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetRoguelikeInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2CGetRoguelikeInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetRoguelikeInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2CGetRoguelikeInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2CGetRoguelikeInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(11, value.IsFromPool, value.MaxLayer);
		writer.WriteValue<List<int>>(value.StrengBuffId);
		writer.WriteValue<List<int>>(value.BattlePropIds);
		writer.WriteUnmanaged<int, int, int, int, int, int>(value.TeamSetId, value.RefreshTimes, value.RoleId, value.EndlessLayer, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2CGetRoguelikeInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<int> value4;
		List<int> value5;
		int value6;
		int value7;
		int value8;
		int value9;
		int value10;
		int value11;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MaxLayer;
				value4 = value.StrengBuffId;
				value5 = value.BattlePropIds;
				value6 = value.TeamSetId;
				value7 = value.RefreshTimes;
				value8 = value.RoleId;
				value9 = value.EndlessLayer;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadValue(ref value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				message = reader.ReadString();
				goto IL_023c;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadValue<List<int>>();
			value5 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, int, int, int, int>(out value6, out value7, out value8, out value9, out value10, out value11);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2CGetRoguelikeInfoResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MaxLayer;
				value4 = value.StrengBuffId;
				value5 = value.BattlePropIds;
				value6 = value.TeamSetId;
				value7 = value.RefreshTimes;
				value8 = value.RoleId;
				value9 = value.EndlessLayer;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
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
				goto IL_023c;
			}
		}
		value = new S2CGetRoguelikeInfoResponse
		{
			IsFromPool = value2,
			MaxLayer = value3,
			StrengBuffId = value4,
			BattlePropIds = value5,
			TeamSetId = value6,
			RefreshTimes = value7,
			RoleId = value8,
			EndlessLayer = value9,
			RpcId = value10,
			Error = value11,
			Message = message
		};
		return;
		IL_023c:
		value.IsFromPool = value2;
		value.MaxLayer = value3;
		value.StrengBuffId = value4;
		value.BattlePropIds = value5;
		value.TeamSetId = value6;
		value.RefreshTimes = value7;
		value.RoleId = value8;
		value.EndlessLayer = value9;
		value.RpcId = value10;
		value.Error = value11;
		value.Message = message;
	}
}
