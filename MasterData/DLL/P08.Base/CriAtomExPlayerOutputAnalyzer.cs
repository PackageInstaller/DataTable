using System;

[Obsolete("Use CriWare.CriAtomExOutputAnalyzer")]
public class CriAtomExPlayerOutputAnalyzer : CriAtomExOutputAnalyzer
{
	public enum Type
	{
		LevelMeter,
		SpectrumAnalyzer,
		PcmCapture
	}

	public new struct Config(int num_spectrum_analyzer_bands = 8, int num_stored_output_data = 4096)
	{
		public int num_spectrum_analyzer_bands = num_spectrum_analyzer_bands;

		public int num_stored_output_data = num_stored_output_data;
	}

	public CriAtomExPlayerOutputAnalyzer(Type[] types, Config[] configs = null)
	{
		CriAtomExOutputAnalyzer.Config config = default(CriAtomExOutputAnalyzer.Config);
		for (int i = 0; i < types.Length; i++)
		{
			switch (types[i])
			{
			case Type.LevelMeter:
				config.enableLevelmeter = true;
				break;
			case Type.SpectrumAnalyzer:
				config.enableSpectrumAnalyzer = true;
				if (configs != null && configs.Length > i)
				{
					config.numSpectrumAnalyzerBands = configs[i].num_spectrum_analyzer_bands;
				}
				else
				{
					config.numSpectrumAnalyzerBands = 8;
				}
				break;
			case Type.PcmCapture:
				config.enablePcmCapture = true;
				if (configs != null && configs.Length > i)
				{
					config.numCapturedPcmSamples = configs[i].num_stored_output_data;
				}
				else
				{
					config.numCapturedPcmSamples = 4096;
				}
				break;
			}
		}
		InitializeWithConfig(config);
	}
}
