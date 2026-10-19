using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class BulletUI : MonoBehaviour, IEntityUI
{
	public Transform root;

	public GameObject cell;

	public Vector2 offsetPos;

	private Entity m_Bullet;

	private bool m_Show;

	private List<BitMaskSwitcher> m_Cells = new List<BitMaskSwitcher>();

	public bool Show
	{
		get
		{
			return m_Show;
		}
		set
		{
			if (m_Show != value)
			{
				m_Show = value;
				gameObject.SetActive(value);
			}
		}
	}

	public void Init(Entity entity, bool show, Vector3 vector3)
	{
		m_Bullet = entity;
		CompAbility compAbility = entity.GetCompAbility();
		compAbility.onHPChange += new Action<int, int>(RefreshHp);
		for (int i = 0; i < compAbility.maxHP; i++)
		{
			if (i < m_Cells.Count)
			{
				m_Cells[i].gameObject.SetActive(value: true);
				continue;
			}
			GameObject gameObject = UnityEngine.Object.Instantiate(cell, root);
			m_Cells.Add(gameObject.GetComponent<BitMaskSwitcher>());
		}
		Show = true;
	}

	private void RefreshHp(int value, int newValue)
	{
		for (int i = 0; i < m_Bullet.GetCompAbility().maxHP; i++)
		{
			m_Cells[i].SetActive((i < newValue) ? 1 : 0);
		}
	}

	public void UpdatePos()
	{
		if (!m_Bullet.IsValid || !m_Bullet.IsActive() || !m_Bullet.IsAlive())
		{
			Show = false;
			return;
		}
		Show = true;
		Vector3 position = GameUtility.mainCamera.WorldToScreenPoint(m_Bullet.GetRootTransform().position + new Vector3(offsetPos.x, offsetPos.y, 0f));
		position.z = transform.position.z;
		transform.position = GameUtility.uiCamera.ScreenToWorldPoint(position);
	}

	public void OnRelease(Action callback = null)
	{
		Show = false;
		m_Cells.ForEach((BitMaskSwitcher x) =>
		{
			x.gameObject.SetActive(value: false);
		});
	}
}
