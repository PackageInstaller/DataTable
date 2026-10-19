using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class GachaInsufficientPropsView : BaseUIView<GachaInsufficientPropsViewInputController>
{
	public ActButton BtnCanel;

	public ActButton BtnClose;

	public ActButton BtnConfirm;

	public TextMeshProUGUI TextDes;

	public TextMeshProUGUI TextTips;

	public LocalizeStringEvent TextBtnConfirm;

	private GachaInsufficientPropsViewData m_data;

	[Header("按键提示相关")]
	public ViewControlLayer btnGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	public override UniTask PreInit()
	{
		m_data = uiViewData as GachaInsufficientPropsViewData;
		return base.PreInit();
	}

	protected override void Init()
	{
		TextDes.text = m_data.StringDes;
		TextTips.text = m_data.StringTips;
		BtnConfirm.SetBtnClick(OnConfirm);
		BtnCanel.SetBtnClick(Close);
		BtnClose.SetBtnClick(Close);
		if (m_data.isbuy)
		{
			TextBtnConfirm.StringReference.TableEntryReference = 2716L;
		}
		else
		{
			TextBtnConfirm.StringReference.TableEntryReference = 13L;
		}
		base.Init();
	}

	private void OnConfirm()
	{
		m_data.OnConfirm?.Invoke();
		Close();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}
}
