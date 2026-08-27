local UINMiniGameGroupList = class("UINMiniGameGroupList", UIBaseNode)
local base = UIBaseNode
local UINMiniGameGroupItem = require("Game.ActivityHistoryTinyGame.UI.UINMiniGameGroupItem")
local CS_ResLoader = CS.ResLoader

function UINMiniGameGroupList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINMiniGameGroupItem, self.ui.gameItem)
  self.ui.gameItem:SetActive(false)
  self.__OnEnterMiniGameCallback = BindCallback(self, self.__OnEnterMiniGame)
  self.resLoader = CS_ResLoader.Create()
end

function UINMiniGameGroupList:InitMiniGameGroup(actHTGData)
  self._actHTGData = actHTGData
  self.ui.actName.text = self._actHTGData:GetActivityName()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  local actFrameId = self._actHTGData:GetActFrameId()
  self._itemPool:HideAll()
  for index, gameType in ipairs(self._actHTGData:GetTGCfgData().tiny_game_type) do
    local item = self._itemPool:GetOne()
    local data = self._actHTGData:GetHTGData(gameType)
    item:InitMiniGameGroupItem(data, self.resLoader, self.__OnEnterMiniGameCallback)
    item:PlayMiniGroupItemAni(index * 0.033)
  end
  self._timerId = TimerManager:StartTimer(1, self.__CountDown, self)
  self:__CountDown()
end

function UINMiniGameGroupList:__CountDown()
  if self._nextTime == nil or PlayerDataCenter.timestamp > self._nextTime then
    if PlayerDataCenter.timestamp > self._actHTGData:GetActivityDestroyTime() then
      if self._timerId ~= nil then
        TimerManager:StopTimer(self._timerId)
        self._timerId = nil
      end
      for i, v in ipairs(self._itemPool.listItem) do
        v:SetHTGMiniGameLocked(true)
      end
      return
    end
    local desIndex
    if PlayerDataCenter.timestamp < self._actHTGData:GetActivityEndTime() then
      self._nextTime = self._actHTGData:GetActivityEndTime()
      for i, v in ipairs(self._itemPool.listItem) do
        v:SetHTGMiniGameLocked(false)
      end
      desIndex = 0
    else
      self._nextTime = self._actHTGData:GetActivityDestroyTime()
      for i, v in ipairs(self._itemPool.listItem) do
        v:SetHTGMiniGameLocked(true)
      end
      desIndex = 1
    end
    local date = TimeUtil:TimestampToDate(self._nextTime, false, true)
    self.ui.text_time:SetIndex(desIndex, string.format("%02d", date.month), string.format("%02d", date.day), string.format("%02d", date.hour), string.format("%02d", date.min))
  end
  local diffCount = self._nextTime - PlayerDataCenter.timestamp
  local d, h, m = TimeUtil:TimestampToTimeInter(diffCount, false, true)
  if 0 < d then
    self.ui.tex_TimeLeft:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.tex_TimeLeft:SetIndex(1, tostring(h))
  else
    self.ui.tex_TimeLeft:SetIndex(2, tostring(m))
  end
end

function UINMiniGameGroupList:__OnEnterMiniGame(miniGameData)
  if self._actHTGData:IsActivityRunning() then
    self._actHTGData:PlayHTG(miniGameData:GetTinyGameType())
  end
end

function UINMiniGameGroupList:OnDelete()
  base.OnDelete(self)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self.resLoader:Put2Pool()
  self.resLoader = nil
end

return UINMiniGameGroupList
