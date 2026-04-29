_class("UIPetIntimacyImageRecall", Object)
UIPetIntimacyImageRecall = UIPetIntimacyImageRecall

function UIPetIntimacyImageRecall:Constructor(intimacyMainController, petData)
  self._intimacyMainController = intimacyMainController
  self._petData = petData
  self._isInited = false
  self._petModule = GameGlobal.GetModule(PetModule)
end

function UIPetIntimacyImageRecall:Init()
  self._scrollView = self._intimacyMainController:GetUIComponent("UIDynamicScrollView", "ImageRecallListView")
  self._noMovieGO = self._intimacyMainController:GetGameObject("nomovie")
  self:_InitImageRecallData()
  self:_InitScrollView()
end

function UIPetIntimacyImageRecall:PetDataChanged(petData)
  self._petData = petData
  if self._isInited then
    self:_InitImageRecallData()
  end
end

function UIPetIntimacyImageRecall:Refresh()
  if self._isInited then
    self._currentSelectedData = nil
    self._currentSelectedItem = nil
    self._scrollView:SetListItemCount(self._imageRecallCount, true)
    self._scrollView:RefreshAllShownItem()
  else
    self:Init()
    self._isInited = true
  end
end

function UIPetIntimacyImageRecall:CloseWindow()
  self:_CancelSelected()
end

function UIPetIntimacyImageRecall:Destroy()
end

function UIPetIntimacyImageRecall:Update()
end

