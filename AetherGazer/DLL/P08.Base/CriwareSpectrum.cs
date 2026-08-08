using UnityEngine;

public class CriwareSpectrum : MonoBehaviour
{
	public CriAtomSource atomSrc;

	private const int originalBandNum = 512;

	private CriAtomExOutputAnalyzer anlyzr;

	private float[] spctLv = new float[512];

	public void initialize(CriAtomSource _atomSrc)
	{
		atomSrc = _atomSrc;
		if (!(null == atomSrc))
		{
			anlyzr = new CriAtomExOutputAnalyzer(new CriAtomExOutputAnalyzer.Config
			{
				enableSpectrumAnalyzer = true,
				numSpectrumAnalyzerBands = 512
			});
			atomSrc.AttachToAnalyzer(anlyzr);
		}
	}

	public float[] GetSpectrum()
	{
		if (anlyzr == null)
		{
			return new float[0];
		}
		anlyzr.GetSpectrumLevels(ref spctLv);
		return spctLv;
	}

	private void OnDestroy()
	{
		atomSrc.DetachFromAnalyzer(anlyzr);
		anlyzr.Dispose();
	}
}
