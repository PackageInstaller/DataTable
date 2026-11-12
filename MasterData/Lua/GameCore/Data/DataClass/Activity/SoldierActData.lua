local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local SoldierActData = class("SoldierActData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local RedDotManager = require("GameCore.RedDot.RedDotManager")

function SoldierActData:Init()
  self:InitData()
end

function SoldierActData:InitData()
  self.bLevelNewKey = LocalData.GetPlayerLocalData("SoliderLevel_New")
  if self.bLevelNewKey == nil then
    self.bLevelNewKey = true
  end
  RedDotManager.SetValid(RedDotDefine.Solider_Level_New, nil, self.bLevelNewKey)
end

function SoldierActData:RefreshSoldierActData(nActId, msgData)
  self:InitData()
  self.nActId = nActId
  PlayerData.SoldierData:SetCurGradeChallengeData(msgData.CurGradeChallengeId, msgData.Stage, msgData.NodeIndex)
  PlayerData.SoldierData:SetHighestChallengeId(msgData.GradeChallengeId)
  PlayerData.SoldierData:SetQuestDataList(msgData.Quests)
end

function SoldierActData:RefreshQuestData(questData)
  PlayerData.SoldierData:SetQuestData(questData)
end

function SoldierActData:RefreshLevelNew()
  self.bLevelNewKey = false
  LocalData.SetPlayerLocalData("SoliderLevel_New", self.bLevelNewKey)
  RedDotManager.SetValid(RedDotDefine.Solider_Level_New, nil, self.bLevelNewKey)
end

function SoldierActData:RefreshAllQuestData(callback)
  local function callFunc()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_detail_req, {}, nil, callFunc)
end

return SoldierActData
