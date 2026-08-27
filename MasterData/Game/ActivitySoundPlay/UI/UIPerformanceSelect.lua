local base = UIBaseWindow
local UIPerformanceSelect = class("UIPerformanceSelect", base)
local UIPerformanceSelectMusicItem = require("Game.ActivitySoundPlay.UI.UIPerformanceSelectMusicItem")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local TinyGameUtil = require("Game.TinyGames.TinyGameUtil")

function UIPerformanceSelect:OnInit()
  self._selectMusicItemPool = UIItemPool.New(UIPerformanceSelectMusicItem, self.ui.selectMusicItem)
  self.ui.selectMusicItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickShowSoundPlayScoreRank)
  self.__OnPerformanceChange = BindCallback(self, self.OnPerformanceChange)
  MsgCenter:AddListener(eMsgEventId.TinyGameDataChange, self.__OnPerformanceChange)
  local topStatusData = UIUtil.CreateNewTopStatusData(self)
  topStatusData.topBtnOnlyReturn = true
  topStatusData:SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true):PushTopStatusDataToBackStack(true)
end

function UIPerformanceSelect:InitPerformanceSelect()
  ConfigData:LoadDynCfg(eDynConfigData.activity_instrument_rhythm)
  self.tinigameData = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true):GetTinyGameSoundPlayData()
  self:RefreshMusicList()
  self:RefreshTotalScore()
end

function UIPerformanceSelect:OnPerformanceChange()
  self:RefreshMusicList()
  self:RefreshTotalScore()
end

function UIPerformanceSelect:RefreshMusicList()
  self._selectMusicItemPool:HideAll()
  local allRhythmcfg = ConfigData.activity_instrument_rhythm
  for id, rhythmcfg in ipairs(allRhythmcfg) do
    local item = self._selectMusicItemPool:GetOne()
    local score = self.tinigameData:GetTinyGameSubLevelHistoryScore(id)
    item:InitSkinLimitTaskItem(rhythmcfg, score)
  end
end

function UIPerformanceSelect:RefreshTotalScore()
  local totalScore = self.tinigameData:GetTotalMusicScore()
  self.ui.tex_Score.text = totalScore
end

function UIPerformanceSelect:OnClickShowSoundPlayScoreRank()
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(function()
      local allFriendRanks, mineGrade = self.tinigameData:GetTinyGameRankInfo()
      local rankIndex = TinyGameUtil.SortTinyGameRankDatas(allFriendRanks, mineGrade)
      UIManager:ShowWindowAsync(UIWindowTypeID.PerformanceRank, function(win)
        if win == nil then
          return
        end
        win:RefreshPerformanceRank(allFriendRanks, mineGrade, rankIndex)
      end)
    end)
  else
    local allFriendRanks, mineGrade = self.tinigameData:GetTinyGameRankInfo()
    local rankIndex = TinyGameUtil.SortTinyGameRankDatas(allFriendRanks, mineGrade)
    UIManager:ShowWindowAsync(UIWindowTypeID.PerformanceRank, function(win)
      if win == nil then
        return
      end
      win:RefreshPerformanceRank(allFriendRanks, mineGrade, rankIndex)
    end)
  end
end

function UIPerformanceSelect:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TinyGameDataChange, self.__OnPerformanceChange)
  self._selectMusicItemPool:DeleteAll()
  self._selectMusicItemPool = nil
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_instrument_rhythm)
end

return UIPerformanceSelect
