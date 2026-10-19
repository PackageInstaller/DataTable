using System;

namespace ACT.Config;

[Serializable]
public class CharacterConstellationRgb
{
	public readonly int id;

	public readonly float[] RgbFirstFloat = new float[0];

	public readonly float[] RgbSecondFloat = new float[0];

	public readonly float[] RgbThirdFloat = new float[0];

	public readonly float[] RgbFirstSecondFloat = new float[0];

	public readonly float[] RgbFirstThirdFloat = new float[0];

	public readonly float[] RgbSecondThirdFloat = new float[0];

	public CharacterConstellationRgb(int id, float[] RgbFirstFloat, float[] RgbSecondFloat, float[] RgbThirdFloat, float[] RgbFirstSecondFloat, float[] RgbFirstThirdFloat, float[] RgbSecondThirdFloat)
	{
		this.id = id;
		this.RgbFirstFloat = RgbFirstFloat;
		this.RgbSecondFloat = RgbSecondFloat;
		this.RgbThirdFloat = RgbThirdFloat;
		this.RgbFirstSecondFloat = RgbFirstSecondFloat;
		this.RgbFirstThirdFloat = RgbFirstThirdFloat;
		this.RgbSecondThirdFloat = RgbSecondThirdFloat;
	}
}
