local IMAGE_PATH = {
  DIS_LOW = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Topped_Tip2_Btn_01Dis.png",
  DIS_HIGH = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Topped_Tip2_Btn_02Dis.png",
  NOR_LOW = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Topped_Tip2_Btn_01Nor.png",
  NOR_MID = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Topped_Tip2_Btn_02Nor.png",
  NOR_MAX = "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Topped_Tip2_Btn_02Max.png"
}
local AwakerAffectionItem, Super = System.NewComponent("AwakerAffectionItem")

function AwakerAffectionItem:ctor(itemUI, cfg, awakerAffectionModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Topped_Tip2_ItemResource(itemUI)
  self.cfg = cfg
  self.model = awakerAffectionModel
  self.isMin = cfg.AwakerFavorabilityLevel == self.model:GetMinLv()
  self.isMax = cfg.AwakerFavorabilityLevel == self.model:GetMaxLv()
  local awakerId = self.model:GetSelectAwakerId()
  self.isBreakthroughLevel = cfg.AwakerFavorabilityLevel >= AwakerFavorabilityCfgUtils.GetBreakthroughStartLevel(awakerId)
  self.lv = cfg.AwakerFavorabilityLevel
  self.isLvMax = self.lv >= FavorabilityVisualUtils.ShowPremiumCardFaceLevel()
end

function AwakerAffectionItem:OnBind(binder)
  self.binder = binder
  if self.ui.Text_Lv then
    binder:BindToText(self.ui.Text_Lv, function()
      local lv = self.cfg.AwakerFavorabilityLevel
      if self.isBreakthroughLevel and lv > self.model:GetBreakthroughLevel() then
        do return string.format, "<color=%s>%d</color>", CommonDefine.TextColorDefine.Gray end
        return string.format, "<color=%s>%d</color>", CommonDefine.TextColorDefine.Gray, lv
      end
      return lv
    end)
  end
  binder:BindToText(self.ui.Text_Num, function()
    do return self.model.GetTotalNeedExp, self.model end
    return self.model.GetTotalNeedExp, self.model, self.cfg.AwakerFavorabilityLevel
  end)
  binder:BindZ1Button(self.ui.Button, function()
    self.model:SetSelectLv(self.cfg.AwakerFavorabilityLevel)
  end, function()
    return CommonDefine.BtnType.Normal
  end)
  binder:BindToVisible(self.ui.Group_Sel, function()
    return self.model:GetSelectLv() == self.cfg.AwakerFavorabilityLevel
  end)
  self.ui.Group_Line1:SetActive(self.isMin)
  self.ui.Group_Line2:SetActive(not self.isMax)
  local scale = self.isMax and 1 or 0.8
  local scaleVec = CS.UnityEngine.Vector3(scale, scale, 1)
  self.ui.Image_Dis.transform.localScale = scaleVec
  self.ui.Image_Nor.transform.localScale = scaleVec
  self.ui.Group_Sel.transform.localScale = scaleVec
  self.ui.Text_Lv.transform.localScale = scaleVec
  binder:BindToRaw(function(childBinder, watchValues)
    local likeLv = watchValues[1]
    local breakthroughLv = watchValues[2]
    local show = likeLv >= self.cfg.AwakerFavorabilityLevel
    self.ui.Group_Nor:SetActive(show)
    self.ui.Group_Dis:SetActive(not show)
    if self.ui.Text_Lv then
      self.ui.Text_Lv:SetActive(not self.isMax or not show)
    end
    if self.ui.Image_Lv then
      self.ui.Image_Lv:SetActive(self.isMax and show)
    end
    self.ui.Image_LineLight01:SetActive(show)
    self.ui.Image_LineLight02:SetActive(show)
    if self.ui.Image_Dis then
      local disRes = self.isLvMax and IMAGE_PATH.DIS_HIGH or IMAGE_PATH.DIS_LOW
      childBinder:SetImage(self.ui.Image_Dis, disRes)
    end
    if self.ui.Image_Nor then
      local norRes
      if self.isLvMax then
        norRes = IMAGE_PATH.NOR_MAX
      elseif self.isBreakthroughLevel then
        norRes = IMAGE_PATH.NOR_MID
      else
        norRes = IMAGE_PATH.NOR_LOW
      end
      childBinder:SetImage(self.ui.Image_Nor, norRes)
    end
    self.ui.Group_Lock:SetActive(false)
    if self.isBreakthroughLevel then
      local isUnlocked = breakthroughLv >= self.cfg.AwakerFavorabilityLevel
      if self.ui.Group_Lock then
        self.ui.Group_Lock:SetActive(not isUnlocked)
      end
    end
  end, function()
    return {
      self.model:GetAwakerLikeLv(),
      self.model:GetBreakthroughLevel()
    }
  end)
  binder:BindEvent(EventMgr.Instance.AwakerAffecttionEvent, function()
    self:UpdateRedPoint()
  end)
  self:UpdateRedPoint()
end

function AwakerAffectionItem:UpdateRedPoint()
  local lv = self.cfg.AwakerFavorabilityLevel
  local awakerId = self.model:GetSelectAwakerId()
  local show = RedPointDataUtils.IsAwakerAffectionRedShow(awakerId, lv) or RedPointDataUtils.IsAwakerAffectionBreakthroughRedShow(awakerId, lv)
  if not self.ui_Red then
    self.ui_Red = Com_RedDotResource(self.ui.Com_RedDot)
  end
  self.ui_Red.Group_RedDot:SetActive(show)
end

return AwakerAffectionItem
