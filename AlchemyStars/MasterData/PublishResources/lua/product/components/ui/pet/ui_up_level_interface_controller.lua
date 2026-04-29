_class("UIUpLevelInterfaceController", UIController)
UIUpLevelInterfaceController = UIUpLevelInterfaceController

function UIUpLevelInterfaceController:Constructor()
  self._listItemBaseCout = 20
  self._listItemTotalRow = 5
  self._itemCountPerRow = 4
  self._listItemTotalCount = 50
  self._maxMatChooseCount = 9999
  self._petInfo = nil
  self._addExp = 0
  self._arriveLevel = 0
  self._arriveExp = 0
  self._addItemInfos = {}
  self._tItemInfos = nil
  self._AsyncLoadFlagMap = {}
  self._TaskList = {}
  self.items = {}
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
end

function UIUpLevelInterfaceController:GetComponents()
  self._needcoin = self:GetUIComponent("UILocalizationText", "needcoin")
  self._h3dScrollView = self:GetUIComponent("UIDynamicScrollView", "H3DScrollView")
  self._coinGo = self:GetUIComponent("RectTransform", "xiaohaobi")
  self:AttachEvent(GameEventType.PetUpLevelEvent, self.RefreshPetUpLevelEvent)
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self:AttachEvent(GameEventType.PetUpGradeEvent, self.OnItemGraded)
  self._leftLine = self:GetUIComponent("Image", "leftLine")
  self._consumeName = self:GetUIComponent("UILocalizationText", "consumeName")
  self._coinBg = self:GetUIComponent("Image", "coin")
  self._rightLine = self:GetUIComponent("Image", "rightLine")
  local sop = self:GetUIComponent("UISelectObjectPath", "mainmenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.currencyMenu:SetData({
    RoleAssetID.RoleAssetGold
  })
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, true)
    self:CloseDialog()
  end, nil, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
  end)
  self._content = self:GetUIComponent("RectTransform", "PetContent")
  self._left = self:GetUIComponent("Transform", "left")
  self._right = self:GetUIComponent("Transform", "right")
  self._center = self:GetUIComponent("Transform", "center")
  self._leftView = self:GetUIComponent("UIView", "rectLeft")
  self._centerView = self:GetUIComponent("UIView", "rectCenter")
  self._rightView = self:GetUIComponent("UIView", "rectRight")
  self._leftLua = UIUpLevelInfoItem:New()
  self._centerLua = UIUpLevelInfoItem:New()
  self._rightLua = UIUpLevelInfoItem:New()
  self._leftLua:SetView(self._leftView)
  self._centerLua:SetView(self._centerView)
  self._rightLua:SetView(self._rightView)
  self._leftLua:OnShowItem()
  self._centerLua:OnShowItem()
  self._rightLua:OnShowItem()
  self._rectLeft = self:GetUIComponent("RectTransform", "rectLeft")
  self._rectLeft.anchoredPosition = Vector2(-200, 0)
  self._rectCenter = self:GetUIComponent("RectTransform", "rectCenter")
  self._rectCenter.anchoredPosition = Vector2(0, 0)
  self._rectRight = self:GetUIComponent("RectTransform", "rectRight")
  self._rectRight.anchoredPosition = Vector2(200, 0)
  self._alphaLeft = self:GetUIComponent("CanvasGroup", "rectLeft")
  self._alphaLeft.alpha = 0
  self._alphaLeft.blocksRaycasts = false
  self._alphaCenter = self:GetUIComponent("CanvasGroup", "rectCenter")
  self._alphaCenter.alpha = 1
  self._alphaCenter.blocksRaycasts = true
  self._alphaRight = self:GetUIComponent("CanvasGroup", "rectRight")
  self._alphaRight.alpha = 0
  self._alphaRight.blocksRaycasts = false
  self.effAnim = self:GetUIComponent("Animation", "Eff")
  self.effResReq = {}
  self.effGo = {}
  self.effGo.items = {}
  self.effGo.attibutes = {}
  self.levelPanelObj = self:GetGameObject("LevelPanel")
  self.canWeakPanelObj = self:GetGameObject("CanWakePanel")
  self.levelPanelAnim = self:GetUIComponent("Animation", "LevelPanel")
  self.canWeakPanelAnim = self:GetUIComponent("Animation", "CanWakePanel")
  self.tips_can_weak_root = self:GetGameObject("tips_can_weak_root")
  self.tips_weak_max_root = self:GetGameObject("tips_weak_max_root")
  self._upAddQuickBtn = self:GetGameObject("UpAddQuickBtn")
  self._upAddQuickBtnEff = self:GetGameObject("UpAddQuickBtn2")
end

function UIUpLevelInterfaceController:OnShow(uiParams)
  self._mulitOpen = UnityEngine.Input.multiTouchEnabled
  UnityEngine.Input.multiTouchEnabled = false
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self._itemModule = GameGlobal.GameLogic():GetModule(ItemModule)
  self._roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  local petid = uiParams[1]
  self:RequestAllPetInfos()
  self._currIndex = self:FindOpenPetIndex(petid)
  self._currIndexTemp = self._currIndex
  self._petInfo = self._petInfos[self._currIndex]
  self._petPstID = self._petInfo:GetPstID()
  self:GetComponents()
  self:OnShowInfos()
  self:InitPetScrollView()
  self:AttachEvent(GameEventType.OnLevelUpAttValueChanged, self.OnLevelUpAttValueChanged)
  self:AttachEvent(GameEventType.CloseUIUpLevelAddQuickBox, self.CloseUIUpLevelAddQuickBox)
  self:SetLongPressGrade()
  self:RefreshLevelOrCanAWeak(false)
  local etl = UICustomUIEventListener.Get(self._upAddQuickBtn)
  self:AddUICustomEventListener(etl, UIEvent.Press, function(go)
    self:OnDown(go)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    self:OnUp(go)
  end)
