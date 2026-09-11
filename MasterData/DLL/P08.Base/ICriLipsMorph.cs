using System;

public interface ICriLipsMorph
{
	CriLipsMouth.Info SilenceInfo { set; }

	void Update(ICriLipsAnalyzeModule analyzeModule);

	[Obsolete("Consider using ICriLipsMorph.Update(ICriLipsAnalyzeModule) instead.")]
	void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount);

	void Reset();
}
