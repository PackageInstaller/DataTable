local InfinityTowerBountyUp = class("InfinityTowerBountyUp", BaseCtrl)
InfinityTowerBountyUp._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  imgFrameBgAni = {sNodeName = "imgFrameBg", sComponentName = "Animator"},
  texBountyUp = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Daily_BountyUp"
  },
  texLastLv = {sComponentName = "TMP_Text"},
  texCurrentLv = {sComponentName = "TMP_Text"},
  auto_lv = {},
  auto_lvTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_AutoLevel"
  },
  SuccessBar = {}
}
InfinityTowerBountyUp._mapEventConfig = {
  Show_Infinity_BountyUp = "OnEvent_ShowInfinityBountyUp",
  Close_BountyUp_Auto = "OnEvent_CloseInfinityBountyUp"
}

function InfinityTowerBountyUp:Awake()
  self._mapNode.aniBlur.gameObject:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.SuccessBar.gameObject:SetActive(false)
end

function InfinityTowerBountyUp:OnEvent_ShowInfinityBountyUp()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function InfinityTowerBountyUp:Open()
  if PlayerData.InfinityTower:GetAutoNextLv() then
    self._mapNode.auto_lv:SetActive(true)
  else
    self._mapNode.auto_lv:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.texLastLv, PlayerData.InfinityTower.LastBountyLevel)
  NovaAPI.SetTMPText(self._mapNode.texCurrentLv, PlayerData.InfinityTower.BountyLevel)
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self._mapNode.btnClose.gameObject:SetActive(true)
  self._mapNode.SuccessBar.gameObject:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.8)
end

function InfinityTowerBountyUp:OnBtnClick_Close(btn)
  self._mapNode.aniBlur.gameObject:SetActive(false)
  self._mapNode.imgFrameBgAni:Play("InfinityTowerBountyUp_out")
  self:AddTimer(1, 0.2, function()
    self._mapNode.btnClose.gameObject:SetActive(false)
    self._mapNode.SuccessBar.gameObject:SetActive(false)
  end, true, true, true)
  EventManager.Hit("Close_Infinity_BountyUp")
end

function InfinityTowerBountyUp:OnEvent_CloseInfinityBountyUp()
  self._mapNode.aniBlur.gameObject:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.imgFrameBgAni:Play("InfinityTowerBountyUp_out")
  self:AddTimer(1, 0.2, function()
    self._mapNode.SuccessBar.gameObject:SetActive(false)
  end, true, true, true)
end

return InfinityTowerBountyUp
