_class("UIUpLevelInfoItem", Object)
UIUpLevelInfoItem = UIUpLevelInfoItem

function UIUpLevelInfoItem:OnShowItem()
  self.expFormat = "%s<color=#00f8ff>/</color>%s"
  self._name2Assets = {}
  self.key2CustomWidgetPools = {}
  self.type2ComponentTable = {}
  self._expSlider = self:GetUIComponent("Slider", "Slider")
  self._expBGGo = self:GetGameObject("expBG")
  self._expProcessText = self:GetUIComponent("UILocalizationText", "expProcess")
  self._maxLevelTip = self:GetGameObject("revolvingText")
  self._jiantou = self:GetGameObject("jiantou")
  self._attPool = self:GetUIComponent("UISelectObjectPath", "RowItem")
  self._fromLevel = self:GetUIComponent("UILocalizationText", "fromlevel")
  self._maxLevelGo = self:GetGameObject("maxBG")
  self._toLevelGo = self:GetGameObject("toLevelGo")
  self._toLevel = self:GetUIComponent("UILocalizationText", "toLevel")
  self._expAdd = self:GetUIComponent("UILocalizationText", "needexp")
  self._sliderEff = self:GetGameObject("SliderEff")
  self._name = self:GetUIComponent("UILocalizationText", "nameTex")
  self._revolvingText = self:GetUIComponent("RevolvingTextWithDynamicScroll", "revolvingText")
  self._fillEff = self:GetGameObject("fillEff")
  self._max = self:GetGameObject("max")
  local attCount = 3
  self._attPool:SpawnObjects("UIAttributeCompareItem", attCount)
end

function UIUpLevelInfoItem:Dispose()
  local key2CustomWidgetPools = table.shallowcopy(self.key2CustomWidgetPools)
  if key2CustomWidgetPools then
    for k, v in pairs(key2CustomWidgetPools) do
      v:Dispose()
    end
  end
  table.clear(self.key2CustomWidgetPools)
  self.key2CustomWidgetPools = nil
  self.type2ComponentTable = nil
  self._name = nil
  self._sliderEff = nil
  self._expAdd = nil
  self._toLevel = nil
  self._toLevelGo = nil
  self._maxLevelGo = nil
  self._fromLevel = nil
  self._attPool = nil
  self._jiantou = nil
  self._maxLevelTip = nil
  self._expProcessText = nil
  self._expBGGo = nil
  self._expSlider = nil
  self._view = nil
  UIResourceManager.DisposeAllAssets(self._name2Assets)
  self._name2Assets = nil
end

function UIUpLevelInfoItem:OnLevelUpAttValueChanged(rate)
  local rowList = self._attPool:GetAllSpawnList()
  for index = 1, 3 do
    local tAttItem = rowList[index]
    tAttItem:OnLevelUpAttValueChanged(rate)
  end
end

function UIUpLevelInfoItem:AttValueAnimUpdate(deltaTime)
  local rowList = self._attPool:GetAllSpawnList()
  local ret = true
  for index = 1, 3 do
    local tAttItem = rowList[index]
    local result = tAttItem:UpdateAttributeAnim(deltaTime)
    ret = ret and result
  end
  return ret
end

function UIUpLevelInfoItem:StartPlayAttributeAmin()
  local rowList = self._attPool:GetAllSpawnList()
  local ret = true
  for index = 1, 3 do
    local tAttItem = rowList[index]
    tAttItem:StartPlayAttributeAmin()
  end
end

function UIUpLevelInfoItem:PlayLevelUpEffect()
  if self._sliderEff then
    self._sliderEff:SetActive(false)
    self._sliderEff:SetActive(true)
  end
end

function UIUpLevelInfoItem:RefreshData(idx, petInfo)
  self._petInfo = petInfo
  self:UpLevelCheckIsCurrent()
end

