local UINWCRankPanel = class("UINWCRankPanel", UIBaseNode)
local base = UIBaseNode
local UINWCRankPanelItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanelItem")
local eType = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankRewardPanelItem").eType
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local WCEnum = require("Game.WeeklyChallenge.WCEnum")
UINWCRankPanel.eRankListType = {cur = 1, old = 2}
UINWCRankPanel.eDragWay = {down = 1, up = 2}

function UINWCRankPanel:OnInit()
  self.rankListType = nil
  self.logicPageRankNum = ConfigData.game_config.WeeklyChallengeRankPageNum
  self.totalRankNum = ConfigData.game_config.WeeklyChallengeRankTotalNum
  self.maxPageNum = self:GetIndexPageNum(self.totalRankNum)
  self.curPageNum = 0
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.rankPlayerDataDic = {
    [WCEnum.eRankType.normal] = {
      [UINWCRankPanel.eRankListType.cur] = {},
      [UINWCRankPanel.eRankListType.old] = {}
    },
    [WCEnum.eRankType.activity] = {
      [UINWCRankPanel.eRankListType.cur] = {},
      [UINWCRankPanel.eRankListType.old] = {}
    }
  }
  self.itemDic = {}
  self.isHistoryInited = {}
  self.cannotDragDown = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loop_scroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.loop_scroll.onValueChanged:AddListener(BindCallback(self, self.__OnValueChange))
  self.myHead = UINUserHead.New()
  self.myHead:Init(self.ui.my_uINBaseHead)
end

function UINWCRankPanel:ShowRankPlayers(rankListType, challengeData, wc_cfg, resloader, rankType)
  self.rankListType = rankListType or UINWCRankPanel.eRankListType.cur
  self.rankType = rankType
  self.wc_cfg = wc_cfg
  self.resloader = resloader
  local myInfoData = PlayerDataCenter.inforData
  self.myHead:InitUserHeadUI(myInfoData:GetAvatarId(), myInfoData:GetAvatarFrameId(), resloader)
  if self.rankListType == UINWCRankPanel.eRankListType.cur then
    self.curPageNum = 0
    self:TrySendGetPageData(0)
    self.dragWay = UINWCRankPanel.eDragWay.down
  elseif self.rankListType == UINWCRankPanel.eRankListType.old then
    if self.isHistoryInited == nil or not self.isHistoryInited[self.rankType] then
      self:TrySendGetPageData(0)
      self.isHistoryInited[self.rankType] = true
    else
      local num = #self.rankPlayerDataDic[self.rankType][UINWCRankPanel.eRankListType.old]
      self.ui.loop_scroll.totalCount = num
      self.ui.obj_emptyState:SetActive(num <= 0)
      self.__isHasFirstElement = false
      self.__isHasLastElement = false
      self.ui.loop_scroll:RefreshCells()
      self:RefreshSelfRank(self.oldSelfRange[self.rankType])
    end
  end
end

function UINWCRankPanel:__OnNewItem(go)
  local rankItem = UINWCRankPanelItem.New()
  rankItem:Init(go)
  self.itemDic[go] = rankItem
end

function UINWCRankPanel:__OnChangeItem(go, index)
  local rankItem = self.itemDic[go]
  if rankItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  rankItem.o_index = index
  local rankData
  if self.rankListType == UINWCRankPanel.eRankListType.cur then
    rankData = self.rankPlayerDataDic[self.rankType][self.rankListType][index + 1 + self.curPageNum * self.logicPageRankNum]
  else
    rankData = self.rankPlayerDataDic[self.rankType][self.rankListType][index + 1]
  end
  if rankData == nil then
    rankItem:SetWCRItemWait4Data(index + 1)
  else
    rankItem:RefreshWCRItemInfo(rankData, self.resloader)
  end
  if index == 0 then
    self.__isHasFirstElement = true
    self.__firstElementGo = go
  elseif index == self.ui.loop_scroll.totalCount - 1 then
    self.__isHasLastElement = true
    self.__lastElementGo = go
  end
end

function UINWCRankPanel:__OnReturnItem(go)
  local rankItem = self.itemDic[go]
  if rankItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local index = rankItem.o_index
  if index == 0 then
    self.__isHasFirstElement = false
  elseif index == self.ui.loop_scroll.totalCount - 1 then
    self.__isHasLastElement = false
  end
end

function UINWCRankPanel:__OnValueChange(pos)
  local isHasFirstElement = self.__isHasFirstElement
  local isHasLastElement = self.__isHasLastElement
  if isHasFirstElement or isHasLastElement then
    local overValue = math.abs(self.ui.float_overRate)
    if isHasFirstElement then
      local viewTopPos = self.ui.goTop_view.position.y
      local contentTopPos = self.__firstElementGo.transform.position.y
      if overValue < viewTopPos - contentTopPos then
        self:__OnDragOverTop()
      end
    end
    if isHasLastElement then
      local viewDownPos = self.ui.goBotton_view.position.y
      local contentDownPos = self.__lastElementGo.transform.position.y
      if overValue < contentDownPos - viewDownPos then
        self:__OnDragOverBottle()
      end
    end
  end
end

