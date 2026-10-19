using System;
using System.Collections.Concurrent;
using System.IO;
using ProximaWebSocketSharp;
using ProximaWebSocketSharp.Server;
using UnityEngine;

namespace Proxima;

internal class ProximaEmbeddedConnection : WebSocketBehavior, ProximaConnection
{
	private ConcurrentQueue<(ProximaConnection, string)> _receiveQueue;

	private string _password;

	private bool _passwordProvided;

	private string _displayName;

	private ProximaInstanceHello _hello;

	private DateTime _lastListTime;

	private DateTime _lastSelectTime;

	private ProximaStatus _status;

	private ProximaDispatcher _dispatcher;

	public bool Open => ReadyState == WebSocketState.Open;

	public void Initialize(string displayName, string password, ProximaDispatcher dispatcher, ProximaStatus status, ConcurrentQueue<(ProximaConnection, string)> queue)
	{
		_displayName = displayName;
		_receiveQueue = queue;
		_dispatcher = dispatcher;
		_status = status;
		_dispatcher.Dispatch(() =>
		{
			_hello = ProximaSerialization.CreateHello(_displayName);
			_password = ProximaSerialization.HashPassword(password, _hello.ConnectionId);
		});
	}

	protected override void OnClose(CloseEventArgs e)
	{
		_dispatcher.Dispatch(() =>
		{
			if (_passwordProvided)
			{
				_status.DecrementConnections();
			}
		});
	}

	public void SendMessage(MemoryStream data)
	{
		if (Open)
		{
			SendAsTextAsync(data, (bool b) =>
			{
			});
		}
	}

	protected override void OnMessage(MessageEventArgs e)
	{
		if (_passwordProvided)
		{
			_receiveQueue.Enqueue((this, e.Data));
			return;
		}
		ProximaRequest request;
		try
		{
			request = JsonUtility.FromJson<ProximaRequest>(e.Data);
		}
		catch (Exception ex)
		{
			Log.Error("Failed to parse request: " + ex.Message);
			return;
		}
		if (request.Type == ProximaRequestType.List)
		{
			_ = _lastListTime;
			if (DateTime.Now - _lastListTime < TimeSpan.FromSeconds(1.0))
			{
				SendMessage(ProximaSerialization.ErrorResponse(request, "Too many requests."));
				return;
			}
			_dispatcher.Dispatch(() =>
			{
				SendMessage(ProximaSerialization.DataResponse(request, new ProximaInstanceHello[1] { _hello }));
			});
			_lastListTime = DateTime.Now;
		}
		else if (request.Type == ProximaRequestType.Select)
		{
			_ = _lastSelectTime;
			if (DateTime.Now - _lastSelectTime < TimeSpan.FromSeconds(1.0))
			{
				SendMessage(ProximaSerialization.ErrorResponse(request, "Too many requests."));
				return;
			}
			MemoryStream data;
			if (request.Cmd != _hello.InstanceId)
			{
				data = ProximaSerialization.ErrorResponse(request, "Invalid selection.");
			}
			else if (request.Args.Length != 1 || request.Args[0] != _password)
			{
				data = ProximaSerialization.ErrorResponse(request, "Invalid password.");
			}
			else
			{
				data = ProximaSerialization.DataResponse(request, "OK");
				_passwordProvided = true;
				_dispatcher.Dispatch(() =>
				{
					_status.IncrementConnections();
				});
			}
			SendMessage(data);
			_lastSelectTime = DateTime.Now;
		}
		else
		{
			Log.Info("Unknown request: " + request.Type);
		}
	}
}
