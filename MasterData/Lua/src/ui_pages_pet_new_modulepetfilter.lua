local this = class("modulePetFilter", G_UIModuleBase)
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()

function this.bind()
  return {
    list_optionGroup = {
      moduleName = "pages/pet/new/cellSortFilterPetGroup"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      if self._onClose then
        self._onClose()
      end
    end,
    onClick_reset = function(self)
      for i, v in pairs(self.modules.list_optionGroup) do
        local cell = v
        cell:setOptionListActive()
      end
    end,
    onClick_confirm = function(self)
      local valueList = {}
      for i, v in ipairs(self.modules.list_optionGroup) do
        valueList[v.bind.type] = v:getSelectValueList()
        if table.isEmpty(valueList[v.bind.type]) then
          valueList[v.bind.type] = nil
        end
      end
      if self._confirmCheck and not self._confirmCheck(valueList) then
        return
      end
      if self._callback then
        self._callback(valueList)
      end
      if self._onConfirmClose then
        self._onConfirmClose()
      end
    end,
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

function this:initFilterModule(param)
  self._callback = param.callback
  self._onCancel = param.onCancel
  self._onClose = param.onClose
  self._onConfirmClose = param.onConfirmClose
  self._confirmCheck = param.confirmCheck
  local selectValue = param.selectValue or {}
  local tmp = {}
  if param.customFilterGroups then
    for _, group in ipairs(param.customFilterGroups) do
      local typeId = group.type
      local tpl_filterType = _systemFiltertypeTpl:getTplById(typeId)
      local groupSelectValue = table.clone(selectValue[typeId]) or {}
      if table.isEmpty(groupSelectValue) and not table.isEmpty(group.defaultList) then
        groupSelectValue = table.clone(group.defaultList) or {}
      end
      if (group.selectLimit or 1) == 1 and 1 < #groupSelectValue then
        groupSelectValue = {
          groupSelectValue[1]
        }
      end
      table.insert(tmp, {
        selectValue = groupSelectValue,
        selectLimit = group.selectLimit or 1,
        type = typeId,
        txt_title = group.txt_title or tpl_filterType and _systemFiltertypeTpl:getFilterTypeName(tpl_filterType) or "",
        filterOptionHandle = group.filterOptionHandle,
        hideSelectLimit = group.hideSelectLimit,
        keepOneSelected = group.keepOneSelected,
        defaultList = group.defaultList
      })
    end
  else
    local sortFilterId
    if param._forceFilterId then
      sortFilterId = param._forceFilterId
    else
      local tpl_sys = _systemUnlockTpl:getTplById(param.systemId)
      sortFilterId = _systemUnlockTpl:getFilterConfig(tpl_sys)
    end
    local tpl_sortFilter = _systemFilterTpl:getTplById(sortFilterId)
    local filterConfig = _systemFilterTpl:getFilterConfig(tpl_sortFilter)
    for _, typeAndLimit in pairs(filterConfig) do
      local typeId, limit = table.unpack(typeAndLimit)
      local tpl_filterType = _systemFiltertypeTpl:getTplById(typeId)
      table.insert(tmp, {
        selectValue = table.clone(selectValue[typeId]) or {},
        selectLimit = limit,
        type = typeId,
        txt_title = _systemFiltertypeTpl:getFilterTypeName(tpl_filterType)
      })
    end
  end
  self.bind.list_optionGroup:clear()
  self.bind.list_optionGroup:insert_array(tmp)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_Content)
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

return this
