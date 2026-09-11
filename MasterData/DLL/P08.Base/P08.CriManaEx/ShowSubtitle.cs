using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

namespace P08.CriManaEx;

public class ShowSubtitle : MonoBehaviour
{
	public CriManaMovieControllerForUI m_moviePlay;

	public Text m_subtitleText;

	private string _content;

	private void Update()
	{
		if (!(m_moviePlay == null) && !(m_subtitleText == null) && m_moviePlay.player.subtitleSize != 0)
		{
			_content = Marshal.PtrToStringAnsi(m_moviePlay.player.subtitleBuffer, m_moviePlay.player.subtitleSize);
			m_subtitleText.text = _content;
		}
	}
}
