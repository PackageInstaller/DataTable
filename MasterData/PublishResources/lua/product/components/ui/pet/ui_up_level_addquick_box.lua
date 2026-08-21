_class("UIUpLevelAddQuickBox", UIController)
UIUpLevelAddQuickBox = UIUpLevelAddQuickBox

function UIUpLevelAddQuickBox:Constructor()
  self._pressTime = Cfg.cfg_global.sale_and_use_press_long_deltaTime.IntValue
  self._maxMatChooseCount = 9999
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self._itemModule = GameGlobal.GameLogic():GetModule(ItemModule)
  self._roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
end

function UIUpLevelAddQuickBox:OnShow(uiParams)
  self._petInfo = uiParams[1]
  self._petid = self._petInfo:GetTemplateID()
  self._curPetLevel = 0
  self._nextPetLevel = 0
  self._isAdd = true
  self._levelOffset = 0
  self._updateTime = 0
  self._addItemInfos = {}
  self._useItems = {}
  self._useCoin = 0
  self._overExp = 0
  self._totleExp = 0
  self._canReachLevels = {}
  self:RequestPetInfo()
  self:InitWidget()
  self:InitUI()
  self:FlushItemPanel()
end

function UIUpLevelAddQuickBox:RequestPetInfo()
  self._petPstID = self._petInfo:GetPstID()
  self._expItemList, self._colorItems, self._normalItems = self:GetFilterExpItems()
  self._curPetLevel = self._petInfo:GetPetLevel()
  self._curPetExp = self._petInfo:GetPetExp()
  self._nextPetLevel = self._curPetLevel
end

function UIUpLevelAddQuickBox:GetCanReachLevels(TT)
  self._canAdd = false
  local petMaxLevel = self:GetEnableMaxLevel()
  
  local function checkContent(tab, num)
    for index, value in ipairs(tab) do
      if value == num then
        return true
      end
    end
    return false
  end
  
  for i = self._curPetLevel, petMaxLevel do
    local useItems = self:CalculateItemUse(i)
    local endLevel = self:CheckPreview(useItems)
    if not checkContent(self._canReachLevels, endLevel) then
      table.insert(self._canReachLevels, endLevel)
    end
    YIELD(TT)
  end
  table.sort(self._canReachLevels, function(a, b)
    return a < b
  end)
  self._canAdd = true
  Log.fatal("")
end

