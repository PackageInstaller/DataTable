using UnityEngine;

namespace ACT.UI;

public class MonoGameModeSelectionView : BaseUIView
{
	private GameLoader m_Loader;

	protected override void Init()
	{
		m_Loader = GameObject.Find("GameLoader").GetComponent<GameLoader>();
	}

	public void ConfigSave()
	{
		m_Loader.mode = GameLoader.GameMode.ConfigSave;
		m_Loader.ContinueGameStart();
	}

	public void Local()
	{
		m_Loader.mode = GameLoader.GameMode.Local;
		m_Loader.ContinueGameStart();
	}

	public void Network()
	{
		m_Loader.mode = GameLoader.GameMode.Network;
		m_Loader.ContinueGameStart();
	}
}
