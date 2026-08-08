using System;
using System.Collections.Generic;
using UnityEngine;

public class QWorldHudEntity : MonoBehaviour
{
	public float sizeFactor = 1f;

	public float maxSizeFactor = 5f;

	public float minDistance = 0.2f;

	public QWorldNameHud nameHud;

	public QWorldCommonHud commonHud;

	public QWorldQuestHud questHud;

	public bool InUse;

	public Action onHideDone;

	private Dictionary<QWorldHudType, QWorldHudBase> huds;

	public void OnInit(QWorldHudAsset config)
	{
		InUse = false;
		huds = new Dictionary<QWorldHudType, QWorldHudBase>(3);
		huds.Add(QWorldHudType.Name, nameHud);
		huds.Add(QWorldHudType.Common, commonHud);
		huds.Add(QWorldHudType.Quest, questHud);
		nameHud.OnInit(QWorldHudType.Name, config.GetConfig(QWorldHudType.Name), this);
		commonHud.OnInit(QWorldHudType.Common, config.GetConfig(QWorldHudType.Common), this);
		questHud.OnInit(QWorldHudType.Quest, config.GetConfig(QWorldHudType.Quest), this);
	}

	public void OnReset()
	{
		foreach (KeyValuePair<QWorldHudType, QWorldHudBase> hud in huds)
		{
			hud.Value.OnDispose();
		}
		base.transform.localScale = Vector3.one;
		onHideDone = null;
	}

	public QWorldHudBase Get(QWorldHudType hudType)
	{
		if (huds.TryGetValue(hudType, out var value))
		{
			return value;
		}
		return null;
	}

	public bool IsShow(QWorldHudType hudType)
	{
		if (huds.TryGetValue(hudType, out var value))
		{
			return value.IsShow;
		}
		return false;
	}

	public void OnHideDone(QWorldHudBase hud)
	{
		foreach (KeyValuePair<QWorldHudType, QWorldHudBase> hud2 in huds)
		{
			if (hud2.Value.IsShow)
			{
				return;
			}
		}
		foreach (KeyValuePair<QWorldHudType, QWorldHudBase> hud3 in huds)
		{
			hud3.Value.OnDispose();
		}
		onHideDone?.Invoke();
		onHideDone = null;
		base.transform.localScale = Vector3.zero;
		QWorldHudManager.Instance.Return(this);
	}

	public void Hide()
	{
		foreach (KeyValuePair<QWorldHudType, QWorldHudBase> hud in huds)
		{
			hud.Value.OnDispose();
		}
		base.transform.localScale = Vector3.zero;
		onHideDone?.Invoke();
		onHideDone = null;
		QWorldHudManager.Instance.Return(this);
	}

	public void CloseToCamera()
	{
		if (Mathf.Abs(Vector3.Distance(base.transform.position, QWorldCameraManager.Instance.MainCamera.transform.position)) < minDistance)
		{
			base.transform.localScale = Vector3.zero;
		}
	}

	public virtual void UpdatePosition(Transform target)
	{
		base.transform.position = target.position;
		base.transform.forward = QWorldCameraManager.Instance.MainCamera.transform.forward;
		float num = Mathf.Max(0f, QWorldCameraManager.Instance.MainCamera.transform.InverseTransformPoint(base.transform.position).z) * sizeFactor;
		float num2 = Mathf.Clamp(0.1f * num, 0f, maxSizeFactor);
		base.transform.localScale = num2 * Vector3.one;
	}
}