function UIUpLevelAddQuickBox:InitWidget()
  self._curlevel = self:GetUIComponent("UILocalizationText", "curlevel")
  self._nextlevel = self:GetUIComponent("UILocalizationText", "nextlevel")
  self._addExp = self:GetUIComponent("UILocalizationText", "addExp")
  self._itemCount = self:GetUIComponent("UILocalizationText", "itemCount")
  self._expText = self:GetUIComponent("UILocalizationText", "expText")
  self._costCount = self:GetUIComponent("UILocalizationText", "costCount")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  local path = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self._tips = path:SpawnObject("UISelectInfo")
  self._listRcet = self:GetUIComponent("RectTransform", "list")
  self._contentRcet = self:GetUIComponent("RectTransform", "Content")
  self._addBtn = self:GetGameObject("addBtn")
  self._subBtn = self:GetGameObject("subBtn")
  self._addBtnMult = self:GetGameObject("addMultBtn")
  self._subBtnMult = self:GetGameObject("subMultBtn")
  self._nextObj = self:GetGameObject("next")
  self._maxObj = self:GetGameObject("max")
  self._expCalCulate = self:GetUIComponent("UILocalizationText", "expCalCulate")
  self._addCalCulate = self:GetUIComponent("UILocalizationText", "addCalCulate")
  self._expSlider = self:GetUIComponent("Slider", "expSlider")
  self._addSlider = self:GetUIComponent("Slider", "addSlider")
  self._safeArea = self:GetGameObject("safeArea")
  local sop = self:GetUIComponent("UISelectObjectPath", "mainmenu")
  self.currencyMenu = sop:SpawnObject("UICurrencyMenu")
  self.currencyMenu:SetData({
    RoleAssetID.RoleAssetGold
  })
  self._isAddMouseDown = false
  self._isSubMouseDown = false
  self._isTenStep = false
  local etlAdd = UILongPressTriggerListener.Get(self._addBtn)
  
  function etlAdd.onLongPress(go)
    self._isTenStep = false
    if self._isAddMouseDown == false then
      self._isAddMouseDown = true
    end
  end
  
  function etlAdd.onLongPressEnd(go)
    if self._isAddMouseDown == true then
      self._isAddMouseDown = false
    end
  end
  
  local etlSub = UILongPressTriggerListener.Get(self._subBtn)
  
  function etlSub.onLongPress(go)
    self._isTenStep = false
    if self._isSubMouseDown == false then
      self._isSubMouseDown = true
    end
  end
  
  function etlSub.onLongPressEnd(go)
    if self._isSubMouseDown == true then
      self._isSubMouseDown = false
    end
  end
  
  local etlAdd = UILongPressTriggerListener.Get(self._addBtnMult)
  
  function etlAdd.onLongPress(go)
    self._isTenStep = true
    if self._isAddMouseDown == false then
      self._isAddMouseDown = true
    end
  end
  
  function etlAdd.onLongPressEnd(go)
    if self._isAddMouseDown == true then
      self._isAddMouseDown = false
    end
    self._isTenStep = false
  end
  
  local etlSub = UILongPressTriggerListener.Get(self._subBtnMult)
  
  function etlSub.onLongPress(go)
    self._isTenStep = true
    if self._isSubMouseDown == false then
      self._isSubMouseDown = true
    end
  end
  
  function etlSub.onLongPressEnd(go)
    if self._isSubMouseDown == true then
      self._isSubMouseDown = false
    end
    self._isTenStep = false
  end
  
  self._lastNum = self._addSlider.value
  UIEventTriggerListener.Get(self._addSlider.gameObject).onDrag = function(go)
    self._realValue = self._addSlider.value
    self._realValue = self._nextPetLevel
    self._lastNum = self._realValue
    self._expText.gameObject:SetActive(false)
    self._addExp.gameObject:SetActive(false)
    self._expCalCulate.gameObject:SetActive(true)
    self._addCalCulate.gameObject:SetActive(true)
    self:OnChangeViewDrag()
  end
  UIEventTriggerListener.Get(self._addSlider.gameObject).onEndDrag = function(go)
    self._expText.gameObject:SetActive(true)
    self._addExp.gameObject:SetActive(true)
    self._expCalCulate.gameObject:SetActive(false)
    self._addCalCulate.gameObject:SetActive(false)
    self:OnChangeView()
  end
  self._addSlider.onValueChanged:AddListener(function()
    self._isAdd = self._addSlider.value > self._lastNum
    self._lastNum = self._addSlider.value
    self._realValue = self._addSlider.value
    if self._isAdd then
      self._levelOffset = 0
      self._nextPetLevel = math.ceil(self._realValue)
    else
      self._levelOffset = -1
      self._nextPetLevel = math.floor(self._realValue)
    end
    Log.fatal(self._nextPetLevel)
  end)
end

function UIUpLevelAddQuickBox:OnChangeViewDrag()
  local endLevel = self._nextPetLevel
  if self._isAdd then
    endLevel = self:CheckPrevieAdd(self._nextPetLevel)
  else
    endLevel = self:CheckPrevieReduce(self._nextPetLevel)
  end
  self._nextPetLevel = endLevel
  self._useItems, self._useCoin = self:CalculateItemUse(self._nextPetLevel)
  self:FlushUIDrag()
  self:FlushItemPanel()
end

function UIUpLevelAddQuickBox:OnChangeView()
  local endLevel = self._nextPetLevel
  if self._isAdd then
    endLevel = self:CheckPrevieAdd(self._nextPetLevel)
  else
    endLevel = self:CheckPrevieReduce(self._nextPetLevel)
  end
  self._nextPetLevel = endLevel
  self._useItems, self._useCoin = self:CalculateItemUse(self._nextPetLevel)
  self._addSlider.value = self._nextPetLevel
  self:FlushUI()
  self:FlushItemPanel()
end

function UIUpLevelAddQuickBox:OnHide()
end

function UIUpLevelAddQuickBox:Clear()
  self:InitUI()
  self._curPetLevel = self._petInfo:GetPetLevel()
  self._nextPetLevel = 0
  self._addItemInfos = nil
end