end

function UIUpLevelInterfaceController:SetLongPressGrade()
  local grade = self._petInfo:GetPetGrade()
  HelperProxy:GetInstance():SetLongEventGrade(grade)
end

function UIUpLevelInterfaceController:OnHide(go)
  for _, v in pairs(self._TaskList) do
    if v then
      GameGlobal.TaskManager():KillTask(v)
      v = nil
    end
  end
  HelperProxy:GetInstance():SetLongEventGrade(nil)
  UnityEngine.Input.multiTouchEnabled = self._mulitOpen
  self:Release()
  if self._unLockEvent then
    self:UnLock("UpLevelEffPlaying")
    GameGlobal.Timer():CancelEvent(self._unLockEvent)
    self._unLockEvent = nil
  end
  self:DetachEvent(GameEventType.PetUpLevelEvent, self.RefreshPetUpLevelEvent)
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self:DetachEvent(GameEventType.PetUpGradeEvent, self.OnItemGraded)
  self:DetachEvent(GameEventType.CloseUIUpLevelAddQuickBox, self.CloseUIUpLevelAddQuickBox)
end

function UIUpLevelInterfaceController:OnLevelUpAttValueChanged(rate)
  self._centerLua:OnLevelUpAttValueChanged(rate)
end

function UIUpLevelInterfaceController:OnShowInfos()
  if self._petInfos[self._currIndex - 1] then
    self._leftLua:SetData(self._currIndex - 1, self._petInfos[self._currIndex - 1])
  end
  if self._petInfos[self._currIndex] then
    self._centerLua:SetData(self._currIndex, self._petInfos[self._currIndex])
  end
  if self._petInfos[self._currIndex + 1] then
    self._rightLua:SetData(self._currIndex + 1, self._petInfos[self._currIndex + 1])
  end
end

function UIUpLevelInterfaceController:RequestAllPetInfos()
  self._petInfos = self._petModule.uiModule:GetSortedPets()
  self._listShowItemCount = table.count(self._petInfos)
end

function UIUpLevelInterfaceController:FindOpenPetIndex(petid)
  if self._petInfos then
    for index = 1, #self._petInfos do
      if self._petInfos[index]:GetTemplateID() == petid then
        return index
      end
    end
  end
  return 1
end

function UIUpLevelInterfaceController:InitPetScrollView()
  self._itemTable = {}
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "PetScrollView", "UIUpLevelPetDetailItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end, function(index, uiwidget)
    return self:_OnHideItem(index, uiwidget)
  end)
  local safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._listShowItemCount then
      return
    end
    self:_ShowCurrIndexInfo(index + 1)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetListIndexChanged, self._petInfo:GetTemplateID())
  end)
  self._scrollViewHelper:SetValueChangedCallback(function(group, value, contentSize, itemSize)
    self:_OnValueChangedCallBack(group + 1, value, contentSize, itemSize)
  end)
  self._scrollRectWidth = self:GetUIComponent("RectTransform", "PetScrollView").sizeDelta.x
  self._scrollViewHelper:Init(self._listShowItemCount, self._currIndex, safeArea.rect.size)
  if self._listShowItemCount <= 1 then
    local scrollRect = self:GetUIComponent("ScrollRect", "PetScrollView")
    scrollRect.enabled = false
  end
  self._scrollViewHelper:SetNextPageOffset(0.1)
end

function UIUpLevelInterfaceController:_OnShowItem(index, uiwidget)
  if self._itemTable[index] == nil then
    self._itemTable[index] = uiwidget
  end
  local petData = self._petInfos[index]
  local matCgName = petData:GetPetStaticBody(PetSkinEffectPath.BODY_LEVLE_UP)
  uiwidget:SetData(index, petData, self._currIndex)
end

function UIUpLevelInterfaceController:_OnHideItem(index, uiwidget)
  if self._itemTable[index] == nil then
    return
  end
  uiwidget:OnHideCallBack()
end

function UIUpLevelInterfaceController:_ShowCurrIndexInfo(index)
  self._currIndex = index
  if self._notFirst then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpLevelCheckIsCurrent, self._currIndex)
  end
  self._petInfo = self._petInfos[index]
  self._petPstID = self._petInfo:GetPstID()
  self._tItemInfos = self:GetMaterialItemInfos()
  self:ChangeLeftCenterRight()
  self:Reset()
  table.clear(self._addItemInfos)
  table.clear(self.items)
  self:InitItemListView()
  local imageLoader = self:GetUIComponent("RawImageLoader", "BgLoader")
  UICommonHelper:GetInstance():ChangePetTagBackground(self._petInfo:GetTemplateID(), imageLoader, true)
  self._currIndexTemp = self._currIndex
  self:RefreshLevelOrCanAWeak(false)
