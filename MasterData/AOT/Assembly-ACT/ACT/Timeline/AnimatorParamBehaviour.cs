using System;
using System.Collections.Generic;
using Bamboo.Collections;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class AnimatorParamBehaviour : PlayableBehaviour
{
	public List<TimelineAnimatorPara> configs;

	private Animator m_TrackBinding;

	private bool m_FirstPlay = true;

	private BArray<TimelineAnimatorPara> m_default;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		m_TrackBinding = playerData as Animator;
		if (!m_FirstPlay || !m_TrackBinding)
		{
			return;
		}
		m_FirstPlay = false;
		m_default = BArrayPool<TimelineAnimatorPara>.Default.Get();
		foreach (TimelineAnimatorPara config in configs)
		{
			switch (config.paramType)
			{
			case TimelineAnimatorPara.ParamType.Trigger:
				m_default.Add(config);
				m_TrackBinding.SetTrigger(config.paramName);
				break;
			case TimelineAnimatorPara.ParamType.Bool:
			{
				bool newValue = m_TrackBinding.GetBool(config.paramName);
				m_default.Add(new TimelineAnimatorPara
				{
					paramName = config.paramName,
					paramType = TimelineAnimatorPara.ParamType.Trigger,
					newValue = newValue
				});
				m_TrackBinding.SetBool(config.paramName, config.newValue);
				break;
			}
			case TimelineAnimatorPara.ParamType.CrossFade:
			{
				m_default.Add(config);
				int num = Animator.StringToHash(config.paramName);
				if (!m_TrackBinding.HasState(0, num))
				{
					return;
				}
				if (config.crossFadetime > 0f)
				{
					m_TrackBinding.CrossFadeInFixedTime(num, config.crossFadetime, 0);
				}
				else
				{
					m_TrackBinding.Play(num, 0);
				}
				break;
			}
			default:
				throw new NotImplementedException("UnknownType!");
			}
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		m_FirstPlay = true;
		if (m_default == null)
		{
			return;
		}
		for (int i = 0; i < m_default.Length; i++)
		{
			TimelineAnimatorPara timelineAnimatorPara = m_default[i];
			switch (timelineAnimatorPara.paramType)
			{
			case TimelineAnimatorPara.ParamType.Trigger:
				m_TrackBinding.ResetTrigger(timelineAnimatorPara.paramName);
				break;
			case TimelineAnimatorPara.ParamType.Bool:
				m_TrackBinding.SetBool(timelineAnimatorPara.paramName, timelineAnimatorPara.newValue);
				break;
			default:
				throw new NotImplementedException("UnknownType!");
			case TimelineAnimatorPara.ParamType.CrossFade:
				break;
			}
		}
		BArrayPool<TimelineAnimatorPara>.Default.Recycle(m_default);
	}
}