function UIUpLevelAddQuickBox:InitUI()
  local level = self._petInfo:GetPetLevel()
  self._curlevel:SetText(level)
  self._nextlevel:SetText("")
  self._costCount:SetText(self._useCoin)
  self._nextObj:SetActive(false)
  local info = self:GetPetInfo()
  local text = "<color=#ffe71c>" .. info.curExp .. "</color>"
  text = text .. "/" .. info.maxExp
  self._expText:SetText(text)
  self._expSlider.value = info.curExp / info.maxExp
  self._addSlider.minValue = self._curPetLevel
  local useItems = self:CalculateItemUse(self:GetEnableMaxLevel())
  self._maxEndLevel = self:CheckPreview(useItems)
  self._addSlider.maxValue = self._maxEndLevel
  self._addSlider.value = self._curPetLevel
  self._addExp:SetText("")
  local lvConfig = self._petInfo:GetLevelConfig(self._curPetLevel + 1)
  self._maxObj:SetActive(lvConfig == nil)
end

function UIUpLevelAddQuickBox:FlushUI()
  local level = self._petInfo:GetPetLevel()
  self._curlevel:SetText(level)
  local next = math.modf(self._nextPetLevel)
  self._nextlevel:SetText(next)
  self._costCount:SetText(self._useCoin)
  self._nextObj:SetActive(self._nextPetLevel > self._curPetLevel)
  local info = self:GetPetInfo()
  local nextMaxExp = info.maxExp
  local lvConfig = self._petInfo:GetLevelConfig(self._nextPetLevel + 1)
  local isMax = false
  if lvConfig then
    self._maxObj:SetActive(false)
    nextMaxExp = lvConfig.NeedExp
    if self._addSlider.value == self._addSlider.maxValue then
      local expLevel = self:CalculateExpEnableMaxLevel()
      local coinLevel = self:CalculateCoinEnableMaxLevel()
      local expLevelConfig = self._petInfo:GetLevelConfig(expLevel + 1)
      local coinLevelConfig = self._petInfo:GetLevelConfig(coinLevel + 1)
      if expLevel < coinLevel then
        ToastManager.ShowToast(StringTable.Get("str_pet_config_up_jasper_not_enough"))
      elseif expLevel > coinLevel then
        ToastManager.ShowToast(StringTable.Get("str_pet_config_up_money_not_enough"))
      elseif expLevelConfig or coinLevelConfig then
        ToastManager.ShowToast(StringTable.Get("str_pet_config_up_both_not_enough"))
      end
    end
  else
    self._maxObj:SetActive(true)
    isMax = true
    lvConfig = self._petInfo:GetLevelConfig(self._nextPetLevel)
    nextMaxExp = lvConfig.NeedExp
  end
  local liftNum = isMax and nextMaxExp or self:GetOverLevelInfo()
  if self._nextPetLevel == self._curPetLevel then
    liftNum = self._petInfo:GetPetExp()
  end
  local text = "<color=#ffe71c>" .. liftNum .. "</color>"
  text = text .. "/" .. nextMaxExp
  self._expText:SetText(text)
  self._expSlider.value = liftNum / nextMaxExp
  local str = self._totleExp > 0 and "+" .. self._totleExp or ""
  self._addExp:SetText(str)
end

function UIUpLevelAddQuickBox:FlushUIDrag()
  local level = self._petInfo:GetPetLevel()
  self._curlevel:SetText(level)
  local next = math.modf(self._addSlider.value)
  self._nextlevel:SetText(next)
  self._costCount:SetText(self._useCoin)
  self._nextObj:SetActive(self._nextPetLevel > self._curPetLevel)
  local info = self:GetPetInfo()
  local nextMaxExp = info.maxExp
  local lvConfig = self._petInfo:GetLevelConfig(self._nextPetLevel + 1)
  local isMax = false
  if lvConfig then
    self._maxObj:SetActive(false)
    nextMaxExp = lvConfig.NeedExp
    if self._addSlider.value == self._addSlider.maxValue then
      local expLevel = self:CalculateExpEnableMaxLevel()
      local coinLevel = self:CalculateCoinEnableMaxLevel()
      local expLevelConfig = self._petInfo:GetLevelConfig(expLevel + 1)
      local coinLevelConfig = self._petInfo:GetLevelConfig(coinLevel + 1)
      if expLevel < coinLevel then
        ToastManager.ShowToast(StringTable.Get("str_pet_config_up_jasper_not_enough"))
      elseif expLevel > coinLevel then
        ToastManager.ShowToast(StringTable.Get("str_pet_config_up_money_not_enough"))
      elseif expLevelConfig or coinLevelConfig then
        ToastManager.ShowToast(StringTable.Get("str_pet_config_up_both_not_enough"))
      end
    end
  else
    self._maxObj:SetActive(true)
    isMax = true
    lvConfig = self._petInfo:GetLevelConfig(self._nextPetLevel)
    nextMaxExp = lvConfig.NeedExp
  end
  local liftNum = isMax and nextMaxExp or self:GetOverLevelInfo()
  if self._nextPetLevel == self._curPetLevel then
    liftNum = self._petInfo:GetPetExp()
  end
  local text = "<color=#ffe71c>" .. liftNum .. "</color>"
  text = text .. "/" .. nextMaxExp
  self._expText:SetText(text)
  self._expSlider.value = liftNum / nextMaxExp
  local str = self._totleExp > 0 and "+" .. self._totleExp or ""
  self._addExp:SetText(str)
