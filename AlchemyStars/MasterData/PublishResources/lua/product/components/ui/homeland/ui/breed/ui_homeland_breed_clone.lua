_class("UIHomelandBreedClone", UICustomWidget)
UIHomelandBreedClone = UIHomelandBreedClone

function UIHomelandBreedClone:Constructor()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._seedData = nil
  self._resultSeedData = nil
  self._refreshInterval = 0
  self._atlas = self:GetAsset("UIHomelandBreed.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandBreedClone:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedClone:_GetComponents()
  self._curPossess = self:GetUIComponent("UILocalizationText", "CurPossess")
  self._cloneTime = self:GetUIComponent("UILocalizationText", "CloneTime")
  self._seed = self:GetUIComponent("UISelectObjectPath", "Seed")
  self._resultSeed = self:GetUIComponent("UISelectObjectPath", "ResultSeed")
  self._cloneBtn = self:GetUIComponent("Image", "CloneBtn")
  self._cloneBtnText = self:GetUIComponent("UILocalizationText", "CloneBtnText")
  self._cloneSpeedUpBtn = self:GetUIComponent("Image", "CloneSpeedUpBtn")
  self._cloneSpeedUpBtnText = self:GetUIComponent("UILocalizationText", "CloneSpeedUpBtnText")
  self._costBgObj = self:GetGameObject("CostBg")
end

function UIHomelandBreedClone:_OnValue()
  self._seedWidget = self._seed:SpawnObject("UIHomelandBreedItem")
  self._resultSeedWidget = self._resultSeed:SpawnObject("UIHomelandBreedItem")
end

function UIHomelandBreedClone:SetData(breedInfo)
  self:_InitBreedInfo(breedInfo)
  self:_RefreshUIInfo()
end

function UIHomelandBreedClone:_InitBreedInfo(breedInfo)
  self._breedInfo = breedInfo
  self._directionalCultivation = nil
  if self._breedInfo then
    self._directionalCultivation = breedInfo.client_info.directional_cultivation[1]
  end
  self._seedData = nil
  self._resultSeedData = nil
  if self._directionalCultivation then
    self._seedData = Cfg.cfg_item[self._directionalCultivation.seed_id]
    self._resultSeedData = Cfg.cfg_item[self._breedInfo.cultivation_result[1].assetid]
  end
end

function UIHomelandBreedClone:RefreshBreedInfo(breedInfo)
  self._breedInfo = breedInfo
end

function UIHomelandBreedClone:_RefreshUIInfo()
  self:_RefreshSeedInfo()
  self:_RefreshBtn()
  self:_RefreshTime()
end

function UIHomelandBreedClone:_RefreshSeedInfo()
  self._seedWidget:SetData(self._seedData)
  self._resultSeedWidget:SetData(self._resultSeedData)
  local curPossessStr = StringTable.Get("str_homeland_breed_clone_desc2")
  if self._seedData then
    local cfgSeed = Cfg.cfg_item_tree_seed[self._seedData.ID]
    local cfg = Cfg.cfg_item[cfgSeed.TreeId]
    local str = string.format("<color=#faab2a>%s</color>", StringTable.Get(cfg.Name) .. ":" .. self._itemModule:GetItemCount(cfg.ID))
    curPossessStr = StringTable.Get("str_homeland_breed_clone_desc3") .. str
  end
  self._curPossess:SetText(curPossessStr)
  self._costBgObj:SetActive(self._seedData ~= nil)
end

function UIHomelandBreedClone:_RefreshBtn()
  if not self._seedData then
    self._cloneSpeedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon6")
    self._cloneSpeedUpBtnText.color = Color(0.4980392156862745, 0.4980392156862745, 0.4980392156862745)
    self._cloneBtn.sprite = self._atlas:GetSprite("n17_plant_di7")
    self._cloneBtnText:SetText(StringTable.Get("str_homeland_breed_start"))
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.Cloning then
    self._cloneSpeedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon5")
    self._cloneSpeedUpBtnText.color = Color(0.43137254901960786, 0.6470588235294118, 0.15294117647058825)
    self._cloneBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self._cloneBtnText:SetText(StringTable.Get("str_homeland_breed_end"))
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.CloneReap then
    self._cloneSpeedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon6")
    self._cloneSpeedUpBtnText.color = Color(0.4980392156862745, 0.4980392156862745, 0.4980392156862745)
    self._cloneBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self._cloneBtnText:SetText(StringTable.Get("str_homeland_breed_reap"))
  else
    self._cloneSpeedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon6")
    self._cloneSpeedUpBtnText.color = Color(0.4980392156862745, 0.4980392156862745, 0.4980392156862745)
    self._cloneBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self._cloneBtnText:SetText(StringTable.Get("str_homeland_breed_start"))
  end
end

function UIHomelandBreedClone:Update(deltaTime)
  if self.uiOwner:GetCurBreedState() ~= HomelandBreedState.Cloning then
    return
  end
  self._refreshInterval = self._refreshInterval + deltaTime
  if self._refreshInterval >= 1000 then
    self._refreshInterval = 0
    self:_RefreshTime()
  end
end

function UIHomelandBreedClone:_RefreshTime()
  local timeStr = "00:00:00"
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Cloning then
    local remainTime = self._homelandModule:GetLandEndTime(self._breedInfo) - self._svrTimeModule:GetServerTime() * 0.001
    timeStr = HomelandBreedTool.GetTimeStr(remainTime)
    if remainTime <= 0 then
      self.uiOwner:SetCurBreedState(HomelandBreedState.CloneReap)
      self:_RefreshUIInfo()
    end
  elseif self._seedData and self.uiOwner:GetCurBreedState() == HomelandBreedState.None then
    local cfgSeed = Cfg.cfg_item_tree_seed[self._seedData.ID]
    local cfgTreeAttribute = Cfg.cfg_item_tree_attribute[cfgSeed.TreeId]
    local cfg = Cfg.cfg_homeland_rarity({
      Species = cfgTreeAttribute.Species,
      Rarity = cfgTreeAttribute.Rarity
    })
    timeStr = HomelandBreedTool.GetTimeStr(cfg[1].DirectionalTime)
  end
  self._cloneTime:SetText(timeStr)
end

function UIHomelandBreedClone:SeedBtnOnClick(go)
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Cloning or self.uiOwner:GetCurBreedState() == HomelandBreedState.CloneReap then
    self:ShowDialog("UIItemTipsHomeland", self._seedData.ID, go)
    return
  end
  self:ShowDialog("UIHomelandBackpack", 4, function(item)
    local cfgSeed = Cfg.cfg_item_tree_seed[item:GetTemplateID()]
    return cfgSeed and item:GetTemplate().ItemSubType == ItemSubType.ItemSubType_Seed
  end, function(item)
    if item:GetCount() < 2 then
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_clone_noenough"))
      return false
    end
    self._seedData = item:GetTemplate()
    local cfgtree = Cfg.cfg_item_tree_seed[self._seedData.ID]
    self._resultSeedData = Cfg.cfg_item[cfgtree.TreeId]
    self:_RefreshUIInfo()
    return true
  end)
end

function UIHomelandBreedClone:ResultSeedBtnOnClick(go)
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Cloning or self.uiOwner:GetCurBreedState() == HomelandBreedState.CloneReap then
    self:ShowDialog("UIItemTipsHomeland", self._resultSeedData.ID, go)
    return
  end
end

function UIHomelandBreedClone:CloneSpeedUpBtnOnClick(go)
  local state = self.uiOwner:GetCurBreedState()
  if state == HomelandBreedState.Cloning then
    local id, time = self:_GetAccelerateItemInfo()
    local resultID = self._breedInfo.cultivation_result[1].assetid
    local helpTime = Cfg.cfg_item_tree_attribute[resultID].HelpAllTime
    self:ShowDialog("UIHomelandAccelerate", StringTable.Get("str_homeland_breed_speedup_desc"), self._homelandModule:GetLandEndTime(self._breedInfo), id, time, function(id, count)
      self:_UseItem(id, count)
    end, helpTime)
  elseif state ~= HomelandBreedState.CloneReap then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_nospeedup"))
  end
end

function UIHomelandBreedClone:_GetAccelerateItemInfo()
  local cfg = Cfg.cfg_item_cultivation({})
  for _, value in pairs(cfg) do
    if value.ItemAttrType == CultivationItemType.E_ACCELERATION then
      return value.ID, value.Time
    end
  end
  return 0, 0
end

function UIHomelandBreedClone:CloneBtnOnClick(go)
  if not self._seedData then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_clone_noenough"))
    return
  end
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.None then
    self:_StartClone()
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.Cloning then
    self:_CancleClone()
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.CloneReap then
    self:_CloneReap()
  end
end

function UIHomelandBreedClone:_StartClone()
  self:Lock("UIHomelandStartClone")
  self:StartTask(function(TT)
    local clietCultivationInfo = ClietCultivationInfo:New()
    local directionalCultivation = DirectionalCultivation:New()
    directionalCultivation.seed_id = self._seedData.ID
    table.insert(clietCultivationInfo.directional_cultivation, directionalCultivation)
    clietCultivationInfo.land_pstid = self.uiOwner.buildingPstId
    local res = self._homelandModule:HandleCultivation(TT, clietCultivationInfo)
    if res:GetSucc() then
      self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
      self.uiOwner:SetCurBreedState(HomelandBreedState.Cloning)
      self:_RefreshUIInfo()
      self.uiOwner.breedLand:PlantTree()
    end
    self:UnLock("UIHomelandStartClone")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandCloseBreedUI)
  end, self)
