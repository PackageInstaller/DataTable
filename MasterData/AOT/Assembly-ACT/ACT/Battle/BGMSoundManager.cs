using System;
using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle;

[Obsolete]
public class BGMSoundManager : Singleton<BGMSoundManager>
{
	protected List<BGMSoundTransfer> m_Bgms;

	private BGMSoundTransfer m_bgm;

	public override void Init()
	{
		m_Bgms = new List<BGMSoundTransfer>();
	}

	public override void UnInit()
	{
		m_Bgms.Clear();
	}

	public void AddListener(BGMSoundTransfer transfer)
	{
		m_Bgms.Add(transfer);
	}

	public void RemoveListener(BGMSoundTransfer transfer)
	{
		if (m_Bgms.Contains(transfer))
		{
			m_Bgms.Remove(transfer);
		}
	}
}
