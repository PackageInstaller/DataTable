_class("UIHomelandBreedStateChg", UICustomWidget)
UIHomelandBreedStateChg = UIHomelandBreedStateChg
local toint = math.tointeger

function UIHomelandBreedStateChg:Constructor()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._atlas = self:GetAsset("UIHomelandBreed.spriteatlas", LoadType.SpriteAtlas)
  self._costItemId = 5400002
end

function UIHomelandBreedStateChg:OnShow(uiParams)
  self:InitWidget()
  self:_OnValue()
end

function UIHomelandBreedStateChg:InitWidget()
  self.seed = self:GetUIComponent("UISelectObjectPath", "Seed")
  self.culBtn = self:GetUIComponent("Image", "CulBtn")
  self.propicon = self:GetUIComponent("RawImageLoader", "propicon")
  self.propCount = self:GetUIComponent("UILocalizationText", "propCount")
  self.ResultMask = self:GetGameObject("ResultMask")
  self.treeCountBg = self:GetGameObject("treeCountBg")
  self.treeCount = self:GetUIComponent("UILocalizationText", "treeCount")
  self.tipTxt = self:GetUIComponent("UILocalizationText", "tipTxt")
end

function UIHomelandBreedStateChg:_OnValue()
  self.seedWidget = self.seed:SpawnObject("UIHomelandBreedItem")
  local propCfg = Cfg.cfg_item[self._costItemId]
  if propCfg then
    self.propicon:LoadImage(propCfg.Icon)
  end
end

function UIHomelandBreedStateChg:SetData(breedInfo)
  self._mainSeedData = nil
  self:_RefreshUIInfo()
end

function UIHomelandBreedStateChg:SeedBtnOnClick(go)
  self:ShowDialog("UIHomelandBackpack", 4, function(item)
    local cfgTree = Cfg.cfg_item_tree_attribute[item:GetTemplateID()]
    return cfgTree and cfgTree.Rarity == 4
  end, function(item)
    local curCount, placedCount = 0, 0
    curCount, placedCount = UIForgeData.GetOwnPlaceCount(item:GetTemplateID())
    if curCount == placedCount then
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_statechg_nofree"))
      return false
    end
    self._mainSeedData = item:GetTemplate()
    self:_RefreshUIInfo()
    return true
  end)
end

function UIHomelandBreedStateChg:ResultSeedBtnOnClick(go)
  if not self._mainSeedData then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_statechg_notree"))
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local n = itemModule:GetItemCount(self._costItemId)
  if n < 1 then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_statechg_noitem"))
    return
  end
  self:ShowDialog("UIHomelandBreedPreview", HomelandBreedPreviewType.StateChg, self._mainSeedData, self._mutationSeedData)
end

function UIHomelandBreedStateChg:CulBtnOnClick(go)
  if not self._mainSeedData then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_statechg_notree"))
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local n = itemModule:GetItemCount(self._costItemId)
  if n < 1 then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_breed_statechg_noitem"))
    return
  end
  self:_StartBreed()
end

function UIHomelandBreedStateChg:PropBtnOnClick(go)
  self:ShowDialog("UIItemTipsHomeland", self._costItemId, go)
end

function UIHomelandBreedStateChg:_StartBreed()
  self:Lock("UIHomelandStartBreed")
  self:StartTask(function(TT)
    local clietCultivationInfo = ClietCultivationInfo:New()
    local stateChangeCultivation = StateChangeCultivation:New()
    stateChangeCultivation.tree_id = self._mainSeedData.ID
    stateChangeCultivation.item_id = self._costItemId
    table.insert(clietCultivationInfo.state_change_cultivation, stateChangeCultivation)
    clietCultivationInfo.land_pstid = self.uiOwner.buildingPstId
    local res = self._homelandModule:HandleCultivation(TT, clietCultivationInfo)
    if res:GetSucc() then
      self.uiOwner.breedLand:PlantTree()
    end
    self:UnLock("UIHomelandStartBreed")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandCloseBreedUI)
  end, self)
end

function UIHomelandBreedStateChg:Update(deltaTime)
end

function UIHomelandBreedStateChg:_RefreshUIInfo()
  self.seedWidget:SetData(self._mainSeedData, Vector2(568, 568), Vector2(500, 500))
  local itemModule = GameGlobal.GetModule(ItemModule)
  if self._mainSeedData then
    self.treeCountBg:SetActive(true)
    local treeName = StringTable.Get(self._mainSeedData.Name)
    local treeCount = itemModule:GetItemCount(self._mainSeedData.ID)
    local strTreeCount = StringTable.Get("str_homeland_breed_tree_name_count", treeName, toint(treeCount))
    self.treeCount:SetText(strTreeCount)
    self.tipTxt:SetText(StringTable.Get("str_homeland_breed_statechg_preview_tips1"))
  else
    self.treeCountBg:SetActive(false)
    self.tipTxt:SetText(StringTable.Get("str_homeland_breed_statechg_preview_tips"))
  end
  local n = itemModule:GetItemCount(self._costItemId)
  local propCfg = Cfg.cfg_item[self._costItemId]
  if propCfg then
    local propName = StringTable.Get(propCfg.Name)
    if n < 1 then
      self.propCount:SetText(string.format("%s: <color=#f8440f>%d</color>/%d", propName, n, 1))
    else
      self.propCount:SetText(string.format("%s: %d/%d", propName, n, 1))
    end
  end
  if 0 < n and self._mainSeedData then
    self.culBtn.sprite = self._atlas:GetSprite("n17_plant_di6")
    self.ResultMask:SetActive(false)
  else
    self.culBtn.sprite = self._atlas:GetSprite("n17_plant_di7")
    self.ResultMask:SetActive(true)
  end
end
