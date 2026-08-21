_class("UIHomelandBreedResult", UIController)
UIHomelandBreedResult = UIHomelandBreedResult

function UIHomelandBreedResult:Constructor()
  self._items = nil
end

function UIHomelandBreedResult:OnShow(uiParams)
  self._mainSeedData = uiParams[1]
  self._mutationSeedData = uiParams[2]
  self._itemDatas = uiParams[3]
  self._callBack = uiParams[4]
  self._breedUIType = uiParams[5]
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandBreedResult:_GetComponents()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._mainSeedItem = self:GetUIComponent("UISelectObjectPath", "MainSeedItem")
  self._mutationSeedItem = self:GetUIComponent("UISelectObjectPath", "MutationSeedItem")
  self._resultSeedItem = self:GetUIComponent("UISelectObjectPath", "ResultSeedItem")
  self._mainSeedName = self:GetUIComponent("UILocalizationText", "MainSeedName")
  self._mutationSeedName = self:GetUIComponent("UILocalizationText", "MutationSeedName")
  self._resultSeedName = self:GetUIComponent("UILocalizationText", "ResultSeedName")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._mainDescription = self:GetUIComponent("UILocalizationText", "MainDescription")
  self._mutationDescription = self:GetUIComponent("UILocalizationText", "MutationDescription")
  self._style3 = self:GetGameObject("Style3")
  self._style2 = self:GetGameObject("Style2")
  self._originSeedItem = self:GetUIComponent("UISelectObjectPath", "OriginSeedItem")
  self._resultTreeItem = self:GetUIComponent("UISelectObjectPath", "ResultTreeItem")
  self._originSeedDesc = self:GetUIComponent("UILocalizationText", "OriginSeedDesc")
  self._originSeedName = self:GetUIComponent("UILocalizationText", "OriginSeedName")
  self._resultTreeName = self:GetUIComponent("UILocalizationText", "ResultTreeName")
  self._bg = self:GetUIComponent("RawImageLoader", "BgRawImage")
end

function UIHomelandBreedResult:CloseBtnOnClick(go)
  self:CloseDialog()
  if self._callBack then
    self._callBack()
  end
end

function UIHomelandBreedResult:_OnValue()
  if self._breedUIType == HomelandBreedUIType.StateChg then
    self._bg:LoadImage("n17_plant_di36")
    self._style2:SetActive(true)
    self._style3:SetActive(false)
    self:_SetSeedInfo(self._originSeedItem, self._originSeedName, self._mainSeedData, Vector2(0, 0), Vector2(250, 250))
    local stateChgDesc = StringTable.Get(self._mainSeedData.Name)
    self._originSeedDesc:SetText(stateChgDesc)
  else
    self._bg:LoadImage("n17_plant_di11")
    self._style2:SetActive(false)
    self._style3:SetActive(true)
    self:_SetSeedInfo(self._mainSeedItem, self._mainSeedName, self._mainSeedData, Vector2(0, 0), Vector2(250, 250))
    self:_SetSeedInfo(self._mutationSeedItem, self._mutationSeedName, self._mutationSeedData, Vector2(0, 0), Vector2(250, 250))
    local mainDescription = StringTable.Get(self._mainSeedData.Name)
    local mutationDescription = StringTable.Get(self._mutationSeedData.Name)
    self._mainDescription:SetText(mainDescription)
    self._mutationDescription:SetText(mutationDescription)
  end
  if self._itemDatas and 0 < #self._itemDatas then
    local cfg
    if self._itemDatas[1].exp then
      cfg = Cfg.cfg_item[self._itemDatas[2].assetid]
    else
      cfg = Cfg.cfg_item[self._itemDatas[1].assetid]
    end
    if self._breedUIType == HomelandBreedUIType.StateChg then
      self:_SetSeedInfo(self._resultTreeItem, self._resultTreeName, cfg, Vector2(0, 0), Vector2(400, 400))
    else
      self:_SetSeedInfo(self._resultSeedItem, self._resultSeedName, cfg, Vector2(0, 0), Vector2(400, 400))
    end
    local count = #self._itemDatas
    self._content:SpawnObjects("UIItemHomeland", count)
    self._items = self._content:GetAllSpawnList()
    for i = 1, count do
      self._items[i]:Flush(self._itemDatas[i])
    end
    self:_SetTitle(self._mainSeedData, cfg)
  end
end

function UIHomelandBreedResult:_SetSeedInfo(seed, name, data, backgroundSize, iconSize)
  local widget = seed:SpawnObject("UIHomelandBreedItem")
  widget:SetData(data, backgroundSize, iconSize)
  name:SetText(StringTable.Get(data.Name))
end

function UIHomelandBreedResult:_SetTitle(mainSeed, ResultSeed)
  local str = "str_homeland_breed_success"
  if self._breedUIType ~= HomelandBreedUIType.StateChg then
    local cfgSeed = Cfg.cfg_item_tree_seed[mainSeed.ID]
    local cfgTreeAttribute = Cfg.cfg_item_tree_attribute[cfgSeed.TreeId]
    local cfgResultTreeAttribute = Cfg.cfg_item_tree_attribute[ResultSeed.ID]
    if cfgResultTreeAttribute.Rarity > cfgTreeAttribute.Rarity then
      str = "str_homeland_breed_upgrade_success"
    end
  end
  self._title:SetText(StringTable.Get(str))
end
