using System.IO;
using System.Runtime.ExceptionServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class WebOperation
{
	private CancellationTokenSource cts;

	private WebCompletionSource<WebRequestStream> requestTask;

	private WebCompletionSource<WebRequestStream> requestWrittenTask;

	private WebCompletionSource<WebResponseStream> responseTask;

	private WebCompletionSource<(bool, WebOperation)> finishedTask;

	private WebRequestStream writeStream;

	private WebResponseStream responseStream;

	private ExceptionDispatchInfo disposedInfo;

	private ExceptionDispatchInfo closedInfo;

	private WebOperation priorityRequest;

	private int requestSent;

	private int finished;

	public HttpWebRequest Request { get; }

	public WebConnection Connection { get; private set; }

	public ServicePoint ServicePoint { get; private set; }

	public BufferOffsetSize WriteBuffer { get; }

	public bool IsNtlmChallenge { get; }

	public bool Aborted
	{
		get
		{
			if (disposedInfo != null || Request.Aborted)
			{
				return true;
			}
			if (cts != null && cts.IsCancellationRequested)
			{
				return true;
			}
			return false;
		}
	}

	public bool Closed
	{
		get
		{
			if (!Aborted)
			{
				return closedInfo != null;
			}
			return true;
		}
	}

	public WebRequestStream WriteStream
	{
		get
		{
			ThrowIfDisposed();
			return writeStream;
		}
	}

	internal WebCompletionSource<(bool, WebOperation)> Finished => finishedTask;

	public WebOperation(HttpWebRequest request, BufferOffsetSize writeBuffer, bool isNtlmChallenge, CancellationToken cancellationToken)
	{
		Request = request;
		WriteBuffer = writeBuffer;
		IsNtlmChallenge = isNtlmChallenge;
		cts = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
		requestTask = new WebCompletionSource<WebRequestStream>();
		requestWrittenTask = new WebCompletionSource<WebRequestStream>();
		responseTask = new WebCompletionSource<WebResponseStream>();
		finishedTask = new WebCompletionSource<(bool, WebOperation)>();
	}

	public void Abort()
	{
		if (SetDisposed(ref disposedInfo).Item2)
		{
			cts?.Cancel();
			SetCanceled();
			Close();
		}
	}

	public void Close()
	{
		if (!SetDisposed(ref closedInfo).Item2)
		{
			return;
		}
		WebRequestStream webRequestStream = Interlocked.Exchange(ref writeStream, null);
		if (webRequestStream == null)
		{
			return;
		}
		try
		{
			webRequestStream.Close();
		}
		catch
		{
		}
	}

	private void SetCanceled()
	{
		OperationCanceledException error = new OperationCanceledException();
		requestTask.TrySetCanceled(error);
		requestWrittenTask.TrySetCanceled(error);
		responseTask.TrySetCanceled(error);
		Finish(ok: false, error);
	}

	private void SetError(Exception error)
	{
		requestTask.TrySetException(error);
		requestWrittenTask.TrySetException(error);
		responseTask.TrySetException(error);
		Finish(ok: false, error);
	}

	private (ExceptionDispatchInfo, bool) SetDisposed(ref ExceptionDispatchInfo field)
	{
		ExceptionDispatchInfo exceptionDispatchInfo = ExceptionDispatchInfo.Capture(new WebException(global::SR.GetString("The request was canceled"), WebExceptionStatus.RequestCanceled));
		ExceptionDispatchInfo exceptionDispatchInfo2 = Interlocked.CompareExchange(ref field, exceptionDispatchInfo, null);
		return (exceptionDispatchInfo2 ?? exceptionDispatchInfo, exceptionDispatchInfo2 == null);
	}

	internal ExceptionDispatchInfo CheckDisposed(CancellationToken cancellationToken)
	{
		if (Aborted || cancellationToken.IsCancellationRequested)
		{
			return CheckThrowDisposed(throwIt: false, ref disposedInfo);
		}
		return null;
	}

	internal void ThrowIfDisposed()
	{
		ThrowIfDisposed(CancellationToken.None);
	}

	internal void ThrowIfDisposed(CancellationToken cancellationToken)
	{
		if (Aborted || cancellationToken.IsCancellationRequested)
		{
			CheckThrowDisposed(throwIt: true, ref disposedInfo);
		}
	}

	internal void ThrowIfClosedOrDisposed()
	{
		ThrowIfClosedOrDisposed(CancellationToken.None);
	}

	internal void ThrowIfClosedOrDisposed(CancellationToken cancellationToken)
	{
		if (Closed || cancellationToken.IsCancellationRequested)
		{
			CheckThrowDisposed(throwIt: true, ref closedInfo);
		}
	}

	private ExceptionDispatchInfo CheckThrowDisposed(bool throwIt, ref ExceptionDispatchInfo field)
	{
		(ExceptionDispatchInfo, bool) tuple = SetDisposed(ref field);
		var (exceptionDispatchInfo, _) = tuple;
		if (tuple.Item2)
		{
			cts?.Cancel();
		}
		if (throwIt)
		{
			exceptionDispatchInfo.Throw();
		}
		return exceptionDispatchInfo;
	}

	internal void RegisterRequest(ServicePoint servicePoint, WebConnection connection)
	{
		if (servicePoint == null)
		{
			throw new ArgumentNullException("servicePoint");
		}
		if (connection == null)
		{
			throw new ArgumentNullException("connection");
		}
		lock (this)
		{
			if (Interlocked.CompareExchange(ref requestSent, 1, 0) != 0)
			{
				throw new InvalidOperationException("Invalid nested call.");
			}
			ServicePoint = servicePoint;
			Connection = connection;
		}
		cts.Token.Register(delegate
		{
			Request.FinishedReading = true;
			SetDisposed(ref disposedInfo);
		});
	}

	public void SetPriorityRequest(WebOperation operation)
	{
		lock (this)
		{
			if (requestSent != 1 || ServicePoint == null || finished != 0)
			{
				throw new InvalidOperationException("Should never happen.");
			}
			if (Interlocked.CompareExchange(ref priorityRequest, operation, null) != null)
			{
				throw new InvalidOperationException("Invalid nested request.");
			}
		}
	}

	public async Task<Stream> GetRequestStream()
	{
		return await requestTask.WaitForCompletion().ConfigureAwait(continueOnCapturedContext: false);
	}

	internal Task<WebRequestStream> GetRequestStreamInternal()
	{
		return requestTask.WaitForCompletion();
	}

	public Task<WebResponseStream> GetResponseStream()
	{
		return responseTask.WaitForCompletion();
	}

	internal async void Run()
	{
		_ = 2;
		try
		{
			ThrowIfClosedOrDisposed();
			WebRequestStream requestStream = await Connection.InitConnection(this, cts.Token).ConfigureAwait(continueOnCapturedContext: false);
			ThrowIfClosedOrDisposed();
			writeStream = requestStream;
			await requestStream.Initialize(cts.Token).ConfigureAwait(continueOnCapturedContext: false);
			ThrowIfClosedOrDisposed();
			requestTask.TrySetCompleted(requestStream);
			WebResponseStream stream = (responseStream = new WebResponseStream(requestStream));
			await stream.InitReadAsync(cts.Token).ConfigureAwait(continueOnCapturedContext: false);
			responseTask.TrySetCompleted(stream);
		}
		catch (OperationCanceledException)
		{
			SetCanceled();
		}
		catch (Exception error)
		{
			SetError(error);
		}
	}

	internal void CompleteRequestWritten(WebRequestStream stream, Exception error = null)
	{
		if (error != null)
		{
			SetError(error);
		}
		else
		{
			requestWrittenTask.TrySetCompleted(stream);
		}
	}

	internal void Finish(bool ok, Exception error = null)
	{
		if (Interlocked.CompareExchange(ref finished, 1, 0) != 0)
		{
			return;
		}
		WebResponseStream webResponseStream;
		WebOperation webOperation;
		lock (this)
		{
			webResponseStream = Interlocked.Exchange(ref responseStream, null);
			webOperation = Interlocked.Exchange(ref priorityRequest, null);
			Request.FinishedReading = true;
		}
		if (error != null)
		{
			webOperation?.SetError(error);
			finishedTask.TrySetException(error);
			return;
		}
		bool item = (!Aborted & ok) && (webResponseStream?.KeepAlive ?? false);
		if (webOperation != null && webOperation.Aborted)
		{
			webOperation = null;
			item = false;
		}
		finishedTask.TrySetCompleted((item, webOperation));
	}
}
