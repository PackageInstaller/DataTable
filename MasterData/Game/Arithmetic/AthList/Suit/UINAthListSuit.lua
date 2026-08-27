local UINAthListSuit = class("UINAthListSuit", UIBaseNode)
local base = UIBaseNode
local UINAthListSuitItem = require("Game.Arithmetic.AthList.Suit.UINAthListSuitItem")

function UINAthListSuit:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tog_SuitRate.isOn = PlayerDataCenter.allAthData:IsShowAthSuitUsingRate()
  UIUtil.AddValueChangedListener(self.ui.tog_SuitRate, self, self._OnClickUseSuitRate)
  self._OnClickSuitItemFunc = BindCallback(self, self._OnClickSuitItem)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.suitItemDic = {}
  self._isInit = true
end

function UINAthListSuit:InitAthListSuit(athListRoot, heroData, resLoader)
  self.athListRoot = athListRoot
  if self.heroData ~= heroData and PlayerDataCenter.allAthData:IsShowAthSuitUsingRate() then
    self._waitSuitUsingRate = true
    self:_ReqSuitUsingRate(heroData, function()
      self._waitSuitUsingRate = false
      if self._waitRefreshList then
        self:RefreshAthListSuit(true)
      end
    end)
  end
  self.heroData = heroData
  self.heroAthSuitRecommendDic, self.recommendAredSuitDic = heroData:GetHeroAthSuitRecommendDic()
  self.resLoader = resLoader
end

function UINAthListSuit:SetAthListSuitSelectedSuitId(athSuitId)
  self.selectedAthSuitId = athSuitId
  self.ui.img_Select.transform:SetParent(self.ui.prefabHolder)
  if athSuitId == nil then
    return
  end
  if self._suitSelSeq ~= nil then
    self._suitSelSeq:Restart()
    return
  end
  self:_InitSuitSelectSeq()
end

function UINAthListSuit:SetAthListSuitArea(areaId)
  self.areaId = areaId
  self.ui.tog_SuitRate.gameObject:SetActive(areaId ~= nil and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Rate))
  self:RefreshAthListSuit(true)
end

function UINAthListSuit:RefreshAthListSuit(refill, targetSuitId)
  if self._waitSuitUsingRate then
    self._waitRefreshList = true
    return
  end
  self._waitRefreshList = false
  local refillIdx = self:_RefreshAthListSuitData(targetSuitId)
  if targetSuitId == nil then
    self:SetAthListSuitSelectedSuitId(nil)
  end
  self:_RefillScrollRect(refill, refillIdx)
end

function UINAthListSuit:_RefreshAthListSuitData(targetSuitId)
  self.curSuitIdList = {}
  if self.areaId == nil then
    for suitId, v in pairs(ConfigData.ath_suit) do
      if not ConfigData.ath_suit.suitParamDic[suitId].exclude then
        table.insert(self.curSuitIdList, suitId)
      end
    end
  elseif PlayerDataCenter.allAthData:IsShowAthSuitUsingRate() then
    self._suitUseRateDic = {}
    local usingRateList = self._heroAthStat.slots[self.areaId].suit
    for k, elem in ipairs(usingRateList) do
      if not ConfigData.ath_suit.suitParamDic[elem.id].exclude then
        table.insert(self.curSuitIdList, elem.id)
        self._suitUseRateDic[elem.id] = elem.ratio
        if #self.curSuitIdList > 3 then
          break
        end
      end
    end
  else
    local suitIdDic = ConfigData.arithmetic.areaSuitDic[self.areaId] or table.emptytable
    for suitId, v in pairs(suitIdDic) do
      if not ConfigData.ath_suit.suitParamDic[suitId].exclude then
        table.insert(self.curSuitIdList, suitId)
      end
    end
  end
  local allAthIdNumDic = PlayerDataCenter.allAthData:GetAllAthIdNumDic()
  local suitAthNumDic = table.GetDefaulValueTable(0)
  for k, suitId in ipairs(self.curSuitIdList) do
    local suitCfltDic = ConfigData.arithmetic.suitDic[suitId]
    if suitCfltDic == nil then
      error("Cant find suitCfltDic, suitId = " .. tostring(suitId))
    else
      for k2, suitAthIdList in pairs(suitCfltDic) do
        for k3, athId in ipairs(suitAthIdList) do
          suitAthNumDic[suitId] = suitAthNumDic[suitId] + allAthIdNumDic[athId]
        end
      end
    end
  end
  self.suitAthNumDic = suitAthNumDic
  if not PlayerDataCenter.allAthData:IsShowAthSuitUsingRate() or self.areaId == nil then
    self:_SortSuitList(suitAthNumDic)
  end
  if targetSuitId ~= nil then
    for k, suitId in ipairs(self.curSuitIdList) do
      if targetSuitId == suitId then
        return k - 1
      end
    end
  end
end

