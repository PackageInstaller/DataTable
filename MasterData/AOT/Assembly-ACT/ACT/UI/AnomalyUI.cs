using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class AnomalyUI : LuminSerializedMonoBehaviour
{
	public RectTransform monsterContent;

	public RectTransform bossContent;

	private Entity m_Anomaler;

	private EntityId lastEntityId;

	public Dictionary<AnomalyType, AnomalyDeBuff> anomalyUI = new Dictionary<AnomalyType, AnomalyDeBuff>();

	public void UpdateAnomaler(Entity anomaler)
	{
		if (!(lastEntityId != anomaler.Id))
		{
			return;
		}
		if (m_Anomaler.IsValid && m_Anomaler.TryGetCompAbility(out CompAbility component))
		{
			if (m_Anomaler.IsAlive() && m_Anomaler.GetEntityType() == EntityType.Boss)
			{
				return;
			}
			if (component.anomalyData != null)
			{
				AnomalyData anomalyData = component.anomalyData;
				anomalyData.isFull = (Action<AnomalyType>)Delegate.Remove(anomalyData.isFull, new Action<AnomalyType>(IsFull));
				for (int i = 0; i < 2; i++)
				{
					AnomalyDeBuff anomalyDeBuff = anomalyUI[(AnomalyType)i];
					if (!(anomalyDeBuff == null))
					{
						anomalyDeBuff.OnExit(component.anomalyData);
					}
				}
			}
		}
		if (anomaler.TryGetCompAbility(out CompAbility component2) && component2.anomalyData != null)
		{
			AnomalyData anomalyData2 = component2.anomalyData;
			anomalyData2.isFull = (Action<AnomalyType>)Delegate.Combine(anomalyData2.isFull, new Action<AnomalyType>(IsFull));
		}
		for (int j = 0; j < 2; j++)
		{
			AnomalyDeBuff anomalyDeBuff2 = anomalyUI[(AnomalyType)j];
			if (!(anomalyDeBuff2 == null))
			{
				anomalyDeBuff2.OnEnter(anomaler);
				if (anomaler.GetEntityType() == EntityType.Boss)
				{
					anomalyDeBuff2.transform.SetParent(bossContent);
				}
				else
				{
					anomalyDeBuff2.transform.SetParent(monsterContent);
				}
			}
		}
		m_Anomaler = anomaler;
		lastEntityId = m_Anomaler.Id;
	}

	public void AnomalyUIEnable()
	{
		UpdateAnomalyUI();
		enabled = true;
	}

	private void Awake()
	{
		foreach (KeyValuePair<AnomalyType, AnomalyDeBuff> item in anomalyUI)
		{
			item.Value.i = (int)item.Key;
		}
	}

	public void AnomalyUIDisable()
	{
		enabled = false;
	}

	private void FixedUpdate()
	{
		UpdateAnomalyUI();
	}

	private void UpdateAnomalyUI()
	{
		if (!m_Anomaler.IsValid || !m_Anomaler.IsAlive() || !m_Anomaler.TryGetCompAbility(out CompAbility component))
		{
			m_Anomaler = default;
			lastEntityId = default;
			return;
		}
		for (int i = 0; i < 2; i++)
		{
			AnomalyDeBuff anomalyDeBuff = anomalyUI[(AnomalyType)i];
			if (anomalyDeBuff == null)
			{
				continue;
			}
			if (component.anomalyData == null)
			{
				if (anomalyDeBuff.gameObject.activeSelf)
				{
					anomalyDeBuff.gameObject.SetActive(value: false);
				}
			}
			else if (!component.anomalyData.isShowUI[i])
			{
				if (anomalyDeBuff.gameObject.activeSelf)
				{
					anomalyDeBuff.gameObject.SetActive(value: false);
				}
				anomalyDeBuff.circle_fill.fillAmount = 0f;
				if (anomalyDeBuff.gameObject.activeSelf)
				{
					anomalyDeBuff.fillEffect.gameObject.SetActive(value: false);
				}
			}
			else
			{
				anomalyDeBuff.Refresh(m_Anomaler);
				if (!anomalyDeBuff.gameObject.activeSelf)
				{
					anomalyDeBuff.gameObject.SetActive(value: true);
				}
			}
		}
	}

	private void IsFull(AnomalyType anomalyType)
	{
		anomalyUI[anomalyType].IsFull();
	}
}
