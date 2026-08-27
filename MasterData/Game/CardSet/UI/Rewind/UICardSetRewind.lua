local base = UIBaseWindow
local UICardSetRewind = class("UICardSetRewind", base)
local UINCardSetRewindItem = require("Game.CardSet.UI.Rewind.UINCardSetRewindItem")
local UINCardSetRewindSortItem = require("Game.CardSet.UI.Rewind.UINCardSetRewindSortItem")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local eSortType = {round = 1, token = 2}
local _sortReverse = false
local eSortFunc = {
  [eSortType.round] = function(a, b)
    if _sortReverse then
      return a.roundId > b.roundId
    end
    return a.roundId < b.roundId
  end,
  [eSortType.token] = function(a, b)
    if _sortReverse then
      return a.score > b.score
    end
    return a.score < b.score
  end
}

function UICardSetRewind:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BcakAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Rewind, self, self._OnClickRewind)
  UIUtil.AddButtonListener(self.ui.btn_RevertLeft, self, self._OnClickRevertLeft)
  UIUtil.AddButtonListener(self.ui.btn_RevertRight, self, self._OnClickRevertRight)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  local sizeX = math.floor(UIManager.BackgroundStretchSize.x / 2)
  self.ui.scrollRect.newItemBoundOffset = sizeX
  self._ItemDic = {}
  self.__SelectRewindItemFunc = BindCallback(self, self._SelectRewindItem)
  self.__ChangeSortFunc = BindCallback(self, self._ChangeSort)
  self._turnSortItem = UINCardSetRewindSortItem.New()
  self._turnSortItem:Init(self.ui.btn_Turn)
  self._tokenSortItem = UINCardSetRewindSortItem.New()
  self._tokenSortItem:Init(self.ui.btn_Token)
  local eventTrigger = CS.EventTriggerListener.Get(self.ui.scrollRect.gameObject)
  eventTrigger:onEndDrag("+", BindCallback(self, self._OnEndDrag))
end

function UICardSetRewind:InitCardSetRewind(cardSetCtrl, closeCallback, isReturn)
  self._cardSetCtrl = cardSetCtrl
  self._cardSetData = cardSetCtrl:GetCardSetData()
  self._actCardSetData = cardSetCtrl:GetCdStActData()
  self._closeCallback = closeCallback
  self:_InitSort()
  self:_InitData()
  self:_RefillScrollRect()
  self:_UpdSelectState()
  if isReturn then
    self:_OnClickRewind()
  end
end

function UICardSetRewind:_InitSort()
  local actId = self._actCardSetData:GetActId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local sortType, isReverse = saveUserData:GetCardSetRewindSort(actId)
  self._sortType = sortType
  _sortReverse = isReverse
  if self._sortType == eSortType.round then
    self._turnSortItem:InitCardSetRewindSortItem(eSortType.round, isReverse, self.__ChangeSortFunc)
    self._tokenSortItem:InitCardSetRewindSortItem(eSortType.token, nil, self.__ChangeSortFunc)
  elseif self._sortType == eSortType.token then
    self._turnSortItem:InitCardSetRewindSortItem(eSortType.round, nil, self.__ChangeSortFunc)
    self._tokenSortItem:InitCardSetRewindSortItem(eSortType.token, isReverse, self.__ChangeSortFunc)
  end
end