function UIUpLevelInfoItem:RefreshPetUpLevelEvent(idx, petInfo)
  self._petInfo = petInfo
  self._addExp = 0
  self._neeUpLevelTotalMoney = 0
  self._neeTotalEXp = 0
  self._expBGGo:SetActive(false)
  self._toLevelGo:SetActive(false)
  self._maxLevelGo:SetActive(false)
end

function UIUpLevelInfoItem:PlayAttAnim(idx)
  if idx == 1 then
    self._fillEff:SetActive(true)
    local rowList = self._attPool:GetAllSpawnList()
    for index = 1, 3 do
      local tAttItem = rowList[index]
      local yieldTime = (index - 1) * 100
      tAttItem:PlayAnimFirst(yieldTime)
    end
  elseif idx == 2 then
    self._fillEff:SetActive(false)
    local rowList = self._attPool:GetAllSpawnList()
    for index = 1, 3 do
      local tAttItem = rowList[index]
      local yieldTime = (index - 1) * 100
      tAttItem:PlayAnimSecond(yieldTime)
    end
  end
end

function UIUpLevelInfoItem:OnAnimFinished()
  local curPetLevel = self._petInfo:GetPetLevel()
  local curPetExp = self._petInfo:GetPetExp()
  local curPetMaxLevel = self._petInfo:GetMaxLevel()
  if curPetLevel >= curPetMaxLevel then
    self._expSlider.value = 1
    self._expProcessText.text = string.format(self.expFormat, "-", "-")
    self._jiantou:SetActive(false)
    self._maxLevelTip:SetActive(true)
    self._max:SetActive(true)
    local maxLevelTipTex = self:GetUIComponent("UILocalizationText", "TextMaxTip")
    local awaken = self._petInfo:GetPetGrade()
    local awakenMax = self._petInfo:GetMaxGrade()
    if awaken < awakenMax then
      maxLevelTipTex:SetText(StringTable.Get("str_pet_config_upgrade_awakenmax"))
    else
      maxLevelTipTex:SetText(StringTable.Get("str_pet_config_upgrade_max"))
    end
    self._revolvingText:OnRefreshRevolving()
  else
    self._max:SetActive(false)
    local upLevelAllExp = self._petInfo:GetLevelUpNeedExp()
    self._jiantou:SetActive(true)
    self._expSlider.value = curPetExp / upLevelAllExp
    self:SetExpProcessText(curPetExp, upLevelAllExp)
    self._maxLevelTip:SetActive(false)
  end
  self._fromLevel.text = string.format("%02d", curPetLevel)
end

function UIUpLevelInfoItem:StopTween()
  if self.tweeners ~= nil and #self.tweeners > 0 then
    for k, v in pairs(self.tweeners) do
      v:Kill()
    end
    self.tweeners = {}
  end
end

function UIUpLevelInfoItem:ShowLevelInfo(level)
  if self._sliderEff then
    self._sliderEff:SetActive(false)
    self._sliderEff:SetActive(true)
  end
  self._fromLevel.text = string.format("%02d", level)
end

function UIUpLevelInfoItem:SetExpSliderValue()
  local curPetLevel = self._petInfo:GetPetLevel()
  local curPetExp = self._petInfo:GetPetExp()
  local curPetMaxLevel = self._petInfo:GetMaxLevel()
  if curPetLevel >= curPetMaxLevel then
    self._expSlider.value = 1
  else
    local upLevelAllExp = self._petInfo:GetLevelUpNeedExp()
    self._expSlider.value = curPetExp / upLevelAllExp
  end
end

function UIUpLevelInfoItem:SliderTweenEndCallBack()
  self._stepListInfos = {}
  self.tweeners = {}
end

function UIUpLevelInfoItem:GetSlider()
  return self._expSlider
end

function UIUpLevelInfoItem:UpLevelCheckIsCurrent()
  self:Reset()
end

