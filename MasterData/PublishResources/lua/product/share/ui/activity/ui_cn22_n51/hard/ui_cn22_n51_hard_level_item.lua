_class("UICN22N51HardLevelItem", UICustomWidget)
UICN22N51HardLevelItem = UICN22N51HardLevelItem

function UICN22N51HardLevelItem:Constructor(uiview)
  self._view = uiview
  self:OnShow()
end

function UICN22N51HardLevelItem:OnShow()
  self._normal = self._view:GetGameObject("normal")
  self._pass = self._view:GetGameObject("pass")
  self._close = self._view:GetUIComponent("Image", "close")
  self._lockIcon = self._view:GetUIComponent("Image", "lockIcon")
  self._passBg = self._view:GetUIComponent("Image", "passBg")
  self._name = self._view:GetUIComponent("UILocalizedTMP", "name")
  self._titleOutline = self._view:GetUIComponent("H3D.UGUI.CircleOutline", "name")
  self._closeCanvasGroup = self._view:GetUIComponent("CanvasGroup", "close")
  self._localPos = self._view.transform.localPosition:Clone()
  self._titleBg = self._view:GetUIComponent("Image", "TitleBg")
  self._lockimg = self._view:GetUIComponent("Image", "lockimg")
  self._hadimg = self._view:GetUIComponent("Image", "hadimg")
  self._finishTxt = self._view:GetUIComponent("UILocalizationText", "FinishedText")
  self._anim = self._view:GetUIComponent("Animation", "anim")
  self._rewardCount = self._view:GetUIComponent("UILocalizationText", "RewardCount")
  self._rewardTop = self._view:GetGameObject("RewardTop")
end

function UICN22N51HardLevelItem:OnHide()
end

function UICN22N51HardLevelItem:SetData(idx, cfg, passInfo, cur, atlas)
  if idx < cur then
    if not passInfo then
      Log.exception("没有通关信息：", idx)
    end
    self._pass:SetActive(true)
    self._closeCanvasGroup.alpha = 0
    self._rewardTop:SetActive(false)
  elseif cur < idx then
    self._pass:SetActive(false)
    self._closeCanvasGroup.alpha = 1
    self._rewardTop:SetActive(true)
  else
    self._normal:SetActive(true)
    self._pass:SetActive(false)
    self._closeCanvasGroup.alpha = 0
    self._rewardTop:SetActive(false)
  end
  local cups = cfg:GetCupDatas()
  local compelteCups = cfg:GetCompleteCupCount()
  self._rewardCount:SetText(compelteCups .. "/" .. #cups)
  self._name:SetText(cfg:GetNodeName())
end

function UICN22N51HardLevelItem:LocalPosition()
  return self._localPos
end

function UICN22N51HardLevelItem:Anim_Pass()
  self._anim:Play("uieff_UIN28HardLevel_Finish")
end

function UICN22N51HardLevelItem:Anim_Open()
end

function UICN22N51HardLevelItem:SetActive(bShow)
  self._view.gameObject:SetActive(bShow)
end