function UINWCRankPanel:__OnDragOverTop()
  if self.curPageNum == 0 then
    return
  end
  if self.isDragOverFreshing then
    return
  end
  if self.rankListType == UINWCRankPanel.eRankListType.cur then
    self:TrySendGetPageData(self.curPageNum - 1)
    self.curPageNum = self.curPageNum - 1
    self.isDragOverFreshing = true
    self.dragWay = UINWCRankPanel.eDragWay.up
  end
end

function UINWCRankPanel:__OnDragOverBottle()
  if self.curPageNum == self.maxPageNum then
    return
  end
  if self.isDragOverFreshing then
    return
  end
  if self.rankListType == UINWCRankPanel.eRankListType.cur then
    if self.cannotDragDown[UINWCRankPanel.eRankListType.cur] then
      return
    end
    self:TrySendGetPageData(self.curPageNum + 1)
    self.curPageNum = self.curPageNum + 1
    self.isDragOverFreshing = true
    self.dragWay = UINWCRankPanel.eDragWay.down
  elseif self.rankListType == UINWCRankPanel.eRankListType.old then
    if self.cannotDragDown[UINWCRankPanel.eRankListType.old] then
      return
    end
    self:TrySendGetPageData(self.curPageNum + 1)
    self.curPageNum = self.curPageNum + 1
    self.isDragOverFreshing = true
    self.dragWay = UINWCRankPanel.eDragWay.down
  end
end

function UINWCRankPanel:GetIndexPageNum(index)
  return math.ceil(index / self.logicPageRankNum) - 1
end

function UINWCRankPanel:TrySendGetPageData(pageNum)
  self.sectorNetworkCtrl:CS_WEEKLYCHALLENGE_RankPage(self.rankListType == UINWCRankPanel.eRankListType.old, pageNum, self.rankType)
end

function UINWCRankPanel:GetRankPageMsg(msg)
  local isOld = msg.history
  local rankType = msg.rankCat
  if rankType ~= self.rankType then
    return
  end
  local rankKeyDic = {}
  for index, rankElem in ipairs(msg.rank) do
    rankKeyDic[rankElem.rank] = rankElem
  end
  self:Refresh2NewPage(isOld, rankType, rankKeyDic)
  self:RefreshSelfRank(msg.selfRange)
  if isOld then
    if self.oldSelfRange == nil then
      self.oldSelfRange = {}
    end
    self.oldSelfRange[self.rankType] = msg.selfRange
  end
end

function UINWCRankPanel:Refresh2NewPage(isOld, rankType, rankKeyDic)
  self.ui.obj_emptyState:SetActive(table.count(rankKeyDic) <= 0)
  if isOld then
    table.merge(self.rankPlayerDataDic[rankType][UINWCRankPanel.eRankListType.old], rankKeyDic)
    if self.rankListType == UINWCRankPanel.eRankListType.old then
      self.ui.loop_scroll.totalCount = #self.rankPlayerDataDic[rankType][UINWCRankPanel.eRankListType.old]
      self.cannotDragDown[UINWCRankPanel.eRankListType.old] = table.count(rankKeyDic) < self.logicPageRankNum
      self.__isHasFirstElement = false
      self.__isHasLastElement = false
      self.ui.loop_scroll:RefreshCells()
    end
  elseif not isOld and self.rankListType == UINWCRankPanel.eRankListType.cur then
    self.rankPlayerDataDic[rankType][UINWCRankPanel.eRankListType.cur] = rankKeyDic
    local num = table.count(rankKeyDic)
    self.ui.loop_scroll:ClearCells()
    self.ui.loop_scroll.totalCount = num
    self.cannotDragDown[UINWCRankPanel.eRankListType.cur] = num < self.logicPageRankNum
    self.__isHasFirstElement = false
    self.__isHasLastElement = false
    if self.dragWay == UINWCRankPanel.eDragWay.down then
      self.ui.loop_scroll:RefillCells()
    elseif self.dragWay == UINWCRankPanel.eDragWay.up then
      self.ui.loop_scroll:RefillCellsFromEnd()
    else
      self.ui.loop_scroll:RefillCells()
    end
    self.ui.loop_scroll:StopMovement()
  end
  self.isDragOverFreshing = false
end

function UINWCRankPanel:RefreshSelfRank(selfRankData)
  local lastRegion
  if self.wc_cfg ~= nil then
    local rankCfgs = ConfigData.weekly_challenge_rank_reward[self.wc_cfg.rank_id]
    local lastRankCfg = rankCfgs[#rankCfgs - 1]
    if lastRankCfg ~= nil and lastRankCfg.type == eType.percentRank then
      lastRegion = lastRankCfg.score / 1000
    end
  end
  if selfRankData.inRank then
    self.ui.tex_MyRank:SetIndex(0, tostring(selfRankData.curRank))
  elseif selfRankData.score <= 0 or selfRankData.total == 0 then
    self.ui.tex_MyRank:SetIndex(2)
  elseif lastRegion ~= nil and lastRegion < selfRankData.curRank / selfRankData.total then
    self.ui.tex_MyRank:SetIndex(3)
  else
    self.ui.tex_MyRank:SetIndex(1, tostring(GetPreciseDecimalStr(selfRankData.curRank / selfRankData.total * 100, 1)))
  end
  self.ui.tex_MyName.text = PlayerDataCenter.playerName
  self.ui.tex_MyScore.text = tostring(selfRankData.score)
end

function UINWCRankPanel:OnDelete()
  base.OnDelete(self)
end

return UINWCRankPanel
