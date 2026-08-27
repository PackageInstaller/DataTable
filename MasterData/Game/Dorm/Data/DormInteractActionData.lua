local DormInteractActionData = class("DormCharInteractData")
local DormEnum = require("Game.Dorm.DormEnum")

function DormInteractActionData:ResetData()
  self.interPointEntity = nil
  self.talkCharEntity = nil
  self.__interactFunc = nil
  self.__interactType = nil
  self._interactEnable = false
end

function DormInteractActionData:InitFntAction(interPointEntity, interactFunc)
  self._interactEnable = true
  self.interPointEntity = interPointEntity
  self.__interactFunc = interactFunc
  self.__interactType = DormEnum.CharInteractState.Fnt
end

function DormInteractActionData:InitTalkAction(charEntity, interactFunc)
  self._interactEnable = true
  self.talkCharEntity = charEntity
  self.__interactFunc = interactFunc
  self.__interactType = DormEnum.CharInteractState.Talk
end

function DormInteractActionData:InitGreetAction(charEntity, interactFunc)
  self._interactEnable = true
  self.talkCharEntity = charEntity
  self.__interactFunc = interactFunc
  self.__interactType = DormEnum.CharInteractState.Greet
end

function DormInteractActionData:InitDoorAction(interactFunc)
  self._interactEnable = true
  self.__interactFunc = interactFunc
  self.__interactType = DormEnum.CharInteractState.LeaveDoor
end

function DormInteractActionData:GetActionData()
  local desc = ""
  local spriteName = ""
  local title = ""
  local hasNew = false
  if self.__interactType == DormEnum.CharInteractState.Fnt then
    local InterPointData = self.interPointEntity:GetInterPointData()
    local fntCfg = InterPointData:GetFntCfg()
    local categoryCfg = ConfigData.dorm_fnt_category[fntCfg.category]
    desc = InterPointData.fntData:GetName()
    spriteName = categoryCfg.icon
    title = InterPointData:GetInteractName()
  elseif self.__interactType == DormEnum.CharInteractState.Talk then
    desc = self.talkCharEntity:GetRoleName()
    spriteName = "Icon_99"
    title = ConfigData:GetTipContent(2032)
    hasNew = not self.talkCharEntity:IsAllTalked()
  elseif self.__interactType == DormEnum.CharInteractState.LeaveDoor then
    desc = ConfigData:GetTipContent(2033)
    spriteName = "Icon_98"
    title = ConfigData:GetTipContent(2034)
  elseif self.__interactType == DormEnum.CharInteractState.Greet then
    desc = self.talkCharEntity:GetRoleName()
    spriteName = "Icon_99"
    title = ConfigData:GetTipContent(2035)
  end
  return desc, spriteName, title, hasNew
end

function DormInteractActionData:SetInteractActionEnable(active)
  self._interactEnable = active
end

function DormInteractActionData:GetInteractActionEnable()
  return self._interactEnable
end

function DormInteractActionData:GetInteractType()
  return self.__interactType
end

function DormInteractActionData:InvokeInteractAction()
  if self.__interactFunc ~= nil then
    self.__interactFunc(self)
  end
end

return DormInteractActionData
