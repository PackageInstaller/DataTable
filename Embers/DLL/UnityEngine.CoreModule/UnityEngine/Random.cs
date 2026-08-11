using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Random/Random.bindings.h")]
public static class Random
{
	[Serializable]
	public struct State
	{
		[SerializeField]
		private int s0;

		[SerializeField]
		private int s1;

		[SerializeField]
		private int s2;

		[SerializeField]
		private int s3;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static State state
	{
		get
		{
			get_state_Injected(out var ret);
			return ret;
		}
		set
		{
			set_state_Injected(ref value);
		}
	}

	public static extern float value
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction]
		get;
	}

	public static Vector3 insideUnitSphere
	{
		[FreeFunction]
		get
		{
			get_insideUnitSphere_Injected(out var ret);
			return ret;
		}
	}

	public static Vector2 insideUnitCircle
	{
		get
		{
			GetRandomUnitCircle(out var output);
			return output;
		}
	}

	public static Vector3 onUnitSphere
	{
		[FreeFunction]
		get
		{
			get_onUnitSphere_Injected(out var ret);
			return ret;
		}
	}

	public static Quaternion rotation
	{
		[FreeFunction]
		get
		{
			get_rotation_Injected(out var ret);
			return ret;
		}
	}

	public static Quaternion rotationUniform
	{
		[FreeFunction]
		get
		{
			get_rotationUniform_Injected(out var ret);
			return ret;
		}
	}

	[Obsolete("Deprecated. Use InitState() function or Random.state property instead.")]
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern int seed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static Color ColorHSV()
	{
		return ColorHSV(0f, 1f, 0f, 1f, 0f, 1f, 1f, 1f);
	}

	public static Color ColorHSV(float hueMin, float hueMax)
	{
		return ColorHSV(hueMin, hueMax, 0f, 1f, 0f, 1f, 1f, 1f);
	}

	public static Color ColorHSV(float hueMin, float hueMax, float saturationMin, float saturationMax)
	{
		return ColorHSV(hueMin, hueMax, saturationMin, saturationMax, 0f, 1f, 1f, 1f);
	}

	public static Color ColorHSV(float hueMin, float hueMax, float saturationMin, float saturationMax, float valueMin, float valueMax)
	{
		return ColorHSV(hueMin, hueMax, saturationMin, saturationMax, valueMin, valueMax, 1f, 1f);
	}

	public static Color ColorHSV(float hueMin, float hueMax, float saturationMin, float saturationMax, float valueMin, float valueMax, float alphaMin, float alphaMax)
	{
		float h = Mathf.Lerp(hueMin, hueMax, value);
		float s = Mathf.Lerp(saturationMin, saturationMax, value);
		float v = Mathf.Lerp(valueMin, valueMax, value);
		Color result = Color.HSVToRGB(h, s, v, hdr: true);
		result.a = Mathf.Lerp(alphaMin, alphaMax, value);
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("SetSeed")]
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern void InitState(int seed);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	public static extern float Range(float minInclusive, float maxInclusive);

	public static int Range(int minInclusive, int maxExclusive)
	{
		return RandomRangeInt(minInclusive, maxExclusive);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	private static extern int RandomRangeInt(int minInclusive, int maxExclusive);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	private static extern void GetRandomUnitCircle(out Vector2 output);

	[Obsolete("Use Random.Range instead")]
	public static float RandomRange(float min, float max)
	{
		return Range(min, max);
	}

	[Obsolete("Use Random.Range instead")]
	public static int RandomRange(int min, int max)
	{
		return Range(min, max);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_state_Injected(out State ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_state_Injected(ref State value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_insideUnitSphere_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_onUnitSphere_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_rotation_Injected(out Quaternion ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_rotationUniform_Injected(out Quaternion ret);
}
