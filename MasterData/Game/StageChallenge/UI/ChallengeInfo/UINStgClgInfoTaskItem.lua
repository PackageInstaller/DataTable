local UINStgClgInfoTaskItem = class("UINStgClgInfoTaskItem", UIBaseNode)
local base = UIBaseNode
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")

function UINStgClgInfoTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.tog_Switch) then
    self._switchChallengeTog = UINCommonSwitchToggle.New()
    self._switchChallengeTog:Init(self.ui.tog_Switch)
  end
end

function UINStgClgInfoTaskItem:InitStgClgInfoTaskItem(taskCfg, isComplete, isFixed, isOpen, changeOpenFunc)
  self.changeOpenFunc = changeOpenFunc
  self.taskCfg = taskCfg
  if isFixed then
    isOpen = true
  else
    self._changeChallengeFunc = self._changeChallengeFunc or BindCallback(self, self._OnClickTaskOpenTog)
    self._switchChallengeTog:InitCommonSwitchToggle(isOpen, self._changeChallengeFunc)
  end
  self:_UpdBgOpenColor(isOpen)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(taskCfg.task_intro)
  self.ui.obj_Icon:SetActive(isComplete)
  self.ui.obj_Complete:SetActive(isComplete)
  self.ui.reward:SetActive(not isComplete)
end

function UINStgClgInfoTaskItem:_UpdBgOpenColor(isOpen)
  self.ui.img_Buttom.color = self.ui.bg_ColorList[isOpen and 1 or 2]
end

function UINStgClgInfoTaskItem:_OnClickTaskOpenTog(isOn)
  self:_UpdBgOpenColor(isOn)
  if self.changeOpenFunc ~= nil then
    self.changeOpenFunc(self.taskCfg.id, isOn)
  end
end

function UINStgClgInfoTaskItem:OnDelete()
  if self._switchChallengeTog ~= nil then
    self._switchChallengeTog:Delete()
  end
  base.OnDelete(self)
end

return UINStgClgInfoTaskItem
