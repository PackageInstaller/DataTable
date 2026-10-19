using System;
using System.Net.Sockets;
using System.Threading;

namespace Telepathy;

public static class ThreadFunctions
{
	public static bool SendMessagesBlocking(NetworkStream stream, byte[] payload, int packetSize)
	{
		try
		{
			stream.Write(payload, 0, packetSize);
			return true;
		}
		catch (Exception ex)
		{
			Log.Info("[Telepathy] Send: stream.Write exception: " + ex);
			return false;
		}
	}

	public static bool ReadMessageBlocking(NetworkStream stream, int MaxMessageSize, byte[] headerBuffer, byte[] payloadBuffer, out int size)
	{
		size = 0;
		if (payloadBuffer.Length != 4 + MaxMessageSize)
		{
			Log.Error($"[Telepathy] ReadMessageBlocking: payloadBuffer needs to be of size 4 + MaxMessageSize = {4 + MaxMessageSize} instead of {payloadBuffer.Length}");
			return false;
		}
		if (!stream.ReadExactly(headerBuffer, 4))
		{
			return false;
		}
		size = Utils.BytesToIntBigEndian(headerBuffer);
		if (size > 0 && size <= MaxMessageSize)
		{
			return stream.ReadExactly(payloadBuffer, size);
		}
		Log.Warning("[Telepathy] ReadMessageBlocking: possible header attack with a header of: " + size + " bytes.");
		return false;
	}

	public static void ReceiveLoop(int connectionId, TcpClient client, int MaxMessageSize, MagnificentReceivePipe receivePipe, int QueueLimit)
	{
		NetworkStream stream = client.GetStream();
		byte[] array = new byte[4 + MaxMessageSize];
		byte[] headerBuffer = new byte[4];
		try
		{
			receivePipe.Enqueue(connectionId, EventType.Connected, default);
			int size;
			while (ReadMessageBlocking(stream, MaxMessageSize, headerBuffer, array, out size))
			{
				receivePipe.Enqueue(message: new ArraySegment<byte>(array, 0, size), connectionId: connectionId, eventType: EventType.Data);
				if (receivePipe.Count(connectionId) >= QueueLimit)
				{
					Log.Warning($"[Telepathy] receivePipe reached limit of {QueueLimit} for connectionId {connectionId}. This can happen if network messages come in way faster than we manage to process them. Disconnecting this connection for load balancing.");
					break;
				}
			}
		}
		catch (Exception ex)
		{
			Log.Info("[Telepathy] ReceiveLoop: finished receive function for connectionId=" + connectionId + " reason: " + ex);
		}
		finally
		{
			stream.Close();
			client.Close();
			receivePipe.Enqueue(connectionId, EventType.Disconnected, default);
		}
	}

	public static void SendLoop(int connectionId, TcpClient client, MagnificentSendPipe sendPipe, ManualResetEvent sendPending)
	{
		NetworkStream stream = client.GetStream();
		byte[] payload = null;
		try
		{
			while (client.Connected)
			{
				sendPending.Reset();
				if (!sendPipe.DequeueAndSerializeAll(ref payload, out var packetSize) || SendMessagesBlocking(stream, payload, packetSize))
				{
					sendPending.WaitOne();
					continue;
				}
				break;
			}
		}
		catch (ThreadAbortException)
		{
		}
		catch (ThreadInterruptedException)
		{
		}
		catch (Exception ex3)
		{
			Log.Info("[Telepathy] SendLoop Exception: connectionId=" + connectionId + " reason: " + ex3);
		}
		finally
		{
			stream.Close();
			client.Close();
		}
	}
}
