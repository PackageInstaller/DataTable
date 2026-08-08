using System;

[Obsolete("Use CriLipsDeformerForAtomSource Component")]
public class CriLipsShapeForAtomSource : CriLipsShape
{
	public CriAtomSourceBase source;

	public float silenceThreshold = -40f;

	public int samplingRate = 48000;

	public CriLipsAtomAnalyzer atomAnalyzer { get; protected set; }

	public bool AttachToAtomSource(CriAtomSourceBase source)
	{
		this.source = source;
		if (source != null)
		{
			return atomAnalyzer.AttachToAtomExPlayer(source.player);
		}
		return atomAnalyzer.DetachFromAtomExPlayer();
	}

	private void Start()
	{
		CriLipsAtomPlugin.InitializeLibrary();
		atomAnalyzer = new CriLipsAtomAnalyzer();
		analyzeModule = atomAnalyzer;
		atomAnalyzer.SetSilenceThreshold(silenceThreshold);
		atomAnalyzer.SetSamplingRate(samplingRate);
		atomAnalyzer.mouth.GetInfoAtSilence(out var silenceInfo);
		base.StartForMorphing(silenceInfo);
		if (source != null)
		{
			atomAnalyzer.AttachToAtomExPlayer(source.player);
		}
	}

	public override void CriInternalUpdate()
	{
		if (!(source == null))
		{
			atomAnalyzer.GetInfo(out info);
			atomAnalyzer.GetMorphTargetBlendAmountAsJapanese(out blendAmount);
			base.UpdateLipsParameter();
		}
	}

	private void OnDestroy()
	{
		if (source != null && source.player != null)
		{
			source.player.StopWithoutReleaseTime();
			atomAnalyzer.DetachFromAtomExPlayer();
		}
		atomAnalyzer.Dispose();
		CriLipsAtomPlugin.FinalizeLibrary();
	}
}
