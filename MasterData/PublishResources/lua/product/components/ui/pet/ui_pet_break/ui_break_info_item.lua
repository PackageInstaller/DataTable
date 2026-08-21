_class("UIBreakInfoItem", Object)
UIBreakInfoItem = UIBreakInfoItem

function UIBreakInfoItem:OnShowItem()
  self._name2Assets = {}
  self.key2CustomWidgetPools = {}
  self.type2ComponentTable = {}
  self:GetComponents()
end

function UIBreakInfoItem:GetComponents()
  self.nameText = self:GetUIComponent("UILocalizationText", "TextSpriteName")
  self.breakText = self:GetUIComponent("UILocalizationText", "Break")
  self.starsLoader = self:GetUIComponent("UISelectObjectPath", "Stars")
  self.startPathLoader = self:GetUIComponent("UISelectObjectPath", "StarPath")
  self.skillGo = self:GetGameObject("skill")
  self.skillIcon = self:GetUIComponent("RawImageLoader", "skillIcon")
  self.skillName = self:GetUIComponent("UILocalizationText", "skillName")
  self.skillType = self:GetUIComponent("UILocalizationText", "skillType")
  self.oneAttGo = self:GetGameObject("oneAtt")
  self.one_icon = self:GetUIComponent("Image", "oneAtt_icon")
  self.one_name = self:GetUIComponent("UILocalizationText", "oneAtt_name")
  self.one_nameEn = self:GetUIComponent("UILocalizationText", "oneAtt_nameEN")
  self.one_value = self:GetUIComponent("UILocalizationText", "oneAtt_value")
  self.one_target = self:GetUIComponent("UILocalizationText", "oneAtt_target")
  self.mulAttGo = self:GetGameObject("mulAtt")
  self.mulAtt_1Go = self:GetGameObject("mulAtt_1")
  self.mulAtt_2Go = self:GetGameObject("mulAtt_2")
  self.mulAtt_3Go = self:GetGameObject("mulAtt_3")
  self.mul_value1 = self:GetUIComponent("UILocalizationText", "mulAtt_1value")
  self.mul_value2 = self:GetUIComponent("UILocalizationText", "mulAtt_2value")
  self.mul_value3 = self:GetUIComponent("UILocalizationText", "mulAtt_3value")
  self.mul_target1 = self:GetUIComponent("UILocalizationText", "mulAtt_1target")
  self.mul_target2 = self:GetUIComponent("UILocalizationText", "mulAtt_2target")
  self.mul_target3 = self:GetUIComponent("UILocalizationText", "mulAtt_3target")
  local sop = self:GetUIComponent("UISelectObjectPath", "preattack")
  self.preAttackCell = sop:SpawnObject("UIPreAttackItem")
  self.preAttackCell:Enable(false)
end

function UIBreakInfoItem:OnValue()
  self:ShowName()
end

function UIBreakInfoItem:SetBreakBaseInfo()
  self:ShowBreakCount()
  self:ShowStar()
  self:ShowStarPath()
end

function UIBreakInfoItem:RefreshBreakInfo(isInit, playAnim, ignoreRefreshSelect)
  if self._uiData then
    self._uiData:Dispose()
  end
  self._uiData = UIBreakUIData:New(self._petInfo)
  self:SetBreakBaseInfo()
  if isInit then
    self.starPathWidget:Init(self._uiData:GetCurrent(), self._uiData:GetAwakeMatch(), self._uiData:GetBreakCount(), self._uiData:GetAllPromoteData(), function(num)
      self:OnSelectPathPoint(num)
    end)
  elseif playAnim then
    self.starPathWidget:RefreshAfterBreak(self._uiData:GetCurrent(), self._uiData:GetAwakeMatch(), self._uiData:GetBreakCount(), self._uiData:GetAllPromoteData())
  else
    self.starPathWidget:InitAgain(self._uiData:GetCurrent(), self._uiData:GetAwakeMatch(), self._uiData:GetBreakCount(), self._uiData:GetAllPromoteData())
  end
  if not ignoreRefreshSelect then
    self._selectPointIdx = -1
    if self._uiData:IsFullBreak() then
      self:OnSelectPathPoint(self._uiData:GetBreakCount())
    else
      self:OnSelectPathPoint(self._uiData:GetCurrent() + 1)
    end
  end
end

function UIBreakInfoItem:OnSelectPathPoint(_num)
  if _num == self._selectPointIdx then
    return
  end
  self._selectPointIdx = _num
  self:RefreshPromoteInfo()
