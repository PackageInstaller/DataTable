using UnityEngine;

public class EffectAudio : MonoBehaviour
{
	public string m_cueSheet;

	public string m_cueName;

	public bool m_useStream;

	private CriAtomSource _criAtomSource;

	private void Awake()
	{
		Init();
	}

	public void Init()
	{
		if (_criAtomSource == null)
		{
			_criAtomSource = GetComponentInChildren<CriAtomSource>();
			if (_criAtomSource == null)
			{
				GameObject gameObject = new GameObject("EffectAudio");
				_criAtomSource = gameObject.AddComponent<CriAtomSource>();
			}
		}
	}

	public void Play()
	{
		if (!(_criAtomSource == null) && !string.IsNullOrEmpty(m_cueSheet) && !string.IsNullOrEmpty(m_cueName))
		{
			AudioManager.Instance.AddCue("effect", m_cueSheet, m_useStream);
			_criAtomSource.cueSheet = m_cueSheet;
			_criAtomSource.cueName = m_cueName;
			_criAtomSource.Play();
		}
	}

	public void Stop()
	{
		if (!(_criAtomSource == null))
		{
			_criAtomSource.Stop();
		}
	}
}
