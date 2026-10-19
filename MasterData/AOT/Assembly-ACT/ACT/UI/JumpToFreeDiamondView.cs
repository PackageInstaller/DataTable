using ACT.Game;
using ACT.UI.InputController.JumpToFreeDiamondViewInputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class JumpToFreeDiamondView : BaseUIView<JumpToFreeDiamondViewInputController>
{
	public LocalizeStringEvent freeDiamondTextEvent;

	public ActButton cancelButton;

	public ActButton confirmButton;

	public ActButton closeButton;

	public ViewControlLayer btnGroupLayer;

	public ViewControlLayer coinGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	public int OwnedCostDiamond => G.localPlayer.GetCountById(98);

	private JumpToFreeDiamondViewData m_data => uiViewData as JumpToFreeDiamondViewData;

	private void Awake()
	{
		cancelButton.SetBtnClick(OnCancelClick);
		confirmButton.SetBtnClick(OnConfirmClick);
		closeButton.SetBtnClick(OnCloseAction);
	}

	protected override void Init()
	{
		base.Init();
		UpdateText();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	private void UpdateText()
	{
		freeDiamondTextEvent.GetVariable<int>("0").Value = m_data.RequireFreeDiamondCount;
	}

	private void OnCancelClick()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	private void OnConfirmClick()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		if (m_data.RequireFreeDiamondCount <= OwnedCostDiamond)
		{
			G.service.ExchangeFreeDiamond(m_data.RequireFreeDiamondCount, (bool success) =>
			{
				if (success)
				{
					Close();
				}
			});
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
			Close();
		}
	}

	public void OnCloseAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}
}
