local PlayerHandbookData = PlayerData.Handbook
local PlayerCharSkinData = class("PlayerCharSkinData")
local TimerManager = require("GameCore.Timer.TimerManager")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local ClientManager = CS.ClientManager.Instance
local tableInsert = table.insert
local tableRemove = table.remove
local SkinData = require("GameCore.Data.DataClass.SkinData")

function PlayerCharSkinData:Init()
  self.tbSkinDataList = {}
  self.tbSkinGainQueue = {}
end

function PlayerCharSkinData:UpdateSkinData(skinId, handbookId, unlock)
  if nil == self.tbSkinDataList[skinId] then
    local skinData = SkinData.new(skinId, handbookId, unlock)
    self.tbSkinDataList[skinId] = skinData
  else
    local nLastState = self.tbSkinDataList[skinId].nUnlock
    self.tbSkinDataList[skinId]:UpdateUnlockState(unlock)
    if nLastState ~= unlock then
      local mapSkinCfg = ConfigTable.GetData("CharacterSkin", skinId)
      if mapSkinCfg == nil then
        return
      end
      PlayerData.Char:UpdateCharSkinVoiceReddot(false, mapSkinCfg.CharId, skinId)
      PlayerData.Char:UpdateCharPlotReddot(mapSkinCfg.CharId)
    end
  end
end

function PlayerCharSkinData:GetSkinListByCharacterId(charId)
  local tbSkinList = {}
  for skinId, skin in pairs(self.tbSkinDataList) do
    if skin:GetCharId() == charId then
      tbSkinList[skinId] = skin
    end
  end
  return tbSkinList
end

function PlayerCharSkinData:GetSkinDataBySkinId(skinId)
  return self.tbSkinDataList[skinId]
end

function PlayerCharSkinData:CheckSkinUnlock(skinId)
  if self.tbSkinDataList[skinId] ~= nil then
    return self.tbSkinDataList[skinId]:CheckUnlock()
  end
  return false
end

function PlayerCharSkinData:SkinGainEnqueue(mapMsgData)
  local bNew = nil ~= mapMsgData.New
  local nSkinId = nil ~= mapMsgData.New and mapMsgData.New.Value or mapMsgData.Duplicated.ID
  local tbItemList = {}
  if nil ~= mapMsgData.Duplicated then
    tbItemList = mapMsgData.Duplicated.Items
  end
  local tbData = {
    nId = nSkinId,
    bNew = bNew,
    tbItemList = tbItemList or {}
  }
  tableInsert(self.tbSkinGainQueue, tbData)
end

function PlayerCharSkinData:RemoveSkinQueue(nId)
  for i = #self.tbSkinGainQueue, 1, -1 do
    if self.tbSkinGainQueue[i].nId == nId then
      tableRemove(self.tbSkinGainQueue, i)
    end
  end
end

function PlayerCharSkinData:TryOpenSkinShowPanel(callback)
  if #self.tbSkinGainQueue == 0 then
    if callback ~= nil then
      callback()
    end
    return false
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveSpecialReward, self.tbSkinGainQueue, callback)
  return true
end

function PlayerCharSkinData:CheckNewSkin()
  return #self.tbSkinGainQueue > 0
end

function PlayerCharSkinData:GetSkinForReward()
  local tbSpReward = {}
  if #self.tbSkinGainQueue == 0 then
    return tbSpReward
  end
  tbSpReward = clone(self.tbSkinGainQueue)
  self.tbSkinGainQueue = {}
  return tbSpReward
end

function PlayerCharSkinData:UpdateSkinUnlock(unlockList)
end

return PlayerCharSkinData