end

function UIUpLevelAddQuickBox:FlushItemPanel()
  local len = #self._expItemList
  if len < 6 then
    self._content:SpawnObjects("UIUpLevelMaterialItem", 6)
  else
    self._content:SpawnObjects("UIUpLevelMaterialItem", len)
  end
  self._uiItems = self._content:GetAllSpawnList()
  
  local function filterFun(index)
    for i, value in ipairs(self._useItems) do
      if value and value[1] == self._expItemList[index]:GetTemplateID() then
        return value
      end
    end
  end
  
  for i, uiItem in ipairs(self._uiItems) do
    if i > len then
      uiItem:SetData(nil)
    else
      local value = filterFun(i)
      uiItem:SetData(self._expItemList[i], self._petInfo:GetPetFirstElement(), value, i, self._maxMatChooseCount, self._safeArea)
      uiItem:ShowUpAnim(true, value == nil)
    end
  end
end

function UIUpLevelAddQuickBox:BgOnClick()
  self:CloseDialog()
end

function UIUpLevelAddQuickBox:OnUpdate(deltaTimeMS)
  self._updateTime = self._updateTime + deltaTimeMS
  if self._updateTime > self._pressTime then
    self._updateTime = self._updateTime - self._pressTime
    if self._isAddMouseDown then
      if self._isTenStep then
        self._levelOffset = 10
        self._nextPetLevel = self:CheckPrevieAdd(math.min(self._nextPetLevel + self._levelOffset, self._maxEndLevel))
        self:ShowLongPressInfo()
      else
        self._levelOffset = 1
        self._nextPetLevel = self:CheckPrevieAdd(math.min(self._nextPetLevel + self._levelOffset, self._maxEndLevel))
        self:ShowLongPressInfo()
      end
    end
    if self._isSubMouseDown then
      if self._isTenStep then
        self._levelOffset = -10
        self._nextPetLevel = self:CheckPrevieReduce(math.max(self._nextPetLevel + self._levelOffset, self._curPetLevel))
        self:ShowLongPressInfo()
      else
        self._levelOffset = -1
        self._nextPetLevel = self:CheckPrevieReduce(math.max(self._nextPetLevel + self._levelOffset, self._curPetLevel))
        self:ShowLongPressInfo()
      end
    end
  end
end

function UIUpLevelAddQuickBox:ShowLongPressInfo()
  self._addSlider.value = self._nextPetLevel
  self._nextlevel:SetText(self._nextPetLevel)
  self._nextObj:SetActive(self._nextPetLevel > self._curPetLevel)
  self._useItems, self._useCoin = self:CalculateItemUse(self._nextPetLevel)
  self:FlushUIDrag()
  self:FlushItemPanel()
end

function UIUpLevelAddQuickBox:AddBtnOnClick()
  self._levelOffset = 1
  self._isAdd = true
  self._nextPetLevel = math.min(self._nextPetLevel + self._levelOffset, self._maxEndLevel)
  self:OnChangeView()
end

function UIUpLevelAddQuickBox:SubBtnOnClick()
  self._levelOffset = -1
  self._nextPetLevel = math.max(self._nextPetLevel + self._levelOffset, self._curPetLevel)
  self._isAdd = false
  self:OnChangeView()
end

