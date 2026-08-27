local UINActivitySeasonBonusCycleItem = class("UINActivitySeasonBonusCycleItem", UIBaseNode)
local base = UIBaseNode

function UINActivitySeasonBonusCycleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_icon, self, self.OnClickRewardShow)
end

function UINActivitySeasonBonusCycleItem:InitBounsCycleItem(activitySeasonData, callback)
  self._data = activitySeasonData
  self._callback = callback
  self._cycleExpLimit = self._data:GetSeasonRewardCycleExpLimit()
  local mainCfg = self._data:GetSeasonMainCfg()
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(mainCfg.cir_des)
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(mainCfg.cirRewardIds[1])
  self:RefreshBounsCycleItem()
end

function UINActivitySeasonBonusCycleItem:RefreshBounsCycleItem()
  local curLevel = self._data:GetSeasonRewardCurLv()
  local maxLevel = self._data:GetSeasonRewardLvLimit()
  if curLevel < maxLevel then
    self.ui.canvasGroup.alpha = 0.9
    self.ui.tex_Num.text = "0"
    self.ui.img_ExpProgress.fillAmount = 0
    self.ui.tex_ExpProgress:SetIndex(0, "0", tostring(self._cycleExpLimit))
    return
  end
  self.ui.canvasGroup.alpha = 1
  local exp = self._data:GetSeasonRewardCurExp()
  local count = exp // self._cycleExpLimit
  local curExp = exp % self._cycleExpLimit
  self.ui.tex_Num.text = tostring(count)
  self.ui.img_ExpProgress.fillAmount = curExp / self._cycleExpLimit
  self.ui.tex_ExpProgress:SetIndex(0, tostring(curExp), tostring(self._cycleExpLimit))
end

function UINActivitySeasonBonusCycleItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback()
  end
end

function UINActivitySeasonBonusCycleItem:OnClickRewardShow()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassRewardPreview, function(window)
    if window == nil then
      return
    end
    local mainCfg = self._data:GetSeasonMainCfg()
    window:InitBPRewardPreview(mainCfg.cirRewardIds[1], mainCfg.cirRewardPreviewIds, mainCfg.cirRewardPreviewNums)
  end)
end

return UINActivitySeasonBonusCycleItem
