using System;
using UnityEngine;

namespace Cinemachine;

[Serializable]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public struct CinemachineBlendDefinition
{
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum Style
	{
		Cut,
		EaseInOut,
		EaseIn,
		EaseOut,
		HardIn,
		HardOut,
		Linear,
		Custom
	}

	[Tooltip("Shape of the blend curve")]
	public Style m_Style;

	[Tooltip("Duration of the blend, in seconds")]
	public float m_Time;

	public AnimationCurve m_CustomCurve;

	private static AnimationCurve[] sStandardCurves;

	public float BlendTime
	{
		get
		{
			if (m_Style != Style.Cut)
			{
				return m_Time;
			}
			return 0f;
		}
	}

	public AnimationCurve BlendCurve
	{
		get
		{
			if (m_Style == Style.Custom)
			{
				if (m_CustomCurve == null)
				{
					m_CustomCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);
				}
				return m_CustomCurve;
			}
			if (sStandardCurves == null)
			{
				CreateStandardCurves();
			}
			return sStandardCurves[(int)m_Style];
		}
	}

	public CinemachineBlendDefinition(Style style, float time)
	{
		m_Style = style;
		m_Time = time;
		m_CustomCurve = null;
	}

	private void CreateStandardCurves()
	{
		sStandardCurves = new AnimationCurve[7];
		sStandardCurves[0] = null;
		sStandardCurves[1] = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);
		sStandardCurves[2] = AnimationCurve.Linear(0f, 0f, 1f, 1f);
		Keyframe[] keys = sStandardCurves[2].keys;
		keys[0].outTangent = 1.4f;
		keys[1].inTangent = 0f;
		sStandardCurves[2].keys = keys;
		sStandardCurves[3] = AnimationCurve.Linear(0f, 0f, 1f, 1f);
		keys = sStandardCurves[3].keys;
		keys[0].outTangent = 0f;
		keys[1].inTangent = 1.4f;
		sStandardCurves[3].keys = keys;
		sStandardCurves[4] = AnimationCurve.Linear(0f, 0f, 1f, 1f);
		keys = sStandardCurves[4].keys;
		keys[0].outTangent = 0f;
		keys[1].inTangent = 3f;
		sStandardCurves[4].keys = keys;
		sStandardCurves[5] = AnimationCurve.Linear(0f, 0f, 1f, 1f);
		keys = sStandardCurves[5].keys;
		keys[0].outTangent = 3f;
		keys[1].inTangent = 0f;
		sStandardCurves[5].keys = keys;
		sStandardCurves[6] = AnimationCurve.Linear(0f, 0f, 1f, 1f);
	}
}
