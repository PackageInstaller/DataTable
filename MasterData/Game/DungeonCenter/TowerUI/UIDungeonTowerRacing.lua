local UIDungeonTowerRacing = class("UIDungeonTowerRacing", UIBaseWindow)
local base = UIBaseWindow
local UINDunTowerRacingItem = require("Game.DungeonCenter.TowerUI.UINDunTowerRacingItem")

function UIDungeonTowerRacing:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self._OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnBtnCloseClicked)
  self._racingTaskPool = UIItemPool.New(UINDunTowerRacingItem, self.ui.taskItem, false)
  self.__onRacingRewardPick = BindCallback(self, self._OnRacingRewardPick)
end

function UIDungeonTowerRacing:InitTowerRacing(towerTypeData)
  self._towerTypeData = towerTypeData
  local towerId = towerTypeData:GetDungeonTowerTypeId()
  self._towerId = towerId
  local isComplete, totalFrame = PlayerDataCenter.dungeonTowerSData:GetTowerTotalRacingFrame(towerId)
  self._isComplete = isComplete
  self._totalFrame = totalFrame
  if isComplete then
    self.ui.tex_TotalTime:SetIndex(0, BattleUtil.FrameToTimeString(totalFrame, true))
  else
    self.ui.tex_TotalTime:SetIndex(1)
  end
  self:_InitRacingTaskList()
end

function UIDungeonTowerRacing:_InitRacingTaskList()
  local isComplete, totalFrame = self._isComplete, self._totalFrame
  self._racingTaskPool:HideAll()
  local towerRacingCfg = self._towerTypeData:GetTowerRacingCfg()
  if towerRacingCfg == nil then
    return
  end
  local pickedList = {}
  for id, racingCfg in pairs(towerRacingCfg) do
    local isPicked = PlayerDataCenter.dungeonTowerSData:IsTowerRacingRewardPick(self._towerId, racingCfg.reward_id)
    local achieve = false
    if isPicked then
      table.insert(pickedList, id)
    else
      local frame = BattleUtil.SecondToFrame(racingCfg.time_limit)
      achieve = isComplete and totalFrame <= frame
      local racingTaskItem = self._racingTaskPool:GetOne()
      racingTaskItem:InitRacintTaskItem(racingCfg, false, achieve, self.__onRacingRewardPick)
    end
  end
  for _, id in pairs(pickedList) do
    local racingCfg = towerRacingCfg[id]
    local racingTaskItem = self._racingTaskPool:GetOne()
    racingTaskItem:InitRacintTaskItem(racingCfg, true, false, self.__onRacingRewardPick)
  end
end

function UIDungeonTowerRacing:_OnRacingRewardPick(racingCfg, racingTaskItem)
  local dunTowerNetwork = NetworkManager:GetNetwork(NetworkTypeID.DungeonTower)
  dunTowerNetwork:CS_DUNGEONTOWER_Pick(self._towerId, racingCfg.reward_id, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      self:_InitRacingTaskList()
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(racingCfg.reward_ids, racingCfg.reward_nums)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function UIDungeonTowerRacing:_OnBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonTowerRacing:OnDelete()
  base.OnDelete(self)
end

return UIDungeonTowerRacing