function UIUpLevelAddQuickBox:AddMultBtnOnClick()
  self._levelOffset = 10
  self._nextPetLevel = math.min(self._nextPetLevel + self._levelOffset, self._maxEndLevel)
  self._isAdd = true
  self:OnChangeView()
end

function UIUpLevelAddQuickBox:SubMultBtnOnClick()
  self._levelOffset = -10
  self._nextPetLevel = math.max(self._nextPetLevel + self._levelOffset, self._curPetLevel)
  self._isAdd = false
  self:OnChangeView()
end

function UIUpLevelAddQuickBox:QuickAddOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseUIUpLevelAddQuickBox, self._useItems)
  self:CloseDialog()
end

function UIUpLevelAddQuickBox:CancalOnClick()
  self._addSlider.value = 0
  self._curPetLevel = self._petInfo:GetPetLevel()
  self._nextPetLevel = 0
  self:CloseDialog()
end

function UIUpLevelAddQuickBox:CheckCanUseWithCoin(exp)
  local totleCoin = self._roleModule:GetGold()
  local endLevel = self._curPetLevel
  local curLevel = self._curPetLevel + 1
  local lvConfig = self._petInfo:GetLevelConfig(curLevel)
  if not lvConfig then
    return false, self._curPetLevel
  end
  local curLevelNeedExp = lvConfig.NeedExp - self._curPetExp
  local upLeveMoney = 0
  upLeveMoney = upLeveMoney + lvConfig.NeedGold * (curLevelNeedExp / lvConfig.NeedExp)
  exp = exp - curLevelNeedExp
  while 0 <= exp do
    curLevel = curLevel + 1
    lvConfig = self._petInfo:GetLevelConfig(curLevel)
    if not lvConfig then
      endLevel = curLevel - 1
      break
    end
    if exp >= lvConfig.NeedExp then
      upLeveMoney = upLeveMoney + lvConfig.NeedGold
    else
      upLeveMoney = upLeveMoney + lvConfig.NeedGold * (exp / lvConfig.NeedExp)
      curLevel = curLevel - 1
    end
    endLevel = curLevel
    exp = exp - lvConfig.NeedExp
  end
  Log.fatal("")
  return totleCoin >= math.ceil(upLeveMoney), endLevel
end

function UIUpLevelAddQuickBox:CheckPreview(useItems)
  local totleExp = 0
  if not useItems or #useItems == 0 then
    return self._curPetLevel
  end
  for k, value in ipairs(useItems) do
    local finalExp = self:CalculateItemFinalExp(value[1])
    for i = 1, value[2] do
      totleExp = totleExp + finalExp
    end
  end
  local endLevel = self._curPetLevel
  if 0 < totleExp then
    local curLevel = self._curPetLevel + 1
    local lvConfig = self._petInfo:GetLevelConfig(curLevel)
    if not lvConfig then
      endLevel = self._curPetLevel
      return
    end
    local curLevelNeedExp = lvConfig.NeedExp - self._curPetExp
    totleExp = totleExp - curLevelNeedExp
    if totleExp < 0 then
      return endLevel
    end
    endLevel = curLevel
    while 0 <= totleExp do
      curLevel = curLevel + 1
      lvConfig = self._petInfo:GetLevelConfig(curLevel)
      if not lvConfig then
        break
      end
      totleExp = totleExp - lvConfig.NeedExp
      if totleExp < 0 then
        break
      end
      endLevel = curLevel
    end
  end
  local coinMaxLevel = self:CalculateCoinEnableMaxLevel()
  return math.min(endLevel, coinMaxLevel)
end

function UIUpLevelAddQuickBox:CheckPrevieAdd(level)
  local useItems = self:CalculateItemUse(level)
  local endLevel = self:CheckPreview(useItems)
  return endLevel
end

function UIUpLevelAddQuickBox:IsEqualItems(itemA, itemB)
  if not itemA or not itemB then
    return false
  end
  if #itemB ~= #itemA then
    return false
  end
  local sameCount = 0
  for i = 1, #itemA do
    for k = 1, #itemB do
      if itemA[i][1] == itemB[k][1] and itemA[i][2] == itemB[k][2] then
        sameCount = sameCount + 1
      end
    end
  end
  return sameCount == #itemA
end

