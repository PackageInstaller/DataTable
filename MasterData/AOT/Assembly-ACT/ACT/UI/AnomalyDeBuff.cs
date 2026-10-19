using System;
using ACT.Battle;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AnomalyDeBuff : MonoBehaviour
{
	public Image debuff_fill;

	public Image circle_fill;

	public Image icon;

	public Animation changeEffect;

	public GameObject fillEffect;

	public float speed = 1f;

	[NonSerialized]
	public int i;

	private bool m_FillFlag;

	public void OnExit(AnomalyData anomalyData)
	{
		if (anomalyData != null)
		{
			m_FillFlag = false;
			ref Action reference = ref anomalyData.onValueChange[i];
			reference = (Action)Delegate.Remove(reference, new Action(ValueChange));
		}
	}

	public void OnEnter(Entity anomaler)
	{
		CompAbility compAbility = anomaler.GetCompAbility();
		if (compAbility.anomalyData == null)
		{
			return;
		}
		ref Action reference = ref compAbility.anomalyData.onValueChange[i];
		reference = (Action)Delegate.Combine(reference, new Action(ValueChange));
		circle_fill.fillAmount = (float)compAbility.anomalyData.anomalyValue[i] * 1f / ((float)AbilityMixinAnomaly.GetAnomalyLimit((AnomalyType)i, anomaler) * 1f);
		if (compAbility.anomalyData.currAnomaly == (AnomalyType)i)
		{
			circle_fill.fillAmount = 1f;
			fillEffect.gameObject.SetActive(value: true);
			compAbility.TryGetAbility(compAbility.anomalyData.anomalyAbilities[i], includeAdd: true, out var ab);
			if (ab != null && ab.Duration != null)
			{
				debuff_fill.fillAmount = ab.Duration.GetVal(ab.stack - 1) / ab.config.fDuration.GetFloat(ab);
			}
		}
	}

	public void ValueChange()
	{
		changeEffect.Play();
	}

	public void IsFull()
	{
		m_FillFlag = true;
		debuff_fill.fillAmount = 1f;
	}

	public void Refresh(Entity m_Anomaler)
	{
		CompAbility compAbility = m_Anomaler.GetCompAbility();
		CompTime compTime = m_Anomaler.GetCompTime();
		if (m_FillFlag)
		{
			circle_fill.fillAmount = InterpolationUtility.FixedLerp(circle_fill.fillAmount, 1f, compTime.fixedDeltaTime * speed);
			if ((double)circle_fill.fillAmount > 0.999999)
			{
				fillEffect.gameObject.SetActive(value: true);
				m_FillFlag = false;
			}
		}
		if (compAbility.anomalyData.currAnomaly == (AnomalyType)i)
		{
			compAbility.TryGetAbility(compAbility.anomalyData.anomalyAbilities[i], includeAdd: true, out var ab);
			if (ab != null && ab.Duration != null)
			{
				debuff_fill.fillAmount = InterpolationUtility.FixedLerp(debuff_fill.fillAmount, ab.Duration.GetVal(ab.stack - 1) / ab.config.fDuration.GetFloat(ab), compTime.fixedDeltaTime * speed);
			}
		}
		else if (!m_FillFlag)
		{
			debuff_fill.fillAmount = 0f;
			circle_fill.fillAmount = InterpolationUtility.FixedLerp(circle_fill.fillAmount, (float)compAbility.anomalyData.anomalyValue[i] * 1f / (float)AbilityMixinAnomaly.GetAnomalyLimit((AnomalyType)i, m_Anomaler) * 1f, compTime.fixedDeltaTime * speed);
			if (fillEffect.gameObject.activeSelf)
			{
				fillEffect.gameObject.SetActive(value: false);
			}
		}
	}
}
