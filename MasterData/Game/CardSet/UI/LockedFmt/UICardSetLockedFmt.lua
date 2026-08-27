local UICardSetLockedFmt = class("UICardSetLockedFmt", UIBaseWindow)
local base = UIBaseWindow
local UINCardSetLockedFmtTeamItem = require("Game.CardSet.UI.LockedFmt.UINCardSetLockedFmtTeamItem")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UICardSetLockedFmt:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BcakAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.background, self, self.__BcakAction)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__BcakAction)
  self.teamItemPool = UIItemPool.New(UINCardSetLockedFmtTeamItem, self.ui.obj_teamItem, false)
  self._resloader = CS.ResLoader.Create()
end

function UICardSetLockedFmt:InitCardSetLockedFmt(cardSetData)
  self.cardSetData = cardSetData
  self:__RefreshTeamItems()
end

function UICardSetLockedFmt:__RefreshTeamItems()
  self.teamItemPool:HideAll()
  local playType = self.cardSetData:GetCardSetCurPlayType()
  if playType == CardSetEnum.eSetType.rank then
    self:_UpdRankTeam()
    return
  end
  local round = self.cardSetData:GetCardSetCurRound()
  local bannedForms = self.cardSetData:GetCardSetBannedTeamData()
  if bannedForms ~= nil then
    for index, formMsg in ipairs(bannedForms) do
      local teamItem = self.teamItemPool:GetOne(true)
      teamItem:InitCardSetBannedTeamItem(formMsg.heroIds, formMsg.fairyUid, round, index, self._resloader)
    end
  end
end

function UICardSetLockedFmt:_UpdRankTeam()
  local roundDataList = self.cardSetData:GetCsRankRoundDataList()
  local curRoundId = self.cardSetData:GetCsRankRoundId()
  for k, roundData in ipairs(roundDataList) do
    local roundId = roundData:GetCsRankRoundId()
    if roundId ~= curRoundId then
      local heroList = roundData:GetCsRankRoundHeroList()
      local fairyData = roundData:GetCsRankRoundFairyData()
      if #heroList ~= 0 then
        local teamItem = self.teamItemPool:GetOne(true)
        teamItem:InitCardSetRankBannedTeamItem(heroList, fairyData, roundId, self._resloader)
      end
    end
  end
end

function UICardSetLockedFmt:__BcakAction()
  self:Delete()
end

function UICardSetLockedFmt:OnDelete()
  if self._resloader then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self.teamItemPool:DeleteAll()
  base.OnDelete(self)
end

return UICardSetLockedFmt
