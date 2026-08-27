local base = UIBaseNode
local UINWarChessInfoOpNode = class("UINWarChessInfoOpNode", base)
local UINWarChessInfoOpNodeBtn = require("Game.WarChess.UI.Info.UINWarChessInfoOpNodeBtn")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function UINWarChessInfoOpNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.btnPool = UIItemPool.New(UINWarChessInfoOpNodeBtn, self.ui.obj_btn_Info)
  self.btnPool:SetItemPoolHideName("h")
  self.ui.obj_btn_Info:SetActive(false)
end

function UINWarChessInfoOpNode:CleanWCOPRoot()
  self.__actCallback = nil
  self.__infoActCallback = nil
  self.btnPool:HideAll()
end

function UINWarChessInfoOpNode:SetWCAct(actCallback, interactCfg, costAP, isMonster, getIsSecKill)
  local function SetInterAct(isSecKill)
    self.__isWaitingCouldSecKill = false
    
    local interActBtn = self.btnPool:GetOne()
    local index = isMonster and 1 or 2
    if isMonster then
      if isSecKill then
        index = 5
      else
        index = 1
      end
    else
      index = 2
    end
    interActBtn:SetInterActionType(index, costAP)
    interActBtn:SetClickCallback(function()
      if actCallback ~= nil then
        actCallback(interactCfg)
      end
      self:Hide()
    end)
    self.__interActBtn = interActBtn
    if self.__whenWaitOverClkik then
      self:WCOpDoubleClick()
      self.__whenWaitOverClkik = false
    end
  end
  
  if isMonster and getIsSecKill ~= nil then
    self.__isWaitingCouldSecKill = true
    getIsSecKill(SetInterAct)
  else
    SetInterAct(false)
  end
end

function UINWarChessInfoOpNode:SetWCShowDynDeployTeam()
  local infoActBtn = self.btnPool:GetOne()
  infoActBtn:SetInterActionType(3)
  infoActBtn:SetClickCallback(function()
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl:IsWCInSubSystem() then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8516))
      return
    end
    if wcCtrl.backPackCtrl:GetWCDeployPointNum() < 1 then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8523))
    end
    wcCtrl:ChangeWarChessState(eWarChessEnum.eWarChessState.deploy, {isDynDeploy = true})
    self:Hide()
  end)
  self.__infoActBtn = infoActBtn
end

function UINWarChessInfoOpNode:SetWCCustomInteract(actCallback, costAP, typeIndex)
  local infoActBtn = self.btnPool:GetOne()
  infoActBtn:SetInterActionType(typeIndex, costAP)
  infoActBtn:SetClickCallback(function()
    if actCallback ~= nil then
      actCallback()
    end
    self:Hide()
  end)
  self.__infoActBtn = infoActBtn
end

function UINWarChessInfoOpNode:SetWCUseCallback(callback)
  self.__hideCallback = callback
end

function UINWarChessInfoOpNode:WCOpDoubleClick()
  if self.__interActBtn ~= nil then
    self.__interActBtn:__OnClick()
  elseif self.__isWaitingCouldSecKill then
    self.__whenWaitOverClkik = true
  elseif self.__infoActBtn ~= nil then
    self.__infoActBtn:__OnClick()
  end
end

function UINWarChessInfoOpNode:OnHide()
  if self.__hideCallback ~= nil then
    self.__hideCallback()
    self.__hideCallback = nil
  end
end

function UINWarChessInfoOpNode:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoOpNode
