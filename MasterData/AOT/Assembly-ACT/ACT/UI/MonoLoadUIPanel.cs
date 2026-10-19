using System.IO;
using ACT.Game;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoLoadUIPanel : BaseUIView
{
	public Image backGround;

	public Button loadGame;

	private bool m_isClick;

	public bool OnIsClcik
	{
		get
		{
			bool isClick = m_isClick;
			m_isClick = false;
			return isClick;
		}
	}

	private void Start()
	{
		if (!File.Exists(Application.persistentDataPath + "/PlayerDatas.data"))
		{
			loadGame.gameObject.SetActive(value: false);
		}
		else
		{
			loadGame.gameObject.SetActive(value: true);
		}
	}

	public void LoadGame()
	{
		(G.service as LocalGameService).LoadGame();
		m_isClick = true;
	}

	public void NewGame()
	{
	}
}
