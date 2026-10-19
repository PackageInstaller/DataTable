using ACT.Battle;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class PopUpProtagonistExitViewView : BaseUIView
{
	private PopUpProtagonistExitViewViewData m_data;

	[SerializeField]
	[Header("通用弹窗动画")]
	private BetterAnimation _commonBgAnimation;

	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("确认按钮")]
	private ActButton _confirmBtn;

	[SerializeField]
	[Header("取消按钮")]
	private ActButton _cancelBtn;

	private const string Show = "Show";

	private const string Hide = "Hide";

	private void Awake()
	{
		_closeBtn.SetBtnClick(Close);
		_confirmBtn.SetBtnClick(ExitProtagonist);
		_cancelBtn.SetBtnClick(Close);
	}

	protected override void OnUnityDestroy()
	{
		_closeBtn.OnClick.RemoveAllListeners();
		_confirmBtn.OnClick.RemoveAllListeners();
		_cancelBtn.OnClick.RemoveAllListeners();
	}

	private void ExitProtagonist()
	{
		Close();
		Singleton<ProtagonistManager>.instance.ExitProtagonistMode().Forget();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		_commonBgAnimation.GetSequence("Show").Play();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		_commonBgAnimation.GetSequence("Hide").Play();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}
}
