using NetProcol;
using UnityEngine;
using UnityEngine.UI;

public class OnlineReadyButton : MonoBehaviour
{
	public Button m_readyButton;

	public Button m_unReadyButton;

	public Controller m_controller;

	private int entityID;

	private void OnEnable()
	{
		entityID = WorldStateManager.GetWorldStateManager().mPlayerAgentID;
		m_readyButton?.onClick.AddListener(delegate
		{
			OnReadyCommand(isReady: true);
			m_controller.SetSelectedState("unReady");
		});
		m_unReadyButton?.onClick.AddListener(delegate
		{
			OnReadyCommand(isReady: false);
			m_controller.SetSelectedState("Ready");
		});
	}

	private void OnDisable()
	{
		entityID = 0;
		m_controller.SetSelectedState("Ready");
		m_readyButton?.RemoveAllListener();
		m_unReadyButton?.RemoveAllListener();
	}

	private void OnReadyCommand(bool isReady)
	{
		OnlineReadyCommand onlineReadyCommand = CommandFactory.Create(NetprotoOperationCode.CmdOnlineReady) as OnlineReadyCommand;
		onlineReadyCommand.SetData(entityID, isReady);
		ClientSimulator.Instance.SendLocalCommand(onlineReadyCommand);
	}
}
