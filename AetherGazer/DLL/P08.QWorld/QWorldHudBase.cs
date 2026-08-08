using System;
using UnityEngine;

public abstract class QWorldHudBase : MonoBehaviour
{
	public QWorldHudType hudType;

	private bool m_isShow;

	private bool m_isInit;

	private bool m_isInHide;

	private QWorldHudConfig config;

	private int tweenId;

	private QWorldHudEntity root;

	public bool IsShow => m_isShow;

	public bool IsInit => m_isInit;

	public virtual void OnInit(QWorldHudType type, QWorldHudConfig config, QWorldHudEntity _root)
	{
		hudType = type;
		this.config = config;
		root = _root;
		m_isInit = false;
		m_isShow = false;
		m_isInHide = false;
		base.transform.localScale = Vector3.zero;
	}

	public QWorldHudType GetHudType()
	{
		return hudType;
	}

	public virtual void OnDispose()
	{
		m_isShow = false;
		m_isInit = false;
		m_isInHide = false;
		if (tweenId != -1)
		{
			LeanTween.cancel(tweenId);
			tweenId = -1;
		}
		base.transform.localScale = Vector3.zero;
		OnHide(1f);
	}

	public virtual void Show()
	{
		if (!m_isShow || m_isInHide)
		{
			m_isShow = true;
			m_isInHide = false;
			base.transform.localScale = Vector3.one;
			if (tweenId != -1)
			{
				LeanTween.cancel(tweenId);
				tweenId = -1;
			}
			tweenId = LeanTween.value(0f, 1f, config.hideDuration).setOnUpdate(delegate(float f)
			{
				OnShow(f);
			}).setOnComplete((Action)delegate
			{
				OnShow(1f);
				tweenId = -1;
			})
				.uniqueId;
		}
	}

	public abstract void OnShow(float rate);

	public virtual void Hide(bool force = false)
	{
		if (force)
		{
			if (tweenId != -1)
			{
				LeanTween.cancel(tweenId);
				tweenId = -1;
			}
			base.transform.localScale = Vector3.zero;
			OnHide(1f);
			m_isShow = false;
			root.OnHideDone(this);
			m_isInHide = false;
		}
		else if (m_isShow && !m_isInHide)
		{
			if (tweenId != -1)
			{
				LeanTween.cancel(tweenId);
				tweenId = -1;
			}
			m_isInHide = true;
			tweenId = LeanTween.value(0f, 1f, config.hideDuration).setOnUpdate(delegate(float f)
			{
				OnHide(f);
			}).setOnComplete((Action)delegate
			{
				base.transform.localScale = Vector3.zero;
				OnHide(1f);
				m_isShow = false;
				m_isInHide = false;
				root.OnHideDone(this);
				tweenId = -1;
			})
				.uniqueId;
		}
	}

	public abstract void OnHide(float rate);

	public virtual void SetData(QWAgent agent, QWHudBehaviour hudBehaviour)
	{
		m_isInit = true;
	}
}
