using System.Collections.Generic;
using UnityEngine;

public class QWorldHudEntityPool
{
	private static string hudConfigPath = "QWWorld/HUD/Config/QworldHudAsset";

	private static string hudBasePath = "QWWorld/HUD/QWorldHud";

	private Transform hudRoot;

	private QWorldHudAsset config;

	private Queue<QWorldHudEntity> hudPool;

	public void Hide(bool isHide)
	{
		if (isHide)
		{
			hudRoot.transform.localScale = Vector3.zero;
		}
		else
		{
			hudRoot.transform.localScale = Vector3.one;
		}
	}

	public void Init()
	{
		config = Asset.Load<QWorldHudAsset>(hudConfigPath);
		config.Init();
		hudRoot = new GameObject("QWorldHudRoot").transform;
		hudRoot.localPosition = Vector3.zero;
		hudRoot.localRotation = Quaternion.identity;
		hudRoot.localScale = Vector3.one;
		hudPool = new Queue<QWorldHudEntity>();
	}

	public QWorldHudEntity Take()
	{
		if (hudPool.Count > 0)
		{
			QWorldHudEntity qWorldHudEntity = hudPool.Dequeue();
			qWorldHudEntity.OnReset();
			qWorldHudEntity.InUse = true;
			return qWorldHudEntity;
		}
		QWorldHudEntity qWorldHudEntity2 = Create();
		qWorldHudEntity2.InUse = true;
		return qWorldHudEntity2;
	}

	public void Return(QWorldHudEntity hud)
	{
		if (hud.InUse)
		{
			hud.InUse = false;
			hudPool.Enqueue(hud);
		}
	}

	private QWorldHudEntity Create()
	{
		GameObject gameObject = Asset.Instantiate(hudBasePath);
		gameObject.transform.parent = hudRoot;
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.localScale = Vector3.one;
		gameObject.transform.localRotation = Quaternion.identity;
		QWorldHudEntity component = gameObject.GetComponent<QWorldHudEntity>();
		component.OnInit(config);
		return component;
	}

	public void Dispose()
	{
	}

	public QWorldHudConfig GetConfig(QWorldHudType type)
	{
		return config.GetConfig(type);
	}
}
