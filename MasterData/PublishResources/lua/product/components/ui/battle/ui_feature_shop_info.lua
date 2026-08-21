_class("UIFeatureShopCellUIData", Object)
UIFeatureShopCellUIData = UIFeatureShopCellUIData

function UIFeatureShopCellUIData:Constructor(cellID, isLock, hadInvest, cantSelect)
  self._cellID = cellID
  self._isLock = isLock
  self._hadInvest = hadInvest
  self._cantSelect = cantSelect
end

_class("UIFeatureShopInfo", UIController)
UIFeatureShopInfo = UIFeatureShopInfo

function UIFeatureShopInfo:OnShow(uiParams)
  self._castClicked = false
  self._shopInitData = uiParams[1]
  self._curVal = uiParams[2]
  self._castCb = uiParams[3]
  self._cancelCb = uiParams[4]
  self._curPetID = 1602181
  self._skillID = self._shopInitData:GetSkillID()
  self:InitWidget()
  self:OnRefresh()
  self:OnPlayAnimationIn()
end

function UIFeatureShopInfo:InitWidget()
  self._textCellCount = self:GetUIComponent("UILocalizationText", "TextCellCount")
  self._textNode1 = self:GetUIComponent("UILocalizationText", "TextNode1")
  self._textNode2 = self:GetUIComponent("UILocalizationText", "TextNode2")
  self._textNode3 = self:GetUIComponent("UILocalizationText", "TextNode3")
  self._specificObj = self:GetGameObject("Specific")
  self._textSpecific = self:GetUIComponent("UILocalizationText", "TextSpecific")
  self._specificObj:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "UIFeatureShopInfo")
  self._slider = self:GetUIComponent("Slider", "Slider")
  self._castBtn = self:GetUIComponent("Button", "CastBtn")
  self._cellItemUIDatas = {}
  self._cellItems = {}
  for i = 1, 6 do
    self._cellItems[i] = UIFeatureShopInfoItem:New(self:GetUIComponent("UIView", "CellItem" .. i), i, function(index, selected)
      self:OnItemCallBack(index, selected)
    end)
    self._cellItems[i]:Load(self._cellItems[i]._view, self)
  end
end

function UIFeatureShopInfo:OnPlayAnimationIn()
  GameGlobal.UIStateManager():Lock("UIFeatureShopInfo_PlayAnimationIn")
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIFeatureShopInfo_in")
    YIELD(TT, 467)
    GameGlobal.UIStateManager():UnLock("UIFeatureShopInfo_PlayAnimationIn")
  end, self)
end