end

function UIBreakInfoItem:RefreshPromoteInfo()
  self:SetPromotionInfo()
  self.starPathWidget:OnSelected(self._selectPointIdx)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAwakenSelectPointChange, self._idx, self._selectPointIdx)
end

function UIBreakInfoItem:ShowPreAttack(type)
  if self.preAttackCell then
    if type == UIBreakPromoteType.ActiveSkill then
      self.preAttackCell:Enable(true)
      local maxGrade = self._petInfo:GetMaxGrade()
      local skillCfg = Cfg.cfg_pet_skill({
        PetID = self._petInfo:GetTemplateID(),
        Grade = maxGrade,
        Awakening = self._selectPointIdx
      })
      self.preAttackCell:SetData(self._petPstID, skillCfg and skillCfg[1] and skillCfg[1].ActiveSkill, true)
    else
      self.preAttackCell:Enable(false)
    end
  end
end

function UIBreakInfoItem:GetUiData()
  return self._uiData
end

function UIBreakInfoItem:GetSelectPointIdx()
  return self._selectPointIdx
end

function UIBreakInfoItem:GetDesc()
  return self._desc
end

function UIBreakInfoItem:SetPromotionInfo()
  local data = self._uiData:GetPromoteData(self._selectPointIdx)
  self.skillGo:SetActive(false)
  self.oneAttGo:SetActive(false)
  self.mulAttGo:SetActive(false)
  self:ShowPreAttack(data[1].type)
  self._desc = ""
  if #data == 1 and data[1].type >= UIBreakPromoteType.NormalSkill then
    self.skillName.text = data[1].name
    self.skillType.text = self._uiData:GetSkillTypeName(data[1].type)
    self.skillIcon:LoadImage(data[1].icon)
    self.skillGo:SetActive(true)
    self._desc = data[1].des
  else
    local name = StringTable.Get(self._petInfo:GetPetName())
    if #data == 1 then
      if self._showBreifDes then
        self.oneAtt_tip:SetActive(true)
        self.one_valueObj:SetActive(false)
      end
      local attType = data[1].type
      local attValue = data[1].delta
      local from = data[1].from
      local to = data[1].to
      local info = self._uiData:GetAttributeInfo(attType)
      self.one_icon.sprite = info.icon
      self.one_name.text = info.name
      self.one_nameEn.text = info.nameEN
      self.one_value.text = from
      self.one_target.text = to
      self.oneAttGo:SetActive(true)
    else
      self.mulAtt_1Go:SetActive(false)
      self.mulAtt_2Go:SetActive(false)
      self.mulAtt_3Go:SetActive(false)
      for i = 1, #data do
        local att = data[i]
        if att.type == UIBreakPromoteType.Attack then
          self.mulAtt_1Go:SetActive(true)
          self.mul_value1.text = att.from
          self.mul_target1.text = att.to
          if self._showBreifDes then
            self.mulAtt_1tip:SetActive(true)
            self.mulAtt_1valueObj:SetActive(false)
          end
        elseif att.type == UIBreakPromoteType.Defence then
          self.mulAtt_2Go:SetActive(true)
          self.mul_value2.text = att.from
          self.mul_target2.text = att.to
          if self._showBreifDes then
            self.mulAtt_2tip:SetActive(true)
            self.mulAtt_2valueObj:SetActive(false)
          end
        elseif att.type == UIBreakPromoteType.HP then
          self.mulAtt_3Go:SetActive(true)
          self.mul_value3.text = att.from
          self.mul_target3.text = att.to
          if self._showBreifDes then
            self.mulAtt_3tip:SetActive(true)
            self.mulAtt_3valueObj:SetActive(false)
          end
        end
      end
      self.mulAttGo:SetActive(true)
    end
  end
  self._desc = self._uiData:GetAttributeDes(self._selectPointIdx)
end

function UIBreakInfoItem:SetView(view)
  self._view = view
end

function UIBreakInfoItem:SetData(idx, pet)
  self._idx = idx
  self._petInfo = pet
  self:OnValue()
  self:RefreshBreakInfo(true)
  self._isInit = true
end

