local UINDailyDungeonQuickBattle = class("UINDailyDungeonQuickBattle", UIBaseNode)
local base = UIBaseNode
local UINDailyDungeonQuickBattleItem = require("Game.DailyDungeon.UI.LevelSelect.UINDailyDungeonQuickBattleItem")
local cs_MovieManager = CS.MovieManager.Instance

function UINDailyDungeonQuickBattle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._onClickClose = BindCallback(self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, nil, self._onClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Clear, nil, self._onClickClose)
  UIUtil.AddButtonListener(self.ui.background, nil, self._onClickClose)
  self.ui.list.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.list.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._itemDic = {}
end

function UINDailyDungeonQuickBattle:InitDailyQuickBattle(matDungeonCfg, startNum, dungeonElems)
  UIUtil.SetTopStatus(self, self.QuickQuit, nil, nil, nil, true)
  self._scrollIndex = 0
  self._isInAutoShow = true
  self._stageList = {}
  self._startNum = startNum
  self._dungeonElems = dungeonElems
  local battleDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  self._isDouble = battleDyncElem:DgDyncIsHaveMultReward()
  for i = startNum, #matDungeonCfg.stage_id do
    local stageId = matDungeonCfg.stage_id[i]
    local stageCfg = ConfigData.battle_dungeon[stageId]
    table.insert(self._stageList, stageCfg)
  end
  self.ui.list.totalCount = #self._dungeonElems
  self.ui.list:RefillCells()
  if self._moviePlayer == nil then
    self._moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  local avgPath = PathConsts:GetAvgVideoPath("dailyDungeonQuickBattle")
  self._moviePlayer:SetVideoRender(self.ui.videoHodler)
  self._moviePlayer:PlayVideo(avgPath)
  self._moviePlayer:SetLoopSeek(0, 59)
  self:__ShowItem(1.2)
end

function UINDailyDungeonQuickBattle:__OnInstantiateItem(go)
  local item = UINDailyDungeonQuickBattleItem.New()
  item:Init(go)
  self._itemDic[go] = item
end

function UINDailyDungeonQuickBattle:__OnChangeItem(go, index)
  local item = self._itemDic[go]
  local stageCfg = self._stageList[index + 1]
  local dungeonElem = self._dungeonElems[index + 1]
  local stageIndex = index + self._startNum
  item:InitDailyQuickBattleItem(stageCfg, stageIndex, self._isDouble, dungeonElem.commonRewards)
  if self._isInAutoShow then
    item:ShowDailyQuickBattleItem(index <= self._scrollIndex)
  end
end

function UINDailyDungeonQuickBattle:__ShowItem(time)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self.ui.rect.raycastTarget = false
  self.ui.btn_Clear.gameObject:SetActive(false)
  self.ui.obj_Finish:SetActive(false)
  self._timerId = TimerManager:StartTimer(time, function()
    self._scrollIndex = self._scrollIndex + 1
    local index = self._scrollIndex
    local go = self.ui.list:GetCellByIndex(index - 1)
    if go ~= nil then
      local item = self._itemDic[go]
      item:ShowDailyQuickBattleItem(true)
    end
    self.ui.list:LocationItem(index - 1, 500)
    if self._dungeonElems[index + 1] == nil then
      TimerManager:StopTimer(self._timerId)
      self._timerId = nil
      self._moviePlayer:CancelLoopSeek()
      self._moviePlayer:PresetsPauseVideoFrameNo(59)
      self._moviePlayer:SetPauseVideoCallback(function()
        self.ui.obj_Finish:SetActive(true)
        self._isInAutoShow = false
        self.ui.rect.raycastTarget = true
        self.ui.btn_Clear.gameObject:SetActive(true)
      end)
    elseif index == 1 then
      self:__ShowItem(2.5)
    end
  end)
end

function UINDailyDungeonQuickBattle:__ShowQuick()
  self._isInAutoShow = false
  self.ui.rect.raycastTarget = true
  self.ui.btn_Clear.gameObject:SetActive(true)
  self.ui.obj_Finish:SetActive(true)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  for _, item in pairs(self._itemDic) do
    item:ShowDailyQuickBattleItem(true)
  end
  self.ui.list:LocationItem(#self._dungeonElems - 1, 9999)
  self._moviePlayer:CancelLoopSeek()
  self._moviePlayer:PresetsPauseVideoFrameNo(59)
end

function UINDailyDungeonQuickBattle:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINDailyDungeonQuickBattle:QuickQuit(toHome)
  if not toHome and self._isInAutoShow then
    self:__ShowQuick()
    UIUtil.SetTopStatus(self, self.QuickQuit, nil, nil, nil, true)
    return
  end
  if self._moviePlayer ~= nil then
    self._moviePlayer:ReSet()
    cs_MovieManager:ReturnMoviePlayer(self._moviePlayer)
    self._moviePlayer = nil
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self:Hide()
end

function UINDailyDungeonQuickBattle:OnDelete()
  if self._moviePlayer ~= nil then
    self._moviePlayer:ReSet()
    cs_MovieManager:ReturnMoviePlayer(self._moviePlayer)
    self._moviePlayer = nil
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  base.OnDelete(self)
end

return UINDailyDungeonQuickBattle
