local base = require("Game.ActivitySpring.UI.UISpring23Unlock")
local UIActivitySeasonUnlock = class("UIActivitySeasonUnlock", base)
local ActCommonEnum = require("Game.Common.Activity.ActCommonEnum")

function UIActivitySeasonUnlock:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseUnlock)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickJump)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.OnClickBG)
  self.ui.tex_UnlockExtra.gameObject:SetActive(false)
end

function UIActivitySeasonUnlock:BindSeasonUnlockFunc(avgCheckFunc, avgJumpFunc, repeatCheckFunc, repeatJumpFunc)
  self._avgCheckFunc = avgCheckFunc
  self._avgJumpFunc = avgJumpFunc
  self._repeatCheckFunc = repeatCheckFunc
  self._repeatJumpFunc = repeatJumpFunc
end

function UIActivitySeasonUnlock:ShowNext()
  self._index = self._index + 1
  local unlockElemt = self._unlockList[self._index]
  if unlockElemt.unlockType == ActCommonEnum.ActUnlockType.NormalAvg then
    local avgCfg = ConfigData.story_avg[unlockElemt.unlockId]
    if avgCfg ~= nil then
      local showIndex = avgCfg.number
      local desName = LanguageUtil.GetLocaleText(avgCfg.name)
      self.ui.tex_Unlock:SetIndex(0, desName)
    end
    self:__PlayTween()
  elseif unlockElemt.unlockType == ActCommonEnum.ActUnlockType.DunRepeat then
    local stageCfg = ConfigData.battle_dungeon[unlockElemt.unlockId]
    if stageCfg ~= nil then
      self.ui.tex_Unlock:SetIndex(0, LanguageUtil.GetLocaleText(stageCfg.name))
    end
    self:__PlayTween()
  else
    self:OnClickBG()
  end
end

function UIActivitySeasonUnlock:OnClickJump()
  local unlockElemt = self._unlockList[self._index]
  if unlockElemt == nil then
    return
  end
  UIUtil.OnClickBackByUiTab(self)
  if unlockElemt.unlockType == ActCommonEnum.ActUnlockType.NormalAvg then
    if self._avgCheckFunc ~= nil and not self._avgCheckFunc() then
      return
    end
    if self._avgJumpFunc ~= nil then
      self._avgJumpFunc()
    end
  elseif unlockElemt.unlockType == ActCommonEnum.ActUnlockType.DunRepeat then
    if self._repeatCheckFunc ~= nil and not self._repeatCheckFunc() then
      return
    end
    if self._repeatJumpFunc ~= nil then
      self._repeatJumpFunc()
    end
  end
end

return UIActivitySeasonUnlock
