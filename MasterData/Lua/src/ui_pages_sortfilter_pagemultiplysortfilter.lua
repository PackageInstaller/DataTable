local this = class("pageMultiplySortFilter", G_UIPageBase)
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()

function this.bind()
  return {
    list_optionGroup = {
      moduleName = "pages/sortFilter/cellSortFilterGroup"
    },
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    go_sortNumInfo = false,
    txt_sortNumPrefix = "",
    txt_sortNum = ""
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        if self._type == L_SortFilterConst.SortOrFilter.Sort then
          self._defaultSortList = self._defaultSortList or {}
          self._selectSortValueList = {}
          table.fill(self._selectSortValueList, self._defaultSortList)
          self:updateCurSortNum()
          for i, v in pairs(self.modules.list_optionGroup) do
            local cell = v
            cell:setOptionListActive(self._selectSortValueList)
          end
        else
          for i, v in pairs(self.modules.list_optionGroup) do
            local cell = v
            cell:setOptionListActive()
          end
        end
      end,
      onClick_confirm = function(self)
        local valueList = {}
        if self._type == L_SortFilterConst.SortOrFilter.Sort then
          local tpl_sortFilter = _systemFilterTpl:getTplById(self._sortFilterId)
          local solidSortKey = _systemFilterTpl:getSolidSortKey(tpl_sortFilter)
          table.fill(valueList, solidSortKey)
          local sortList = self._selectSortValueList or {}
          table.fill(valueList, sortList)
          local subSortKey = _systemFilterTpl:getSubSortKey(tpl_sortFilter)
          table.fill(valueList, subSortKey)
        else
          for i, v in ipairs(self.modules.list_optionGroup) do
            valueList[v.bind.type] = v:getSelectValueList()
            if table.isEmpty(valueList[v.bind.type]) then
              valueList[v.bind.type] = nil
            end
          end
        end
        self._callback(valueList)
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

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._type = options.type
  self._callback = options.callback
  self.bind.go_sortNumInfo = self._type == L_SortFilterConst.SortOrFilter.Sort
  local selectValue = options.selectValue or {}
  local tpl_sys = _systemUnlockTpl:getTplById(options.systemId)
  self._sortFilterId = _systemUnlockTpl:getFilterConfig(tpl_sys)
  local tpl_sortFilter = _systemFilterTpl:getTplById(self._sortFilterId)
  local tmp = {}
  if self._type == L_SortFilterConst.SortOrFilter.Sort then
    self.txt_title = L_WordsTpl:getValue("notice_pageMultiplySortFilter_02")
    if self.sortHandle == nil then
      self.sortHandle = handler(self, self.hanldeSortItemClick)
    end
    self._selectSortValueList = {}
    local tpl_sortFilter = _systemFilterTpl:getTplById(self._sortFilterId)
    local solidSortKey = _systemFilterTpl:getSolidSortKey(tpl_sortFilter)
    local subSortKey = _systemFilterTpl:getSubSortKey(tpl_sortFilter)
    for index, v in ipairs(selectValue) do
      local existsInSolid = false
      local existsInSub = false
      if solidSortKey then
        for _, val in ipairs(solidSortKey) do
          if val == v then
            existsInSolid = true
            break
          end
        end
      end
      if subSortKey and not existsInSolid then
        for _, val in ipairs(subSortKey) do
          if val == v then
            existsInSub = true
            break
          end
        end
      end
      if not existsInSolid and not existsInSub then
        table.insert(self._selectSortValueList, v)
      end
    end
    local totalSortLimit = _systemFilterTpl:getSortPicksLimit(tpl_sortFilter)
    local sortPicks = _systemFilterTpl:getSortPicks(tpl_sortFilter)
    local sortLimit = _systemFilterTpl:getSortPicksLimit(tpl_sortFilter)
    local defaultList = {}
    for i, sortKey in ipairs(sortPicks) do
      if i <= sortLimit then
        table.insert(defaultList, sortKey)
      end
    end
    self._defaultSortList = defaultList
    self._sortPickLimitNum = sortLimit
    local sortType = _systemFilterTpl:getSortType(tpl_sortFilter)
    for index, typeData in pairs(sortType) do
      table.insert(tmp, {
        sortOrFilter = L_SortFilterConst.SortOrFilter.Sort,
        selectValue = self._selectSortValueList,
        selectLimit = totalSortLimit,
        sortTypeData = typeData,
        defaultList = defaultList,
        txt_title = _systemFilterTpl:getGroupName(tpl_sortFilter, index),
        sortHandle = self.sortHandle
      })
    end
    self.bind.txt_sortNumPrefix = L_WordsTpl:getValue("ui_sort_select_num_prefix")
    self:updateCurSortNum()
  else
    self.txt_title = L_WordsTpl:getValue("notice_pageMultiplySortFilter_01")
    local filterConfig = _systemFilterTpl:getFilterConfig(tpl_sortFilter)
    for _, typeAndLimit in pairs(filterConfig) do
      local typeId, limit = table.unpack(typeAndLimit)
      local tpl_filterType = _systemFiltertypeTpl:getTplById(typeId)
      table.insert(tmp, {
        sortOrFilter = L_SortFilterConst.SortOrFilter.Filter,
        selectValue = table.clone(selectValue[typeId]) or {},
        selectLimit = limit,
        type = typeId,
        txt_title = _systemFiltertypeTpl:getFilterTypeName(tpl_filterType)
      })
    end
  end
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    txtTitle = self.txt_title,
    txtCancel = L_WordsTpl:getValue("residual_code_pagemultiplysortfilter_01")
  })
  self.bind.list_optionGroup:clear()
  self.bind.list_optionGroup:insert_array(tmp)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_Content)
end

function this:show()
  C_InputManager.SetGamepadUIInputMap(self.pageName, true)
end

function this:hide()
  C_InputManager.SetGamepadUIInputMap(self.pageName, false)
end

function this:hanldeSortItemClick(cellSortFilterGroup, isActive, sortId)
  local curSelectNum = #self._selectSortValueList
  local limitReached = curSelectNum >= self._sortPickLimitNum
  if isActive then
    local _, index = table.ipairsFind(self._selectSortValueList, function(v)
      return v == sortId
    end)
    table.remove(self._selectSortValueList, index)
  else
    if limitReached then
      if self._sortPickLimitNum == 1 and curSelectNum == 1 then
        table.remove(self._selectSortValueList, 1)
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_filter_select_num_limit"))
        return
      end
    end
    table.insert(self._selectSortValueList, sortId)
  end
  for i, v in ipairs(self.modules.list_optionGroup) do
    v:setOptionListActive(self._selectSortValueList)
  end
  self:updateCurSortNum()
end

function this:updateCurSortNum()
  local curSelectNum = #self._selectSortValueList
  self.bind.txt_sortNum = L_WordsTpl:getValue("ui_sort_select_num_value", {
    [0] = tostring(curSelectNum),
    [1] = tostring(self._sortPickLimitNum)
  })
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