function UIBreakInfoItem:SetShowBreifDes()
  self._showBreifDes = true
  self.oneAtt_tip = self:GetGameObject("oneAtt_tip")
  self.one_valueObj = self:GetGameObject("oneAtt_value")
  self.mulAtt_1tip = self:GetGameObject("mulAtt_1tip")
  self.mulAtt_1valueObj = self:GetGameObject("mulAtt_1value")
  self.mulAtt_2tip = self:GetGameObject("mulAtt_2tip")
  self.mulAtt_2valueObj = self:GetGameObject("mulAtt_2value")
  self.mulAtt_3tip = self:GetGameObject("mulAtt_3tip")
  self.mulAtt_3valueObj = self:GetGameObject("mulAtt_3value")
end

function UIBreakInfoItem:RefreshData(idx, pet, playAnim)
  self._idx = idx
  self._petInfo = pet
  self:OnValue()
  if self._isInit then
    self:RefreshBreakInfo(false, playAnim)
  else
    self:RefreshBreakInfo(true, playAnim)
  end
end

function UIBreakInfoItem:Dispose()
  local key2CustomWidgetPools = table.shallowcopy(self.key2CustomWidgetPools)
  if key2CustomWidgetPools then
    for k, v in pairs(key2CustomWidgetPools) do
      v:Dispose()
    end
  end
  table.clear(self.key2CustomWidgetPools)
  self.key2CustomWidgetPools = nil
  self.type2ComponentTable = nil
  self.nameText = nil
  self.breakText = nil
  self.starsLoader = nil
  self.startPathLoader = nil
  self.skillGo = nil
  self.skillIcon = nil
  self.skillName = nil
  self.skillType = nil
  self.oneAttGo = nil
  self.one_icon = nil
  self.one_name = nil
  self.one_nameEn = nil
  self.one_value = nil
  self.one_target = nil
  self.mulAttGo = nil
  self.mulAtt_1Go = nil
  self.mulAtt_2Go = nil
  self.mulAtt_3Go = nil
  self.mul_value1 = nil
  self.mul_value2 = nil
  self.mul_value3 = nil
  self.mul_target1 = nil
  self.mul_target2 = nil
  self.mul_target3 = nil
  self.preAttackCell = nil
  self._view = nil
  if self._uiData then
    self._uiData:Dispose()
  end
  self._uiData = nil
  UIResourceManager.DisposeAllAssets(self._name2Assets)
  self._name2Assets = nil
end

function UIBreakInfoItem:ShowName()
  self.nameText:SetText(StringTable.Get(self._petInfo:GetPetName()))
end

function UIBreakInfoItem:ShowBreakCount()
  if self._uiData:IsFullBreak() then
    self.breakText:SetText(StringTable.Get("str_pet_config_break_full"))
  else
    local t = {
      [0] = "str_pet_config_break_0",
      [1] = "str_pet_config_break_1",
      [2] = "str_pet_config_break_2",
      [3] = "str_pet_config_break_3",
      [4] = "str_pet_config_break_4",
      [5] = "str_pet_config_break_5",
      [6] = "str_pet_config_break_6"
    }
    self.breakText:SetText(StringTable.Get(t[self._uiData:GetCurrent()]))
  end
end

function UIBreakInfoItem:ShowStar()
  self.starsLoader:SpawnObjects("UIPetIntimacyStar", self._uiData:GetBreakCount())
  local stars = self.starsLoader:GetAllSpawnList()
  for i = 1, #stars do
    local isBackBreak = i > self._uiData:GetAwakeMatch() and i <= self._uiData:GetCurrent()
    stars[i]:Refresh(i <= self._uiData:GetCurrent(), isBackBreak)
  end
end

function UIBreakInfoItem:ShowStarPath()
  local pathNames = {
    [1] = "UIBreakPathItem1.prefab",
    [2] = "UIBreakPathItem2.prefab",
    [3] = "UIBreakPathItem3.prefab",
    [4] = "UIBreakPathItem4.prefab",
    [5] = "UIBreakPathItem5.prefab",
    [6] = "UIBreakPathItem6.prefab"
  }
  if self.starPathWidget == nil then
    self.startPathLoader.dynamicInfoOfEngine:SetObjectName(pathNames[6])
    self.starPathWidget = self.startPathLoader:SpawnObject("UIBreakStarPath")
  end
end

function UIBreakInfoItem:GetName()
  return "UIBreakInfoItem"
end

function UIBreakInfoItem:GetUIComponent(componentTypeName, name)
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

function UIBreakInfoItem:GetGameObject(name)
  return self._view:GetGameObject(name)
end

function UIBreakInfoItem:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self._name2Assets)
end
