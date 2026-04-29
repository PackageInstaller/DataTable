local HomelandBreedPreviewType = {Mutation = 1, StateChg = 2}
_enum("HomelandBreedPreviewType", HomelandBreedPreviewType)
_class("UIHomelandBreedPreview", UIController)
UIHomelandBreedPreview = UIHomelandBreedPreview

function UIHomelandBreedPreview:Constructor()
  self._items = nil
end

function UIHomelandBreedPreview:OnShow(uiParams)
  self._previewType = uiParams[1]
  self._mainSeedData = uiParams[2]
  self._mutationSeedData = uiParams[3]
  self:_GetComponents()
  if self._previewType == HomelandBreedPreviewType.Mutation then
    self:_FlushMutationPreview()
  elseif self._previewType == HomelandBreedPreviewType.StateChg then
    self:_FlushStateChgPreview()
  else
    Log.error("can't support Previewtype :" .. self._previewType)
  end
end

function UIHomelandBreedPreview:_GetComponents()
  self._scrollView = self:GetUIComponent("Image", "ScrollView")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._txtTips = self:GetUIComponent("UILocalizationText", "TxtTips")
end

function UIHomelandBreedPreview:_FlushMutationPreview()
  self._txtTips:SetText("")
  self._data = self:_MutationDataFilter()
  table.sort(self._data, function(a, b)
    local aProbability = self:GetProbability(a.cfg)
    local bProbability = self:GetProbability(b.cfg)
    if aProbability ~= bProbability then
      return aProbability > bProbability
    end
    return a.cfg.ID > b.cfg.ID
  end)
  local count = table.count(self._data)
  if count <= 0 then
    Log.error("Homeland Breed Directive Cfg Error.")
    return
  end
  self._content:SpawnObjects("UIHomelandBreedPreviewItem", count)
  self._items = self._content:GetAllSpawnList()
  for i = 1, count do
    self._items[i]:SetData(self._previewType, self._mainSeedData, self._data[i])
  end
end

function UIHomelandBreedPreview:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandBreedPreview:_MutationDataFilter()
  local cfgMainSeed = Cfg.cfg_item_tree_seed[self._mainSeedData.ID]
  local cfgMainTree = Cfg.cfg_item_tree_attribute[cfgMainSeed.TreeId]
  local cfgMutationSeed = Cfg.cfg_item_tree_seed[self._mutationSeedData.ID]
  local cfgMutationTree = Cfg.cfg_item_tree_attribute[cfgMutationSeed.TreeId]
  local cfgTree = Cfg.cfg_item_tree_attribute({})
  local rarityCfg = Cfg.cfg_homeland_rarity({
    Species = cfgMainTree.Species,
    Rarity = cfgMainTree.Rarity
  })
  local advancedPro
  if rarityCfg and rarityCfg[1] then
    advancedPro = rarityCfg[1].AdvancedPro
  end
  local data = {}
  for _, tree in pairs(cfgTree) do
    if not (tree.Species == cfgMainTree.Species and (tree.Pedigree == cfgMainTree.Pedigree or tree.Pedigree == cfgMutationTree.Pedigree) and tree.Rarity >= cfgMainTree.Rarity and tree.IsMutation > 0) or tree.Rarity == cfgMainTree.Rarity and tree.ID ~= cfgMainTree.ID and tree.ID ~= cfgMutationTree.ID then
    elseif advancedPro then
      for i = 1, #advancedPro do
        if advancedPro[i][1] == tree.Rarity and advancedPro[i][2] ~= 0 then
          local t = {}
          t.cfg = tree
          
          function t.getProbalilityFunc(cfg)
            return self:GetProbability(cfg)
          end
          
          table.insert(data, t)
        end
      end
    end
  end
  return data
end

