using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(354)]
[MemoryPackable(GenerateType.Object)]
public class PbChatUserInfo : MessageObject, IMemoryPackable<PbChatUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbChatUserInfoFormatter : MemoryPackFormatter<PbChatUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbChatUserInfo value)
		{
			PbChatUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbChatUserInfo value)
		{
			PbChatUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public string UserName { get; set; }

	[MemoryPackOrder(1)]
	public int Icon { get; set; }

	[MemoryPackOrder(2)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(3)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public int TitleId { get; set; }

	[MemoryPackOrder(5)]
	public int Bubble { get; set; }

	public static PbChatUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbChatUserInfo)) as PbChatUserInfo;
		}
		return new PbChatUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserName = null;
			Icon = 0;
			IconFrame = 0;
			Level = 0;
			TitleId = 0;
			Bubble = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbChatUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbChatUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbChatUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbChatUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbChatUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbChatUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int, int, int, int>(value.Icon, value.IconFrame, value.Level, value.TitleId, value.Bubble);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbChatUserInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		int value6;
		int value7;
		string userName;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				userName = value.UserName;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.TitleId;
				value7 = value.Bubble;
				reader.ReadUnmanaged<bool>(out value2);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_0179;
			}
			reader.ReadUnmanaged<bool>(out value2);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, int, int>(out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbChatUserInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				userName = null;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				userName = value.UserName;
				value3 = value.Icon;
				value4 = value.IconFrame;
				value5 = value.Level;
				value6 = value.TitleId;
				value7 = value.Bubble;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					userName = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
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
				goto IL_0179;
			}
		}
		value = new PbChatUserInfo
		{
			IsFromPool = value2,
			UserName = userName,
			Icon = value3,
			IconFrame = value4,
			Level = value5,
			TitleId = value6,
			Bubble = value7
		};
		return;
		IL_0179:
		value.IsFromPool = value2;
		value.UserName = userName;
		value.Icon = value3;
		value.IconFrame = value4;
		value.Level = value5;
		value.TitleId = value6;
		value.Bubble = value7;
	}
}
