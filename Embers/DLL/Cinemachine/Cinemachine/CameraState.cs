using System;
using System.Collections.Generic;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

public struct CameraState
{
	public enum BlendHintValue
	{
		Nothing = 0,
		NoPosition = 1,
		NoOrientation = 2,
		NoTransform = 3,
		SphericalPositionBlend = 4,
		CylindricalPositionBlend = 8,
		RadialAimBlend = 16,
		IgnoreLookAtTarget = 32,
		NoLens = 64
	}

	public struct CustomBlendable(UnityEngine.Object custom, float weight)
	{
		public UnityEngine.Object m_Custom = custom;

		public float m_Weight = weight;
	}

	public LensSettings Lens;

	public Vector3 ReferenceUp;

	public Vector3 ReferenceLookAt;

	public static Vector3 kNoPoint = new Vector3(float.NaN, float.NaN, float.NaN);

	public Vector3 RawPosition;

	public Quaternion RawOrientation;

	public Vector3 PositionDampingBypass;

	public float ShotQuality;

	public Vector3 PositionCorrection;

	public Quaternion OrientationCorrection;

	public BlendHintValue BlendHint;

	private CustomBlendable mCustom0;

	private CustomBlendable mCustom1;

	private CustomBlendable mCustom2;

	private CustomBlendable mCustom3;

	private List<CustomBlendable> m_CustomOverflow;

	public bool HasLookAt => ReferenceLookAt == ReferenceLookAt;

	public Vector3 CorrectedPosition => RawPosition + PositionCorrection;

	public Quaternion CorrectedOrientation => RawOrientation * OrientationCorrection;

	public Vector3 FinalPosition => RawPosition + PositionCorrection;

	public Quaternion FinalOrientation
	{
		get
		{
			if (Mathf.Abs(Lens.Dutch) > 0.0001f)
			{
				return CorrectedOrientation * Quaternion.AngleAxis(Lens.Dutch, Vector3.forward);
			}
			return CorrectedOrientation;
		}
	}

	public static CameraState Default => new CameraState
	{
		Lens = LensSettings.Default,
		ReferenceUp = Vector3.up,
		ReferenceLookAt = kNoPoint,
		RawPosition = Vector3.zero,
		RawOrientation = Quaternion.identity,
		ShotQuality = 1f,
		PositionCorrection = Vector3.zero,
		OrientationCorrection = Quaternion.identity,
		PositionDampingBypass = Vector3.zero,
		BlendHint = BlendHintValue.Nothing
	};

	public int NumCustomBlendables { get; private set; }

	public CustomBlendable GetCustomBlendable(int index)
	{
		switch (index)
		{
		case 0:
			return mCustom0;
		case 1:
			return mCustom1;
		case 2:
			return mCustom2;
		case 3:
			return mCustom3;
		default:
			index -= 4;
			if (m_CustomOverflow != null && index < m_CustomOverflow.Count)
			{
				return m_CustomOverflow[index];
			}
			return new CustomBlendable(null, 0f);
		}
	}

	private int FindCustomBlendable(UnityEngine.Object custom)
	{
		if (mCustom0.m_Custom == custom)
		{
			return 0;
		}
		if (mCustom1.m_Custom == custom)
		{
			return 1;
		}
		if (mCustom2.m_Custom == custom)
		{
			return 2;
		}
		if (mCustom3.m_Custom == custom)
		{
			return 3;
		}
		if (m_CustomOverflow != null)
		{
			for (int i = 0; i < m_CustomOverflow.Count; i++)
			{
				if (m_CustomOverflow[i].m_Custom == custom)
				{
					return i + 4;
				}
			}
		}
		return -1;
	}

	public void AddCustomBlendable(CustomBlendable b)
	{
		int num = FindCustomBlendable(b.m_Custom);
		if (num >= 0)
		{
			b.m_Weight += GetCustomBlendable(num).m_Weight;
		}
		else
		{
			num = NumCustomBlendables++;
		}
		switch (num)
		{
		case 0:
			mCustom0 = b;
			return;
		case 1:
			mCustom1 = b;
			return;
		case 2:
			mCustom2 = b;
			return;
		case 3:
			mCustom3 = b;
			return;
		}
		num -= 4;
		if (m_CustomOverflow == null)
		{
			m_CustomOverflow = new List<CustomBlendable>();
		}
		if (num < m_CustomOverflow.Count)
		{
			m_CustomOverflow[num] = b;
		}
		else
		{
			m_CustomOverflow.Add(b);
		}
	}