end

function UIUpLevelInterfaceController:_OnValueChangedCallBack(group, value, contentSize, itemSize)
  local leftRightDis = math.abs(self._left.position.x - self._right.position.x)
  local centerPosition = self._center.position
  for i = self._currIndex - 1, self._currIndex + 1 do
    if self._itemTable[i] then
      self._itemTable[i]:ChangeCanvasGroupAlpha(leftRightDis, centerPosition.x)
    end
  end
  if self._content.localPosition.x > 0 or self._content.localPosition.x < -self._content.sizeDelta.x + self._scrollRectWidth then
    return
  end
  local c2c = self._itemTable[self._currIndex]:GetC2C()
  local nameRate = c2c / leftRightDis
  local posx = nameRate * 200
  self._rectCenter.anchoredPosition = Vector2(posx, 0)
  self._rectLeft.anchoredPosition = Vector2(posx - 200, 0)
  self._rectRight.anchoredPosition = Vector2(posx + 200, 0)
  self._alphaCenter.alpha = 1 - nameRate * 2
  if c2c < 0 then
    self._alphaLeft.alpha = 0
    self._alphaRight.alpha = nameRate * 2
  elseif 0 < c2c then
    self._alphaLeft.alpha = nameRate * 2
    self._alphaRight.alpha = 0
  else
    self._alphaLeft.alpha = 0
    self._alphaRight.alpha = 0
  end
end

function UIUpLevelInterfaceController:OnItemCountChanged()
end

function UIUpLevelInterfaceController:OnItemGraded()
  self:_ShowCurrIndexInfo(self._currIndex)
end

function UIUpLevelInterfaceController:SetColor(isDefaultColor)
  local color
  if isDefaultColor then
    color = Color(0.96, 0.81, 0.14)
  else
    color = Color(1, 0.4, 0.32)
  end
  if color ~= nil then
    self._leftLine.color = color
    self._consumeName.color = color
    self._coinBg.color = color
    self._needcoin.color = color
    self._rightLine.color = color
  end
end

function UIUpLevelInterfaceController:Release()
  self:StopShakeTween()
  self._petInfo = nil
  self._addItemInfos = nil
  self._tItemInfos = nil
  self._petSpineLoader = nil
  self._needcoin = nil
  self._h3dScrollView = nil
  self._coinGo = nil
  self._scrollViewHelper:Dispose()
  if self._centerLua then
    self._centerLua:Dispose()
    self._centerLua = nil
  end
  if self._leftLua then
    self._leftLua:Dispose()
    self._leftLua = nil
  end
  if self._rightLua then
    self._rightLua:Dispose()
    self._rightLua = nil
  end
end

function UIUpLevelInterfaceController:InitItemListView()
  if self._notFirst then
    self:CalculateCreatItemCout()
    self._listItemTotalRow = math.ceil(self._listItemTotalCount / self._itemCountPerRow)
    self._h3dScrollView:SetListItemCount(self._listItemTotalRow)
    self._h3dScrollView:MovePanelToItemIndex(0, 0)
  else
    self._notFirst = true
    self:CalculateCreatItemCout()
    self._listItemTotalRow = math.ceil(self._listItemTotalCount / self._itemCountPerRow)
    if self._h3dScrollView then
      self._h3dScrollView:InitListView(self._listItemTotalRow, function(scrollView, index)
        return self:_InitListView(scrollView, index)
      end)
    end
  end
end

function UIUpLevelInterfaceController:CalculateCreatItemCout()
  if self._tItemInfos == nil then
    self._listItemTotalCount = self._listItemBaseCout
    return
  end
  local itemCout = table.count(self._tItemInfos)
  if itemCout < self._listItemBaseCout then
    self._listItemTotalCount = self._listItemBaseCout
  else
    local totalRowCount = math.ceil(itemCout / self._itemCountPerRow)
    self._listItemTotalCount = totalRowCount * self._itemCountPerRow
  end
end

function UIUpLevelInterfaceController:ChangeLeftCenterRight()
  if self._currIndexTemp > self._currIndex then
    self._rectRight.anchoredPosition = self._rectRight.anchoredPosition - Vector2(400, 0)
    local rightLuaTemp = self._rightLua
    self._rightLua = self._centerLua
    self._centerLua = self._leftLua
    self._leftLua = rightLuaTemp
    local rightRectTemp = self._rectRight
    self._rectRight = self._rectCenter
    self._rectCenter = self._rectLeft
    self._rectLeft = rightRectTemp
    local alphaRightTemp = self._alphaRight
    self._alphaRight = self._alphaCenter
    self._alphaCenter = self._alphaLeft
    self._alphaLeft = alphaRightTemp
    if self._petInfos[self._currIndex - 1] then
      self._leftLua:RefreshData(self._currIndex - 1, self._petInfos[self._currIndex - 1], false)
    end
  elseif self._currIndexTemp < self._currIndex then
    self._rectLeft.anchoredPosition = self._rectLeft.anchoredPosition + Vector2(400, 0)
    local leftLuaTemp = self._leftLua
    self._leftLua = self._centerLua
    self._centerLua = self._rightLua
    self._rightLua = leftLuaTemp
    local leftRectTemp = self._rectLeft
    self._rectLeft = self._rectCenter
    self._rectCenter = self._rectRight
    self._rectRight = leftRectTemp
    local alphaLeftTemp = self._alphaLeft
    self._alphaLeft = self._alphaCenter
    self._alphaCenter = self._alphaRight
    self._alphaRight = alphaLeftTemp
    if self._petInfos[self._currIndex + 1] then
      self._rightLua:RefreshData(self._currIndex + 1, self._petInfos[self._currIndex + 1], false)
    end
  end
  self._alphaCenter.blocksRaycasts = true
  self._alphaRight.blocksRaycasts = false
  self._alphaLeft.blocksRaycasts = false
