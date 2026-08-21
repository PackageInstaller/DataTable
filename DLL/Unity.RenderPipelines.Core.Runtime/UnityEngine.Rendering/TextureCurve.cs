using System;
using System.Runtime.CompilerServices;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

[Serializable]
public class TextureCurve : IDisposable
{
	private const int k_Precision = 128;

	private const float k_Step = 1f / 128f;

	[SerializeField]
	private bool m_Loop;

	[SerializeField]
	private float m_ZeroValue;

	[SerializeField]
	private float m_Range;

	[SerializeField]
	private AnimationCurve m_Curve;

	private AnimationCurve m_LoopingCurve;

	private Texture2D m_Texture;

	private bool m_IsCurveDirty;

	private bool m_IsTextureDirty;

	[field: SerializeField]
	public int length { get; private set; }

	public Keyframe this[int index] => m_Curve[index];

	public TextureCurve(AnimationCurve baseCurve, float zeroValue, bool loop, in Vector2 bounds)
		: this(baseCurve.keys, zeroValue, loop, in bounds)
	{
	}

	public TextureCurve(Keyframe[] keys, float zeroValue, bool loop, in Vector2 bounds)
	{
		m_Curve = new AnimationCurve(keys);
		m_ZeroValue = zeroValue;
		m_Loop = loop;
		m_Range = bounds.magnitude;
		length = keys.Length;
		SetDirty();
	}

	~TextureCurve()
	{
	}

	[Obsolete("Please use Release() instead.")]
	public void Dispose()
	{
	}

	public void Release()
	{
		CoreUtils.Destroy(m_Texture);
		m_Texture = null;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void SetDirty()
	{
		m_IsCurveDirty = true;
		m_IsTextureDirty = true;
	}

	private static GraphicsFormat GetTextureFormat()
	{
		if (SystemInfo.IsFormatSupported(GraphicsFormat.R16_SFloat, FormatUsage.SetPixels))
		{
			return GraphicsFormat.R16_SFloat;
		}
		if (SystemInfo.IsFormatSupported(GraphicsFormat.R8_UNorm, FormatUsage.SetPixels))
		{
			return GraphicsFormat.R8_UNorm;
		}
		return GraphicsFormat.R8G8B8A8_UNorm;
	}

	public Texture2D GetTexture()
	{
		if (m_Texture == null)
		{
			m_Texture = new Texture2D(128, 1, GetTextureFormat(), TextureCreationFlags.None);
			m_Texture.name = "CurveTexture";
			m_Texture.hideFlags = HideFlags.HideAndDontSave;
			m_Texture.filterMode = FilterMode.Bilinear;
			m_Texture.wrapMode = TextureWrapMode.Clamp;
			m_IsTextureDirty = true;
		}
		if (m_IsTextureDirty)
		{
			Color[] array = new Color[128];
			for (int i = 0; i < array.Length; i++)
			{
				array[i].r = Evaluate((float)i * (1f / 128f));
			}
			m_Texture.SetPixels(array);
			m_Texture.Apply(updateMipmaps: false, makeNoLongerReadable: false);
			m_IsTextureDirty = false;
		}
		return m_Texture;
	}

	public float Evaluate(float time)
	{
		if (m_IsCurveDirty)
		{
			length = m_Curve.length;
		}
		if (length == 0)
		{
			return m_ZeroValue;
		}
		if (!m_Loop || length == 1)
		{
			return m_Curve.Evaluate(time);
		}
		if (m_IsCurveDirty)
		{
			if (m_LoopingCurve == null)
			{
				m_LoopingCurve = new AnimationCurve();
			}
			Keyframe key = m_Curve[length - 1];
			key.time -= m_Range;
			Keyframe key2 = m_Curve[0];
			key2.time += m_Range;
			m_LoopingCurve.keys = m_Curve.keys;
			m_LoopingCurve.AddKey(key);
			m_LoopingCurve.AddKey(key2);
			m_IsCurveDirty = false;
		}
		return m_LoopingCurve.Evaluate(time);
	}

	[MethodImpl((MethodImplOptions)256)]
	public int AddKey(float time, float value)
	{
		int num = m_Curve.AddKey(time, value);
		if (num > -1)
		{
			SetDirty();
		}
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public int MoveKey(int index, in Keyframe key)
	{
		int result = m_Curve.MoveKey(index, key);
		SetDirty();
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void RemoveKey(int index)
	{
		m_Curve.RemoveKey(index);
		SetDirty();
	}

	[MethodImpl((MethodImplOptions)256)]
	public void SmoothTangents(int index, float weight)
	{
		m_Curve.SmoothTangents(index, weight);
		SetDirty();
	}
}
