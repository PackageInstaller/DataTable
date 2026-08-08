using System.Collections.Generic;
using UnityEngine;

public class TimelineCharacterEffectComponentRegulator : CommonSimpleTimelineClipPlayer<FlashActionClip>
{
	public TimelineCharacterEffectHelper TimelineCharacterEffectHelper;

	private List<BuffCharacterRimLightEffect> m_buffRimLightList = new List<BuffCharacterRimLightEffect>();

	private CharacterEffect m_characterEffect;

	private float m_originFillRatio;

	private Color m_originFillOuter;

	private Color m_originFillInner;

	private float m_originFillSoft = 2f;

	public CharacterEffect CharacterEffect
	{
		get
		{
			return m_characterEffect;
		}
		set
		{
			m_characterEffect = value;
			if (m_characterEffect != null)
			{
				m_originFillRatio = m_characterEffect.fillRatio;
				m_originFillOuter = m_characterEffect.fillOuter;
				m_originFillInner = m_characterEffect.fillInner;
				m_originFillSoft = m_characterEffect.fillSoft;
			}
			else
			{
				m_originFillRatio = 0f;
			}
		}
	}

	public void AddBuffRimLight(int buffID, float ratio, float soft, Color outer, Color inner, int order)
	{
		BuffCharacterRimLightEffect buffCharacterRimLightEffect = FrameObjectPool<BuffCharacterRimLightEffect>.Claim();
		buffCharacterRimLightEffect.BuffID = buffID;
		buffCharacterRimLightEffect.Ratio = ratio;
		buffCharacterRimLightEffect.Soft = soft;
		buffCharacterRimLightEffect.Outer = outer;
		buffCharacterRimLightEffect.Inner = inner;
		buffCharacterRimLightEffect.Order = order;
		m_buffRimLightList.Add(buffCharacterRimLightEffect);
	}

	public void RemoveBuffRimLight(int buffID)
	{
		for (int i = 0; i < m_buffRimLightList.Count; i++)
		{
			if (m_buffRimLightList[i].BuffID == buffID)
			{
				BuffCharacterRimLightEffect buffCharacterRimLightEffect = m_buffRimLightList[i];
				m_buffRimLightList.RemoveAt(i);
				if (TimelineCharacterEffectHelper != null)
				{
					TimelineCharacterEffectHelper.RemoveRimLightEffect(buffCharacterRimLightEffect.BuffID);
				}
				FrameObjectPool<BuffCharacterRimLightEffect>.Release(buffCharacterRimLightEffect);
				ResetCharacterRimLightEffectr();
				break;
			}
		}
	}

	public void ClearRemoveBuffRimList()
	{
		for (int i = 0; i < m_buffRimLightList.Count; i++)
		{
			if (TimelineCharacterEffectHelper != null)
			{
				TimelineCharacterEffectHelper.RemoveRimLightEffect(m_buffRimLightList[i].BuffID);
			}
			FrameObjectPool<BuffCharacterRimLightEffect>.Release(m_buffRimLightList[i]);
		}
		m_buffRimLightList.Clear();
		ResetCharacterRimLightEffectr();
	}

	public void UpdateBuffRimLight(int buffID, float ratio, float soft)
	{
		BuffCharacterRimLightEffect buffRimLightEffectByBuffID = GetBuffRimLightEffectByBuffID(buffID);
		if (buffRimLightEffectByBuffID != null)
		{
			buffRimLightEffectByBuffID.Ratio = ratio;
			buffRimLightEffectByBuffID.Soft = soft;
		}
	}

	public void UpdateBuffRimLight(int buffID, float ratio, float soft, Color outer, Color inner)
	{
		BuffCharacterRimLightEffect buffRimLightEffectByBuffID = GetBuffRimLightEffectByBuffID(buffID);
		if (buffRimLightEffectByBuffID != null)
		{
			buffRimLightEffectByBuffID.Ratio = ratio;
			buffRimLightEffectByBuffID.Outer = outer;
			buffRimLightEffectByBuffID.Inner = inner;
			buffRimLightEffectByBuffID.Soft = soft;
		}
	}