end

function UIUpLevelInterfaceController:Reset()
  self._needcoin.text = "0"
  local curPetLevel = self._petInfo:GetPetLevel()
  local curPetExp = self._petInfo:GetPetExp()
  self._arriveLevel = curPetLevel
  self._arriveExp = curPetExp
  self._addExp = 0
  if self._petInfos[self._currIndex - 1] then
    self._leftLua:RefreshData(self._currIndex - 1, self._petInfos[self._currIndex - 1])
  end
  if self._petInfos[self._currIndex] then
    self._centerLua:RefreshData(self._currIndex, self._petInfos[self._currIndex])
  end
  if self._petInfos[self._currIndex + 1] then
    self._rightLua:RefreshData(self._currIndex + 1, self._petInfos[self._currIndex + 1])
  end
end

function UIUpLevelInterfaceController:GetHasItemAsyncLoading()
  for _, v in pairs(self._AsyncLoadFlagMap) do
    if v == 1 then
      return true
    end
  end
  return false
end

function UIUpLevelInterfaceController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    if self._TaskList[item] then
      return item
    end
    self._TaskList[item] = self:StartTask(function(TT)
      if 0 < index then
        while self:GetHasItemAsyncLoading() do
          YIELD(TT)
        end
      end
      self._AsyncLoadFlagMap[item] = 1
      rowPool:AsyncSpawnObjects(TT, "UIConsumableMaterialItem", self._itemCountPerRow)
      local rowList = rowPool:GetAllSpawnList()
      for i = 1, self._itemCountPerRow do
        local tMaterialItem = rowList[i]
        tMaterialItem:PlayFadeAnimIn()
        local itemIndex = index * self._itemCountPerRow + i
        if itemIndex > self._listItemTotalCount then
          tMaterialItem:GetGameObject():SetActive(false)
        else
          self:_ShowMaterialItem(tMaterialItem, itemIndex)
          self.items[itemIndex] = tMaterialItem
        end
      end
      YIELD(TT)
      self._AsyncLoadFlagMap[item] = 2
      item.IsInitHandlerCalled = true
    end)
  else
    local rowList = rowPool:GetAllSpawnList()
    for i = 1, self._itemCountPerRow do
      local tMaterialItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      if itemIndex > self._listItemTotalCount then
        tMaterialItem:GetGameObject():SetActive(false)
      else
        self:_ShowMaterialItem(tMaterialItem, itemIndex)
        self.items[itemIndex] = tMaterialItem
      end
    end
  end
  return item
end

function UIUpLevelInterfaceController:_ShowMaterialItem(tMaterialItem, itemIndex)
  local itemInfo = self._addItemInfos[itemIndex]
  local tInfo = self._tItemInfos[itemIndex]
  tMaterialItem:GetGameObject():SetActive(true)
  tMaterialItem:SetData(tInfo, self._petInfo:GetPetFirstElement(), itemInfo, itemIndex, function(tMaterialItem)
    local tInfo = self:AddMaterialItem(tMaterialItem)
    return tInfo
  end, function(tMaterialItem)
    local tInfo = self:ReduceMaterialItem(tMaterialItem)
    return tInfo
  end, function(tMaterialItem)
    local isReach = self:CheckAddOneMaterialLaterReachMaxLevel(tMaterialItem)
    return isReach
  end, self._maxMatChooseCount)
end

function UIUpLevelInterfaceController:AddMaterialItem(tMaterialItem)
  local isHave, index = self:CheckContainMaterialItem(tMaterialItem)
  if isHave == true then
    self._addItemInfos[tMaterialItem.fromeIndex].count = self._addItemInfos[tMaterialItem.fromeIndex].count + tMaterialItem.count
  else
    self._addItemInfos[tMaterialItem.fromeIndex] = tMaterialItem
    self._addItemInfos[tMaterialItem.fromeIndex].assetid = tMaterialItem.assetid
    self._addItemInfos[tMaterialItem.fromeIndex].m_templateid = tMaterialItem.m_templateid
  end
  self:CalculateADD(tMaterialItem)
  return self._addItemInfos[tMaterialItem.fromeIndex]
end

function UIUpLevelInterfaceController:ReduceMaterialItem(tMaterialItem)
  local isHave, index = self:CheckContainMaterialItem(tMaterialItem)
  if isHave == false then
    return nil
  end
  if isHave == true then
    self._addItemInfos[tMaterialItem.fromeIndex].count = self._addItemInfos[tMaterialItem.fromeIndex].count - 1
    local count = self._addItemInfos[tMaterialItem.fromeIndex].count
    if count <= 0 then
      self._addItemInfos[tMaterialItem.fromeIndex] = nil
    end
  end
  self:CalculateReduce(tMaterialItem)
  return self._addItemInfos[tMaterialItem.fromeIndex]