function UIUpLevelInfoItem:SetDataInit()
  self._addExp = 0
  self._neeUpLevelTotalMoney = 0
  self._neeTotalEXp = 0
  local curPetLevel = self._petInfo:GetPetLevel()
  local curPetExp = self._petInfo:GetPetExp()
  local curPetMaxLevel = self._petInfo:GetMaxLevel()
  self._expBGGo:SetActive(false)
  if curPetLevel >= curPetMaxLevel then
    self._expSlider.value = 1
    self._expProcessText.text = string.format(self.expFormat, "-", "-")
    self._maxLevelTip:SetActive(true)
    local maxLevelTipTex = self:GetUIComponent("UILocalizationText", "TextMaxTip")
    local awaken = self._petInfo:GetPetGrade()
    local awakenMax = self._petInfo:GetMaxGrade()
    if awaken < awakenMax then
      maxLevelTipTex:SetText(StringTable.Get("str_pet_config_upgrade_awakenmax"))
    else
      maxLevelTipTex:SetText(StringTable.Get("str_pet_config_upgrade_max"))
    end
    self._revolvingText:OnRefreshRevolving()
    self._max:SetActive(true)
    self._jiantou:SetActive(false)
  else
    self._max:SetActive(false)
    local upLevelAllExp = self._petInfo:GetLevelUpNeedExp()
    self:SetExpProcessText(curPetExp, upLevelAllExp)
    self._expSlider.value = curPetExp / upLevelAllExp
    self._maxLevelTip:SetActive(false)
    self._jiantou:SetActive(true)
  end
  self._fromLevel.text = string.format("%02d", curPetLevel)
  self._toLevelGo:SetActive(false)
  self._maxLevelGo:SetActive(false)
  self._arriveLevel = curPetLevel
  self._arriveExp = curPetExp
  self:RefreshAttributeChange(curPetLevel)
  self._name:SetText(StringTable.Get(self._petInfo:GetPetName()))
end

function UIUpLevelInfoItem:OnHide()
end

function UIUpLevelInfoItem:OnHideCallBack()
end

function UIUpLevelInfoItem:SetData(index, pet)
  self._petInfo = pet
  self:SetDataInit()
end

function UIUpLevelInfoItem:Reset()
  self._addExp = 0
  self._neeUpLevelTotalMoney = 0
  self._neeTotalEXp = 0
  local curPetLevel = self._petInfo:GetPetLevel()
  local curPetExp = self._petInfo:GetPetExp()
  local curPetMaxLevel = self._petInfo:GetMaxLevel()
  self._expBGGo:SetActive(false)
  if curPetLevel >= curPetMaxLevel then
    self._expSlider.value = 1
    self._expProcessText.text = string.format(self.expFormat, "-", "-")
    self._maxLevelTip:SetActive(true)
    local maxLevelTipTex = self:GetUIComponent("UILocalizationText", "TextMaxTip")
    local awaken = self._petInfo:GetPetGrade()
    local awakenMax = self._petInfo:GetMaxGrade()
    if awaken < awakenMax then
      maxLevelTipTex:SetText(StringTable.Get("str_pet_config_upgrade_awakenmax"))
    else
      maxLevelTipTex:SetText(StringTable.Get("str_pet_config_upgrade_max"))
    end
    self._revolvingText:OnRefreshRevolving()
    self._jiantou:SetActive(false)
    self._max:SetActive(true)
  else
    local upLevelAllExp = self._petInfo:GetLevelUpNeedExp()
    self:SetExpProcessText(curPetExp, upLevelAllExp)
    self._expSlider.value = curPetExp / upLevelAllExp
    self._maxLevelTip:SetActive(false)
    self._jiantou:SetActive(true)
    self._max:SetActive(false)
  end
  self._fromLevel.text = string.format("%02d", curPetLevel)
  self._toLevelGo:SetActive(false)
  self._maxLevelGo:SetActive(false)
  self._arriveLevel = curPetLevel
  self._arriveExp = curPetExp
  self:RefreshAttributeChange(curPetLevel)
  self._name:SetText(StringTable.Get(self._petInfo:GetPetName()))
end