function UIUpLevelAddQuickBox:CheckPrevieReduce(level)
  if level <= self._curPetLevel then
    return self._curPetLevel
  end
  local lastLevel = level + 1
  local lastItem, useItems = {}
  local endLevel = level
  lastItem = self:CalculateItemUse(lastLevel)
  endLevel = self:CheckPreview(lastItem)
  for i = level, 1, -1 do
    useItems = self:CalculateItemUse(i)
    if not self:IsEqualItems(lastItem, useItems) then
      return i
    end
    endLevel = i
  end
  return endLevel
end

function UIUpLevelAddQuickBox:GetPetInfo()
  local petInfo = {}
  local nextLv = self._curPetLevel == self._petInfo:GetMaxLevel() and self._petInfo:GetMaxLevel() or self._curPetLevel + 1
  local levelConfig = self._petInfo:GetLevelConfig(nextLv)
  petInfo.curLevel = self._petInfo:GetPetLevel()
  petInfo.nextlevel = self._nextPetLevel
  petInfo.curExp = self._petInfo:GetPetExp()
  petInfo.maxExp = levelConfig.NeedExp
  return petInfo
end

function UIUpLevelAddQuickBox:CheckMaxLevel(nextLevel)
  local maxLevel = self._petInfo:GetMaxLevel()
  if nextLevel >= maxLevel then
    return true
  end
  return false
end

function UIUpLevelAddQuickBox:GetEnableMaxLevel()
  local expLevel = self:CalculateExpEnableMaxLevel()
  local coinLevel = self:CalculateCoinEnableMaxLevel()
  return math.min(expLevel, coinLevel)
end

function UIUpLevelAddQuickBox:CalculateExpEnableMaxLevel()
  local maxLevel = self._curPetLevel
  local maxExp = 0
  for index, value in ipairs(self._expItemList) do
    maxExp = maxExp + value:GetCount() * self:CalculateItemFinalExp(value:GetTemplateID())
  end
  local curLevel = self._curPetLevel + 1
  local lvConfig = self._petInfo:GetLevelConfig(curLevel)
  if not lvConfig then
    return self._curPetLevel
  end
  local curLevelNeedExp = lvConfig.NeedExp - self._curPetExp
  maxExp = maxExp - curLevelNeedExp
  if 0 < maxExp then
    maxLevel = curLevel
  end
  while 0 < maxExp do
    curLevel = curLevel + 1
    lvConfig = self._petInfo:GetLevelConfig(curLevel)
    if not lvConfig then
      break
    end
    maxExp = maxExp - lvConfig.NeedExp
    if maxExp < 0 then
      break
    end
    maxLevel = curLevel
  end
  return maxLevel
end

function UIUpLevelAddQuickBox:CalculateCoinEnableMaxLevel()
  local cionNum = self._roleModule:GetGold()
  local maxLevel = self._curPetLevel
  local upLeveMoney = 0
  local curLevel = self._curPetLevel + 1
  local lvConfig = self._petInfo:GetLevelConfig(curLevel)
  if not lvConfig then
    return self._curPetLevel
  end
  local curLevelNeedExp = lvConfig.NeedExp - self._curPetExp
  upLeveMoney = upLeveMoney + lvConfig.NeedGold * (curLevelNeedExp / lvConfig.NeedExp)
  cionNum = cionNum - upLeveMoney
  if cionNum < 0 then
    return self._curPetLevel
  end
  maxLevel = curLevel
  while 0 < cionNum do
    curLevel = curLevel + 1
    lvConfig = self._petInfo:GetLevelConfig(curLevel)
    if not lvConfig then
      break
    end
    cionNum = cionNum - lvConfig.NeedGold
    if cionNum < 0 then
      break
    end
    maxLevel = curLevel
  end
  return maxLevel
end

function UIUpLevelAddQuickBox:CalculateItemFinalExp(templateid)
  local cfg = Cfg.cfg_item_pet_exp[templateid]
  local tItemAddExp = self._itemModule:GetItemToPetExp(templateid)
  local firstElement = self._petInfo:GetPetFirstElement()
  if cfg.Element == firstElement then
    local add = Cfg.cfg_global.ElementAddExp.IntValue
    tItemAddExp = tItemAddExp * (add + 100) * 0.01
  end
  return math.floor(tItemAddExp)
end