end

function UIUpLevelInterfaceController:CheckContainMaterialItem(tMaterialItem)
  if self._addItemInfos == nil then
    return false, -1
  end
  for index, tInfo in pairs(self._addItemInfos) do
    if tInfo.assetid == tMaterialItem.assetid then
      return true, index
    end
  end
  return false, -1
end

function UIUpLevelInterfaceController:CalculateADD(tMaterialItem)
  if tMaterialItem == nil then
    return
  end
  local perItemAddExp = self._itemModule:GetItemToPetExp(tMaterialItem.m_templateid)
  perItemAddExp = self:CalculateFinalExp(perItemAddExp, tMaterialItem.m_templateid)
  self._addExp = self._addExp + tMaterialItem.count * perItemAddExp
  self._centerLua:StopTween()
  local isUpLevel, isUpMaxLevel = self:CheckReachMaxLevelByAddExp()
  self:Refresh(isUpLevel, isUpMaxLevel)
end

function UIUpLevelInterfaceController:CalculateFinalExp(itemAddExp, m_templateid)
  local cfg = Cfg.cfg_item_pet_exp[m_templateid]
  local tItemAddExp = itemAddExp
  local firstElement = self._petInfo:GetPetFirstElement()
  if cfg.Element == firstElement then
    local add = Cfg.cfg_global.ElementAddExp.IntValue
    tItemAddExp = itemAddExp * (add + 100) * 0.01
  end
  return math.floor(tItemAddExp)
end

function UIUpLevelInterfaceController:CalculateReduce(tMaterialItem)
  if tMaterialItem == nil then
    return
  end
  local perItemAddExp = self._itemModule:GetItemToPetExp(tMaterialItem.m_templateid)
  perItemAddExp = self:CalculateFinalExp(perItemAddExp, tMaterialItem.m_templateid)
  self._addExp = self._addExp - tMaterialItem.count * perItemAddExp
  self._centerLua:StopTween()
  local isUpLevel, isUpMaxLevel = self:CheckReachMaxLevelByAddExp()
  self:Refresh(isUpLevel, isUpMaxLevel)
end

function UIUpLevelInterfaceController:CheckAddOneMaterialLaterReachMaxLevel(iteminfo)
  local petMaxLevel = self._petInfo:GetMaxLevel()
  local isContinueADDItem = petMaxLevel <= self._arriveLevel
  return isContinueADDItem
end

function UIUpLevelInterfaceController:CheckReachMaxLevelByAddExp()
  local isUpLevel = false
  local isUpMaxLevel = false
  local curGradeMaxLevel = self._petInfo:GetMaxLevel()
  self._arriveLevel = self._petInfo:GetPetLevel()
  self._arriveExp = self._petInfo:GetPetExp()
  local tAddExp = self._addExp
  while true do
    local levelConfig = self._petInfo:GetLevelConfig(self._arriveLevel + 1)
    if levelConfig == nil then
      break
    end
    local lerpExp = levelConfig.NeedExp - self._arriveExp
    if 0 <= tAddExp - lerpExp then
      isUpLevel = true
      tAddExp = tAddExp - lerpExp
      self._arriveLevel = self._arriveLevel + 1
      if curGradeMaxLevel <= self._arriveLevel then
        isUpMaxLevel = true
        break
      end
      self._arriveExp = 0
    else
      self._arriveExp = self._arriveExp + tAddExp
      break
    end
  end
  return isUpLevel, isUpMaxLevel
end

function UIUpLevelInterfaceController:CalculateNeedMoney()
  local neeUpLevelTotalMoney = 0
  local curLevel = self._petInfo:GetPetLevel()
  local curExp = self._petInfo:GetPetExp()
  if curLevel == self._arriveLevel and curExp == self._arriveExp then
    return 0
  end
  if curLevel == self._arriveLevel then
    local tAddExp = self._arriveExp - curExp
    local levelConfig = self._petInfo:GetLevelConfig(self._arriveLevel + 1)
    neeUpLevelTotalMoney = neeUpLevelTotalMoney + levelConfig.NeedGold * (tAddExp / levelConfig.NeedExp)
    return math.ceil(neeUpLevelTotalMoney)
  end
  local _lconf = self._petInfo:GetLevelConfig(curLevel + 1)
  local tAddExp = _lconf.NeedExp - curExp
  neeUpLevelTotalMoney = neeUpLevelTotalMoney + _lconf.NeedGold * (tAddExp / _lconf.NeedExp)
  curLevel = curLevel + 1
  local curGradeMaxLevel = self._petInfo:GetMaxLevel()
  for level = curLevel, self._arriveLevel do
    if level == curGradeMaxLevel then
      break
    end
    if level == self._arriveLevel then
      local levelConfig = self._petInfo:GetLevelConfig(level + 1)
      neeUpLevelTotalMoney = neeUpLevelTotalMoney + levelConfig.NeedGold * (self._arriveExp / levelConfig.NeedExp)
    else
      local levelConfig = self._petInfo:GetLevelConfig(level + 1)
      neeUpLevelTotalMoney = neeUpLevelTotalMoney + levelConfig.NeedGold
    end
  end
  return math.ceil(neeUpLevelTotalMoney)
end

