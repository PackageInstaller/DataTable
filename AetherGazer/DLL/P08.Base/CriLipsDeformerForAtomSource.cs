using UnityEngine;

[AddComponentMenu("CRIWARE/CriLipsDeformerForAtomSource")]
public class CriLipsDeformerForAtomSource : CriLipsDeformer
{
	[SerializeField]
	internal CriAtomSourceBase source;

	public float silenceThreshold = -40f;

	public int samplingRate = 48000;

	public CriLipsAtomAnalyzer atomAnalyzer { get; protected set; }

	public bool AttachToAtomSource(CriAtomSourceBase source)
	{
		this.source = source;
		if (this.source == null)
		{
			return atomAnalyzer.DetachFromAtomExPlayer();
		}
		if (CriLipsAtomPlugin.IsAnalyzerAttachedToPlayer(atomAnalyzer) && !atomAnalyzer.DetachFromAtomExPlayer())
		{
			return false;
		}
		return atomAnalyzer.AttachToAtomExPlayer(source.player);
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
		if (!(source == null) && atomAnalyzer != null && CriLipsAtomPlugin.IsAnalyzerAttachedToPlayer(atomAnalyzer))
		{
			atomAnalyzer.GetInfo(out info);
			atomAnalyzer.GetMorphTargetBlendAmountAsJapanese(out blendAmount);
			base.CriInternalUpdate();
		}
	}

	private void OnDestroy()
	{
		if (atomAnalyzer != null && atomAnalyzer.isAvailable)
		{
			if (CriLipsAtomPlugin.IsAnalyzerAttachedToPlayer(atomAnalyzer))
			{
				atomAnalyzer.DetachFromAtomExPlayer();
			}
			atomAnalyzer.Dispose();
			atomAnalyzer = null;
		}
		CriLipsAtomPlugin.FinalizeLibrary();
	}
}