function UIUpLevelAddQuickBox:CalculateItemUse(level)
  Log.debug("CalculateItemUse")
  local exp, coin = self:CalculateWithTargetLevel(level)
  local colorItems, normalItems = {}, {}, {}
  colorItems = self._colorItems
  normalItems = self._normalItems
  self._overExp = 0
  self._totleExp = exp
  
  local function addUseItemCount(tb, templateID, count)
    local addPer = count ~= nil and count or 1
    local checked = false
    for index, value in ipairs(tb) do
      if value[1] == templateID then
        value[2] = value[2] + addPer
        value.count = value[2]
        checked = true
        break
      end
    end
    if not checked then
      local temp = {templateID, addPer}
      temp.count = addPer
      table.insert(tb, temp)
    end
  end
  
  local useItems = {}
  
  local function colculateExpInfo(checkItems, needExp)
    if not checkItems or #checkItems == 0 then
      return useItems, needExp
    end
    local lastItemExp = self:CalculateItemFinalExp(checkItems[#checkItems]:GetTemplateID())
    local useCount = math.ceil(needExp / lastItemExp)
    for index, value in ipairs(checkItems) do
      local id = value:GetTemplateID()
      local item = {}
      item.id = id
      item.rate = self:CalculateItemFinalExp(value:GetTemplateID()) / lastItemExp
      item.useCount = 0 <= value:GetCount() and math.floor(useCount / item.rate) > value:GetCount() and value:GetCount() or math.floor(useCount / item.rate)
      if 0 < item.useCount then
        addUseItemCount(useItems, value:GetTemplateID(), item.useCount)
      end
      needExp = needExp - item.useCount * self:CalculateItemFinalExp(value:GetTemplateID())
      useCount = useCount - item.useCount * item.rate
      if needExp <= 0 then
        break
      end
    end
    return useItems, needExp
  end
  
  local lvConfig = self._petInfo:GetLevelConfig(self._nextPetLevel + 1)
  useItems, exp = colculateExpInfo(colorItems, exp)
  if exp <= 0 then
    self._overExp = -exp
    self._totleExp = self._totleExp + self._overExp
    if lvConfig then
      coin = coin + lvConfig.NeedGold * (self._overExp / lvConfig.NeedExp)
    end
    return useItems, math.ceil(coin)
  end
  useItems, exp = colculateExpInfo(normalItems, exp)
  self._overExp = -exp
  self._totleExp = self._totleExp + self._overExp
  if lvConfig then
    coin = coin + lvConfig.NeedGold * (self._overExp / lvConfig.NeedExp)
  end
  return useItems, math.ceil(coin)
end

function UIUpLevelAddQuickBox:GetUseItemCount(templateID)
  for index, value in ipairs(self._expItemList) do
    if value:GetTemplateID() == templateID then
      return value:GetCount()
    end
  end
end

function UIUpLevelAddQuickBox:CalculateWithTargetLevel(nextLevel)
  nextLevel = nextLevel or self._nextPetLevel
  if self._curPetLevel == nextLevel then
    return 0, 0
  end
  local totleExp = 0
  local totleCoin = 0
  local curLevel = self._curPetLevel + 1
  local lvConfig = self._petInfo:GetLevelConfig(curLevel)
  if not lvConfig then
    return totleExp, totleCoin
  end
  local curLevelNeedExp = lvConfig.NeedExp - self._curPetExp
  totleExp = totleExp + curLevelNeedExp
  totleCoin = totleCoin + lvConfig.NeedGold * (curLevelNeedExp / lvConfig.NeedExp)
  while nextLevel > curLevel do
    curLevel = curLevel + 1
    lvConfig = self._petInfo:GetLevelConfig(curLevel)
    if not lvConfig then
      break
    end
    totleExp = totleExp + lvConfig.NeedExp
    totleCoin = totleCoin + lvConfig.NeedGold
  end
  return totleExp, totleCoin
end

function UIUpLevelAddQuickBox:GetFilterExpItems()
  local itemInfos = {}
  itemInfos = self._petModule:GetPetExpItems(self._petInfo:GetPstID(), true)
  local cfg = Cfg.cfg_item_pet_exp
  local colorItems, normalItems = {}, {}
  for index, value in ipairs(itemInfos) do
    if cfg[value:GetTemplateID()].Element > 0 then
      table.insert(colorItems, value)
    else
      table.insert(normalItems, value)
    end
  end
  return itemInfos, colorItems, normalItems
end

function UIUpLevelAddQuickBox:GetOverLevelInfo()
  return self._overExp
end
