using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class TimelineCharacterEffectHelper : CMonoBehaviour
{
	private CharacterEffect m_characterEffect;

	private float m_originFillRatio;

	private float m_originFillSoft;

	private Color m_originFillOuter;

	private Color m_originFillInner;

	private InterferenceEffect m_characterInterferenceEffect;

	private int m_buffID;

	private int m_order = int.MinValue;

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
				m_characterInterferenceEffect = m_characterEffect.interferenceEffect;
			}
			else
			{
				m_originFillRatio = 0f;
			}
		}
	}

	private void UpdateOccupyBuff(int buffID, int order)
	{
		m_buffID = buffID;
		m_order = order;
	}

	private bool CanUpdate(int buffID, int order)
	{
		if (m_buffID != buffID)
		{
			return order > m_order;
		}
		return true;
	}

	private void ResetOccupyData()
	{
		m_buffID = 0;
		m_order = int.MinValue;
	}

	public bool HasOccupying()
	{
		return m_buffID != 0;
	}

	private void ResetInterenceEffectParams()
	{
		CharacterEffect.interferenceEffect.enabled = false;
	}

	public void UpdateInterenceEffect(int buffID, int order, float intensity)
	{
		if (CanUpdate(buffID, order))
		{
			UpdateOccupyBuff(buffID, order);
			if (!m_characterInterferenceEffect.enabled)
			{
				m_characterInterferenceEffect.enabled = true;
			}
			Color geometryOutlineColor = m_characterInterferenceEffect.geometryOutlineColor;
			geometryOutlineColor.a = intensity;
			m_characterInterferenceEffect.geometryOutlineColor = geometryOutlineColor;
			ResetRimLightEffectParams();
		}
	}

	public void RemoveInterenceEffect(int buffID)
	{
		if (m_buffID == buffID)
		{
			ResetOccupyData();
			ResetInterenceEffectParams();
		}
	}

	private void ResetRimLightEffectParams()
	{
		m_characterEffect.fillRatio = m_originFillRatio;
		m_characterEffect.fillOuter = m_originFillOuter;
		m_characterEffect.fillInner = m_originFillInner;
		m_characterEffect.fillSoft = m_originFillSoft;
	}

	public void UpdateRimLightEffect(int buffID, int order, float ratio, float soft, Color outer, Color inner)
	{
		if (CanUpdate(buffID, order))
		{
			UpdateOccupyBuff(buffID, order);
			m_characterEffect.fillOuter = outer;
			m_characterEffect.fillInner = inner;
			m_characterEffect.fillRatio = ratio;
			m_characterEffect.fillSoft = soft;
			ResetInterenceEffectParams();
		}
	}

	public void RemoveRimLightEffect(int buffID)
	{
		if (m_buffID == buffID)
		{
			ResetOccupyData();
			ResetRimLightEffectParams();
		}
	}
}
