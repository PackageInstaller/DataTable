#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Network;

namespace Ase;

public class MemoryPackDecoder : IMessageDecoder<IMessage>
{
	protected readonly SemaphoreSlim readLock = new SemaphoreSlim(1, 1);

	protected ByteBuffer buffer = new ByteBuffer(GameEntry.Network.IsBigEndian);

	public async UniTask<IMessage> Decode(BinaryReader reader)
	{
		await readLock.WaitAsync();
		ushort opcode = 0;
		try
		{
			ushort messageSize = await reader.ReadUInt16();
			buffer.Clear();
			await reader.Read(buffer, messageSize);
			ushort length = (ushort)(messageSize - 2);
			opcode = buffer.ReadUInt16();
			Type type = Singleton<NetCodes>.Instance.GetType(opcode);
			byte[] array = buffer.ReadBytes(0, length);
			return MessageSerializeHelper.Deserialize(type, array, 0, array.Length);
		}
		catch (Exception ex)
		{
			Log.Error($"反序列化[{opcode}]错误 : " + ex);
			throw ex;
		}
		finally
		{
			readLock.Release();
		}
	}
}