function UICardSetRewind:_InitData()
  self._inProgressRound = self._cardSetData:GetCardSetCurRound()
  self._selectedRound = self._inProgressRound
  local actId = self._actCardSetData:GetActId()
  local rewindMsgDic = self._actCardSetData:GetActCardSetRewindDataDic()
  local rewindDataList = {}
  local rewindDataDic = {}
  local cardNormalRoundCfg = ConfigData.activity_card_normal_round[actId]
  if cardNormalRoundCfg == nil then
    error("cant get activity_card_normal_round, actId:" .. tostring(actId))
    return
  end
  local minRound = CommonUtil.Int32Max
  local maxRound = 0
  for roundId, roundMsg in pairs(rewindMsgDic) do
    local roundCfg = cardNormalRoundCfg[roundId]
    if roundCfg == nil then
      local turnIdList = ConfigData.activity_card_normal_round.actTurnIdDicList[actId]
      local idx = (roundId - #cardNormalRoundCfg) % #turnIdList
      local turnId = turnIdList[idx + 1]
      roundCfg = cardNormalRoundCfg[turnId]
    end
    minRound = math.min(minRound, roundId)
    maxRound = math.max(maxRound, roundId)
    local rewindData = {
      roundId = roundId,
      score = roundMsg.rewardScore,
      baseScore = roundCfg.hope_value
    }
    table.insert(rewindDataList, rewindData)
    rewindDataDic[roundId] = rewindData
  end
  if minRound > self._selectedRound then
    self._selectedRound = minRound
  end
  if minRound > self._inProgressRound or maxRound < self._inProgressRound then
    self._inProgressRound = nil
  end
  self._rewindDataList = rewindDataList
  self._rewindDataDic = rewindDataDic
  self:_SortRewindDataList()
end

function UICardSetRewind:_SortRewindDataList()
  local sortFunc = eSortFunc[self._sortType]
  table.sort(self._rewindDataList, sortFunc)
end

function UICardSetRewind:_UpdSelectState()
  local selectedInprogress = self._inProgressRound == self._selectedRound
  self.ui.tex_BtnRewind:SetIndex(selectedInprogress and 1 or 0)
  self.ui.btn_RevertLeft.gameObject:SetActive(false)
  self.ui.btn_RevertRight.gameObject:SetActive(false)
  if self._inProgressRound ~= nil then
    if self._inProgressRound < self._selectedRound then
      self.ui.btn_RevertLeft.gameObject:SetActive(true)
      self.ui.tex_LeftRound.text = tostring(self._inProgressRound)
    elseif self._inProgressRound > self._selectedRound then
      self.ui.btn_RevertRight.gameObject:SetActive(true)
      self.ui.tex_RightRound.text = tostring(self._inProgressRound)
    end
  end
end

function UICardSetRewind:_RefillScrollRect(isRefresh)
  self.ui.scrollRect.totalCount = #self._rewindDataList
  if isRefresh then
    self.ui.scrollRect:RefreshCells()
  else
    local idx = 1
    for k, rewindData in ipairs(self._rewindDataList) do
      if rewindData.roundId == self._selectedRound then
        idx = k
        break
      end
    end
    self.ui.scrollRect:RefillCells(idx - 1)
    self.ui.scrollRect:SrollToCellWithinTime(idx - 1, 0.001)
    self.ui.scrollRect:RefreshCells()
  end
end

function UICardSetRewind:__OnNewItem(go)
  local item = UINCardSetRewindItem.New()
  item:Init(go)
  item:SetCardSetRewindItemFunc(self.__SelectRewindItemFunc)
  local itemCfg = self._cardSetData:GetCurCardSetScoreItemCfg()
  local scoreSprite = CRH:GetSprite(itemCfg.small_icon)
  item:SetCardSetRewindItemSprite(scoreSprite)
  self._ItemDic[go] = item
end

function UICardSetRewind:__OnChangeItem(go, index)
  local item = self._ItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local rewindData = self._rewindDataList[index + 1]
  if rewindData == nil then
    error("Can't find rewindData by index, index = " .. tonumber(index))
    return
  end
  local inProgress = self._inProgressRound == rewindData.roundId
  local selected = self._selectedRound == rewindData.roundId
  item:InitCardSetRewindItem(rewindData, inProgress, selected)
end

function UICardSetRewind:_SelectRewindItem(rewindItem, rewindData)
  if self._selectedRound == rewindData.roundId then
    return
  end
  self:_SetSelectedRound(rewindData.roundId)
  self:_LocateSelectedRound()
  self.ui.scrollRect:RefreshCells()
end

function UICardSetRewind:_ChangeSort(sortType, isReverse)
  self._sortType = sortType
  _sortReverse = isReverse
  if self._sortType == eSortType.round then
    self._tokenSortItem:ClearCardSetRewindSort()
  elseif self._sortType == eSortType.token then
    self._turnSortItem:ClearCardSetRewindSort()
  end
  self:_SortRewindDataList()
  self:_RefillScrollRect()
end

function UICardSetRewind:_OnClickRewind()
  local function enterRewindModeFunc()
    self._inProgressRound = self._selectedRound
    
    UIManager:HideWindow(UIWindowTypeID.CardSetRewind)
    self._cardSetCtrl:OpenCardSetUI(CardSetEnum.eSetType.rewind, function(isToHome)
      UIManager:ShowWindowOnly(UIWindowTypeID.CardSetRewind)
      if not isToHome and not IsNull(self.gameObject) then
        self:_RefillScrollRect()
        self:_UpdSelectState()
      end
    end)
  end
  
  local function reqRewindFunc()
    if self._inProgressRound == self._selectedRound then
      enterRewindModeFunc()
    else
      self._cardSetCtrl:ReqCardSetRewindRoundSelect(self._selectedRound, enterRewindModeFunc)
    end
  end
  
  if self._inProgressRound ~= nil and self._inProgressRound ~= self._selectedRound then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(2214), self._inProgressRound), reqRewindFunc)
    return
  end
  reqRewindFunc()
end

function UICardSetRewind:_OnClickRevertLeft()
  self:_SetSelectedRound(self._inProgressRound)
  self:_LocateSelectedRound()
end

function UICardSetRewind:_OnClickRevertRight()
  self:_SetSelectedRound(self._inProgressRound)
  self:_LocateSelectedRound()
end

function UICardSetRewind:_LocateSelectedRound()
  local idx
  for k, rewindData in ipairs(self._rewindDataList) do
    if rewindData.roundId == self._selectedRound then
      idx = k
      break
    end
  end
  if idx then
    self.ui.scrollRect:RefreshCells()
    self.ui.scrollRect:SrollToCellWithinTime(idx - 1, 0.2)
  end
end

function UICardSetRewind:_SetSelectedRound(round)
  self._selectedRound = round
  self:_UpdSelectState()
end

function UICardSetRewind:_OnEndDrag(go, eventData)
  if #self._rewindDataList <= 1 then
    return
  end
  local hPos = self.ui.scrollRect.horizontalNormalizedPosition
  hPos = math.clamp(hPos, 0, 1)
  local unit = 1 / (#self._rewindDataList - 1)
  local idx = math.floor(hPos / unit + 0.5)
  self.ui.scrollRect:StopMovement()
  self.ui.scrollRect:SrollToCell(idx, 1000)
  local roundData = self._rewindDataList[idx + 1]
  self:_SetSelectedRound(roundData.roundId)
  self.ui.scrollRect:RefreshCells()
end

function UICardSetRewind:__BcakAction()
  self:Delete()
  if self._closeCallback then
    self._closeCallback()
  end
  local actId = self._actCardSetData:GetActId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local sortType, isReverse = saveUserData:SetCardSetRewindSort(actId, self._sortType, _sortReverse)
end

function UICardSetRewind:OnDelete()
  for k, v in pairs(self._ItemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UICardSetRewind
