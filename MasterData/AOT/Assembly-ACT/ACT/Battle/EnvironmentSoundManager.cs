using System;
using System.Collections.Generic;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[Obsolete]
public class EnvironmentSoundManager : Singleton<EnvironmentSoundManager>
{
	protected List<EnvironmentSoundTransfer> m_Bgms = new List<EnvironmentSoundTransfer>(8);

	private string ambName;

	private Transform transform;

	[Range(0f, 10f)]
	private float paramValue;

	public override void UnInit()
	{
		m_Bgms.Clear();
	}

	public void AddListener(EnvironmentSoundTransfer transfer)
	{
		m_Bgms.Add(transfer);
	}

	public void RemoveListener(EnvironmentSoundTransfer transfer)
	{
		if (m_Bgms.Contains(transfer))
		{
			m_Bgms.Remove(transfer);
		}
	}
}
