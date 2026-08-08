using UnityEngine;

public class LeanAudioOptions
{
	public enum LeanAudioWaveStyle
	{
		Sine,
		Square,
		Sawtooth,
		Noise
	}

	public LeanAudioWaveStyle waveStyle;

	public Vector3[] vibrato;

	public Vector3[] modulation;

	public int frequencyRate = 44100;

	public float waveNoiseScale = 1000f;

	public float waveNoiseInfluence = 1f;

	public bool useSetData = true;

	public LeanAudioStream stream;

	public LeanAudioOptions setFrequency(int frequencyRate)
	{
		this.frequencyRate = frequencyRate;
		return this;
	}

	public LeanAudioOptions setVibrato(Vector3[] vibrato)
	{
		this.vibrato = vibrato;
		return this;
	}

	public LeanAudioOptions setWaveSine()
	{
		waveStyle = LeanAudioWaveStyle.Sine;
		return this;
	}

	public LeanAudioOptions setWaveSquare()
	{
		waveStyle = LeanAudioWaveStyle.Square;
		return this;
	}

	public LeanAudioOptions setWaveSawtooth()
	{
		waveStyle = LeanAudioWaveStyle.Sawtooth;
		return this;
	}

	public LeanAudioOptions setWaveNoise()
	{
		waveStyle = LeanAudioWaveStyle.Noise;
		return this;
	}

	public LeanAudioOptions setWaveStyle(LeanAudioWaveStyle style)
	{
		waveStyle = style;
		return this;
	}

	public LeanAudioOptions setWaveNoiseScale(float waveScale)
	{
		waveNoiseScale = waveScale;
		return this;
	}

	public LeanAudioOptions setWaveNoiseInfluence(float influence)
	{
		waveNoiseInfluence = influence;
		return this;
	}
}
