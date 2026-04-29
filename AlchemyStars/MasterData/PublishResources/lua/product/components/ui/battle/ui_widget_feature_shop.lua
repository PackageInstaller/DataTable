_class("UIWidgetFeatureShop", UICustomWidget)
UIWidgetFeatureShop = UIWidgetFeatureShop

function UIWidgetFeatureShop:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureShop:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIWidgetFeatureShop:InitWidget()
  self.enableFakeInput = true
  self._shopUiName = "UIFeatureShopInfo"
  self._skillID = 0
  self._coinCount = self:GetUIComponent("UILocalizationText", "CoinCount")
  self._redPoint = self:GetGameObject("uieff_NewInfo")
  if self._redPoint then
    self._redPoint:SetActive(false)
  end
  self._switchTimeEvent = nil
  self._switchTimeLength = 100
  self:RegisterEvent()
end

function UIWidgetFeatureShop:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureCoinCountChange, self._OnFeatureCoinCountChange)
  self:AttachEvent(GameEventType.FeatureRedPointUpdate, self._OnFeatureRedPointUpdate)
end

function UIWidgetFeatureShop:SetData(shopInitInfo)
  self._shopInitInfo = shopInitInfo
  local enterValue = shopInitInfo:GetEnterCoinCount()
  self._skillID = shopInitInfo:GetSkillID()
  self:SetValue(enterValue)
end

function UIWidgetFeatureShop:UIWidgetFeatureShopOnClick(go)
  if InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:OnClickUI()
end

function UIWidgetFeatureShop:OnClickUI()
  local canCastSkill = true
  if canCastSkill then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
      self:ShowShopInfoUI()
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      if self._switchTimeEvent == nil then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISwitchActiveSkillUI)
        self:ShowShopInfoUI()
        Log.notice("preclickhead card skill", self._skillID)
        self._switchTimeEvent = GameGlobal.Timer():AddEvent(self._switchTimeLength, function()
          self._switchTimeEvent = nil
          Log.notice("preview card skill", self._skillID)
        end)
      else
        Log.notice("still in switch", self._skillID)
      end
    end
  end
end

function UIWidgetFeatureShop:ShowShopInfoUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, true, FeatureType.Shop)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillCast)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PauseGuideWeakLine)
  local canCast = true
  
  local function castCb(castSkillID, selectInfo, delayCloseMs)
    self:OnCastSkill(castSkillID, selectInfo, delayCloseMs)
  end
  
  local function cancelCb(curSkillID, delayCloseMs)
    self:OnCancelSkill(curSkillID, delayCloseMs)
  end
  
  self:ShowDialog(self._shopUiName, self._shopInitInfo, self._curVal, castCb, cancelCb)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickUI2ClosePreviewMonster)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, FeatureType.Shop, self._skillID)
end

function UIWidgetFeatureShop:SetValue(coinCount)
  self._curVal = coinCount
  self:_SetUiValue(self._curVal)
end

function UIWidgetFeatureShop:_SetUiValue(sanValue)
  if sanValue < 0 then
    sanValue = 0
  end
  sanValue = math.floor(sanValue + 0.5)
  self._coinCount:SetText(sanValue)
  self:_OnFeatureRedPointUpdate()
end

function UIWidgetFeatureShop:_OnFeatureRedPointUpdate()
  if self._redPoint then
    local showRedPoint = self:_OnCehckFeatureShopRedPoint(self._curVal)
    self._redPoint:SetActive(showRedPoint)
  end
end

function UIWidgetFeatureShop:OnGetCurCellData(cellID)
  local groupDataList = self._shopInitInfo:GetGroupDataList()
  for i = 1, #groupDataList do
    local curGroupDataList = groupDataList[i]
    for j = 1, #curGroupDataList do
      if curGroupDataList[j].CellID == cellID then
        return curGroupDataList[j]
      end
    end
  end
end

function UIWidgetFeatureShop:OnGetCurCellCantSelect(cellID, unlockParamCount, showPageIndex)
  local selectedCellList = FeatureServiceHelper.GetShopSelectedCellList()
  if unlockParamCount == 2 and showPageIndex == 2 then
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
  local targetCellHadInvest = table.icontains(selectedCellList, targetCellID)
  if targetCellHadInvest then
    return true
  end
  return false
