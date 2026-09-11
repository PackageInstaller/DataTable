public interface ICriLipsAnalyzeModule
{
	void GetInfo(out CriLipsMouth.Info info);

	void GetMorphTargetBlendAmountAsJapanese(out CriLipsMouth.MorphTargetBlendAmountAsJapanese morph);

	void GetOpenInfo(out CriLipsMouth.OpenInfo openInfo);

	float GetVolume();

	bool IsAtSilence();

	bool IsAtSilenceForMouthOpen();

	float GetSilenceThreshold();

	void GetInfoAtSilence(out CriLipsMouth.Info info);

	bool IsMorphTargetBlendAmountInterpolative();
}
