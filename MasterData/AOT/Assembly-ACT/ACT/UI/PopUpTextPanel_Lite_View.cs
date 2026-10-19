using ACT.Utility;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpTextPanel_Lite_View : BaseUIView
{
	public LocalizeStringEvent localStringEvent;

	public TextMeshProUGUI text;

	public ActButton CancelBtn;

	public LocalizeStringEvent cancelBtnStrEvent;

	public ActButton ConfirmBtn;

	public LocalizeStringEvent confirmBtnStrEvent;

	public ActButton closeBtn;

	private PopUpTextPanel_Lite_Data _data;

	private bool m_isClicked;

	public override UniTask PreInit()
	{
		_data = uiViewData as PopUpTextPanel_Lite_Data;
		CancelBtn?.SetBtnClick(OnCancelBtn);
		ConfirmBtn?.SetBtnClick(OnConfirmBtn);
		closeBtn?.SetBtnClick(Close);
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		if (_data == null)
		{
			return;
		}
		m_isClicked = false;
		cancelBtnStrEvent?.SetReference(LocalizeTable.Common, _data.cancelBtnDes);
		confirmBtnStrEvent?.SetReference(LocalizeTable.Common, _data.confirmBtnDes);
		localStringEvent.StringReference.TableEntryReference = _data.commonId;
		if (_data.texts == null || _data.texts.Length == 0)
		{
			return;
		}
		if (_data.commonId == 0)
		{
			for (int i = 0; i < _data.texts.Length; i++)
			{
				localStringEvent.OnUpdateString.Invoke(_data.texts[i]);
			}
		}
		for (int j = 0; j < _data.texts.Length; j++)
		{
			localStringEvent.StringReference.GetVariable<string>(j.ToString()).Value = _data.texts[j];
		}
	}

	public void OnConfirmBtn()
	{
		if (!m_isClicked)
		{
			_data.OnConfirm?.Invoke();
			Close();
		}
	}

	public void OnCancelBtn()
	{
		if (!m_isClicked)
		{
			_data.OnCancel?.Invoke();
			Close();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
	}
}
