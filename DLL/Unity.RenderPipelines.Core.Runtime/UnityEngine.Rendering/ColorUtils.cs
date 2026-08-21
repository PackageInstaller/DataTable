namespace UnityEngine.Rendering;

public static class ColorUtils
{
	public static float s_LightMeterCalibrationConstant = 12.5f;

	public static float s_LensAttenuation = 0.65f;

	public static float lensImperfectionExposureScale => 78f / (100f * s_LensAttenuation);

	public static float StandardIlluminantY(float x)
	{
		return 2.87f * x - 3f * x * x - 0.27509508f;
	}

	public static Vector3 CIExyToLMS(float x, float y)
	{
		float num = 1f;
		float num2 = num * x / y;
		float num3 = num * (1f - x - y) / y;
		float x2 = 0.7328f * num2 + 0.4296f * num - 0.1624f * num3;
		float y2 = -0.7036f * num2 + 1.6975f * num + 0.0061f * num3;
		float z = 0.003f * num2 + 0.0136f * num + 0.9834f * num3;
		return new Vector3(x2, y2, z);
	}

	public static Vector3 ColorBalanceToLMSCoeffs(float temperature, float tint)
	{
		float num = temperature / 65f;
		float num2 = tint / 65f;
		float x = 0.31271f - num * ((num < 0f) ? 0.1f : 0.05f);
		float y = StandardIlluminantY(x) + num2 * 0.05f;
		Vector3 vector = new Vector3(0.949237f, 1.03542f, 1.08728f);
		Vector3 vector2 = CIExyToLMS(x, y);
		return new Vector3(vector.x / vector2.x, vector.y / vector2.y, vector.z / vector2.z);
	}

	public static (Vector4, Vector4, Vector4) PrepareShadowsMidtonesHighlights(in Vector4 inShadows, in Vector4 inMidtones, in Vector4 inHighlights)
	{
		Vector4 item = inShadows;
		item.x = Mathf.GammaToLinearSpace(item.x);
		item.y = Mathf.GammaToLinearSpace(item.y);
		item.z = Mathf.GammaToLinearSpace(item.z);
		float num = item.w * ((Mathf.Sign(item.w) < 0f) ? 1f : 4f);
		item.x = Mathf.Max(item.x + num, 0f);
		item.y = Mathf.Max(item.y + num, 0f);
		item.z = Mathf.Max(item.z + num, 0f);
		item.w = 0f;
		Vector4 item2 = inMidtones;
		item2.x = Mathf.GammaToLinearSpace(item2.x);
		item2.y = Mathf.GammaToLinearSpace(item2.y);
		item2.z = Mathf.GammaToLinearSpace(item2.z);
		num = item2.w * ((Mathf.Sign(item2.w) < 0f) ? 1f : 4f);
		item2.x = Mathf.Max(item2.x + num, 0f);
		item2.y = Mathf.Max(item2.y + num, 0f);
		item2.z = Mathf.Max(item2.z + num, 0f);
		item2.w = 0f;
		Vector4 item3 = inHighlights;
		item3.x = Mathf.GammaToLinearSpace(item3.x);
		item3.y = Mathf.GammaToLinearSpace(item3.y);
		item3.z = Mathf.GammaToLinearSpace(item3.z);
		num = item3.w * ((Mathf.Sign(item3.w) < 0f) ? 1f : 4f);
		item3.x = Mathf.Max(item3.x + num, 0f);
		item3.y = Mathf.Max(item3.y + num, 0f);
		item3.z = Mathf.Max(item3.z + num, 0f);
		item3.w = 0f;
		return (item, item2, item3);
	}

	public static (Vector4, Vector4, Vector4) PrepareLiftGammaGain(in Vector4 inLift, in Vector4 inGamma, in Vector4 inGain)
	{
		Vector4 vector = inLift;
		vector.x = Mathf.GammaToLinearSpace(vector.x) * 0.15f;
		vector.y = Mathf.GammaToLinearSpace(vector.y) * 0.15f;
		vector.z = Mathf.GammaToLinearSpace(vector.z) * 0.15f;
		float num = Luminance((Color)vector);
		vector.x = vector.x - num + vector.w;
		vector.y = vector.y - num + vector.w;
		vector.z = vector.z - num + vector.w;
		vector.w = 0f;
		Vector4 vector2 = inGamma;
		vector2.x = Mathf.GammaToLinearSpace(vector2.x) * 0.8f;
		vector2.y = Mathf.GammaToLinearSpace(vector2.y) * 0.8f;
		vector2.z = Mathf.GammaToLinearSpace(vector2.z) * 0.8f;
		float num2 = Luminance((Color)vector2);
		vector2.w++;
		vector2.x = 1f / Mathf.Max(vector2.x - num2 + vector2.w, 0.001f);
		vector2.y = 1f / Mathf.Max(vector2.y - num2 + vector2.w, 0.001f);
		vector2.z = 1f / Mathf.Max(vector2.z - num2 + vector2.w, 0.001f);
		vector2.w = 0f;
		Vector4 vector3 = inGain;
		vector3.x = Mathf.GammaToLinearSpace(vector3.x) * 0.8f;
		vector3.y = Mathf.GammaToLinearSpace(vector3.y) * 0.8f;
		vector3.z = Mathf.GammaToLinearSpace(vector3.z) * 0.8f;
		float num3 = Luminance((Color)vector3);
		vector3.w++;
		vector3.x = vector3.x - num3 + vector3.w;
		vector3.y = vector3.y - num3 + vector3.w;
		vector3.z = vector3.z - num3 + vector3.w;
		vector3.w = 0f;
		return (vector, vector2, vector3);
	}

	public static (Vector4, Vector4) PrepareSplitToning(in Vector4 inShadows, in Vector4 inHighlights, float balance)
	{
		Vector4 item = inShadows;
		Vector4 item2 = inHighlights;
		item.w = balance / 100f;
		item2.w = 0f;
		return (item, item2);
	}

	public static float Luminance(in Color color)
	{
		return color.r * 0.2126729f + color.g * 0.7151522f + color.b * 0.072175f;
	}

	public static float ComputeEV100(float aperture, float shutterSpeed, float ISO)
	{
		return Mathf.Log(aperture * aperture / shutterSpeed * 100f / ISO, 2f);
	}

	public static float ConvertEV100ToExposure(float EV100)
	{
		float num = lensImperfectionExposureScale * Mathf.Pow(2f, EV100);
		return 1f / num;
	}

	public static float ConvertExposureToEV100(float exposure)
	{
		return Mathf.Log(1f / (lensImperfectionExposureScale * exposure), 2f);
	}

	public static float ComputeEV100FromAvgLuminance(float avgLuminance)
	{
		float num = s_LightMeterCalibrationConstant;
		return Mathf.Log(avgLuminance * 100f / num, 2f);
	}

	public static float ComputeISO(float aperture, float shutterSpeed, float targetEV100)
	{
		return aperture * aperture * 100f / (shutterSpeed * Mathf.Pow(2f, targetEV100));
	}

	public static uint ToHex(Color c)
	{
		return ((uint)(c.a * 255f) << 24) | ((uint)(c.r * 255f) << 16) | ((uint)(c.g * 255f) << 8) | (uint)(c.b * 255f);
	}

	public static Color ToRGBA(uint hex)
	{
		return new Color((float)((hex >> 16) & 0xFF) / 255f, (float)((hex >> 8) & 0xFF) / 255f, (float)(hex & 0xFF) / 255f, (float)((hex >> 24) & 0xFF) / 255f);
	}
}
