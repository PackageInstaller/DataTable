namespace UnityEngine.Rendering;

public class HableCurve
{
	public class Segment
	{
		public float offsetX;

		public float offsetY;

		public float scaleX;

		public float scaleY;

		public float lnA;

		public float B;

		public float Eval(float x)
		{
			float num = (x - offsetX) * scaleX;
			float num2 = 0f;
			if (num > 0f)
			{
				num2 = Mathf.Exp(lnA + B * Mathf.Log(num));
			}
			return num2 * scaleY + offsetY;
		}
	}

	private struct DirectParams
	{
		internal float x0;

		internal float y0;

		internal float x1;

		internal float y1;

		internal float W;

		internal float overshootX;

		internal float overshootY;

		internal float gamma;
	}

	public class Uniforms
	{
		private HableCurve parent;

		public Vector4 curve => new Vector4(parent.inverseWhitePoint, parent.x0, parent.x1, 0f);

		public Vector4 toeSegmentA => new Vector4(parent.segments[0].offsetX, parent.segments[0].offsetY, parent.segments[0].scaleX, parent.segments[0].scaleY);

		public Vector4 toeSegmentB => new Vector4(parent.segments[0].lnA, parent.segments[0].B, 0f, 0f);

		public Vector4 midSegmentA => new Vector4(parent.segments[1].offsetX, parent.segments[1].offsetY, parent.segments[1].scaleX, parent.segments[1].scaleY);

		public Vector4 midSegmentB => new Vector4(parent.segments[1].lnA, parent.segments[1].B, 0f, 0f);

		public Vector4 shoSegmentA => new Vector4(parent.segments[2].offsetX, parent.segments[2].offsetY, parent.segments[2].scaleX, parent.segments[2].scaleY);

		public Vector4 shoSegmentB => new Vector4(parent.segments[2].lnA, parent.segments[2].B, 0f, 0f);

		internal Uniforms(HableCurve parent)
		{
			this.parent = parent;
		}
	}

	public readonly Segment[] segments = new Segment[3];

	public readonly Uniforms uniforms;

	public float whitePoint { get; private set; }

	public float inverseWhitePoint { get; private set; }

	public float x0 { get; private set; }

	public float x1 { get; private set; }

	public HableCurve()
	{
		for (int i = 0; i < 3; i++)
		{
			segments[i] = new Segment();
		}
		uniforms = new Uniforms(this);
	}

	public float Eval(float x)
	{
		float num = x * inverseWhitePoint;
		int num2 = ((!(num < x0)) ? ((num < x1) ? 1 : 2) : 0);
		return segments[num2].Eval(num);
	}

	public void Init(float toeStrength, float toeLength, float shoulderStrength, float shoulderLength, float shoulderAngle, float gamma)
	{
		DirectParams srcParams = default(DirectParams);
		toeLength = Mathf.Pow(Mathf.Clamp01(toeLength), 2.2f);
		toeStrength = Mathf.Clamp01(toeStrength);
		shoulderAngle = Mathf.Clamp01(shoulderAngle);
		shoulderStrength = Mathf.Clamp(shoulderStrength, 1E-05f, 0.99999f);
		shoulderLength = Mathf.Max(0f, shoulderLength);
		gamma = Mathf.Max(1E-05f, gamma);
		float num = toeLength * 0.5f;
		float num2 = (1f - toeStrength) * num;
		float num3 = 1f - num2;
		float num4 = num + num3;
		float num5 = (1f - shoulderStrength) * num3;
		float num6 = num + num5;
		float y = num2 + num5;
		float num7 = Mathf.Pow(2f, shoulderLength) - 1f;
		float w = num4 + num7;
		srcParams.x0 = num;
		srcParams.y0 = num2;
		srcParams.x1 = num6;
		srcParams.y1 = y;
		srcParams.W = w;
		srcParams.gamma = gamma;
		srcParams.overshootX = srcParams.W * 2f * shoulderAngle * shoulderLength;
		srcParams.overshootY = 0.5f * shoulderAngle * shoulderLength;
		InitSegments(srcParams);
	}

	private void InitSegments(DirectParams srcParams)
	{
		DirectParams directParams = srcParams;
		whitePoint = srcParams.W;
		inverseWhitePoint = 1f / srcParams.W;
		directParams.W = 1f;
		directParams.x0 /= srcParams.W;
		directParams.x1 /= srcParams.W;
		directParams.overshootX = srcParams.overshootX / srcParams.W;
		float num = 0f;
		float num2 = 0f;
		AsSlopeIntercept(out var m, out var b, directParams.x0, directParams.x1, directParams.y0, directParams.y1);
		float gamma = srcParams.gamma;
		Segment obj = segments[1];
		obj.offsetX = 0f - b / m;
		obj.offsetY = 0f;
		obj.scaleX = 1f;
		obj.scaleY = 1f;
		obj.lnA = gamma * Mathf.Log(m);
		obj.B = gamma;
		num = EvalDerivativeLinearGamma(m, b, gamma, directParams.x0);
		num2 = EvalDerivativeLinearGamma(m, b, gamma, directParams.x1);
		directParams.y0 = Mathf.Max(1E-05f, Mathf.Pow(directParams.y0, directParams.gamma));
		directParams.y1 = Mathf.Max(1E-05f, Mathf.Pow(directParams.y1, directParams.gamma));
		directParams.overshootY = Mathf.Pow(1f + directParams.overshootY, directParams.gamma) - 1f;
		x0 = directParams.x0;
		x1 = directParams.x1;
		Segment obj2 = segments[0];
		obj2.offsetX = 0f;
		obj2.offsetY = 0f;
		obj2.scaleX = 1f;
		obj2.scaleY = 1f;
		SolveAB(out var lnA, out var B, directParams.x0, directParams.y0, num);
		obj2.lnA = lnA;
		obj2.B = B;
		Segment obj3 = segments[2];
		float num3 = 1f + directParams.overshootX - directParams.x1;
		float y = 1f + directParams.overshootY - directParams.y1;
		SolveAB(out var lnA2, out var B2, num3, y, num2);
		obj3.offsetX = 1f + directParams.overshootX;
		obj3.offsetY = 1f + directParams.overshootY;
		obj3.scaleX = -1f;
		obj3.scaleY = -1f;
		obj3.lnA = lnA2;
		obj3.B = B2;
		float num4 = segments[2].Eval(1f);
		float num5 = 1f / num4;
		segments[0].offsetY *= num5;
		segments[0].scaleY *= num5;
		segments[1].offsetY *= num5;
		segments[1].scaleY *= num5;
		segments[2].offsetY *= num5;
		segments[2].scaleY *= num5;
	}

	private void SolveAB(out float lnA, out float B, float x0, float y0, float m)
	{
		B = m * x0 / y0;
		lnA = Mathf.Log(y0) - B * Mathf.Log(x0);
	}

	private void AsSlopeIntercept(out float m, out float b, float x0, float x1, float y0, float y1)
	{
		float num = y1 - y0;
		float num2 = x1 - x0;
		if (num2 == 0f)
		{
			m = 1f;
		}
		else
		{
			m = num / num2;
		}
		b = y0 - x0 * m;
	}

	private float EvalDerivativeLinearGamma(float m, float b, float g, float x)
	{
		return g * m * Mathf.Pow(m * x + b, g - 1f);
	}
}