function UIUpLevelInterfaceController:RefreshPetUpLevelEvent()
  self.items = {}
  self._addItemInfos = {}
  self._addExp = 0
  self._tItemInfos = self:GetMaterialItemInfos()
  self:CalculateCreatItemCout()
  self._listItemTotalRow = math.ceil(self._listItemTotalCount / self._itemCountPerRow)
  self._h3dScrollView:SetListItemCount(self._listItemTotalRow, false)
  self._h3dScrollView:RefreshAllShownItem()
  if self._listItemTotalCount > self._listItemBaseCout then
    self._h3dScrollView:MovePanelToItemIndex(0, 0)
  end
  self._needcoin.text = "0"
  local curPetLevel = self._petInfo:GetPetLevel()
  local curPetExp = self._petInfo:GetPetExp()
  self._arriveLevel = curPetLevel
  self._arriveExp = curPetExp
  self._addExp = 0
  if self._petInfos[self._currIndex] then
    self._centerLua:RefreshPetUpLevelEvent(self._currIndex, self._petInfos[self._currIndex])
  end
end

function UIUpLevelInterfaceController:GetSliderTweenData()
  local curGradeMaxLevel = self._petInfo:GetMaxLevel()
  local tAddExp = self._addExp
  local _arriveLevel = self._petInfo:GetPetLevel()
  local _arriveExp = self._petInfo:GetPetExp()
  local isInsert = false
  local _stepList = {}
  while true do
    local levelConfig = self._petInfo:GetLevelConfig(_arriveLevel + 1)
    if levelConfig == nil then
      break
    end
    local _step = {}
    local lerpExp = levelConfig.NeedExp - _arriveExp
    if 0 <= tAddExp - lerpExp then
      if isInsert == false then
        _step.Start = _arriveExp / levelConfig.NeedExp
      end
      tAddExp = tAddExp - lerpExp
      _arriveLevel = _arriveLevel + 1
      if curGradeMaxLevel <= _arriveLevel then
        _arriveLevel = curGradeMaxLevel
        _arriveExp = levelConfig.NeedExp
        _step.End = 1
        if isInsert == false then
          isInsert = true
          _step.End = 1
          table.insert(_stepList, _step)
        end
        break
      end
      if isInsert == false then
        isInsert = true
        _step.End = 1
        table.insert(_stepList, _step)
      end
      _arriveExp = 0
    else
      _step.Start = _arriveExp / levelConfig.NeedExp
      _arriveExp = _arriveExp + tAddExp
      _step.End = _arriveExp / levelConfig.NeedExp
      table.insert(_stepList, _step)
      break
    end
  end
  return _stepList
end

function UIUpLevelInterfaceController:Refresh(isUpLevel, isUpMaxLevel)
  self._centerLua:Refresh(isUpLevel, isUpMaxLevel, self._arriveLevel, self._arriveExp, self._addExp)
  self._needcoin.text = HelperProxy:GetInstance():FormatGold(self:CalculateNeedMoney())
end

function UIUpLevelInterfaceController:GetLevelLerpAttChangeData(tReachLevel)
  local curLevel = self._petInfo:GetPetLevel()
  local curLevelConfig = self._petInfo:GetLevelConfig(curLevel)
  local nextLevelConfig = self._petInfo:GetLevelConfig(tReachLevel)
  local attackValue = self._petInfo:GetPetAttack()
  local defenceValue = self._petInfo:GetPetDefence()
  local healthValue = self._petInfo:GetPetHealth()
  local attAttack = {}
  attAttack.attValue = attackValue
  local attDefence = {}
  attDefence.attValue = defenceValue
  local attHealth = {}
  attHealth.attValue = healthValue
  local curInfos = {}
  table.insert(curInfos, attAttack)
  table.insert(curInfos, attDefence)
  table.insert(curInfos, attHealth)
  local nextLevelAttackConfig = 0
  local nextLevelDefenceConfig = 0
  local nextLevelHealthConfig = 0
  if tReachLevel > curLevel then
    nextLevelAttackConfig = nextLevelConfig.Attack - curLevelConfig.Attack
    nextLevelDefenceConfig = nextLevelConfig.Defence - curLevelConfig.Defence
    nextLevelHealthConfig = nextLevelConfig.Health - curLevelConfig.Health
  elseif curLevel == tReachLevel then
  else
    Log.fatal("[PetLevelUp] target level error: ", tReachLevel)
  end
  local attNextAttack = {}
  attNextAttack.attValue = attackValue + nextLevelAttackConfig
  local attNextDefence = {}
  attNextDefence.attValue = defenceValue + nextLevelDefenceConfig
  local attNextHealth = {}
  attNextHealth.attValue = healthValue + nextLevelHealthConfig
  local nextInfos = {}
  table.insert(nextInfos, attNextAttack)
  table.insert(nextInfos, attNextDefence)
  table.insert(nextInfos, attNextHealth)
  local attInfos = {}
  for index = 1, 3 do
    local info = {}
    info.attType = index
    info.CurAttValue = curInfos[index].attValue
    info.NextAttValue = nextInfos[index].attValue
    table.insert(attInfos, info)
  end
  return attInfos
end

function UIUpLevelInterfaceController:_ShowAttItem(tAttItem, attInfo, index)
  tAttItem:GetGameObject():SetActive(true)
  tAttItem:SetData(attInfo)
end