end

function UIWidgetFeatureShop:_OnCehckFeatureShopRedPoint(sanValue)
  local showRedPoint = false
  local selectedCellList = FeatureServiceHelper.GetShopSelectedCellList()
  if table.count(selectedCellList) == 6 then
    return showRedPoint
  end
  local unlockParam = self._shopInitInfo:GetUnlockParam()
  local unlockParamCount = table.count(unlockParam)
  local eachGroupCellCount = 2
  local showPageIndex = 1
  if 1 < unlockParamCount then
    local firstSelectCount = 0
    if table.icontains(selectedCellList, 1) or table.icontains(selectedCellList, 2) then
      firstSelectCount = firstSelectCount + 1
    end
    if table.icontains(selectedCellList, 3) or table.icontains(selectedCellList, 4) then
      firstSelectCount = firstSelectCount + 1
    end
    if table.icontains(selectedCellList, 5) or table.icontains(selectedCellList, 6) then
      firstSelectCount = firstSelectCount + 1
    end
    if firstSelectCount == 3 then
      showPageIndex = 2
    end
  end
  local curUnlockParam = unlockParam[showPageIndex]
  local curStage = #curUnlockParam
  local curStageMin = 0
  local curStageMax = 0
  for i = 1, #curUnlockParam do
    if sanValue <= curUnlockParam[i] then
      curStage = i
      break
    end
  end
  local matchPet = InnerGameHelperRender.GetLocalMatchPetByTemplateID(1602181)
  local curEquipLv = matchPet:GetEquipLv()
  for i = 1, 6 do
    if not table.icontains(selectedCellList, i) then
      local curCellData = self:OnGetCurCellData(i)
      local equipLevelLimit = curCellData.NeedEquipLevel or 0
      local groupIndex = math.floor((i - 1) / eachGroupCellCount) + 1
      local unlockNeedCount = curUnlockParam[groupIndex]
      local isLock = curEquipLv < equipLevelLimit or sanValue < unlockNeedCount and curStage == 1
      local cantSelect = self:OnGetCurCellCantSelect(i, unlockParamCount, showPageIndex) or sanValue < unlockNeedCount
      if isLock == false and cantSelect == false then
        showRedPoint = true
      end
      if showRedPoint == true then
        break
      end
    end
  end
  return showRedPoint
end

function UIWidgetFeatureShop:_OnFeatureCoinCountChange(curValue, oldValue, modifyValue)
  self._curVal = self._curVal + modifyValue
  self:SetValue(self._curVal)
end

function UIWidgetFeatureShop:OnCastSkill(castSkillID, selectInfo, delayCloseMs)
  self:Lock("UIAnimOnShopCast")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CastShopSkill, castSkillID, selectInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
  self:HideShopInfoUI(delayCloseMs)
end

function UIWidgetFeatureShop:OnCancelSkill(curSkillID, delayCloseMs)
  if delayCloseMs and 0 < delayCloseMs then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self._timerHandler = GameGlobal.Timer():AddEvent(delayCloseMs, function()
      self:OnCancelSkillDo(curSkillID, delayCloseMs)
    end)
  else
    self:OnCancelSkillDo(curSkillID, delayCloseMs)
  end
end

function UIWidgetFeatureShop:OnCancelSkillDo(curSkillID, delayCloseMs)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewFeatureSkill, false, true, curSkillID, FeatureType.Shop)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  self:HideShopInfoUI(delayCloseMs)
end

function UIWidgetFeatureShop:HideShopInfoUI(delayCloseMs)
  if delayCloseMs and 0 < delayCloseMs then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self._timerHandler = GameGlobal.Timer():AddEvent(delayCloseMs, function()
      self:UnLock("UIAnimOnShopCast")
      GameGlobal.UIStateManager():CloseDialog(self._shopUiName)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, FeatureType.Shop)
    end)
  else
    self:UnLock("UIAnimOnShopCast")
    GameGlobal.UIStateManager():CloseDialog(self._shopUiName)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, FeatureType.Shop)
  end
end
