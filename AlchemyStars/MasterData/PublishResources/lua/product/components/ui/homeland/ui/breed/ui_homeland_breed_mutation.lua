_class("UIHomelandBreedMutation", UICustomWidget)
UIHomelandBreedMutation = UIHomelandBreedMutation

function UIHomelandBreedMutation:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._mainSeedData = nil
  self._mutationSeedData = nil
  self._breedItem = nil
  self._directiveId = 0
  self._refreshInterval = 0
  self._atlas = self:GetAsset("UIHomelandBreed.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandBreedMutation:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedMutation:_GetComponents()
  self._mutationTime = self:GetUIComponent("UILocalizationText", "MutationTime")
  self._mainSeed = self:GetUIComponent("UISelectObjectPath", "MainSeed")
  self._mutationSeed = self:GetUIComponent("UISelectObjectPath", "MutationSeed")
  self._mutationLock = self:GetGameObject("MutationLock")
  self._mutationAdd = self:GetGameObject("MutationAdd")
  self._itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon")
  self._itemIconObj = self:GetGameObject("ItemIcon")
  self._itemLock = self:GetGameObject("ItemLock")
  self._itemAdd = self:GetGameObject("ItemAdd")
  self._itemText = self:GetGameObject("ItemText")
  self._speedUpBtn = self:GetUIComponent("Image", "SpeedUpBtn")
  self._mutationPreviewBtnLock = self:GetGameObject("MutationPreviewBtnLock")
  self._mutationBtn = self:GetUIComponent("Image", "MutationBtn")
  self._previewBtnText = self:GetUIComponent("UILocalizationText", "MutationPreviewBtnText")
  self._mutationBtnText = self:GetUIComponent("UILocalizationText", "MutationBtnText")
  self._selectMutationText = self:GetGameObject("SelectMutationText")
  self._speedUpBtnText = self:GetUIComponent("UILocalizationText", "SpeedUpBtnText")
end

function UIHomelandBreedMutation:_OnValue()
  self._mainSeedWidget = self._mainSeed:SpawnObject("UIHomelandBreedItem")
  self._mutationSeedWidget = self._mutationSeed:SpawnObject("UIHomelandBreedItem")
end

function UIHomelandBreedMutation:SetData(breedInfo)
  self:_InitBreedInfo(breedInfo)
  self:_RefreshUIInfo()
end

function UIHomelandBreedMutation:_InitBreedInfo(breedInfo)
  self._breedInfo = breedInfo
  self._mutationData = nil
  if self._breedInfo then
    self._mutationData = breedInfo.client_info.mutation_cultivation[1]
  end
  self._mainSeedData = nil
  self._mutationSeedData = nil
  self._directiveId = 0
  if self._mutationData then
    self._mainSeedData = Cfg.cfg_item[self._mutationData.main_seed_id]
    self._mutationSeedData = Cfg.cfg_item[self._mutationData.second_seed_id]
    self._breedItem = Cfg.cfg_item[self._mutationData.addtion_item_id]
    self._directiveId = self._mutationData.target_tree_id
  end
end

function UIHomelandBreedMutation:RefreshBreedInfo(breedInfo)
  self._breedInfo = breedInfo
end

function UIHomelandBreedMutation:_RefreshUIInfo()
  self:_RefreshSeedInfo()
  self:_RefreshBtn()
  self:_RefreshItem()
  self:_RefreshTime()
end

function UIHomelandBreedMutation:Update(deltaTime)
  if self.uiOwner:GetCurBreedState() ~= HomelandBreedState.Mutationing then
    return
  end
  self._refreshInterval = self._refreshInterval + deltaTime
  if self._refreshInterval >= 1000 then
    self._refreshInterval = 0
    self:_RefreshTime()
  end
end

function UIHomelandBreedMutation:SpeedUpBtnOnClick(go)
  local state = self.uiOwner:GetCurBreedState()
  if state == HomelandBreedState.Mutationing then
    local id, time = self:_GetAccelerateItemInfo()
    local resultID = self._breedInfo.cultivation_result[1].assetid
    local helpTime = Cfg.cfg_item_tree_attribute[resultID].HelpAllTime
    self:ShowDialog("UIHomelandAccelerate", StringTable.Get("str_homeland_breed_speedup_desc"), self._homelandModule:GetLandEndTime(self._breedInfo), id, time, function(id, count)
      self:_UseItem(id, count)
    end, helpTime)
  elseif state ~= HomelandBreedState.MutationReap then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_nospeedup"))
  end
end

function UIHomelandBreedMutation:_GetAccelerateItemInfo()
  local cfg = Cfg.cfg_item_cultivation({})
  for _, value in pairs(cfg) do
    if value.ItemAttrType == CultivationItemType.E_ACCELERATION then
      return value.ID, value.Time
    end
  end
  return 0, 0
end

function UIHomelandBreedMutation:MutationPreviewBtnOnClick(go)
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap then
    return
  end
  if not self:_SeedSelectComplete() then
    return
  end
  if self._breedItem then
    local cfg = Cfg.cfg_item_cultivation[self._breedItem.ID]
    if cfg.ItemAttrType == CultivationItemType.E_DIRECTIONAL_BREAK then
      self:ShowDialog("UIHomelandBreedDirective", self._mainSeedData, self._mutationSeedData, self._directiveId, function(id)
        self:_DirectiveSelectComplete(id)
      end)
      return
    end
  end
  self:ShowDialog("UIHomelandBreedPreview", HomelandBreedPreviewType.Mutation, self._mainSeedData, self._mutationSeedData)
end

function UIHomelandBreedMutation:MainSeedBtnOnClick(go)
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing or self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap then
    self:ShowDialog("UIItemTipsHomeland", self._mainSeedData.ID, go)
    return
  end
  self:ShowDialog("UIHomelandBackpack", 4, function(item)
    if item:GetTemplate().ItemSubType ~= ItemSubType.ItemSubType_Seed then
      return false
    end
    local seed = Cfg.cfg_item_tree_seed[item:GetTemplateID()]
    local seedAttribute = Cfg.cfg_item_tree_attribute[seed.TreeId]
    return seedAttribute.Rarity ~= RarityType.S and seedAttribute.IsMutation > 0
  end, function(item)
    self._mainSeedData = item:GetTemplate()
    self:_RefreshUIInfo()
    return true
  end)
end

function UIHomelandBreedMutation:MutationSeedBtnOnClick(go)
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing or self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap then
    self:ShowDialog("UIItemTipsHomeland", self._mutationSeedData.ID, go)
    return
  end
  if not self._mainSeedData then
    return
  end
  self:ShowDialog("UIHomelandBackpack", 4, function(item)
    return item:GetTemplate().ItemSubType == ItemSubType.ItemSubType_Seed and self:_CheckSeed(self._mainSeedData, item:GetTemplate())
  end, function(item)
    self._mutationSeedData = item:GetTemplate()
    self:_RefreshUIInfo()
    return true
  end)
end

function UIHomelandBreedMutation:ItemBtnOnClick(go)
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing or self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap then
    if self._breedItem then
      self:ShowDialog("UIItemTipsHomeland", self._breedItem.ID, go)
    else
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_notitem"))
    end
    return
  end
  if not self:_SeedSelectComplete() then
    return
  end
  self:ShowDialog("UIHomelandBackpack", 4, function(item)
    if item:GetTemplate().ItemSubType ~= ItemSubType.ItemSubType_CultivationItem then
      return false
    end
    local mainSeed = Cfg.cfg_item_tree_seed[self._mainSeedData.ID]
    local mainSeedAttribute = Cfg.cfg_item_tree_attribute[mainSeed.TreeId]
    local cfg = Cfg.cfg_item_cultivation[item:GetTemplateID()]
    return cfg.Species == mainSeedAttribute.Species and cfg.Rarity == mainSeedAttribute.Rarity and (cfg.ItemAttrType == CultivationItemType.E_MUST_BREAK or cfg.ItemAttrType == CultivationItemType.E_DIRECTIONAL_BREAK)
  end, function(item)
    self._breedItem = item:GetTemplate()
    self:_RefreshItem()
    return true
  end)
end

function UIHomelandBreedMutation:MutationBtnOnClick(go)
  if not self:_SeedSelectComplete() then
    return
  end
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.None then
    if self._breedItem then
      local cfg = Cfg.cfg_item_cultivation[self._breedItem.ID]
      if cfg.ItemAttrType == CultivationItemType.E_DIRECTIONAL_BREAK and self._directiveId <= 0 then
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_directive_noselect"))
        return
      end
    end
    self:_StartBreed()
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing then
    self:_CancleBreed()
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap then
    self:_BreedReap()
  end
end

function UIHomelandBreedMutation:_StartBreed()
  self:Lock("UIHomelandStartBreed")
  self:StartTask(function(TT)
    local clietCultivationInfo = ClietCultivationInfo:New()
    local mutationCultivation = MutationCultivation:New()
    mutationCultivation.main_seed_id = self._mainSeedData.ID
    mutationCultivation.second_seed_id = self._mutationSeedData.ID
    if self._breedItem then
      mutationCultivation.addtion_item_id = self._breedItem.ID
    end
    mutationCultivation.target_tree_id = self._directiveId
    table.insert(clietCultivationInfo.mutation_cultivation, mutationCultivation)
    clietCultivationInfo.land_pstid = self.uiOwner.buildingPstId
    local res = self._homelandModule:HandleCultivation(TT, clietCultivationInfo)
    if res:GetSucc() then
      self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
      self.uiOwner:SetCurBreedState(HomelandBreedState.Mutationing)
      self:_RefreshUIInfo()
      self.uiOwner.breedLand:PlantTree()
    end
    self:UnLock("UIHomelandStartBreed")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandCloseBreedUI)
  end, self)
