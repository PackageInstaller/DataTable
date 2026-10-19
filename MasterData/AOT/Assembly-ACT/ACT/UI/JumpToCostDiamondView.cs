using ACT.UI.InputController.JumpToCostDiamondViewInputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class JumpToCostDiamondView : BaseUIView<JumpToCostDiamondViewInputController>
{
	private JumpToCostDiamondViewData m_data;

	public ActButton jumpBtn;

	[Header("按键提示相关")]
	public ViewControlLayer btnGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	private void Awake()
	{
		jumpBtn.SetBtnClick(OnJumpBtnClick);
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

	private void OnJumpBtnClick()
	{
		Close();
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP, new ShopViewData
		{
			FirstTabID = 5
		});
	}
}
