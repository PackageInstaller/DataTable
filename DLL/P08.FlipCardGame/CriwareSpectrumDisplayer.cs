using UnityEngine;

public class CriwareSpectrumDisplayer : MonoBehaviour
{
	[Header("Criware播放器Key")]
	public string key = "music";

	public SpectrumDisplayer spectrumDisplayer;

	private CriwareSpectrum spectrum;

	private void Start()
	{
		CriAtomSource player = AudioManager.Instance.GetPlayer(key);
		if (null != player)
		{
			spectrum = player.gameObject.GetComponent<CriwareSpectrum>();
		}
	}

	private void Update()
	{
		if (!(spectrum == null) && !(spectrumDisplayer == null))
		{
			spectrumDisplayer.inputData = spectrum.GetSpectrum();
		}
	}
}