function UINAthListSuit:_SortSuitList(suitAthNumDic)
  local careerCfgcre = self.heroData:GetCareerCfg()
  local suitRecommendArea = careerCfgcre.algorithm_suit_recommend
  table.sort(self.curSuitIdList, function(suitIdA, suitIdB)
    local recommendA = self.heroAthSuitRecommendDic[suitIdA] ~= nil
    local recommendB = self.heroAthSuitRecommendDic[suitIdB] ~= nil
    if recommendA ~= recommendB then
      return recommendA
    end
    local recommendArea
    if self.areaId == nil then
      recommendArea = suitRecommendArea
    else
      recommendArea = self.areaId
    end
    local priorityDic = self.recommendAredSuitDic[recommendArea]
    local priorityA = priorityDic[suitIdA] or math.maxinteger
    local priorityB = priorityDic[suitIdB] or math.maxinteger
    if priorityA ~= priorityB then
      return priorityA < priorityB
    end
    local hasA = 0 < suitAthNumDic[suitIdA]
    local hasB = 0 < suitAthNumDic[suitIdB]
    if hasA ~= hasB then
      return hasA
    end
    local orderA = ConfigData.ath_suit.suitParamDic[suitIdA].suit_order
    local orderB = ConfigData.ath_suit.suitParamDic[suitIdB].suit_order
    if orderA ~= orderB then
      return orderA < orderB
    end
    return suitIdA < suitIdB
  end)
end

function UINAthListSuit:_RefillScrollRect(refill, refillIdx)
  self.ui.scrollRect.totalCount = #self.curSuitIdList
  if self._isInit or refill or self._nextFill then
    self.ui.scrollRect:RefillCells(refillIdx or 0)
    self._isInit = false
    self._nextFill = not self.ui.scrollRect.gameObject.activeInHierarchy
  else
    self.ui.scrollRect:RefreshCells()
  end
  self.athListRoot:ShowAthListEmpty(#self.curSuitIdList == 0)
end

function UINAthListSuit:__OnNewItem(go)
  local item = UINAthListSuitItem.New()
  item:Init(go)
  self.suitItemDic[go] = item
end

function UINAthListSuit:__OnChangeItem(go, index)
  local item = self.suitItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local suitId = self.curSuitIdList[index + 1]
  if suitId == nil then
    error("Can't find suitId by index, index = " .. tonumber(index))
  end
  local curCount = self.suitAthNumDic[suitId]
  local isRecommend = self.heroAthSuitRecommendDic[suitId] ~= nil
  item:InitAthListSuitItem(suitId, isRecommend, self._OnClickSuitItemFunc, self.resLoader, curCount)
  if PlayerDataCenter.allAthData:IsShowAthSuitUsingRate() and self.areaId ~= nil then
    local usingRate = self._suitUseRateDic[suitId]
    item:ShowAthListSuitItemUsingRate(usingRate)
  end
  if self.selectedAthSuitId == suitId then
    self.ui.img_Select.transform:SetParent(item.transform)
    self.ui.img_Select.transform.anchoredPosition = Vector2.New(-3, 3)
  end
end

function UINAthListSuit:__OnReturnItem(go)
  local item = self.suitItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  if self.selectedAthSuitId ~= nil and item.suitId == self.selectedAthSuitId then
    self.ui.img_Select.transform:SetParent(self.ui.prefabHolder)
  end
end

function UINAthListSuit:_OnClickSuitItem(suitId)
  if self.suitAthNumDic[suitId] > 0 then
    self.athListRoot:ShowAthListSuitAth(suitId)
  end
end

function UINAthListSuit:_OnClickUseSuitRate(isOn)
  if isOn then
    self:_ReqSuitUsingRate(self.heroData, function()
      self._showSuitUsingRate = true
      PlayerDataCenter.allAthData:SetShowAthSuitUsingRate(true)
      self:RefreshAthListSuit(true)
    end)
    return
  end
  PlayerDataCenter.allAthData:SetShowAthSuitUsingRate(false)
  self:RefreshAthListSuit(true)
end

function UINAthListSuit:_ReqSuitUsingRate(heroData, callBack)
  PlayerDataCenter.allAthData:GetHeroAthStat(heroData.dataId, function(heroAthStat)
    self._heroAthStat = heroAthStat
    if callBack then
      callBack()
    end
  end)
end

function UINAthListSuit:_InitSuitSelectSeq()
  local cs_DoTween = CS.DG.Tweening.DOTween
  local seq = cs_DoTween.Sequence()
  seq:Append(self.ui.img_Select:DOColor(Color.white, 0.25):From():SetLoops(3))
  seq:Append(self.ui.img_Select:DOFade(0, 0.25):SetDelay(0.25))
  seq:SetAutoKill(false)
  seq:OnComplete(function()
    self:SetAthListSuitSelectedSuitId(nil)
  end)
  self._suitSelSeq = seq
end

function UINAthListSuit:OnDelete()
  for k, suitItem in pairs(self.suitItemDic) do
    suitItem:Delete()
  end
  self.suitItemDic = nil
  if self._suitSelSeq ~= nil then
    self._suitSelSeq:Kill()
    self._suitSelSeq = nil
  end
  base.OnDelete(self)
end

return UINAthListSuit
