using System.IO;
using System.Net.Sockets;
using System.Text;

namespace System.Net;

internal class CommandStream : NetworkStreamWrapper
{
	internal enum PipelineInstruction
	{
		Abort,
		Advance,
		Pause,
		Reread,
		GiveStream
	}

	[Flags]
	internal enum PipelineEntryFlags
	{
		UserCommand = 1,
		GiveDataStream = 2,
		CreateDataConnection = 4,
		DontLogParameter = 8
	}

	internal class PipelineEntry
	{
		internal string Command;

		internal PipelineEntryFlags Flags;

		internal PipelineEntry(string command)
		{
			Command = command;
		}

		internal PipelineEntry(string command, PipelineEntryFlags flags)
		{
			Command = command;
			Flags = flags;
		}

		internal bool HasFlag(PipelineEntryFlags flags)
		{
			return (Flags & flags) != 0;
		}
	}

	private static readonly AsyncCallback s_writeCallbackDelegate = WriteCallback;

	private static readonly AsyncCallback s_readCallbackDelegate = ReadCallback;

	private bool _recoverableFailure;

	protected WebRequest _request;

	protected bool _isAsync;

	private bool _aborted;

	protected PipelineEntry[] _commands;

	protected int _index;

	private bool _doRead;

	private bool _doSend;

	private ResponseDescription _currentResponseDescription;

	protected string _abortReason;

	private string _buffer = string.Empty;

	private Encoding _encoding = Encoding.UTF8;

	private Decoder _decoder;

	internal bool RecoverableFailure => _recoverableFailure;

	protected Encoding Encoding
	{
		get
		{
			return _encoding;
		}
		set
		{
			_encoding = value;
			_decoder = _encoding.GetDecoder();
		}
	}

	internal CommandStream(TcpClient client)
		: base(client)
	{
		_decoder = _encoding.GetDecoder();
	}

