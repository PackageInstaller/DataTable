local this = class("pagePetReleaseQuickSelect", G_UIPageBase)
local petTpl = L_GameTpl:getPetTpl()
local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local systemFilterTpl = L_GameTpl:getSystemFilterTpl()
local petTalentTpl = L_GameTpl:getPetTalentTpl()

function this.bind()
  return {
    list_optionGroup = {
      moduleName = "pages/pet/cellReleaseFilterGroup"
    },
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        self:initPage()
      end,
      onClick_confirm = function(self)
        self:dealFilter()
        L_UI:close(self.pageName)
      end
    },
    onValueChanged_scrollView = function(self, _)
      if not self._lockBackVertical then
        self._backScrollNormalize = nil
      end
    end,
    list_optionGroup = {
      onClick_title = function(self, uiBinding, open)
        L_GameUtil.forceRebuildLayout(self.bindComponents.rect_Content)
        self._backScrollNormalize = self.bindComponents.scrollView_group.verticalNormalizedPosition
        FrameScheduler.add(function()
          self:refreshNormalizePos(uiBinding, open)
        end, 1, uiBinding)
      end
    }
  }
end

function this:dealFilter()
  local petItems = table.clone(L_PetStore:getPetList())
  for _, v in ipairs(self.modules.list_optionGroup) do
    local typeId = v.bind.type
    local subIdList = v:getSelectSubIdList()
    if not table.isEmpty(subIdList) then
      petItems = self:dealFilterByType(petItems, typeId, subIdList)
    end
  end
  local filteredPets = {}
  if petItems then
    for _, pet in pairs(petItems) do
      if self:checkPetStatusAndTips(pet) then
        table.insert(filteredPets, pet)
      end
    end
  end
  petItems = filteredPets
  if self.callback then
    self.callback(petItems)
  end
end

function this:checkPetStatusAndTips(pet)
  if not pet then
    return false
  end
  local tpl = petTpl:getTplById(pet.id)
  if not tpl then
    return false
  end
  if not petTpl:getIsRelease(tpl) then
    return false
  end
  if not math.isEmpty(pet:getHeroId()) then
    return false
  end
  if pet:isInMountRoulette() then
    return false
  end
  if pet.work_status ~= L_Const.PetStationedWorkStatusType.PSWST_NONE then
    return false
  end
  return true
end

function this:dealFilterByType(petItems, typeId, subIdList)
  local selectedDic = {}
  for _, subId in ipairs(subIdList) do
    if not math.isEmpty(subId) then
      selectedDic[subId] = true
    end
  end
  if selectedDic[18] then
    local pets = {}
    for _, v in pairs(petItems) do
      local boxId = v.box_id or 0
      if boxId // 100 == self.currentBox then
        table.insert(pets, v)
      end
    end
    return pets
  elseif selectedDic[19] then
    return petItems
  elseif typeId == L_SortFilterConst.FilterType.QiBoQuality then
    return self:dealFilterByQiBoQuality(petItems, selectedDic)
  else
    return petItems
  end
end

function this:dealFilterByQiBoQuality(petItems, selectedDic)
  local pets = {}
  for _, pet in pairs(petItems) do
    local tpl = petTalentTpl:getTplById(pet.petTalentId)
    local filterContentId = tpl and petTalentTpl:getFilterContentId(tpl)
    if filterContentId and selectedDic[filterContentId] then
      table.insert(pets, pet)
    end
  end
  return pets
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.callback = options.callback
  self.currentBox = options.currentBox
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("notice_soldier_selectFast"),
    txtCancel = L_WordsTpl:getValue("residual_code_pagepetreleasequickselect_01")
  })
  self:initPage()
end

function this:initPage()
  local systemTpl = systemUnlockTpl:getTplById(L_SystemConst.enum.petRelease)
  local filterId = systemUnlockTpl:getFilterConfig(systemTpl)
  local filterTpl = systemFilterTpl:getTplById(filterId)
  local filterConfig = systemFilterTpl:getFilterConfig(filterTpl)
  local groups = {}
  local scopeFilterType
  for _, typeAndLimit in ipairs(filterConfig or {}) do
    local typeId, _ = table.unpack(typeAndLimit)
    if typeId == L_SortFilterConst.FilterType.Gene then
      scopeFilterType = typeId
      break
    end
  end
  for _, typeAndLimit in ipairs(filterConfig or {}) do
    local typeId, limit = table.unpack(typeAndLimit)
    local group = {type = typeId, selectLimit = limit}
    if typeId == L_SortFilterConst.FilterType.QiBoQuality then
      group.filterOptionHandle = handler(self, self.setQiBoQualityFilterOption)
    end
    group.keepOneSelected = typeId == scopeFilterType
    table.insert(groups, group)
  end
  self.bind.list_optionGroup:clear()
  self.bind.list_optionGroup:insert_array(groups)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_Content)
end

function this:setQiBoQualityFilterOption(typeId, optionData)
  if typeId ~= L_SortFilterConst.FilterType.QiBoQuality then
    return
  end
  for _, tpl in ipairs(petTalentTpl:getAllList() or {}) do
    if petTalentTpl:getFilterContentId(tpl) == optionData.subId then
      optionData.iconStr = petTalentTpl:getIcon(tpl) or optionData.iconStr
      optionData.img_icon = optionData.iconStr
      break
    end
  end
  optionData.showIcon = optionData.iconStr ~= nil
  optionData.showFilterIcon = optionData.showIcon
end

function this:refreshNormalizePos(cellUiBinding, isInfoOpen)
  local scroll = self.bindComponents.scrollView_group
  if not scroll then
    return
  end
  if isInfoOpen then
    local isVisible = L_EffectUtil.isElementVerticalVisible(cellUiBinding, scroll.viewport, scroll.content)
    local jumpY = self:getJumpY(cellUiBinding)
    local contenSize = scroll.content.sizeDelta
    local viewPortRectSize = scroll.viewport.rect.size
    if not isVisible then
      self._lockBackVertical = true
      scroll.verticalNormalizedPosition = math.clamp(1 - jumpY / (contenSize.y - viewPortRectSize.y), 0, 1)
      FrameScheduler.add(function()
        self._lockBackVertical = false
      end, 1, cellUiBinding)
    end
  else
    if self._backScrollNormalize then
      local y = self._backScrollNormalize
      scroll.verticalNormalizedPosition = math.clamp(y, 0, 1)
    end
    self._backScrollNormalize = nil
  end
end

function this:getJumpY(targetElement)
  local elementRect = targetElement:GetComponent(typeof(C_RectTransform))
  local elementAnchoredPos = elementRect.anchoredPosition
  return -elementAnchoredPos.y - 11 - elementRect.rect.height / 2
end

function this:escHandle()
  L_UI:close(self.pageName)
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Frame_Close")
end

return this
