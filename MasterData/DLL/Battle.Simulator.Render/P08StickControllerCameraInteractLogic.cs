using Cinemachine;
using UnityEngine;

public class P08StickControllerCameraInteractLogic : IStickControllerGameLogic
{
	public CinemachinePOV composer;

	private CriAtomExPlayback criAtomExPlayback;

	private CriAtomExPlayback criAtomExPlaybackStop;

	public string m_cueSheet;

	public string m_cueName;

	public string m_cueNameStop;

	public bool m_useStream;

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		if (composer == null)
		{
			return;
		}
		composer.m_HorizontalAxis.m_InputAxisValue = joystickForwardVector.x;
		composer.m_VerticalAxis.m_InputAxisValue = joystickForwardVector.y;
		if (joystickForwardVector.sqrMagnitude > 0.01f)
		{
			if (criAtomExPlayback.status != CriAtomExPlayback.Status.Playing && !string.IsNullOrEmpty(m_cueSheet) && !string.IsNullOrEmpty(m_cueName))
			{
				criAtomExPlayback = AudioManager.Instance.Play("effect", m_cueSheet, m_cueName, m_useStream);
			}
			if (criAtomExPlaybackStop.status != CriAtomExPlayback.Status.Removed)
			{
				criAtomExPlaybackStop.Stop();
			}
		}
		else if (criAtomExPlayback.status != CriAtomExPlayback.Status.Removed)
		{
			criAtomExPlayback.Stop();
			if (criAtomExPlaybackStop.status != CriAtomExPlayback.Status.Playing && !string.IsNullOrEmpty(m_cueSheet) && !string.IsNullOrEmpty(m_cueNameStop))
			{
				criAtomExPlaybackStop = AudioManager.Instance.Play("effect", m_cueSheet, m_cueNameStop, m_useStream);
			}
		}
	}

	public void InitAudioInfo(string cueSheet, string cueName, string cueNameStop, bool useStream)
	{
		m_cueSheet = cueSheet;
		m_cueName = cueName;
		m_cueNameStop = cueNameStop;
		m_useStream = useStream;
	}
}