	public static CameraState Lerp(CameraState stateA, CameraState stateB, float t)
	{
		t = Mathf.Clamp01(t);
		float t2 = t;
		CameraState result = default(CameraState);
		if ((stateA.BlendHint & stateB.BlendHint & BlendHintValue.NoPosition) != BlendHintValue.Nothing)
		{
			result.BlendHint |= BlendHintValue.NoPosition;
		}
		if ((stateA.BlendHint & stateB.BlendHint & BlendHintValue.NoOrientation) != BlendHintValue.Nothing)
		{
			result.BlendHint |= BlendHintValue.NoOrientation;
		}
		if ((stateA.BlendHint & stateB.BlendHint & BlendHintValue.NoLens) != BlendHintValue.Nothing)
		{
			result.BlendHint |= BlendHintValue.NoLens;
		}
		if (((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.SphericalPositionBlend) != BlendHintValue.Nothing)
		{
			result.BlendHint |= BlendHintValue.SphericalPositionBlend;
		}
		if (((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.CylindricalPositionBlend) != BlendHintValue.Nothing)
		{
			result.BlendHint |= BlendHintValue.CylindricalPositionBlend;
		}
		if (((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.NoLens) == 0)
		{
			result.Lens = LensSettings.Lerp(stateA.Lens, stateB.Lens, t);
		}
		else if ((stateA.BlendHint & stateB.BlendHint & BlendHintValue.NoLens) == 0)
		{
			if ((stateA.BlendHint & BlendHintValue.NoLens) != BlendHintValue.Nothing)
			{
				result.Lens = stateB.Lens;
			}
			else
			{
				result.Lens = stateA.Lens;
			}
		}
		result.ReferenceUp = Vector3.Slerp(stateA.ReferenceUp, stateB.ReferenceUp, t);
		result.ShotQuality = Mathf.Lerp(stateA.ShotQuality, stateB.ShotQuality, t);
		result.PositionCorrection = ApplyPosBlendHint(stateA.PositionCorrection, stateA.BlendHint, stateB.PositionCorrection, stateB.BlendHint, result.PositionCorrection, Vector3.Lerp(stateA.PositionCorrection, stateB.PositionCorrection, t));
		result.OrientationCorrection = ApplyRotBlendHint(stateA.OrientationCorrection, stateA.BlendHint, stateB.OrientationCorrection, stateB.BlendHint, result.OrientationCorrection, Quaternion.Slerp(stateA.OrientationCorrection, stateB.OrientationCorrection, t));
		if (!stateA.HasLookAt || !stateB.HasLookAt)
		{
			result.ReferenceLookAt = kNoPoint;
		}
		else
		{
			float fieldOfView = stateA.Lens.FieldOfView;
			float fieldOfView2 = stateB.Lens.FieldOfView;
			if (((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.NoLens) == 0 && !result.Lens.Orthographic && !Mathf.Approximately(fieldOfView, fieldOfView2))
			{
				LensSettings lens = result.Lens;
				lens.FieldOfView = InterpolateFOV(fieldOfView, fieldOfView2, Mathf.Max((stateA.ReferenceLookAt - stateA.CorrectedPosition).magnitude, stateA.Lens.NearClipPlane), Mathf.Max((stateB.ReferenceLookAt - stateB.CorrectedPosition).magnitude, stateB.Lens.NearClipPlane), t);
				result.Lens = lens;
				t2 = Mathf.Abs((lens.FieldOfView - fieldOfView) / (fieldOfView2 - fieldOfView));
			}
			result.ReferenceLookAt = Vector3.Lerp(stateA.ReferenceLookAt, stateB.ReferenceLookAt, t2);
		}
		result.RawPosition = ApplyPosBlendHint(stateA.RawPosition, stateA.BlendHint, stateB.RawPosition, stateB.BlendHint, result.RawPosition, result.InterpolatePosition(stateA.RawPosition, stateA.ReferenceLookAt, stateB.RawPosition, stateB.ReferenceLookAt, t));
		if (result.HasLookAt && ((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.RadialAimBlend) != BlendHintValue.Nothing)
		{
			result.ReferenceLookAt = result.RawPosition + Vector3.Slerp(stateA.ReferenceLookAt - result.RawPosition, stateB.ReferenceLookAt - result.RawPosition, t2);
		}
		Quaternion blended = result.RawOrientation;
		if (((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.NoOrientation) == 0)
		{
			Vector3 vector = Vector3.zero;
			if (result.HasLookAt && Quaternion.Angle(stateA.RawOrientation, stateB.RawOrientation) > 0.0001f)
			{
				vector = result.ReferenceLookAt - result.CorrectedPosition;
			}
			if (vector.AlmostZero() || ((stateA.BlendHint | stateB.BlendHint) & BlendHintValue.IgnoreLookAtTarget) != BlendHintValue.Nothing)
			{
				blended = Quaternion.Slerp(stateA.RawOrientation, stateB.RawOrientation, t);
			}
			else
			{
				Vector3 vector2 = result.ReferenceUp;
				vector.Normalize();
				if (Vector3.Cross(vector, vector2).AlmostZero())
				{
					blended = Quaternion.Slerp(stateA.RawOrientation, stateB.RawOrientation, t);
					vector2 = blended * Vector3.up;
				}
				blended = Quaternion.LookRotation(vector, vector2);
				Vector2 a = -stateA.RawOrientation.GetCameraRotationToTarget(stateA.ReferenceLookAt - stateA.CorrectedPosition, vector2);
				Vector2 b = -stateB.RawOrientation.GetCameraRotationToTarget(stateB.ReferenceLookAt - stateB.CorrectedPosition, vector2);
				blended = blended.ApplyCameraRotation(Vector2.Lerp(a, b, t2), vector2);
			}
		}
		result.RawOrientation = ApplyRotBlendHint(stateA.RawOrientation, stateA.BlendHint, stateB.RawOrientation, stateB.BlendHint, result.RawOrientation, blended);
		for (int i = 0; i < stateA.NumCustomBlendables; i++)
		{
			CustomBlendable customBlendable = stateA.GetCustomBlendable(i);
			customBlendable.m_Weight *= 1f - t;
			if (customBlendable.m_Weight > 0f)
			{
				result.AddCustomBlendable(customBlendable);
			}
		}
		for (int j = 0; j < stateB.NumCustomBlendables; j++)
		{
			CustomBlendable customBlendable2 = stateB.GetCustomBlendable(j);
			customBlendable2.m_Weight *= t;
			if (customBlendable2.m_Weight > 0f)
			{
				result.AddCustomBlendable(customBlendable2);
			}
		}
		return result;
	}

	private static float InterpolateFOV(float fovA, float fovB, float dA, float dB, float t)
	{
		float a = dA * 2f * Mathf.Tan(fovA * (MathF.PI / 180f) / 2f);
		float b = dB * 2f * Mathf.Tan(fovB * (MathF.PI / 180f) / 2f);
		float num = Mathf.Lerp(a, b, t);
		float value = 179f;
		float num2 = Mathf.Lerp(dA, dB, t);
		if (num2 > 0.0001f)
		{
			value = 2f * Mathf.Atan(num / (2f * num2)) * 57.29578f;
		}
		return Mathf.Clamp(value, Mathf.Min(fovA, fovB), Mathf.Max(fovA, fovB));
	}

	private static Vector3 ApplyPosBlendHint(Vector3 posA, BlendHintValue hintA, Vector3 posB, BlendHintValue hintB, Vector3 original, Vector3 blended)
	{
		if (((hintA | hintB) & BlendHintValue.NoPosition) == 0)
		{
			return blended;
		}
		if ((hintA & hintB & BlendHintValue.NoPosition) != BlendHintValue.Nothing)
		{
			return original;
		}
		if ((hintA & BlendHintValue.NoPosition) != BlendHintValue.Nothing)
		{
			return posB;
		}
		return posA;
	}

	private static Quaternion ApplyRotBlendHint(Quaternion rotA, BlendHintValue hintA, Quaternion rotB, BlendHintValue hintB, Quaternion original, Quaternion blended)
	{
		if (((hintA | hintB) & BlendHintValue.NoOrientation) == 0)
		{
			return blended;
		}
		if ((hintA & hintB & BlendHintValue.NoOrientation) != BlendHintValue.Nothing)
		{
			return original;
		}
		if ((hintA & BlendHintValue.NoOrientation) != BlendHintValue.Nothing)
		{
			return rotB;
		}
		return rotA;
	}

	private Vector3 InterpolatePosition(Vector3 posA, Vector3 pivotA, Vector3 posB, Vector3 pivotB, float t)
	{
		if (pivotA == pivotA && pivotB == pivotB)
		{
			if ((BlendHint & BlendHintValue.CylindricalPositionBlend) != BlendHintValue.Nothing)
			{
				Vector3 vector = Vector3.ProjectOnPlane(posA - pivotA, ReferenceUp);
				Vector3 vector2 = Vector3.ProjectOnPlane(posB - pivotB, ReferenceUp);
				Vector3 vector3 = Vector3.Slerp(vector, vector2, t);
				posA = posA - vector + vector3;
				posB = posB - vector2 + vector3;
			}
			else if ((BlendHint & BlendHintValue.SphericalPositionBlend) != BlendHintValue.Nothing)
			{
				Vector3 vector4 = Vector3.Slerp(posA - pivotA, posB - pivotB, t);
				posA = pivotA + vector4;
				posB = pivotB + vector4;
			}
		}
		return Vector3.Lerp(posA, posB, t);
	}
}
