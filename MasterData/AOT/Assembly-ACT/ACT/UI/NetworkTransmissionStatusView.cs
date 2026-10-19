using ACT.Error;
using ACT.Game.Data;
using Google.Protobuf;
using UnityEngine;

namespace ACT.UI;

public class NetworkTransmissionStatusView : BaseUIView
{
	private static NetworkTransmissionStatusView _instance;

	public GameObject waitView;

	public GameObject errorView;

	private int m_waitCount;

	public static NetworkTransmissionStatusView Instance => _instance;

	private void Awake()
	{
		_instance = this;
	}

	public void WaitOne(bool sendSuccess)
	{
		if (sendSuccess)
		{
			m_waitCount++;
			if (m_waitCount > 0)
			{
				waitView.SetActive(value: true);
			}
		}
		else
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("send error");
			}
			errorView.SetActive(value: true);
		}
	}

	public void SetOne(IMessage message)
	{
		m_waitCount--;
		if (m_waitCount <= 0)
		{
			waitView.SetActive(value: false);
		}
		ErrorAck error = message as ErrorAck;
		if (error == null)
		{
			return;
		}
		LuminError.Handle(error, new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, null, null, (ResolvedError _) =>
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(error.Message);
			}
			errorView.SetActive(value: true);
			return true;
		}));
	}
}
