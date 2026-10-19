using System;
using UnityEngine;
using UnityEngine.Networking.PlayerConnection;

namespace YooAsset;

internal class RemoteDebuggerInRuntime : MonoBehaviour
{
	private static bool _sampleOnce;

	private static bool _autoSample;

	private void Awake()
	{
	}

	private void OnEnable()
	{
		PlayerConnection.instance.Register(RemoteDebuggerDefine.kMsgEditorSendToPlayer, OnHandleEditorMessage);
	}

	private void OnDisable()
	{
		PlayerConnection.instance.Unregister(RemoteDebuggerDefine.kMsgEditorSendToPlayer, OnHandleEditorMessage);
	}

	private void LateUpdate()
	{
		if (_autoSample || _sampleOnce)
		{
			_sampleOnce = false;
			byte[] data = DebugReport.Serialize(YooAssets.GetDebugReport());
			PlayerConnection.instance.Send(RemoteDebuggerDefine.kMsgPlayerSendToEditor, data);
		}
	}

	private static void OnHandleEditorMessage(MessageEventArgs args)
	{
		RemoteCommand remoteCommand = RemoteCommand.Deserialize(args.data);
		if (remoteCommand.CommandType == 0)
		{
			_sampleOnce = true;
			return;
		}
		if (remoteCommand.CommandType == 1)
		{
			if (remoteCommand.CommandParam == "open")
			{
				_autoSample = true;
			}
			else
			{
				_autoSample = false;
			}
			return;
		}
		throw new NotImplementedException(remoteCommand.CommandType.ToString());
	}
}
