using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1145)]
[MemoryPackable(GenerateType.Object)]
public class GmInnerModifyUnionInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<GmInnerModifyUnionInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GmInnerModifyUnionInfoRequestFormatter : MemoryPackFormatter<GmInnerModifyUnionInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GmInnerModifyUnionInfoRequest value)
		{
			GmInnerModifyUnionInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GmInnerModifyUnionInfoRequest value)
		{
			GmInnerModifyUnionInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public string Declaration { get; set; }

	public static GmInnerModifyUnionInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GmInnerModifyUnionInfoRequest)) as GmInnerModifyUnionInfoRequest;
		}
		return new GmInnerModifyUnionInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			Name = null;
			Declaration = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GmInnerModifyUnionInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GmInnerModifyUnionInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new GmInnerModifyUnionInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GmInnerModifyUnionInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GmInnerModifyUnionInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GmInnerModifyUnionInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.UnionId);
		writer.WriteString(value.Name);
		writer.WriteString(value.Declaration);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GmInnerModifyUnionInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		string name;
		string declaration;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				name = value.Name;
				declaration = value.Declaration;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				declaration = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			declaration = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GmInnerModifyUnionInfoRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				name = null;
				declaration = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				name = value.Name;
				declaration = value.Declaration;
				value4 = value.RpcId;
				value5 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						name = reader.ReadString();
						if (memberCount != 3)
						{
							declaration = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value5);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0156;
			}
		}
		value = new GmInnerModifyUnionInfoRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			Name = name,
			Declaration = declaration,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.Name = name;
		value.Declaration = declaration;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
