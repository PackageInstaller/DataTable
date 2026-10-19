using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SkinRewardView : BaseUIView
{
	public BImage skinHalfBanner;

	public LocalizeStringEvent skinName;

	public LocalizeStringEvent characterName;

	public ActButton gotoBtn;

	public ActButton confirmBtn;

	private Skin _skinData;

	private SkinRewardViewData m_data => uiViewData as SkinRewardViewData;

	private void Awake()
	{
		gotoBtn.SetBtnClick(OnGotoBtnClick);
		confirmBtn.SetBtnClick(OnConfirmBtnClick);
	}

	private void OnConfirmBtnClick()
	{
		Close();
	}

	private void OnGotoBtnClick()
	{
	}

	protected override void Init()
	{
		base.Init();
		_skinData = CoreUtils.GetData(m_data.SkinId, RuntimeConfigs.data.Skins);
		Station.LoadImage(139, m_data.SkinId, skinHalfBanner);
		skinName.SetTable(LocalizeTable.ShortCommon);
		skinName.StringReference.TableEntryReference = _skinData.skinname;
		EntityData data = CoreUtils.GetData(_skinData.roleid, RuntimeConfigs.data.entityDatas);
		characterName.SetTable(LocalizeTable.ShortCommon);
		characterName.StringReference.TableEntryReference = data.nameLocal;
	}
}
