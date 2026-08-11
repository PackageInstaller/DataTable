using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using GameFramework.Network;

namespace Ase;

public class MemoryPackEncoder : IMessageEncoder<IMessage>
{
	protected readonly SemaphoreSlim writeLock = new SemaphoreSlim(1, 1);

	protected int sequence;

	public async UniTask Encode(IMessage message, BinaryWriter writer)
	{
		await writeLock.WaitAsync();
		try
		{
			if (message is IRequest request)
			{
				request.RpcId = ++sequence;
			}
			ushort opcode = Singleton<NetCodes>.Instance.GetOpcode(message.GetType());
			byte[] array = MessageSerializeHelper.Serialize((MessageObject)message);
			ushort value = (ushort)(array.Length + 2);
			writer.Write(value);
			writer.Write(opcode);
			await writer.WriteAsync(array, 0, array.Length);
			await writer.FlushAsync();
		}
		catch (Exception value2)
		{
			Console.WriteLine(value2);
			throw;
		}
		finally
		{
			writeLock.Release();
		}
	}
}