	internal virtual void Abort(Exception e)
	{
		if (NetEventSource.IsEnabled)
		{
			NetEventSource.Info(this, "closing control Stream", "Abort");
		}
		lock (this)
		{
			if (_aborted)
			{
				return;
			}
			_aborted = true;
		}
		try
		{
			Close(0);
		}
		finally
		{
			if (e != null)
			{
				InvokeRequestCallback(e);
			}
			else
			{
				InvokeRequestCallback(null);
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (NetEventSource.IsEnabled)
		{
			NetEventSource.Info(this, null, "Dispose");
		}
		InvokeRequestCallback(null);
	}

	protected void InvokeRequestCallback(object obj)
	{
		WebRequest request = _request;
		if (request != null)
		{
			((FtpWebRequest)request).RequestCallback(obj);
		}
	}

	protected void MarkAsRecoverableFailure()
	{
		if (_index <= 1)
		{
			_recoverableFailure = true;
		}
	}

	internal Stream SubmitRequest(WebRequest request, bool isAsync, bool readInitalResponseOnConnect)
	{
		ClearState();
		PipelineEntry[] commands = BuildCommandsList(request);
		InitCommandPipeline(request, commands, isAsync);
		if (readInitalResponseOnConnect)
		{
			_doSend = false;
			_index = -1;
		}
		return ContinueCommandPipeline();
	}

	protected virtual void ClearState()
	{
		InitCommandPipeline(null, null, isAsync: false);
	}

	protected virtual PipelineEntry[] BuildCommandsList(WebRequest request)
	{
		return null;
	}

	protected Exception GenerateException(string message, WebExceptionStatus status, Exception innerException)
	{
		return new WebException(message, innerException, status, null);
	}

	protected Exception GenerateException(FtpStatusCode code, string statusDescription, Exception innerException)
	{
		return new WebException(global::SR.Format("The remote server returned an error: {0}.", NetRes.GetWebStatusCodeString(code, statusDescription)), innerException, WebExceptionStatus.ProtocolError, null);
	}

	protected void InitCommandPipeline(WebRequest request, PipelineEntry[] commands, bool isAsync)
	{
		_commands = commands;
		_index = 0;
		_request = request;
		_aborted = false;
		_doRead = true;
		_doSend = true;
		_currentResponseDescription = null;
		_isAsync = isAsync;
		_recoverableFailure = false;
		_abortReason = string.Empty;
	}

	internal void CheckContinuePipeline()
	{
		if (_isAsync)
		{
			return;
		}
		try
		{
			ContinueCommandPipeline();
		}
		catch (Exception e)
		{
			Abort(e);
		}
	}

	protected Stream ContinueCommandPipeline()
	{
		bool isAsync = _isAsync;
		while (_index < _commands.Length)
		{
			if (_doSend)
			{
				if (_index < 0)
				{
					throw new InternalException();
				}
				byte[] bytes = Encoding.GetBytes(_commands[_index].Command);
				if (NetEventSource.Log.IsEnabled())
				{
					string text = _commands[_index].Command.Substring(0, _commands[_index].Command.Length - 2);
					if (_commands[_index].HasFlag(PipelineEntryFlags.DontLogParameter))
					{
						int num = text.IndexOf(' ');
						if (num != -1)
						{
							text = text.Substring(0, num) + " ********";
						}
					}
					if (NetEventSource.IsEnabled)
					{
						NetEventSource.Info(this, $"Sending command {text}", "ContinueCommandPipeline");
					}
				}
				try
				{
					if (isAsync)
					{
						BeginWrite(bytes, 0, bytes.Length, s_writeCallbackDelegate, this);
					}
					else
					{
						Write(bytes, 0, bytes.Length);
					}
				}
				catch (IOException)
				{
					MarkAsRecoverableFailure();
					throw;
				}
				catch
				{
					throw;
				}
				if (isAsync)
				{
					return null;
				}
			}
			Stream stream = null;
			if (PostSendCommandProcessing(ref stream))
			{
				return stream;
			}
		}
		lock (this)
		{
			Close();
		}
		return null;
	}

	private bool PostSendCommandProcessing(ref Stream stream)
	{
		if (_doRead)
		{
			bool isAsync = _isAsync;
			int index = _index;
			PipelineEntry[] commands = _commands;
			try
			{
				ResponseDescription currentResponseDescription = ReceiveCommandResponse();
				if (isAsync)
				{
					return true;
				}
				_currentResponseDescription = currentResponseDescription;
			}
			catch
			{
				if (index < 0 || index >= commands.Length || commands[index].Command != "QUIT\r\n")
				{
					throw;
				}
			}
		}
		return PostReadCommandProcessing(ref stream);
	}

	private bool PostReadCommandProcessing(ref Stream stream)
	{
		if (_index >= _commands.Length)
		{
			return false;
		}
		_doSend = false;
		_doRead = false;
		PipelineEntry pipelineEntry = ((_index != -1) ? _commands[_index] : null);
		switch ((_currentResponseDescription == null && pipelineEntry.Command == "QUIT\r\n") ? PipelineInstruction.Advance : PipelineCallback(pipelineEntry, _currentResponseDescription, timeout: false, ref stream))
		{
		case PipelineInstruction.Abort:
		{
			Exception ex = ((!(_abortReason != string.Empty)) ? GenerateException("The underlying connection was closed: The server committed a protocol violation", WebExceptionStatus.ServerProtocolViolation, null) : new WebException(_abortReason));
			Abort(ex);
			throw ex;
		}
		case PipelineInstruction.Advance:
			_currentResponseDescription = null;
			_doSend = true;
			_doRead = true;
			_index++;
			break;
		case PipelineInstruction.Pause:
			return true;
		case PipelineInstruction.GiveStream:
			_currentResponseDescription = null;
			_doRead = true;
			if (_isAsync)
			{
				ContinueCommandPipeline();
				InvokeRequestCallback(stream);
			}
			return true;
		case PipelineInstruction.Reread:
			_currentResponseDescription = null;
			_doRead = true;
			break;
		}
		return false;
	}

	protected virtual PipelineInstruction PipelineCallback(PipelineEntry entry, ResponseDescription response, bool timeout, ref Stream stream)
	{
		return PipelineInstruction.Abort;
	}

	private static void ReadCallback(IAsyncResult asyncResult)
	{
		ReceiveState receiveState = (ReceiveState)asyncResult.AsyncState;
		try
		{
			Stream connection = receiveState.Connection;
			int num = 0;
			try
			{
				num = connection.EndRead(asyncResult);
				if (num == 0)
				{
					receiveState.Connection.CloseSocket();
				}
			}
			catch (IOException)
			{
				receiveState.Connection.MarkAsRecoverableFailure();
				throw;
			}
			catch
			{
				throw;
			}
			receiveState.Connection.ReceiveCommandResponseCallback(receiveState, num);
		}
		catch (Exception e)
		{
			receiveState.Connection.Abort(e);
		}
	}

	private static void WriteCallback(IAsyncResult asyncResult)
	{
		CommandStream commandStream = (CommandStream)asyncResult.AsyncState;
		try
		{
			try
			{
				commandStream.EndWrite(asyncResult);
			}
			catch (IOException)
			{
				commandStream.MarkAsRecoverableFailure();
				throw;
			}
			catch
			{
				throw;
			}
			Stream stream = null;
			if (!commandStream.PostSendCommandProcessing(ref stream))
			{
				commandStream.ContinueCommandPipeline();
			}
		}
		catch (Exception e)
		{
			commandStream.Abort(e);
		}
	}

	protected virtual bool CheckValid(ResponseDescription response, ref int validThrough, ref int completeLength)
	{
		return false;
	}

	private ResponseDescription ReceiveCommandResponse()
	{
		ReceiveState receiveState = new ReceiveState(this);
		try
		{
			if (_buffer.Length > 0)
			{
				ReceiveCommandResponseCallback(receiveState, -1);
			}
			else
			{
				try
				{
					if (_isAsync)
					{
						BeginRead(receiveState.Buffer, 0, receiveState.Buffer.Length, s_readCallbackDelegate, receiveState);
						return null;
					}
					int num = Read(receiveState.Buffer, 0, receiveState.Buffer.Length);
					if (num == 0)
					{
						CloseSocket();
					}
					ReceiveCommandResponseCallback(receiveState, num);
				}
				catch (IOException)
				{
					MarkAsRecoverableFailure();
					throw;
				}
				catch
				{
					throw;
				}
			}
		}
		catch (Exception ex2)
		{
			if (ex2 is WebException)
			{
				throw;
			}
			throw GenerateException("The underlying connection was closed: An unexpected error occurred on a receive", WebExceptionStatus.ReceiveFailure, ex2);
		}
		return receiveState.Resp;
	}

	private void ReceiveCommandResponseCallback(ReceiveState state, int bytesRead)
	{
		int completeLength = -1;
		while (true)
		{
			int validThrough = state.ValidThrough;
			if (_buffer.Length > 0)
			{
				state.Resp.StatusBuffer.Append(_buffer);
				_buffer = string.Empty;
				if (!CheckValid(state.Resp, ref validThrough, ref completeLength))
				{
					throw GenerateException("The underlying connection was closed: The server committed a protocol violation", WebExceptionStatus.ServerProtocolViolation, null);
				}
			}
			else
			{
				if (bytesRead <= 0)
				{
					throw GenerateException("The underlying connection was closed: The server committed a protocol violation", WebExceptionStatus.ServerProtocolViolation, null);
				}
				char[] array = new char[_decoder.GetCharCount(state.Buffer, 0, bytesRead)];
				int chars = _decoder.GetChars(state.Buffer, 0, bytesRead, array, 0, flush: false);
				string text = new string(array, 0, chars);
				state.Resp.StatusBuffer.Append(text);
				if (!CheckValid(state.Resp, ref validThrough, ref completeLength))
				{
					throw GenerateException("The underlying connection was closed: The server committed a protocol violation", WebExceptionStatus.ServerProtocolViolation, null);
				}
				if (completeLength >= 0)
				{
					int num = state.Resp.StatusBuffer.Length - completeLength;
					if (num > 0)
					{
						_buffer = text.Substring(text.Length - num, num);
					}
				}
			}
			if (completeLength >= 0)
			{
				break;
			}
			state.ValidThrough = validThrough;
			try
			{
				if (_isAsync)
				{
					BeginRead(state.Buffer, 0, state.Buffer.Length, s_readCallbackDelegate, state);
					return;
				}
				bytesRead = Read(state.Buffer, 0, state.Buffer.Length);
				if (bytesRead == 0)
				{
					CloseSocket();
				}
			}
			catch (IOException)
			{
				MarkAsRecoverableFailure();
				throw;
			}
			catch
			{
				throw;
			}
		}
		string text2 = state.Resp.StatusBuffer.ToString();
		state.Resp.StatusDescription = text2.Substring(0, completeLength);
		if (NetEventSource.IsEnabled)
		{
			NetEventSource.Info(this, $"Received response: {text2.Substring(0, completeLength - 2)}", "ReceiveCommandResponseCallback");
		}
		if (_isAsync)
		{
			if (state.Resp != null)
			{
				_currentResponseDescription = state.Resp;
			}
			Stream stream = null;
			if (!PostReadCommandProcessing(ref stream))
			{
				ContinueCommandPipeline();
			}
		}
	}
}
