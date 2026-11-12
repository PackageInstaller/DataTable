local PlayerTrialData = class("PlayerTrialData")
local AdventureModuleHelper = CS.AdventureModuleHelper
local Actor2DManager = require("Game.Actor2D.Actor2DManager")

function PlayerTrialData:Init()
  self.curLevel = nil
  self.bInSettlement = false
  self.nActId = nil
  self.nSelectTrialGroupId = nil
  self.sLevelTitle = nil
  self.nMode = AllEnum.TrialMode.ActivityTrial
end

function PlayerTrialData:SetTrialAct(nActId)
  self.nActId = nActId
end

function PlayerTrialData:SetTrialMode(nMode)
  self.nMode = nMode or AllEnum.TrialMode.ActivityTrial
end

function PlayerTrialData:IsActivityTrialMode()
  return self.nMode == AllEnum.TrialMode.ActivityTrial
end

function PlayerTrialData:IsSkinTrialMode()
  return self.nMode == AllEnum.TrialMode.SkinTrial
end

function PlayerTrialData:UserEventUpload_TrialBattle(nAction)
  if not self:IsSkinTrialMode() then
    return
  end
  local nGroupId = self:GetSelectTrialGroup()
  local nPlayerId = PlayerData.Base._nPlayerId
  local nSkinId
  local mapGroup = nGroupId and ConfigTable.GetData("TrialGroup", nGroupId)
  local mapTrial = mapGroup and ConfigTable.GetData("TrialCharacter", mapGroup.TrialChar)
  if mapTrial then
    nSkinId = mapTrial.CharacterSkin
  end
  if not (nGroupId and nPlayerId) or not nSkinId then
    return
  end
  local tab = {
    {
      "trial_group",
      tostring(nGroupId)
    },
    {
      "role_id",
      tostring(nPlayerId)
    },
    {
      "skin_id",
      tostring(nSkinId)
    },
    {
      "action",
      tostring(nAction)
    }
  }
  NovaAPI.UserEventUpload("trial_battle", tab)
end

function PlayerTrialData:GetTrialAct()
  return self.nActId
end

function PlayerTrialData:SetSelectTrialGroup(nGroupId)
  self.nSelectTrialGroupId = nGroupId
end

function PlayerTrialData:GetSelectTrialGroup()
  return self.nSelectTrialGroupId
end

function PlayerTrialData:CheckGroupReceived()
  if not self:IsActivityTrialMode() then
    return true
  end
  if not self.nActId or not self.nSelectTrialGroupId then
    return false
  end
  local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if not actData then
    return false
  end
  return actData:CheckGroupReceived(self.nSelectTrialGroupId)
end

function PlayerTrialData:GetNextUnreceiveGroup()
  if not self:IsActivityTrialMode() then
    return
  end
  if not self.nActId then
    return
  end
  local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if not actData then
    return
  end
  return actData:GetNextUnreceiveGroup()
end

function PlayerTrialData:SendReceiveTrialRewardReq(callback)
  if not self:IsActivityTrialMode() then
    if callback then
      callback()
    end
    return false
  end
  if not self.nActId or not self.nSelectTrialGroupId then
    callback()
    return false
  end
  local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if not actData then
    callback()
    return false
  end
  actData:SendActivityTrialRewardReceiveReq(self.nSelectTrialGroupId, callback)
end

function PlayerTrialData:EnterTrialEditor(nFloor)
  self:SetTrialMode(AllEnum.TrialMode.ActivityTrial)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Editor.Trial.TrialEditor")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    Actor2DManager.ForceUseL2D(true)
    self.curLevel:Init(self, nFloor)
  end
end

function PlayerTrialData:EnterTrial(nLevelId)
  self:SetTrialMode(AllEnum.TrialMode.ActivityTrial)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.Trial.TrialLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    Actor2DManager.ForceUseL2D(true)
    self.curLevel:Init(self, nLevelId)
  end
end

function PlayerTrialData:EnterSkinTrial(nLevelId)
  self:SetTrialAct(nil)
  self:SetTrialMode(AllEnum.TrialMode.SkinTrial)
  if self.curLevel ~= nil then
    printError("当前关卡level不为空1")
    return
  end
  local luaClass = require("Game.Adventure.Trial.TrialLevel")
  if luaClass == nil then
    return
  end
  self.curLevel = luaClass
  if type(self.curLevel.BindEvent) == "function" then
    self.curLevel:BindEvent()
  end
  if type(self.curLevel.Init) == "function" then
    Actor2DManager.ForceUseL2D(true)
    self.curLevel:Init(self, nLevelId)
  end
end

function PlayerTrialData:LevelEnd()
  Actor2DManager.ForceUseL2D(false)
  PlayerData.Build:DeleteTrialBuild()
  if nil ~= self.curLevel and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
end

function PlayerTrialData:GetCurLevel()
  if self.curLevel == nil then
    return 0
  end
  return self.curLevel.nLevelId
end

function PlayerTrialData:SetLevelTitle(sTitle)
  self.sLevelTitle = sTitle
end

function PlayerTrialData:GetLevelTitle()
  return self.sLevelTitle or ""
end

function PlayerTrialData:SetSettlementState(bInSettlement)
  self.bInSettlement = bInSettlement
end

function PlayerTrialData:GetSettlementState()
  return self.bInSettlement
end

return PlayerTrialData
