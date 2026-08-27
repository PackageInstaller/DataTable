local UINSteinsGateMiniGameRank = class("UINSteinsGateMiniGameRank", UIBaseNode)
local base = UIBaseNode
local UINSGMiniGameRankItem = require("Game.ActivitySteinsGateMiniGame.UI.Rank.UINSGMiniGameRankItem")
local ActSGMiniGameEnum = require("Game.ActivitySteinsGateMiniGame.Data.ActSGMiniGameEnum")
local TinyGameUtil = require("Game.TinyGames.TinyGameUtil")

function UINSteinsGateMiniGameRank:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.background, self, self.BackAction)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.BackAction)
  UIUtil.AddButtonListener(self.ui.btn_Big, self, self.OnClickMashUp)
  UIUtil.AddButtonListener(self.ui.btn_Small, self, self.OnClickMashDown)
  self.ui.rankFrame.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.rankFrame.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.rankItemDic = {}
end

function UINSteinsGateMiniGameRank:InitSteinsGateMiniGameRank(actData, gameType, closeCallback)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.CloseFunc):SetTopStatusVisible(false):PushTopStatusDataToBackStack(true)
  self.actData = actData
  self.gameType = nil
  self.closeCallback = closeCallback
  self.mashUpGameData = self.actData:GetSteinsGateTinyGameData(ActSGMiniGameEnum.GameType.MashUp)
  self.mashDownGameData = self.actData:GetSteinsGateTinyGameData(ActSGMiniGameEnum.GameType.MashDown)
  if gameType == ActSGMiniGameEnum.GameType.MashDown or nil then
    self:OnClickMashDown()
  else
    self:OnClickMashUp()
  end
end

function UINSteinsGateMiniGameRank:RefreshSGMiniGameRankDetail()
  local nowData = self.gameType == ActSGMiniGameEnum.GameType.MashDown and self.mashDownGameData or self.mashUpGameData
  local allFriendRanks, mineGrade = nowData:GetTinyGameRankInfo()
  self.allFriendRanks = allFriendRanks
  self.mineGrade = mineGrade
  self.mineGrade.rank = TinyGameUtil.SortTinyGameRankDatas(self.allFriendRanks, self.mineGrade)
  self.ui.rankFrame.totalCount = #self.allFriendRanks
  self.ui.rankFrame:RefillCells()
  self.ui.tex_MyRank.text = string.format("%02d", self.mineGrade.rank)
  self.ui.tex_MyScore.text = tostring(self.mineGrade.score)
end

function UINSteinsGateMiniGameRank:__OnNewItem(go)
  local rankItem = UINSGMiniGameRankItem.New()
  rankItem:Init(go)
  self.rankItemDic[go] = rankItem
end

function UINSteinsGateMiniGameRank:__OnChangeItem(go, index)
  local rankItem = self.rankItemDic[go]
  if rankItem == nil then
    error("Can't find rankItem by gameObject")
    return
  end
  local info = self.allFriendRanks[index + 1]
  rankItem:InitSGMiniGameRankItem(info, index + 1)
end

function UINSteinsGateMiniGameRank:OnClickMashUp()
  if self.gameType == ActSGMiniGameEnum.GameType.MashUp then
    return
  end
  self.ui.img_Big:SetIndex(1)
  self.ui.img_Small:SetIndex(0)
  self.gameType = ActSGMiniGameEnum.GameType.MashUp
  self:RefreshSGMiniGameRankDetail()
end

function UINSteinsGateMiniGameRank:OnClickMashDown()
  if self.gameType == ActSGMiniGameEnum.GameType.MashDown then
    return
  end
  self.ui.img_Big:SetIndex(0)
  self.ui.img_Small:SetIndex(1)
  self.gameType = ActSGMiniGameEnum.GameType.MashDown
  self:RefreshSGMiniGameRankDetail()
end

function UINSteinsGateMiniGameRank:CloseFunc()
  self:Hide()
  if self.closeCallback then
    self.closeCallback()
  end
end

function UINSteinsGateMiniGameRank:BackAction()
  UIUtil.OnClickBackByUiTab(self)
end

function UINSteinsGateMiniGameRank:OnDelete()
end

return UINSteinsGateMiniGameRank
