local UINChangeHeroName = class("UINChangeHeroName", UIBaseNode)
local base = UIBaseNode
local CS_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local MIN_INPUT = 2
local MAX_INPUT = 10

function UINChangeHeroName:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.CloseFunction)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnChangeNameConfirm)
  self.ui.heroname_inputField.characterLimit = MAX_INPUT
end

function UINChangeHeroName:UpdateDialog(heroId)
  self.heroId = heroId
  local vowCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  local heroName = vowCtrl:GetHeroName(heroId, true)
  self.ui.text_tips:SetIndex(0, heroName)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local nextTime = heroData:GetVowNextChangeNameTime()
  if nextTime <= PlayerDataCenter.timestamp or nextTime == 0 then
    self.ui.text_changeTimes.text = 1
  else
    self.ui.text_changeTimes.text = 0
  end
end

function UINChangeHeroName:OnChangeNameConfirm()
  local inputUserName = self.ui.heroname_inputField.text
  if string.IsNullOrEmpty(inputUserName) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(23002))
    return
  end
  local heroData = PlayerDataCenter:GetHeroData(self.heroId)
  if inputUserName == heroData:GetVowChangedName() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(23002))
    return
  end
  local inputLength = RenameHelper:GetNameLength(inputUserName)
  if inputLength > MAX_INPUT then
    inputUserName = RenameHelper:ClampNameInLength(inputUserName, MAX_INPUT)
    self.ui.heroname_inputField.text = inputUserName
    return
  elseif inputLength < MIN_INPUT then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(23002))
    return
  end
  ControllerManager:GetController(ControllerTypeId.VowSystem, true):ReqVowModifyName(self.heroId, inputUserName, self.CloseFunction)
end

function UINChangeHeroName:OnDelete()
  base.OnDelete(self)
end

return UINChangeHeroName