function UIHomelandBreedPreview:GetProbability(cfg)
  local cfgMainSeed = Cfg.cfg_item_tree_seed[self._mainSeedData.ID]
  local cfgMainTree = Cfg.cfg_item_tree_attribute[cfgMainSeed.TreeId]
  local cfgMutationSeed = Cfg.cfg_item_tree_seed[self._mutationSeedData.ID]
  local cfgMutationTree = Cfg.cfg_item_tree_attribute[cfgMutationSeed.TreeId]
  local rarityCfgs = Cfg.cfg_homeland_rarity({
    Species = cfgMainTree.Species,
    Rarity = cfgMainTree.Rarity
  })
  local rarityCfg = rarityCfgs[1]
  local rarity = cfg.Rarity
  local result = 0
  if cfg.ID == cfgMainTree.ID then
    result = self:UIHomelandGetPro(rarity) * rarityCfg.MainSeedPro / 100.0
  elseif cfg.ID == cfgMutationTree.ID then
    result = self:UIHomelandGetPro(rarity) * (1.0 - rarityCfg.MainSeedPro / 100.0)
  elseif cfgMainTree.Pedigree == cfgMutationTree.Pedigree then
    result = self:UIHomelandGetPro(rarity) / self:UIHomelandGetRarityNum(rarity)
  elseif cfg.Pedigree == cfgMainTree.Pedigree then
    result = self:UIHomelandGetPro(rarity) / self:UIHomelandGetRarityNum(rarity) * rarityCfg.MainSeedPro / 100.0 * 2.0
  else
    result = self:UIHomelandGetPro(rarity) / self:UIHomelandGetRarityNum(rarity) * (1.0 - rarityCfg.MainSeedPro / 100.0) * 2.0
  end
  return result
end

function UIHomelandBreedPreview:UIHomelandGetPro(ratity)
  local cfgMainSeed = Cfg.cfg_item_tree_seed[self._mainSeedData.ID]
  local cfgMainTree = Cfg.cfg_item_tree_attribute[cfgMainSeed.TreeId]
  local rarityCfg = Cfg.cfg_homeland_rarity({
    Species = cfgMainTree.Species,
    Rarity = cfgMainTree.Rarity
  })
  local advancedPro
  if rarityCfg and rarityCfg[1] then
    advancedPro = rarityCfg[1].AdvancedPro
  end
  if advancedPro then
    for i = 1, #advancedPro do
      if advancedPro[i][1] == ratity then
        return advancedPro[i][2] / 100.0
      end
    end
  end
  return 0
end

function UIHomelandBreedPreview:UIHomelandGetRarityNum(rarity)
  local result = self:_MutationDataFilter()
  local num = 0
  for _, tree in pairs(result) do
    if tree.cfg.Rarity == rarity then
      num = num + 1
    end
  end
  return num
end

function UIHomelandBreedPreview:_FlushStateChgPreview()
  self._txtTips:SetText(StringTable.Get("str_homeland_breed_statechg_preview_tips2"))
  self._data = self:_StateChgDataFilter()
  table.sort(self._data, function(a, b)
    return a.cfg.ID > b.cfg.ID
  end)
  local count = table.count(self._data)
  if count <= 0 then
    Log.error("Homeland Breed Attribute preview Cfg Error.")
    return
  end
  self._content:SpawnObjects("UIHomelandBreedPreviewItem", count)
  self._items = self._content:GetAllSpawnList()
  for i = 1, count do
    self._items[i]:SetData(self._previewType, self._mainSeedData, self._data[i])
  end
end

function UIHomelandBreedPreview:_StateChgDataFilter()
  local cfgMainTree = Cfg.cfg_item_tree_attribute[self._mainSeedData.ID]
  local rarity = cfgMainTree.Rarity
  local species = cfgMainTree.Species
  local pedigree = cfgMainTree.Pedigree
  local serialNum = cfgMainTree.SerialNum
  local cfgTrees = Cfg.cfg_item_tree_attribute({})
  local data = {}
  for _, tree in pairs(cfgTrees) do
    if tree.IsMutation == 1 and tree.SerialNum ~= serialNum and tree.Rarity == rarity and tree.Species == species and tree.Pedigree == pedigree then
      local t = {}
      t.cfg = tree
      table.insert(data, t)
    end
  end
  return data
end