	public BuffCharacterRimLightEffect GetBuffRimLightEffectByBuffID(int buffID)
	{
		for (int i = 0; i < m_buffRimLightList.Count; i++)
		{
			if (m_buffRimLightList[i].BuffID == buffID)
			{
				return m_buffRimLightList[i];
			}
		}
		return null;
	}

	public BuffCharacterRimLightEffect GetLastestBuffRimLightEffect()
	{
		if (m_buffRimLightList.Count <= 0)
		{
			return null;
		}
		return m_buffRimLightList[m_buffRimLightList.Count - 1];
	}

	public bool HasBuffCharacterRimLightEffect()
	{
		return m_buffRimLightList.Count > 0;
	}

	public BuffCharacterRimLightEffect GetMaxOrderBuffRimLightEffect()
	{
		if (m_buffRimLightList.Count <= 0)
		{
			return null;
		}
		int num = -1;
		int index = m_buffRimLightList.Count - 1;
		for (int num2 = m_buffRimLightList.Count - 1; num2 >= 0; num2--)
		{
			if (m_buffRimLightList[num2].Order > num)
			{
				num = m_buffRimLightList[num2].Order;
				index = num2;
			}
		}
		return m_buffRimLightList[index];
	}

	public void ResetCharacterRimLightEffectr()
	{
		if (!HasBuffCharacterRimLightEffect())
		{
			m_characterEffect.fillRatio = m_originFillRatio;
			m_characterEffect.fillOuter = m_originFillOuter;
			m_characterEffect.fillInner = m_originFillInner;
			m_characterEffect.fillSoft = m_originFillSoft;
		}
	}

	protected override void _Initialize(List<FlashActionClip> clips)
	{
	}

	protected override void _EnterNodes(List<FlashActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterRimLightEffectr();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<FlashActionClip> clipsInThisFrame, float normalized)
	{
		FlashActionClip clip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		UpdateNode(clip, normalized);
	}

	protected override void _ExitNodes(List<FlashActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterRimLightEffectr();
	}

	protected override void _Shutdown()
	{
		ClearRemoveBuffRimList();
		ResetCharacterRimLightEffectr();
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	public void UpdateNode(FlashActionClip clip, float normalized)
	{
		if (clip.IsCustomFillColor)
		{
			m_characterEffect.fillOuter = clip.FillOuter;
			m_characterEffect.fillInner = clip.FillInner;
			m_characterEffect.fillSoft = clip.FillSoft;
		}
		else
		{
			m_characterEffect.fillOuter = m_originFillOuter;
			m_characterEffect.fillInner = m_originFillInner;
			m_characterEffect.fillSoft = m_originFillSoft;
		}
		AnimationCurve curve = clip.Curve;
		float time = (normalized - clip.NormalizedBegin) / (clip.NormalizedEnd - clip.NormalizedBegin);
		float fillRatio = curve.Evaluate(time);
		m_characterEffect.fillRatio = fillRatio;
	}

	public override void Update(float normalized)
	{
		if (!HasBuffCharacterRimLightEffect() && (!(TimelineCharacterEffectHelper != null) || !TimelineCharacterEffectHelper.HasOccupying()))
		{
			base.Update(normalized);
		}
	}

	public override void UpdateWithoutTimeScale(float realTimeDelta)
	{
		if (HasBuffCharacterRimLightEffect())
		{
			BuffCharacterRimLightEffect maxOrderBuffRimLightEffect = GetMaxOrderBuffRimLightEffect();
			if (maxOrderBuffRimLightEffect != null)
			{
				if (TimelineCharacterEffectHelper != null)
				{
					TimelineCharacterEffectHelper.UpdateRimLightEffect(maxOrderBuffRimLightEffect.BuffID, maxOrderBuffRimLightEffect.Order, maxOrderBuffRimLightEffect.Ratio, maxOrderBuffRimLightEffect.Soft, maxOrderBuffRimLightEffect.Outer, maxOrderBuffRimLightEffect.Inner);
				}
				return;
			}
		}
		if (!TimelineCharacterEffectHelper.HasOccupying())
		{
			base.UpdateWithoutTimeScale(realTimeDelta);
		}
	}
}
