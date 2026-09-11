using System.Collections.Generic;
using CriMana;
using UnityEngine;

public class CriManaExMultipleVedio : MonoBehaviour
{
	public uint m_maxDataSize = 300000u;

	public CriManaMovieMaterial m_manaPlayer;

	public List<string> m_paths = new List<string>();

	public List<bool> m_isLoop = new List<bool>();

	private int _nextIndex;

	protected void Start()
	{
		_nextIndex = PlayUntilLoopInternal(_nextIndex);
		m_manaPlayer.player.SetMaxPictureDataSize(m_maxDataSize);
		m_manaPlayer.Play();
	}

	private void OnEnable()
	{
		m_manaPlayer.player.SetVolume(AudioManager.Instance.MusicVolume);
	}

	private int PlayUntilLoopInternal(int pStartIndex)
	{
		if (m_manaPlayer == null)
		{
			return -1;
		}
		if (pStartIndex >= m_paths.Count)
		{
			return m_paths.Count;
		}
		if (1 == m_paths.Count)
		{
			if (0 < m_isLoop.Count && m_isLoop[0])
			{
				m_manaPlayer.player.Loop(sw: true);
			}
			else
			{
				m_manaPlayer.player.Loop(sw: false);
			}
			m_manaPlayer.player.SetFile(null, m_paths[0]);
			return m_paths.Count;
		}
		for (int i = pStartIndex; i < m_paths.Count; i++)
		{
			if (i < m_isLoop.Count && m_isLoop[i])
			{
				if (!m_manaPlayer.player.SetFile(null, m_paths[i], Player.SetMode.AppendRepeatedly))
				{
					m_manaPlayer.player.Loop(sw: true);
					m_manaPlayer.player.SetFile(null, m_paths[i]);
				}
				return i + 1;
			}
			m_manaPlayer.player.SetFile(null, m_paths[i], Player.SetMode.Append);
		}
		return m_paths.Count;
	}

	public void PlayUntilLoop()
	{
		_nextIndex = PlayUntilLoopInternal(_nextIndex);
	}

	public void PlayByIndex(int index)
	{
		if (index > m_paths.Count)
		{
			index = m_paths.Count;
		}
		_nextIndex = index;
		_nextIndex = PlayUntilLoopInternal(_nextIndex);
	}
}
