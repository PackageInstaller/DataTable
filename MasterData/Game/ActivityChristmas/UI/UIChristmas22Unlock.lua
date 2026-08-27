local base = UIBaseWindow
local UIChristmas22Unlock = class("UIChristmas22Unlock", base)
local ActCommonEnum = require("Game.Common.Activity.ActCommonEnum")

function UIChristmas22Unlock:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.OnClickNext)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickJump)
end

function UIChristmas22Unlock:Christmas22UnlockBindFunc(avgFunc, envFunc, dunFunc)
  self._avgFunc = avgFunc
  self._envFunc = envFunc
  self._dunFunc = dunFunc
end

function UIChristmas22Unlock:InitChristmas22NewUnlock(unlockInfo, actData)
  self._nextIndex = 1
  self._unlockInfo = unlockInfo
  self._infoList = unlockInfo:GetActUnlockInfoList()
  self._actData = actData
  self:__ShowMessage()
end

function UIChristmas22Unlock:__ShowMessage()
  local info = self._infoList[self._nextIndex]
  if info == nil then
    return
  end
  if info.unlockType == ActCommonEnum.ActUnlockType.NormalAvg then
    local avgCfg = ConfigData.story_avg[info.unlockId]
    if avgCfg ~= nil then
      local showIndex = avgCfg.number
      local desName = LanguageUtil.GetLocaleText(avgCfg.name)
      self.ui.tex_Unlock:SetIndex(1, tostring(showIndex), desName)
    end
  elseif info.unlockType == ActCommonEnum.ActUnlockType.EnvDifficulty then
    local actId = self._actData:GetActId()
    local diffInfoCfg = ConfigData.activity_hallowmas_stage_info[actId][info.unlockId]
    local envCfg = ConfigData.activity_hallowmas_general_env[info.unlockPara]
    if envCfg ~= nil and diffInfoCfg ~= nil then
      local desName = LanguageUtil.GetLocaleText(envCfg.general_env_name)
      local diffName = LanguageUtil.GetLocaleText(diffInfoCfg.difficulty_name)
      self.ui.tex_Unlock:SetIndex(0, desName, diffName)
    end
  elseif info.unlockType == ActCommonEnum.ActUnlockType.DunRepeat then
    local stageCfg = ConfigData.battle_dungeon[info.unlockId]
    if stageCfg ~= nil then
      self.ui.tex_Unlock:SetIndex(2, LanguageUtil.GetLocaleText(stageCfg.name))
    end
  end
end

function UIChristmas22Unlock:OnClickNext()
  self._nextIndex = self._nextIndex + 1
  if self._nextIndex > #self._infoList then
    self._unlockInfo:ClearActUnlockInfo()
    UIUtil.OnClickBackByUiTab(self)
  else
    self:__ShowMessage()
  end
end

function UIChristmas22Unlock:OnClickJump()
  UIUtil.OnClickBackByUiTab(self)
  local info = self._infoList[self._nextIndex]
  if not self._actData:IsActivityRunning() then
    return
  end
  self._unlockInfo:ClearActUnlockInfo()
  if info == nil then
    return
  end
  if info.unlockType == ActCommonEnum.ActUnlockType.NormalAvg then
    if self._avgFunc ~= nil then
      self._avgFunc()
    end
  elseif info.unlockType == ActCommonEnum.ActUnlockType.EnvDifficulty then
    if self._envFunc ~= nil then
      self._envFunc()
    end
  elseif info.unlockType == ActCommonEnum.ActUnlockType.DunRepeat and self._dunFunc ~= nil then
    self._dunFunc()
  end
end

function UIChristmas22Unlock:OnDelete()
  base.OnDelete(self)
end

return UIChristmas22Unlock