end

function UIHomelandBreedMutation:_CancleBreed()
  local function callBack()
    self:Lock("UIHomelandCancleBreed")
    
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
      self:UnLock("UIHomelandCancleBreed")
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

function UIHomelandBreedMutation:_BreedReap()
  self:Lock("UIHomelandBreedReap")
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
      self:ShowDialog("UIHomelandBreedResult", self._mainSeedData, self._mutationSeedData, items, function()
        self:_BreedResultCallBack()
      end, HomelandBreedUIType.Mutation)
      self.uiOwner.breedLand:Clear()
      if 0 < exp then
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_add_exp", exp))
      end
      YIELD(TT, 1000)
      local uiModule = GameGlobal.GetUIModule(HomelandModule)
      uiModule:TryPopLevelUpTip()
    end
    self:UnLock("UIHomelandBreedReap")
  end, self)
end

function UIHomelandBreedMutation:_BreedResultCallBack()
  self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
  self.uiOwner:SetCurBreedState(HomelandBreedState.None)
  self:_RefreshUIInfo()
end

function UIHomelandBreedMutation:_SeedSelectComplete()
  local complete = self._mainSeedData and self._mutationSeedData
  if not complete then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_noseed"))
  end
  return complete
end

function UIHomelandBreedMutation:_RefreshSeedInfo()
  self._mainSeedWidget:SetData(self._mainSeedData, Vector2(568, 568), Vector2(500, 500))
  self._mutationLock:SetActive(self._mainSeedData == nil)
  self._mutationAdd:SetActive(not self._mutationLock.activeSelf)
  if not self:_CheckSeed(self._mainSeedData, self._mutationSeedData) then
    self._mutationSeedData = nil
  end
  self._mutationSeedWidget:SetData(self._mutationSeedData, Vector2(345, 345), Vector2(250, 250))
  self._selectMutationText:SetActive(self._mainSeedData and not self._mutationSeedData)
