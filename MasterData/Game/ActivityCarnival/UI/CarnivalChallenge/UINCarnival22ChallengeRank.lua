local UINCarnival22ChallengeRank = class("UINCarnival22ChallengeRank", UIBaseNode)
local base = UINCarnival22ChallengeRank
local UINCarnival22ChallengeRankItem = require("Game.ActivityCarnival.UI.CarnivalChallenge.UINCarnival22ChallengeRankItem")
local BattleUtil = require("Game.Battle.BattleUtil")

function UINCarnival22ChallengeRank:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.Hide)
  self.ui.frame.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.frame.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.frame.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.frame.onValueChanged:AddListener(BindCallback(self, self.__OnValueChange))
  self._rectHeight = self.ui.frame.transform.rect.height
  self.itemDic = {}
end

function UINCarnival22ChallengeRank:InitCarnivalChallengeRank(rankId, resloder)
  self._rankId = rankId
  self._resloder = resloder
  self._pageContentNum = ConfigData.buildinConfig.CommonRankPageNum
  local rankCfg = ConfigData.common_ranklist[rankId]
  self._maxPage = math.ceil(rankCfg.precise_max / self._pageContentNum) - 1
end

function UINCarnival22ChallengeRank:OpenCarnivalChallengeRank()
  self._cannotNext = false
  self._isReqing = false
  self._curPage = nil
  self._firstItem = nil
  self._lastItem = nil
  self._pageDataDic = {}
  self:__ReqRankPage(0)
end

function UINCarnival22ChallengeRank:__UpdateCarnivalChallengeRank(data, pageId)
  local lastPageId = self._curPage
  self.rankList = data.rank
  self._curPage = pageId
  local num = #self.rankList
  self._cannotNext = num < self._pageContentNum or self._curPage >= self._maxPage
  self.ui.frame:ClearCells()
  if num == 0 then
    self.ui.myRank:SetActive(false)
    self.ui.emptyState:SetActive(true)
    return
  end
  self.ui.emptyState:SetActive(false)
  self.ui.myRank:SetActive(true)
  self._firstItem = nil
  self._lastItem = nil
  self.ui.frame.totalCount = num
  if lastPageId == nil or lastPageId <= self._curPage then
    self.ui.frame:RefillCells()
  else
    self.ui.frame:RefillCellsFromEnd()
  end
  self.ui.frame:StopMovement()
  local rankSelf = data.myRank
  if rankSelf == nil then
    self.ui.tex_MyRank:SetIndex(1)
    self.ui.tex_MyTime.gameObject:SetActive(false)
  else
    self.ui.tex_MyTime.gameObject:SetActive(true)
    local time = self:__CalRecordTime(rankSelf.score)
    local min = math.floor(time / 60)
    local sec = time % 60
    self.ui.tex_MyTime:SetIndex(0, string.format("%02d", min), string.format("%.03f", sec))
    if rankSelf.rankParam == 0 then
      self.ui.tex_MyRank:SetIndex(2)
    elseif rankSelf.inRank then
      self.ui.tex_MyRank:SetIndex(0, tostring(rankSelf.rankParam))
    else
      local rate = math.floor(rankSelf.rankParam / 100)
      self.ui.tex_MyRank:SetIndex(0, tostring(rate) .. "%")
    end
  end
end

function UINCarnival22ChallengeRank:__OnNewItem(go)
  local rankItem = UINCarnival22ChallengeRankItem.New()
  rankItem:Init(go)
  self.itemDic[go] = rankItem
end

function UINCarnival22ChallengeRank:__OnChangeItem(go, index)
  local rankItem = self.itemDic[go]
  local data = self.rankList[index + 1]
  if data.second == nil then
    local seconed = self:__CalRecordTime(data.entry.score1)
    data.second = seconed
  end
  rankItem:InitCarnivalChallengeRankItem(data, self._resloder)
  if index == 0 then
    self._firstItem = rankItem
  elseif index == #self.rankList - 1 then
    self._lastItem = rankItem
  end
end

function UINCarnival22ChallengeRank:__OnReturnItem(go)
  local rankitem = self.itemDic[go]
  if rankitem == self._firstItem then
    self._firstItem = nil
  elseif rankitem == self._lastItem then
    self._lastItem = nil
  end
end

function UINCarnival22ChallengeRank:__OnValueChange(pos)
  if self._isReqing or self._curPage == nil then
    return
  end
  if self._curPage > 0 and self._firstItem ~= nil then
    local worldPos = self._firstItem.transform:TransformPoint(Vector3.zero)
    local frameLocalPos = self.ui.frame.transform:InverseTransformPoint(worldPos)
    local posY = frameLocalPos.y
    if posY < self._rectHeight / 2 - self.ui.pageCheckDis then
      self:__ReqRankPage(self._curPage - 1)
    end
  end
  if not self._cannotNext and self._lastItem ~= nil then
    local worldPos = self._lastItem.transform:TransformPoint(Vector3.zero)
    local frameLocalPos = self.ui.frame.transform:InverseTransformPoint(worldPos)
    local posY = frameLocalPos.y
    if posY > -self._rectHeight / 2 + self.ui.pageCheckDis then
      self:__ReqRankPage(self._curPage + 1)
    end
  end
end

function UINCarnival22ChallengeRank:__CalRecordTime(score)
  local frame = 4294967295 - score
  local time = frame / BattleUtil.LogicFrameCount
  return time
end

function UINCarnival22ChallengeRank:__ReqRankPage(pageId)
  if self._pageDataDic[pageId] ~= nil then
    self:__UpdateCarnivalChallengeRank(self._pageDataDic[pageId], pageId)
    return
  end
  self._isReqing = true
  local objNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  objNetwork:CS_Rank_Detail(self._rankId, pageId, function(objList)
    if IsNull(self.transform) or not self.active then
      return
    end
    self._isReqing = false
    if objList.Count ~= 1 then
      return
    end
    local msg = objList[0]
    if msg == nil then
      return
    end
    self._pageDataDic[pageId] = msg
    self:__UpdateCarnivalChallengeRank(msg, pageId)
  end)
end

return UINCarnival22ChallengeRank