function UIFeatureShopInfo:OnRefresh()
  self._newSelectedCellList = {}
  local unlockParam = self._shopInitData:GetUnlockParam()
  local unlockParamCount = table.count(unlockParam)
  self._selectedCellList = FeatureServiceHelper.GetShopSelectedCellList()
  local showPageIndex = 1
  if 1 < unlockParamCount then
    local firstSelectCount = 0
    if table.icontains(self._selectedCellList, 1) or table.icontains(self._selectedCellList, 2) then
      firstSelectCount = firstSelectCount + 1
    end
    if table.icontains(self._selectedCellList, 3) or table.icontains(self._selectedCellList, 4) then
      firstSelectCount = firstSelectCount + 1
    end
    if table.icontains(self._selectedCellList, 5) or table.icontains(self._selectedCellList, 6) then
      firstSelectCount = firstSelectCount + 1
    end
    if firstSelectCount == 3 then
      showPageIndex = 2
    end
  end
  self._showPageIndex = showPageIndex
  local curUnlockParam = unlockParam[showPageIndex]
  self._textNode1:SetText(curUnlockParam[1])
  self._textNode2:SetText(curUnlockParam[2])
  self._textNode3:SetText(curUnlockParam[3])
  self._textCellCount:SetText(self._curVal)
  local curStage = #curUnlockParam
  local curStageMin = 0
  local curStageMax = 0
  for i = 1, #curUnlockParam do
    if self._curVal <= curUnlockParam[i] then
      curStage = i
      break
    end
  end
  if curStage == 1 then
    if showPageIndex == 1 then
      curStageMin = 0
    else
      local lastUnlockParam = unlockParam[showPageIndex - 1]
      curStageMin = lastUnlockParam[#lastUnlockParam]
    end
  else
    curStageMin = curUnlockParam[curStage - 1]
  end
  curStageMax = curUnlockParam[curStage]
  local sliderMin = 0
  local sliderMax = 0.3
  if curStage == 2 then
    sliderMin = 0.3
    sliderMax = 0.645
  elseif curStage == 3 then
    sliderMin = 0.645
    sliderMax = 1
  end
  local curStageValue = self._curVal - curStageMin
  local curStageTotalValue = curStageMax - curStageMin
  local curStagePercent = curStageValue / curStageTotalValue
  local curSlideLength = sliderMax - sliderMin
  self._slider.value = sliderMin + curStagePercent * curSlideLength
  local matchPet = InnerGameHelperRender.GetLocalMatchPetByTemplateID(self._curPetID)
  local curEquipLv = matchPet:GetEquipLv()
  local eachGroupCellCount = 2
  local shopUIHadSeeUnlockCellList = FeatureServiceHelper.GetShopUIHadSeeUnlockCellList() or {}
  local newUnlockCellList = {}
  for i = 1, 6 do
    local curCellData = self:OnGetCurCellData(i)
    local equipLevelLimit = curCellData.NeedEquipLevel or 0
    local groupIndex = math.floor((i - 1) / eachGroupCellCount) + 1
    local unlockNeedCount = curUnlockParam[groupIndex]
    local hadInvest = table.icontains(self._selectedCellList, i)
    local isLock = not hadInvest and (curEquipLv < equipLevelLimit or unlockNeedCount > self._curVal and curStage == 1)
    local cantSelect = self:OnGetCurCellCantSelect(i, unlockParamCount) or unlockNeedCount > self._curVal
    if isLock == false and not table.icontains(shopUIHadSeeUnlockCellList, i) then
      self._cellItems[i]:OnRefresh(true, hadInvest, cantSelect)
      table.insert(newUnlockCellList, i)
    else
      self._cellItems[i]:OnRefresh(isLock, hadInvest, cantSelect)
    end
    self._cellItemUIDatas[i] = UIFeatureShopCellUIData:New(i, isLock, hadInvest, cantSelect)
  end
  self:RefreshCastBtnState()
  if table.count(newUnlockCellList) > 0 then
    table.appendArray(shopUIHadSeeUnlockCellList, newUnlockCellList)
    FeatureServiceHelper.SetShopUIHadSeeUnlockCellList(shopUIHadSeeUnlockCellList)
    GameGlobal.UIStateManager():Lock("UIFeatureShopInfo_PlayAnimationUnLock")
    self:StartTask(function(TT)
      YIELD(TT, 467)
      for i = 1, #newUnlockCellList do
        local index = newUnlockCellList[i]
        self._cellItems[index]:OnPlayAnimUnlock()
      end
      YIELD(TT, 333)
      GameGlobal.UIStateManager():UnLock("UIFeatureShopInfo_PlayAnimationUnLock")
    end, self)
  end
end

function UIFeatureShopInfo:RefreshCastBtnState()
  local canCast = false
  if #self._newSelectedCellList > 0 then
    canCast = true
  end
  if self._castBtn then
    self._castBtn.interactable = canCast
  end
end

function UIFeatureShopInfo:OnGetCurCellData(cellID)
  local groupDataList = self._shopInitData:GetGroupDataList()
  for i = 1, #groupDataList do
    local curGroupDataList = groupDataList[i]
    for j = 1, #curGroupDataList do
      if curGroupDataList[j].CellID == cellID then
        return curGroupDataList[j]
      end
    end
  end
end

function UIFeatureShopInfo:OnGetCurCellCantSelect(cellID, unlockParamCount)
  if unlockParamCount == 2 and self._showPageIndex == 2 then
    return false
  end
  local targetCellID = 1
  if cellID == 1 then
    targetCellID = 2
  elseif cellID == 2 then
    targetCellID = 1
  elseif cellID == 3 then
    targetCellID = 4
  elseif cellID == 4 then
    targetCellID = 3
  elseif cellID == 5 then
    targetCellID = 6
  elseif cellID == 6 then
    targetCellID = 5
  end
  local targetCellHadInvest = table.icontains(self._selectedCellList, targetCellID)
  if targetCellHadInvest then
    return true
  end
  return false
end

function UIFeatureShopInfo:OnItemCallBack(index, selected)
  self._specificObj:SetActive(true)
  local textSpecificKey = "str_battle_she_feature_ui_skill_" .. index .. "_specific"
  self._textSpecific:SetText(StringTable.Get(textSpecificKey))
  if table.icontains(self._selectedCellList, index) then
    return
  end
  local uiData = self._cellItemUIDatas[index]
  if not uiData then
    return
  end
  if uiData._cantSelect or uiData._isLock or uiData._hadInvest then
    return
  end
  if selected then
    table.insert(self._newSelectedCellList, index)
    self:_CheckSameGroupOhterCellUnselect(index)
  else
    table.removev(self._newSelectedCellList, index)
  end
  self:RefreshCastBtnState()
end

function UIFeatureShopInfo:_CheckSameGroupOhterCellUnselect(cellID)
  local groupIndex = self:GetCellGroupIndex(cellID)
  local otherCellID = self:GetOhterCellInSameGroup(cellID)
  local otherUIData = self._cellItemUIDatas[otherCellID]
  local needUnselect = false
  if not otherUIData._isLock and not otherUIData._hadInvest and not otherUIData._cantSelect then
    local unlockParam = self._shopInitData:GetUnlockParam()
    local unlockParamCount = table.count(unlockParam)
    if unlockParamCount < 2 then
      needUnselect = true
    elseif self._showPageIndex == 1 then
      needUnselect = true
    end
  end
  if needUnselect then
    self._cellItems[otherCellID]:ClearSelect()
    table.removev(self._newSelectedCellList, otherCellID)
  end
end

function UIFeatureShopInfo:_OnGetSameGroupOhterCellUnselect(cellID)
  local groupIndex = self:GetCellGroupIndex(cellID)
  local otherCellID = self:GetOhterCellInSameGroup(cellID)
  if table.icontains(self._selectedCellList, otherCellID) or table.icontains(self._newSelectedCellList, otherCellID) then
    return
  end
  local otherUIData = self._cellItemUIDatas[otherCellID]
  local needUnselect = false
  if not otherUIData._isLock and not otherUIData._hadInvest and not otherUIData._cantSelect then
    local unlockParam = self._shopInitData:GetUnlockParam()
    local unlockParamCount = table.count(unlockParam)
    if unlockParamCount < 2 then
      needUnselect = true
    elseif self._showPageIndex == 1 then
      needUnselect = true
    end
  end
  if needUnselect then
    return otherCellID
  end
end

function UIFeatureShopInfo:CastBtnOnClick()
  if self._castClicked then
    return
  end
  if self._castCb then
    local delayCloseMs = 1633
    if #self._newSelectedCellList > 0 then
      self._castClicked = true
      self._castCb(self._skillID, self._newSelectedCellList, delayCloseMs)
      GameGlobal.UIStateManager():Lock("UIFeatureShopInfo_PlayAnimationHadInvest")
      self:StartTask(function(TT)
        for i = 1, #self._newSelectedCellList do
          local index = self._newSelectedCellList[i]
          self._cellItems[index]:OnPlayAnimHadInvest()
        end
        local cantInvestList = self:_OnGetCantInvestList()
        for i = 1, #cantInvestList do
          local index = cantInvestList[i]
          self._cellItems[index]:OnPlayAnimCantInvest()
        end
        YIELD(TT, 1333)
        self._anim:Play("uieff_UIFeatureShopInfo_out")
        YIELD(TT, 200)
        GameGlobal.UIStateManager():UnLock("UIFeatureShopInfo_PlayAnimationHadInvest")
      end, self)
    end
  end
end

function UIFeatureShopInfo:_OnGetCantInvestList()
  if table.count(self._shopInitData:GetUnlockParam()) == 2 and self._showPageIndex == 2 then
    return {}
  end
  local cantInvestList = {}
  for i = 1, #self._newSelectedCellList do
    local index = self._newSelectedCellList[i]
    local otherCellID = self:_OnGetSameGroupOhterCellUnselect(index)
    if otherCellID then
      table.insert(cantInvestList, otherCellID)
    end
  end
  return cantInvestList
end

function UIFeatureShopInfo:DotBGOnClick()
  if self._cancelCb then
    local delayCloseMs = 200
    self._cancelCb(self._skillID, delayCloseMs)
    self._anim:Play("uieff_UIFeatureShopInfo_out")
  end
end

function UIFeatureShopInfo:GetCellGroupIndex(cellID)
  local cellGroupIndex = 0
  local groupDataList = self._shopInitData:GetGroupDataList()
  for i = 1, #groupDataList do
    local curGroupDataList = groupDataList[i]
    for j = 1, #curGroupDataList do
      if curGroupDataList[j].CellID == cellID then
        cellGroupIndex = i
        break
      end
    end
    if 0 < cellGroupIndex then
      break
    end
  end
  return cellGroupIndex
end

function UIFeatureShopInfo:GetOhterCellInSameGroup(cellID)
  local otherCellID = 0
  local cellGroupIndex = self:GetCellGroupIndex(cellID)
  local groupDataList = self._shopInitData:GetGroupDataList()
  local curGroupDataList = groupDataList[cellGroupIndex]
  for j = 1, #curGroupDataList do
    if curGroupDataList[j].CellID ~= cellID then
      otherCellID = curGroupDataList[j].CellID
      break
    end
  end
  return otherCellID
end
