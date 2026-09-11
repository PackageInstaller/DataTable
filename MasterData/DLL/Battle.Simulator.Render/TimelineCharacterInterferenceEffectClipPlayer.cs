using System.Collections.Generic;
using UnityEngine.Pipelines.SimPipeline.Character;

public class TimelineCharacterInterferenceEffectClipPlayer : CommonSimpleTimelineClipPlayer<CharacterInterferenceEffectClip>
{
	public TimelineCharacterEffectHelper TimelineCharacterEffectHelper;

	private List<BuffCharacterInterenceEffect> m_buffCharacterInterenceEffectList = new List<BuffCharacterInterenceEffect>();

	private InterferenceEffect m_characterInterferenceEffect;

	public InterferenceEffect CharacterInterferenceEffect
	{
		get
		{
			return m_characterInterferenceEffect;
		}
		set
		{
			m_characterInterferenceEffect = value;
			_ = m_characterInterferenceEffect;
		}
	}

	public void AddBuffCharacterInterenceEffect(int creationIndex, float intensity, int order)
	{
		BuffCharacterInterenceEffect buffCharacterInterenceEffect = FrameObjectPool<BuffCharacterInterenceEffect>.Claim();
		buffCharacterInterenceEffect.CreationIndex = creationIndex;
		buffCharacterInterenceEffect.Intensity = intensity;
		buffCharacterInterenceEffect.Order = order;
		m_buffCharacterInterenceEffectList.Add(buffCharacterInterenceEffect);
	}

	public void RemoveBuffCharacterInterenceEffect(int creationIndex)
	{
		for (int i = 0; i < m_buffCharacterInterenceEffectList.Count; i++)
		{
			if (m_buffCharacterInterenceEffectList[i].CreationIndex == creationIndex)
			{
				BuffCharacterInterenceEffect buffCharacterInterenceEffect = m_buffCharacterInterenceEffectList[i];
				m_buffCharacterInterenceEffectList.RemoveAt(i);
				if (TimelineCharacterEffectHelper != null)
				{
					TimelineCharacterEffectHelper.RemoveInterenceEffect(buffCharacterInterenceEffect.CreationIndex);
				}
				FrameObjectPool<BuffCharacterInterenceEffect>.Release(buffCharacterInterenceEffect);
				ResetCharacterInterferenceParams();
				break;
			}
		}
	}

	public void ClearBuffCharacterInterenceEffect()
	{
		for (int i = 0; i < m_buffCharacterInterenceEffectList.Count; i++)
		{
			if (TimelineCharacterEffectHelper != null)
			{
				TimelineCharacterEffectHelper.RemoveInterenceEffect(m_buffCharacterInterenceEffectList[i].CreationIndex);
			}
			FrameObjectPool<BuffCharacterInterenceEffect>.Release(m_buffCharacterInterenceEffectList[i]);
		}
		m_buffCharacterInterenceEffectList.Clear();
		ResetCharacterInterferenceParams();
	}

	public void UpdateBuffCharacterInterenceEffect(int creationIndex, float intensity)
	{
		BuffCharacterInterenceEffect buffCharacterInterenceEffectByCreationIndex = GetBuffCharacterInterenceEffectByCreationIndex(creationIndex);
		if (buffCharacterInterenceEffectByCreationIndex != null)
		{
			buffCharacterInterenceEffectByCreationIndex.Intensity = intensity;
		}
	}

	public BuffCharacterInterenceEffect GetBuffCharacterInterenceEffectByCreationIndex(int creationIndex)
	{
		for (int i = 0; i < m_buffCharacterInterenceEffectList.Count; i++)
		{
			if (m_buffCharacterInterenceEffectList[i].CreationIndex == creationIndex)
			{
				return m_buffCharacterInterenceEffectList[i];
			}
		}
		return null;
	}

	public BuffCharacterInterenceEffect GetLastestBuffCharacterInterenceEffect()
	{
		if (m_buffCharacterInterenceEffectList.Count <= 0)
		{
			return null;
		}
		return m_buffCharacterInterenceEffectList[m_buffCharacterInterenceEffectList.Count - 1];
	}

	public bool HasBuffCharacterInterenceEffect()
	{
		return m_buffCharacterInterenceEffectList.Count > 0;
	}

	public BuffCharacterInterenceEffect GetMaxOrderBuffRimLightEffect()
	{
		if (m_buffCharacterInterenceEffectList.Count <= 0)
		{
			return null;
		}
		int num = -1;
		int index = m_buffCharacterInterenceEffectList.Count - 1;
		for (int num2 = m_buffCharacterInterenceEffectList.Count - 1; num2 >= 0; num2--)
		{
			if (m_buffCharacterInterenceEffectList[num2].Order > num)
			{
				num = m_buffCharacterInterenceEffectList[num2].Order;
				index = num2;
			}
		}
		return m_buffCharacterInterenceEffectList[index];
	}

	public void ResetCharacterInterferenceParams()
	{
		m_characterInterferenceEffect.enabled = false;
	}

	protected override void _Initialize(List<CharacterInterferenceEffectClip> clips)
	{
		ResetCharacterInterferenceParams();
	}

	protected override void _EnterNodes(List<CharacterInterferenceEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterInterferenceParams();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CharacterInterferenceEffectClip> clipsInThisFrame, float normalized)
	{
		if (!m_characterInterferenceEffect.enabled)
		{
			m_characterInterferenceEffect.enabled = true;
		}
	}

	protected override void _ExitNodes(List<CharacterInterferenceEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterInterferenceParams();
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetCharacterInterferenceParams();
	}

	protected override void _Shutdown()
	{
		ClearBuffCharacterInterenceEffect();
		ResetCharacterInterferenceParams();
	}

	public override void Update(float normalized)
	{
		if (HasBuffCharacterInterenceEffect())
		{
			BuffCharacterInterenceEffect maxOrderBuffRimLightEffect = GetMaxOrderBuffRimLightEffect();
			if (maxOrderBuffRimLightEffect != null)
			{
				if (TimelineCharacterEffectHelper != null)
				{
					TimelineCharacterEffectHelper.UpdateInterenceEffect(maxOrderBuffRimLightEffect.CreationIndex, maxOrderBuffRimLightEffect.Order, maxOrderBuffRimLightEffect.Intensity);
				}
				return;
			}
		}
		if (!(TimelineCharacterEffectHelper != null) || !TimelineCharacterEffectHelper.HasOccupying())
		{
			base.Update(normalized);
		}
	}
}
