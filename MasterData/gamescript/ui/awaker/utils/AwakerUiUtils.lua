local AwakerUiUtils = {}

function AwakerUiUtils:RefreshAwakerSkinStarGroup(binder, skinTid)
  local starUi = UI_Common_SkinStarResource(self.ui.UI_Common_SkinStar)
  local skinQuality = AwakerSkinCfgUtils.GetSkinQuality(skinTid)
  local starNum = AwakerSkinDefine.SkinQualityStarNum[skinQuality]
  for i = 1, 5 do
    binder:SetActive(starUi["Star_" .. i], i <= starNum)
  end
end

return AwakerUiUtils
