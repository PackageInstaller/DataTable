using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10044)]
[MemoryPackable(GenerateType.Object)]
public class G2C_PlayerInfo : MessageObject, IResponse, IMessage, IMemoryPackable<G2C_PlayerInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_PlayerInfoFormatter : MemoryPackFormatter<G2C_PlayerInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_PlayerInfo value)
		{
			G2C_PlayerInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_PlayerInfo value)
		{
			G2C_PlayerInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PlayerInfo PlayerInfo { get; set; }

	[MemoryPackOrder(1)]
	public List<PlayerInfo> PlayerInfos { get; set; } = new List<PlayerInfo>();

	[MemoryPackOrder(2)]
	public List<string> TestRepeatedString { get; set; } = new List<string>();

	[MemoryPackOrder(3)]
	public List<int> TestRepeatedInt32 { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public List<long> TestRepeatedInt64 { get; set; } = new List<long>();

	public static G2C_PlayerInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_PlayerInfo)) as G2C_PlayerInfo;
		}
		return new G2C_PlayerInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			PlayerInfo = null;
			PlayerInfos.Clear();
			TestRepeatedString.Clear();
			TestRepeatedInt32.Clear();
			TestRepeatedInt64.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_PlayerInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_PlayerInfo>())
		{
			MemoryPackFormatterProvider.Register(new G2C_PlayerInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_PlayerInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_PlayerInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PlayerInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PlayerInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_PlayerInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(9, value.IsFromPool);
		writer.WritePackable<PlayerInfo>(value.PlayerInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PlayerInfo>>(value.PlayerInfos));
		writer.WriteValue<List<string>>(value.TestRepeatedString);
		writer.WriteValue<List<int>>(value.TestRepeatedInt32);
		writer.WriteValue<List<long>>(value.TestRepeatedInt64);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_PlayerInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PlayerInfo value3;
		List<PlayerInfo> value4;
		List<string> value5;
		List<int> value6;
		List<long> value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerInfo;
				value4 = value.PlayerInfos;
				value5 = value.TestRepeatedString;
				value6 = value.TestRepeatedInt32;
				value7 = value.TestRepeatedInt64;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadValue(ref value5);
				reader.ReadValue(ref value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01f2;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PlayerInfo>();
			value4 = ListFormatter.DeserializePackable<PlayerInfo>(ref reader);
			value5 = reader.ReadValue<List<string>>();
			value6 = reader.ReadValue<List<int>>();
			value7 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, int>(out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_PlayerInfo), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerInfo;
				value4 = value.PlayerInfos;
				value5 = value.TestRepeatedString;
				value6 = value.TestRepeatedInt32;
				value7 = value.TestRepeatedInt64;
				value8 = value.RpcId;
				value9 = value.Error;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									reader.ReadValue(ref value7);
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
				goto IL_01f2;
			}
		}
		value = new G2C_PlayerInfo
		{
			IsFromPool = value2,
			PlayerInfo = value3,
			PlayerInfos = value4,
			TestRepeatedString = value5,
			TestRepeatedInt32 = value6,
			TestRepeatedInt64 = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01f2:
		value.IsFromPool = value2;
		value.PlayerInfo = value3;
		value.PlayerInfos = value4;
		value.TestRepeatedString = value5;
		value.TestRepeatedInt32 = value6;
		value.TestRepeatedInt64 = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