end

function UIHomelandBreedMutation:_RefreshBtn()
  if not self._mainSeedData or not self._mutationSeedData then
    self._speedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon6")
    self._speedUpBtnText.color = Color(0.4980392156862745, 0.4980392156862745, 0.4980392156862745)
    self._mutationPreviewBtnLock:SetActive(true)
    self._mutationBtn.sprite = self._atlas:GetSprite("n17_plant_di7")
    self._mutationBtnText:SetText(StringTable.Get("str_homeland_breed_start"))
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing then
    self._speedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon5")
    self._speedUpBtnText.color = Color(0.43137254901960786, 0.6470588235294118, 0.15294117647058825)
    self._mutationPreviewBtnLock:SetActive(false)
    self._mutationBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self._mutationBtnText:SetText(StringTable.Get("str_homeland_breed_end"))
  elseif self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap then
    self._speedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon6")
    self._speedUpBtnText.color = Color(0.4980392156862745, 0.4980392156862745, 0.4980392156862745)
    self._mutationPreviewBtnLock:SetActive(true)
    self._mutationBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self._mutationBtnText:SetText(StringTable.Get("str_homeland_breed_reap"))
  else
    self._speedUpBtn.sprite = self._atlas:GetSprite("n17_plant_icon6")
    self._speedUpBtnText.color = Color(0.4980392156862745, 0.4980392156862745, 0.4980392156862745)
    self._mutationPreviewBtnLock:SetActive(false)
    self._mutationBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self._mutationBtnText:SetText(StringTable.Get("str_homeland_breed_start"))
  end
end