function UIUpLevelInterfaceController:GetMaterialItemInfos()
  local itemInfos = {}
  itemInfos = self._petModule:GetPetExpItems(self._petInfo:GetPstID())
  return itemInfos
end

function UIUpLevelInterfaceController:StopShakeTween()
  if self.tweer then
    self.tweer:Kill()
    self._coinGo.anchoredPosition = Vector2(0, 0)
  end
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
end

function UIUpLevelInterfaceController:StartTimer()
  self.event = GameGlobal.Timer():AddEvent(self._waitTime, function()
    self:SetColor(true)
  end)
end

function UIUpLevelInterfaceController:DOShakePosition()
  if self.tweer and self.tweer:IsPlaying() then
    return
  end
  self:StopShakeTween()
  self:SetColor(false)
  self.tweer = self._coinGo:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self:StartTimer()
  end)
end

function UIUpLevelInterfaceController:UpLevelBtnOnClick(go)
  local cionNum = self._roleModule:GetGold()
  if cionNum < self:CalculateNeedMoney() then
    self:DOShakePosition()
    return
  end
  local petLevel = self._petInfo:GetPetLevel()
  local petMaxLevel = self._petInfo:GetMaxLevel()
  if petLevel >= petMaxLevel then
    return
  end
  if table.count(self._addItemInfos) <= 0 then
    return
  end
  self._centerLua:StopTween()
  self._stepListInfos = self:GetSliderTweenData()
  local pstID = self._petInfo:GetPstID()
  local tSendItemsInfos = {}
  for key, value in pairs(self._addItemInfos) do
    local sendInfo = ItemAsset:New()
    sendInfo.assetid = value.assetid
    sendInfo.count = value.count
    table.insert(tSendItemsInfos, sendInfo)
  end
  self:StartUpLevel(pstID, tSendItemsInfos)
end

function UIUpLevelInterfaceController:StartUpLevel(pstID, tSendItemsInfos)
  GameGlobal.TaskManager():StartTask(self.UpLevelEvent, self, pstID, tSendItemsInfos)
end

