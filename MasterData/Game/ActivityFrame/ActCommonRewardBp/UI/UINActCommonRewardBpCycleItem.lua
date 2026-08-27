local UINActCommonRewardBpCycleItem = class("UINActCommonRewardBpCycleItem", UIBaseNode)
local base = UIBaseNode

function UINActCommonRewardBpCycleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_icon, self, self.OnClickRewardShow)
end

function UINActCommonRewardBpCycleItem:InitBounsCycleItem(activityCommonBpData, callback)
  self._data = activityCommonBpData
  self._callback = callback
  self._cycleExpLimit = self._data:GetCommonRewardCycleExpLimit()
  local cirData = self._data:GetCirRewardData()
  if cirData == nil then
    return
  end
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(cirData.cir_des)
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(cirData.cirRewardIds[1])
  self:RefreshBounsCycleItem()
end

function UINActCommonRewardBpCycleItem:RefreshBounsCycleItem()
  local curLevel = self._data:GetCommonRewardCurLv()
  local maxLevel = self._data:GetCommonRewardLvLimit()
  if curLevel < maxLevel then
    self.ui.canvasGroup.alpha = 0.9
    self.ui.tex_Num.text = "0"
    self.ui.img_ExpProgress.fillAmount = 0
    self.ui.tex_ExpProgress:SetIndex(0, "0", tostring(self._cycleExpLimit))
    return
  end
  self.ui.canvasGroup.alpha = 1
  local exp = self._data:GetCommonRewardCurExp()
  local count = exp // self._cycleExpLimit
  local curExp = exp % self._cycleExpLimit
  self.ui.tex_Num.text = tostring(count)
  self.ui.img_ExpProgress.fillAmount = curExp / self._cycleExpLimit
  self.ui.tex_ExpProgress:SetIndex(0, tostring(curExp), tostring(self._cycleExpLimit))
end

function UINActCommonRewardBpCycleItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback()
  end
end

function UINActCommonRewardBpCycleItem:OnClickRewardShow()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassRewardPreview, function(window)
    if window == nil then
      return
    end
    local mainCfg = self._data:GetSeasonMainCfg()
    window:InitBPRewardPreview(mainCfg.cirRewardIds[1], mainCfg.cirRewardPreviewIds, mainCfg.cirRewardPreviewNums)
  end)
end

return UINActCommonRewardBpCycleItem