function UIHomelandBreedMutation:_RefreshItem()
  local lock = false
  local noSeed = not self._mainSeedData or not self._mutationSeedData
  if noSeed then
    self._breedItem = nil
  end
  if noSeed or (self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing or self.uiOwner:GetCurBreedState() == HomelandBreedState.MutationReap) and not self._breedItem then
    lock = true
  end
  self._itemLock:SetActive(lock)
  self._itemAdd:SetActive(not lock)
  self._itemIconObj:SetActive(self._breedItem ~= nil)
  self._itemText:SetActive(not self._itemIconObj.activeSelf)
  if self._breedItem then
    local cfg = Cfg.cfg_item[self._breedItem.ID]
    self._itemIcon:LoadImage(cfg.Icon)
  end
  local str = "str_homeland_breed_result_preview"
  if self._breedItem then
    local cfg = Cfg.cfg_item_cultivation[self._breedItem.ID]
    if cfg.ItemAttrType == CultivationItemType.E_DIRECTIONAL_BREAK then
      if self._directiveId <= 0 then
        str = "str_homeland_breed_directive"
      else
        str = "str_homeland_breed_directed"
      end
    end
  end
  self._previewBtnText:SetText(StringTable.Get(str))
end

function UIHomelandBreedMutation:_RefreshTime()
  local timeStr = "00:00:00"
  if self.uiOwner:GetCurBreedState() == HomelandBreedState.Mutationing then
    local remainTime = self._homelandModule:GetLandEndTime(self._breedInfo) - self._svrTimeModule:GetServerTime() * 0.001
    timeStr = HomelandBreedTool.GetTimeStr(remainTime)
    if remainTime <= 0 then
      self.uiOwner:SetCurBreedState(HomelandBreedState.MutationReap)
      self:_RefreshUIInfo()
    end
  elseif self._mainSeedData and self.uiOwner:GetCurBreedState() == HomelandBreedState.None then
    local cfgSeed = Cfg.cfg_item_tree_seed[self._mainSeedData.ID]
    local cfgTreeAttribute = Cfg.cfg_item_tree_attribute[cfgSeed.TreeId]
    local cfg = Cfg.cfg_homeland_rarity({
      Species = cfgTreeAttribute.Species,
      Rarity = cfgTreeAttribute.Rarity
    })
    timeStr = HomelandBreedTool.GetTimeStr(cfg[1].MutationTime)
  end
  self._mutationTime:SetText(timeStr)
end

function UIHomelandBreedMutation:_CheckSeed(_mainSeed, _mutationSeed)
  if not _mainSeed or not _mutationSeed then
    return false
  end
  local mainSeed = Cfg.cfg_item_tree_seed[_mainSeed.ID]
  local mainSeedAttribute = Cfg.cfg_item_tree_attribute[mainSeed.TreeId]
  local mutationSeed = Cfg.cfg_item_tree_seed[_mutationSeed.ID]
  local mutationSeedAttribute = Cfg.cfg_item_tree_attribute[mutationSeed.TreeId]
  if mainSeedAttribute.Rarity == RarityType.S or mutationSeedAttribute.Species == RarityType.S then
    return false
  end
  if mainSeed.ID == mutationSeed.ID then
    return false
  end
  if mainSeedAttribute.Species ~= mutationSeedAttribute.Species then
    return false
  end
  if mainSeedAttribute.Rarity ~= mutationSeedAttribute.Rarity then
    return false
  end
  if mainSeedAttribute.IsMutation == 0 or mutationSeedAttribute.IsMutation == 0 then
    return false
  end
  if mainSeedAttribute.IsMutation ~= mutationSeedAttribute.IsMutation then
    return false
  end
  return true
end

function UIHomelandBreedMutation:_ItemOnClick()
  self:ItemBtnOnClick(self._itemIconObj)
end

function UIHomelandBreedMutation:_DirectiveSelectComplete(id)
  self._directiveId = id
  local str = "str_homeland_breed_directive"
  if self._directiveId > 0 then
    str = "str_homeland_breed_directed"
  end
  self._previewBtnText:SetText(StringTable.Get(str))
end

function UIHomelandBreedMutation:_SelectItemCallBakc()
  self:_InitBreedInfo(self.uiOwner:RefreshCultivationInfo())
  self:_RefreshUIInfo()
  self.uiOwner.breedLand:RefreshPhases()
end

function UIHomelandBreedMutation:_UseItem(id, count)
  self:Lock("UIHomelandBreedMutation")
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
    self:UnLock("UIHomelandBreedMutation")
  end, self)
end