function UIUpLevelInterfaceController:UpLevelEvent(TT, pstID, tSendItemsInfos)
  self:Lock(self:GetName())
  local fromLevel = self._petInfo:GetPetLevel()
  self._lastLevel = fromLevel
  local fromAtk = self._petInfo:GetPetAttack()
  local fromDef = self._petInfo:GetPetDefence()
  local fromHp = self._petInfo:GetPetHealth()
  local res = self._petModule:RequestPetAddExp(TT, pstID, tSendItemsInfos)
  local result = res:GetResult()
  if result == PET_RESULT_CODE.PET_SUCCEED or result == PET_RESULT_CODE.PET_ADD_EXP_ONLY then
    local varyPetInfo = self._petModule:GetPet(pstID)
    self._petInfo = varyPetInfo
    local toLevel = self._petInfo:GetPetLevel()
    local toAtk = self._petInfo:GetPetAttack()
    local toDef = self._petInfo:GetPetDefence()
    local toHp = self._petInfo:GetPetHealth()
    local pstID = self._petInfo:GetPstID()
    self._petModule.uiModule:SetCurSelctPet(varyPetInfo)
    self:ShowEff(fromLevel, toLevel, fromAtk, toAtk, fromDef, toDef, fromHp, toHp, self._stepListInfos[#self._stepListInfos].End)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetUpLevelEvent)
    local tplID = varyPetInfo:GetTemplateID()
    local pm = GameGlobal.GetModule(PetAudioModule)
    pm:PlayPetAudio("LevelUp", tplID)
    self:RefreshLevelOrCanAWeak(true)
  else
    local errmsg = self._petModule:GetErrorMsg(result)
    ToastManager.ShowToast(errmsg)
  end
  self:UnLock(self:GetName())
end

function UIUpLevelInterfaceController:UpLevelCanceRefresh()
  if table.count(self._addItemInfos) <= 0 then
    return
  end
  self._addItemInfos = {}
  self:Reset()
  self:CalculateCreatItemCout()
  self._listItemTotalRow = math.ceil(self._listItemTotalCount / self._itemCountPerRow)
  self._h3dScrollView:SetListItemCount(self._listItemTotalRow, false)
  self._h3dScrollView:RefreshAllShownItem()
  if self._listItemTotalCount > self._listItemBaseCout then
    self._h3dScrollView:MovePanelToItemIndex(0, 0)
  end
end

function UIUpLevelInterfaceController:CancelBtnOnClick(go)
  self:UpLevelCanceRefresh()
end

function UIUpLevelInterfaceController:ShowEff(from, to, fromAtk, toAtk, fromDef, toDef, fromHp, toHp, endPercent)
  if from < to then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundLevelUp)
  end
  for _, item in pairs(self._addItemInfos) do
    local idx = item.fromeIndex
    local childIdx = idx % self._itemCountPerRow
    if childIdx == 0 then
      childIdx = self._itemCountPerRow
    end
    local rawIdx = math.ceil(idx / self._itemCountPerRow)
    local rawGo = self._h3dScrollView:GetShownItemByItemIndex(rawIdx - 1)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", rawGo.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    local pos = rowList[childIdx]:GetGameObject().transform.position
    local eff = self.effGo.items[idx]
    if eff then
      self.effGo.items[idx]:SetActive(false)
    else
      local resReq = ResourceManager:GetInstance():SyncLoadAsset("uieff_UIUpLevelInterfaceController_wupin.prefab", LoadType.GameObject)
      self.effResReq[#self.effResReq + 1] = resReq
      eff = resReq.Obj
      eff.transform:SetParent(self.effAnim.transform)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effGo.items[idx] = eff
    end
    eff.transform.position = pos
    eff:SetActive(true)
  end
  self._centerLua:OnAnimFinished()
  if self:CheckIsUpLevel() then
    self._centerLua:PlayLevelUpEffect()
  end
  self:PlayAttributeAnim()
end

function UIUpLevelInterfaceController:PlayAttributeAnim()
  GameGlobal.TaskManager():StartTask(self._AttributeAnimCoro, self)
end

function UIUpLevelInterfaceController:_AttributeAnimCoro(TT)
  self:Lock("UIUpLevelInterfaceController_AttributeAnimCoro")
  self._centerLua:StartPlayAttributeAmin()
  while not self._centerLua:AttValueAnimUpdate(UnityEngine.Time.deltaTime) do
    YIELD(TT)
  end
  self:UnLock("UIUpLevelInterfaceController_AttributeAnimCoro")
end

function UIUpLevelInterfaceController:CheckIsUpLevel()
  local currentLevel = self._petInfo:GetPetLevel()
  if currentLevel == self._lastLevel then
    return false
  else
    return true
  end
end

function UIUpLevelInterfaceController:GetMaterialItem(index)
  if self.items[index] then
    return self.items[index].uiItem:GetBtn()
  else
    return nil
  end
end

function UIUpLevelInterfaceController:ShowLevelInfo(level)
  self._centerLua:ShowLevelInfo(level)
end

function UIUpLevelInterfaceController:GetGuideScroll()
  return self:GetUIComponent("ScrollRect", "H3DScrollView")
end

function UIUpLevelInterfaceController:UpAddQuickBtnOnClick(go)
end

function UIUpLevelInterfaceController:CloseUIUpLevelAddQuickBox(useItems)
  if not useItems then
    return
  end
  if not self.items then
    return
  end
  self:UpLevelCanceRefresh()
  
  local function filterFun(templateid)
    for index, item in ipairs(self.items) do
      if item._itemInfo.m_template_data.ID == templateid then
        return index, item
      end
    end
  end
  
  for index, value in ipairs(useItems) do
    local idx, item = filterFun(value[1])
    if item then
      self._addItemInfos[idx] = item
      self._addItemInfos[idx].fromeIndex = idx
      self._addItemInfos[idx].assetid = item._itemInfo.m_data.item_pstid
      self._addItemInfos[idx].m_templateid = item._itemInfo.m_template_data.ID
      self._addItemInfos[idx].count = value[2]
      self:CalculateADD(self._addItemInfos[idx])
      self:_ShowMaterialItem(self._addItemInfos[idx], idx)
    end
  end
end

function UIUpLevelInterfaceController:RefreshLevelOrCanAWeak(needAnim)
  local petLevel = self._petInfo:GetPetLevel()
  local petMaxLevel = self._petInfo:GetMaxLevel()
  local petGrade = self._petInfo:GetPetGrade()
  self.levelPanelObj:SetActive(false)
  self.canWeakPanelObj:SetActive(false)
  if petLevel >= petMaxLevel then
    self.canWeakPanelObj:SetActive(true)
    if needAnim then
      self.levelPanelAnim:Play("uieff_SpiritLevelUp_LevelPanel_out")
      self.canWeakPanelAnim:Play("uieff_SpiritLevelUp_CanWakePanel_in")
    end
    if petGrade >= self._petInfo:GetMaxGrade() then
      self.tips_can_weak_root:SetActive(false)
      self.tips_weak_max_root:SetActive(true)
      return
    else
      self.tips_can_weak_root:SetActive(true)
      self.tips_weak_max_root:SetActive(false)
    end
    self:_CheckGuide()
    return
  end
  self.levelPanelObj:SetActive(true)
end

function UIUpLevelInterfaceController:_CheckGuide()
  local oldGuideIsDone = GameGlobal.GetModule(GuideModule):IsGuideDone(1070)
  if not oldGuideIsDone then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIUpLevelInterfaceController)
  end
end

function UIUpLevelInterfaceController:GradeButtonOnClick(go)
  local petInfo = self._petInfo
  local petId = petInfo:GetTemplateID()
  self.SkipTransitionAmin = true
  self:ShowDialog("UIGradeInterfaceController", petId, function()
    self.SkipTransitionAmin = true
    self:CloseDialog()
  end)
end

function UIUpLevelInterfaceController:OnDown(go)
  self._upAddQuickBtnEff:SetActive(true)
end

function UIUpLevelInterfaceController:OnUp(go)
  local petLevel = self._petInfo:GetPetLevel()
  local petMaxLevel = self._petInfo:GetMaxLevel()
  if petLevel >= petMaxLevel then
    ToastManager.ShowToast(StringTable.Get("str_pet_config_levelup_max_tip"))
    return
  end
  if not self._petInfo then
    return
  end
  self:ShowDialog("UIUpLevelAddQuickBox", self._petInfo)
  self._upAddQuickBtnEff:SetActive(false)
end
