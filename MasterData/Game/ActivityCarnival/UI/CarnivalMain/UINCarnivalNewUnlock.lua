local UINCarnivalNewUnlock = class("UINCarnivalNewUnlock", UIBaseNode)
local base = UIBaseNode
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")

function UINCarnivalNewUnlock:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.OnClickNext)
  UIUtil.AddButtonListener(self.ui.checkBG, self, self.OnClickJump)
end

function UINCarnivalNewUnlock:CarnivalNewUnlockBindFunc(reviewStageFunc, envFunc)
  self._reviewStageFunc = reviewStageFunc
  self._envFunc = envFunc
end

function UINCarnivalNewUnlock:InitCarnivalNewUnlock(carnivalData)
  self._nextIndex = 1
  self._carnivalData = carnivalData
  self._infoList = carnivalData:GetNewunlockInfo()
  self:__ShowMessage()
end

function UINCarnivalNewUnlock:__ShowMessage()
  local info = self._infoList[self._nextIndex]
  if info == nil then
    return
  end
  if info.unlockType == ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Env then
    local envCfg = self._carnivalData:GetCarnivalEnvCfgById(info.unlockId)
    if envCfg ~= nil then
      local desName = LanguageUtil.GetLocaleText(envCfg.env_name)
      self.ui.tex_CNUnlock:SetIndex(info.unlockType - 1, desName)
    end
  elseif info.unlockType == ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Stage then
    local stageCfg = ConfigData.sector_stage[info.unlockId]
    if stageCfg ~= nil then
      local showIndex = stageCfg.num
      local desName = LanguageUtil.GetLocaleText(stageCfg.name)
      self.ui.tex_CNUnlock:SetIndex(info.unlockType - 1, tostring(showIndex), desName)
    end
  else
    local avgCfg = ConfigData.story_avg[info.unlockId]
    if avgCfg ~= nil then
      local showIndex = avgCfg.number
      local desName = LanguageUtil.GetLocaleText(avgCfg.name)
      self.ui.tex_CNUnlock:SetIndex(info.unlockType - 1, tostring(showIndex), desName)
    end
  end
end

function UINCarnivalNewUnlock:OnClickNext()
  self._nextIndex = self._nextIndex + 1
  if self._nextIndex > #self._infoList then
    self._carnivalData:ClearNewUnlockInfo()
    self:Hide()
  else
    self:__ShowMessage()
  end
end

function UINCarnivalNewUnlock:OnClickJump()
  local info = self._infoList[self._nextIndex]
  if not self._carnivalData:IsActivityRunning() and info.unlockType == ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Env then
    return
  end
  self:Hide()
  self._carnivalData:ClearNewUnlockInfo()
  if info == nil then
    return
  end
  if info.unlockType == ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Env then
    if self._envFunc ~= nil then
      self._envFunc()
    end
  elseif self._reviewStageFunc ~= nil then
    self._reviewStageFunc()
  end
end

return UINCarnivalNewUnlock
