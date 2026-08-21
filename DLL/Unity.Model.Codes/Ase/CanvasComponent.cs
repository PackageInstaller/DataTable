using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

[DisallowMultipleComponent]
public sealed class CanvasComponent : GameFrameworkComponent
{
	[Serializable]
	public sealed class CanvasGroup
	{
		[SerializeField]
		private string m_Name;

		[SerializeField]
		private string m_Desc;

		[SerializeField]
		private Transform m_Root;

		[SerializeField]
		private Canvas m_Canvas;

		public string Name => m_Name;

		public Transform Root => m_Root;

		public Canvas Canvas => m_Canvas;
	}

	[SerializeField]
	private Transform m_InstanceRoot;

	[SerializeField]
	private CanvasGroup[] m_CanvasGroups;

	private Dictionary<string, CanvasGroup> m_CacheCanvasGroups;

	public int CanvasGroupCount => m_CacheCanvasGroups.Count;

	public override void Init()
	{
		if (GameEntryRuntime.GetComponent<BaseComponent>() == null)
		{
			return;
		}
		m_CacheCanvasGroups = new Dictionary<string, CanvasGroup>();
		for (int i = 0; i < m_CanvasGroups.Length; i++)
		{
			if (!HasSoundGroup(m_CanvasGroups[i].Name))
			{
				m_CacheCanvasGroups.Add(m_CanvasGroups[i].Name, m_CanvasGroups[i]);
			}
		}
	}

	public bool HasSoundGroup(string canvasGroupName)
	{
		if (string.IsNullOrEmpty(canvasGroupName))
		{
			throw new GameFrameworkException("Canvas group name is invalid.");
		}
		return m_CacheCanvasGroups.ContainsKey(canvasGroupName);
	}

	public CanvasGroup GetCanvasGroup(string canvasGroupName)
	{
		if (string.IsNullOrEmpty(canvasGroupName))
		{
			throw new GameFrameworkException("Canvas group name is invalid.");
		}
		if (m_CacheCanvasGroups.TryGetValue(canvasGroupName, out var value))
		{
			return value;
		}
		return null;
	}

	public override void Shutdown()
	{
		m_CacheCanvasGroups.Clear();
		m_CacheCanvasGroups = null;
	}
}