function UIPetIntimacyImageRecall:_InitImageRecallData()
  self._currentSelectedData = nil
  self._currentSelectedItem = nil
  self._imageRecallDatas = {}
  local index = 1
  local imageRecallConfig = {}
  local cfg_story = Cfg.cfg_aircraft_pet_stroy_refresh({})
  local petid = self._petData:GetTemplateID()
  for key, value in pairs(cfg_story) do
    local insert = false
    if value.TriggerType == EStoryTriggerType.EnterAircraftSection then
      local _petid = value.PetID
      if _petid == petid then
        insert = true
      elseif value.EnterTriggerNeedPetsArray and table.count(value.EnterTriggerNeedPetsArray) > 0 then
        for i = 1, #value.EnterTriggerNeedPetsArray do
          local __petid = value.EnterTriggerNeedPetsArray[i]
          if __petid == petid then
            insert = true
            break
          end
        end
      end
    else
      local _petid = value.PetID
      if _petid == petid then
        insert = true
      end
    end
    if insert then
      table.insert(imageRecallConfig, value)
    end
  end
  table.sort(imageRecallConfig, function(a, b)
    return a.ID < b.ID
  end)
  local skinCfg = {}
  local skinPetCfg = Cfg.cfg_pet_skin({
    PetId = self._petData:GetTemplateID()
  })
  if skinPetCfg then
    for i = 1, #skinPetCfg do
      local item = skinPetCfg[i]
      if not item.StoryId then
      end
      table.insert(skinCfg, item)
    end
  end
  table.sort(skinCfg, function(a, b)
    local sort_a = 0
    local sort_b = 0
    if a.SkinType then
      if a.SkinType == PetSkinFlag.PSF_COLLECTION then
        sort_a = 2
      else
        sort_a = 1
      end
    end
    if b.SkinType then
      if b.SkinType == PetSkinFlag.PSF_COLLECTION then
        sort_b = 2
      else
        sort_b = 1
      end
    end
    if sort_a ~= sort_b then
      return sort_a > sort_b
    else
      return a.id < b.id
    end
  end)
  local allCfg = {}
  for i = 1, #skinCfg do
    local item = skinCfg[i]
    local itemData = {}
    itemData.data = item
    itemData.type = 2
    if item.SkinType and item.SkinType == PetSkinFlag.PSF_COLLECTION then
      itemData.collect = true
    end
    table.insert(allCfg, itemData)
  end
  for i = 1, #imageRecallConfig do
    local item = imageRecallConfig[i]
    local itemData = {}
    itemData.data = item
    itemData.type = 1
    table.insert(allCfg, itemData)
  end
  if allCfg then
    for i = 1, #allCfg do
      local cfg = allCfg[i]
      local value = cfg.data
      if cfg.type == 1 then
        if value.ID ~= nil and value.ID ~= 0 and (value.MutexStoryEventId == 0 or value.MutexStoryEventId == nil) then
          local storyConfig = Cfg.cfg_pet_story[value.ID]
          local imageRecallData = {}
          imageRecallData.storyId = storyConfig.StoryID
          imageRecallData.title = storyConfig.Title
          imageRecallData.des = storyConfig.Des
          imageRecallData.icon = storyConfig.Icon
          imageRecallData.affinityLevel = value.AffinityLevel
          if value.TriggerType == EStoryTriggerType.EnterAircraftSection then
            if value.PetID == self._petData:GetTemplateID() then
              imageRecallData.isOpen = self._petData:IsFinishedStory(value.ID)
            else
              local mainPetID = value.PetID
              local mainPet = self._petModule:GetPetByTemplateId(mainPetID)
              if mainPet then
                imageRecallData.isOpen = mainPet:IsFinishedStory(value.ID)
              else
                imageRecallData.isOpen = false
              end
            end
          else
            imageRecallData.isOpen = self._petData:IsFinishedStory(value.ID)
          end
          imageRecallData.isSelected = false
          imageRecallData.index = index
          imageRecallData.condition = storyConfig.Condition
          self._imageRecallDatas[index] = imageRecallData
          index = index + 1
        end
      elseif value.StoryId then
        local storyConfig = Cfg.cfg_pet_story[value.StoryId]
        if storyConfig then
          local imageRecallData = {}
          imageRecallData.storyId = storyConfig.StoryID
          imageRecallData.title = storyConfig.Title
          imageRecallData.des = storyConfig.Des
          imageRecallData.icon = storyConfig.Icon
          imageRecallData.affinityLevel = value.AffinityLevel or 0
          local petSkinData = self._petModule:GetPetSkinsData(self._petData:GetTemplateID())
          local have = false
          if petSkinData and petSkinData.skin_info then
            for _, skinInfo in pairs(petSkinData.skin_info) do
              if skinInfo.skin_id == value.id then
                if skinInfo.unlock_CG == 1 then
                  have = true
                end
                break
              end
            end
          end
          imageRecallData.isOpen = have
          imageRecallData.isSelected = false
          imageRecallData.collect = cfg.collect
          imageRecallData.index = index
          imageRecallData.condition = storyConfig.Condition
          self._imageRecallDatas[index] = imageRecallData
          index = index + 1
        else
          Log.error("###[UIPetIntimacyImageRecall] storyConfig is nil ! id --> ", value.StoryId)
        end
      else
        Log.debug("###[UIPetIntimacyImageRecall] value.StoryId is nil !")
      end
    end
  end
  self._imageRecallCount = #self._imageRecallDatas
  self._noMovieGO:SetActive(0 >= self._imageRecallCount)
end

function UIPetIntimacyImageRecall:_InitScrollView()
  self._scrollView:InitListView(self._imageRecallCount, function(scrollview, index)
    return self:_OnGetImageRecallItem(scrollview, index)
  end)
end

function UIPetIntimacyImageRecall:_OnGetImageRecallItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self._intimacyMainController:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIPetIntimacyImageRecallItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._imageRecallCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshImageRecallItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIPetIntimacyImageRecall:_RefreshImageRecallItemInfo(itemWidget, index)
  itemWidget:Refresh(self._intimacyMainController, self, self._petData, self._imageRecallDatas[index])
end

function UIPetIntimacyImageRecall:OnItemClicked(item, itemData)
  self:_CancelSelected()
  self._currentSelectedData = itemData
  self._currentSelectedData.isSelected = true
  self._currentSelectedItem = item
  self._currentSelectedItem:RefreshSelectedStatus()
end

function UIPetIntimacyImageRecall:_CancelSelected()
  if self._currentSelectedData then
    self._currentSelectedData.isSelected = false
  end
  if self._currentSelectedItem then
    self._currentSelectedItem:RefreshSelectedStatus()
  end
  self._currentSelectedData = nil
  self._currentSelectedItem = nil
end