end

function UIHomelandBreedClone:_CancleClone()
  local function callBack()
    self:Lock("UIHomelandCancleClone")
    
    self:StartTask(function(TT)
      local res = self._homelandModule:HandleCancelCultivation(TT, self.uiOwner.buildingPstId)
      if res:GetSucc() then
        self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
        self.uiOwner:SetCurBreedState(HomelandBreedState.None)
        self:_RefreshUIInfo()
        self.uiOwner.breedLand:Clear()
      else
        Log.fatal("Cancel breed failed:", res:GetResult())
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_error_" .. res:GetResult()))
        self:_RefreshUIInfo()
      end
      self:UnLock("UIHomelandCancleClone")
    end, self)
  end
  
  local title = ""
  local desc = StringTable.Get("str_homeland_breed_end_desc")
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function(param)
      if callBack then
        callBack()
      end
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end

function UIHomelandBreedClone:_CloneReap()
  self:Lock("UIHomelandCloneReap")
  self:StartTask(function(TT)
    local res, items, exp, first = self._homelandModule:HandlePickupCultivation(TT, self.uiOwner.buildingPstId)
    if res:GetSucc() then
      if 0 < exp then
        local roleAsset = {}
        roleAsset.exp = true
        roleAsset.first = first
        roleAsset.assetid = -1
        roleAsset.count = exp
      end
      self:ShowDialog("UIHomelandBreedResult", self._seedData, self._seedData, items, function()
        self:_BreedResultCallBack()
      end, HomelandBreedUIType.Clone)
      self.uiOwner.breedLand:Clear()
      if 0 < exp then
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_add_exp", exp))
      end
      YIELD(TT, 1000)
      local uiModule = GameGlobal.GetUIModule(HomelandModule)
      uiModule:TryPopLevelUpTip()
    end
    self:UnLock("UIHomelandCloneReap")
  end, self)
end

function UIHomelandBreedClone:_BreedResultCallBack()
  self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
  self.uiOwner:SetCurBreedState(HomelandBreedState.None)
  self:_RefreshUIInfo()
end

function UIHomelandBreedClone:_SelectItemCallBakc()
  self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
  self:_RefreshUIInfo()
  self.uiOwner.breedLand:RefreshPhases()
end

function UIHomelandBreedClone:_UseItem(id, count)
  self:Lock("UIHomelandBreedClone")
  self:StartTask(function(TT)
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = id
    roleAsset.count = count
    local res = self._homelandModule:HandleAccelerateCultivation(TT, self.uiOwner.buildingPstId, roleAsset)
    if res:GetSucc() then
      self:_SelectItemCallBakc()
    else
      Log.fatal("Breed accelerate failed:", res:GetResult())
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_error_" .. res:GetResult()))
    end
    self:UnLock("UIHomelandBreedClone")
  end, self)
end