function UIUpLevelInfoItem:SetExpProcessText(curPetExp, upLevelAllExp)
  self._expProcessText.text = string.format(self.expFormat, self:FormatExp(curPetExp), self:FormatExp(upLevelAllExp))
end

function UIUpLevelInfoItem:FormatExp(_exp)
  if 999999999 < _exp then
    local num = math.floor(_exp / 10000000)
    return tostring(num / 10) .. StringTable.Get("str_common_hundred_million")
  else
    return _exp
  end
end

function UIUpLevelInfoItem:RefreshAttributeChange(tReachLevel)
  local attVaryInfos = self:GetLevelLerpAttChangeData(tReachLevel)
  local rowList = self._attPool:GetAllSpawnList()
  for index = 1, 3 do
    local tAttItem = rowList[index]
    self:_ShowAttItem(tAttItem, attVaryInfos[index], index)
  end
end

function UIUpLevelInfoItem:GetLevelLerpAttChangeData(tReachLevel)
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

function UIUpLevelInfoItem:_ShowAttItem(tAttItem, attInfo, index)
  tAttItem:GetGameObject():SetActive(true)
  tAttItem:SetData(attInfo)
end

function UIUpLevelInfoItem:Refresh(isUpLevel, isUpMaxLevel, al, ae, addE)
  self._arriveLevel = al
  self._arriveExp = ae
  self._addExp = addE
  if isUpLevel then
    self._toLevelGo:SetActive(true)
    self._toLevel.text = string.format("%02d", self._arriveLevel)
  else
    self._toLevelGo:SetActive(false)
  end
  local curPetExp = self._petInfo:GetPetExp()
  if isUpMaxLevel then
    self._expSlider.value = 1
    self._expProcessText.text = string.format(self.expFormat, "-", "-")
  else
    local levelConfig = self._petInfo:GetLevelConfig(self._arriveLevel + 1)
    if levelConfig then
      self:SetExpProcessText(self._arriveExp, levelConfig.NeedExp)
      self._expSlider.value = self._arriveExp / levelConfig.NeedExp
    end
  end
  self:RefreshAttributeChange(self._arriveLevel)
  self._maxLevelGo:SetActive(isUpMaxLevel)
  if self._addExp <= 0 then
    self._expBGGo:SetActive(false)
  else
    self._expBGGo:SetActive(true)
    self._expAdd.text = "+" .. self:FormatExp(self._addExp)
  end
end

function UIUpLevelInfoItem:SetView(view)
  self._view = view
end

function UIUpLevelInfoItem:GetName()
  return "UIUpLevelInfoItem"
end

function UIUpLevelInfoItem:GetUIComponent(componentTypeName, name)
  if componentTypeName == "UISelectObjectPath" then
    local uiCustomWidgetPool = self.key2CustomWidgetPools[name]
    if uiCustomWidgetPool then
      return uiCustomWidgetPool
    end
    local view = self._view
    if view then
      local dynamicInfoOfEngine = view:GetUIComponent(componentTypeName, name)
      if dynamicInfoOfEngine then
        uiCustomWidgetPool = UICustomWidgetPool:New(self, dynamicInfoOfEngine)
        self.key2CustomWidgetPools[name] = uiCustomWidgetPool
        return uiCustomWidgetPool
      end
    end
    Log.fatal("UIController", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  else
    local name2Component = self.type2ComponentTable[componentTypeName]
    if name2Component then
      local component = name2Component[name]
      if component then
        return component
      end
    end
    local view = self._view
    if view then
      local target = view:GetUIComponent(componentTypeName, name)
      if target then
        if name2Component == nil then
          self.type2ComponentTable[componentTypeName] = {}
          name2Component = self.type2ComponentTable[componentTypeName]
        end
        name2Component[name] = target
        return target
      end
    end
    Log.fatal("UIController", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  end
end

function UIUpLevelInfoItem:GetGameObject(name)
  return self._view:GetGameObject(name)
end

function UIUpLevelInfoItem:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self._name2Assets)
end
