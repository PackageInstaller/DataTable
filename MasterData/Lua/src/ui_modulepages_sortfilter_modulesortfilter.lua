local this = class("moduleSortFilter", G_UIModuleBase)
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()
local _systemSorttypeTpl = L_GameTpl:getSystemSorttypeTpl()

function this.bind()
  return {
    go_button = false,
    go_icon_on = false,
    go_bar = false,
    txt_bar = nil,
    go_dropdown = false,
    txt_dropdown = nil,
    go_dropdownContent = false,
    isOn_arrow = false,
    list_dropdown = {
      moduleName = "modulePages/sortFilter/cellSortFilterDropdown"
    },
    go_sort_reverse_btn = false
  }
end

function this.methods()
  return {
    onClick_button = function(self)
      self:openMultiplyPage(L_SortFilterConst.SortFilterStyle.Button)
    end,
    onClick_bar = function(self)
      self:openMultiplyPage(L_SortFilterConst.SortFilterStyle.Bar)
    end,
    onClick_dropdown = function(self)
      if self._dropDownShow then
        C_AudioManager.Play("Play_SFX_System_UI_General_Drop_Close")
      else
        C_AudioManager.Play("Play_SFX_System_UI_General_Drop_Open")
      end
      self:checkDropdownShow()
    end,
    onClick_reverse = function(self)
      self.bindComponents.ani_reverse_icon:Stop()
      if self._isSortReverse then
        self.bindComponents.ani_reverse_icon:Play("anim_btn_reverse_press_2")
      else
        self.bindComponents.ani_reverse_icon:Play("anim_btn_reverse_press_1")
      end
      self._isSortReverse = not self._isSortReverse
      self._sortCallback(self._sortKeyList, self._isSortReverse)
    end,
    list_dropdown = {
      onClick_select = function(self, bind)
        if not self._dropDownShow then
          return
        end
        self:checkDropdownShow()
        if self._sortStyle == L_SortFilterConst.SortFilterStyle.Dropdown then
          self._sortKeyList = {}
          local solidSortKey = _systemFilterTpl:getSolidSortKey(self._sortFilterTpl)
          table.fill(self._sortKeyList, solidSortKey)
          table.insert(self._sortKeyList, bind.type)
          local subSortKey = _systemFilterTpl:getSubSortKey(self._sortFilterTpl)
          table.fill(self._sortKeyList, subSortKey)
          self._sortCallback(self._sortKeyList, self._isSortReverse)
        elseif self._filterStyle == L_SortFilterConst.SortFilterStyle.Dropdown then
          self._filterKeyDic = {
            [bind.type] = {
              bind.id
            }
          }
          self._filterCallback(self._filterKeyDic)
          self.bindComponents.ani_btn_filter:SetBool("On", not table.isEmpty(self._filterKeyDic))
          self.bind.go_icon_on = not table.isEmpty(self._filterKeyDic) and true or false
        end
        self:setDropdownListActive()
      end
    }
  }
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:setData(param)
  self._systemId = param.systemId
  self._filterCallback = param.filterCallback
  self._filterKeyDic = param.filterKeyDic
  self._sortCallback = param.sortCallback
  self._sortKeyList = param.sortKeyList
  self._isSortReverse = param.isSortReverse
  local tpl_sys = _systemUnlockTpl:getTplById(self._systemId)
  self._sortFilterTpl = _systemFilterTpl:getTplById(_systemUnlockTpl:getFilterConfig(tpl_sys))
  self._filterStyle = _systemFilterTpl:getFilterComponents(self._sortFilterTpl)
  self._sortStyle = _systemFilterTpl:getSortComponents(self._sortFilterTpl)
  if self._filterStyle == self._sortStyle and self._filterStyle ~= nil then
    error("通用筛选组件filter与sort样式相同,暂不支持，请检查配置")
  end
  self.bind.go_button = self._filterStyle == L_SortFilterConst.SortFilterStyle.Button or self._sortStyle == L_SortFilterConst.SortFilterStyle.Button
  self.bind.go_bar = self._filterStyle == L_SortFilterConst.SortFilterStyle.Bar or self._sortStyle == L_SortFilterConst.SortFilterStyle.Bar
  self.bind.go_dropdown = self._filterStyle == L_SortFilterConst.SortFilterStyle.Dropdown or self._sortStyle == L_SortFilterConst.SortFilterStyle.Dropdown
  self.bind.go_sort_reverse_btn = _systemFilterTpl:getIsReverseOpen(self._sortFilterTpl)
  if self.bind.go_button then
    self:setButtonData()
  end
  if self.bind.go_bar then
    error("TypeBar已废弃 请检查配置")
    self:setBarData()
  end
  if self.bind.go_dropdown then
    self:setDropdownData()
  end
  self.bindComponents.ani_btn_filter:SetBool("On", not table.isEmpty(self._filterKeyDic))
  self.bind.go_icon_on = not table.isEmpty(self._filterKeyDic) and true or false
end

function this:setButtonData()
end

function this:setBarData()
end

function this:setDropdownData()
  self._dropDownShow = false
  self.bind.go_dropdownContent = self._dropDownShow
  self.bind.isOn_arrow = self._dropDownShow
  local tmp = {}
  if self._filterStyle == L_SortFilterConst.SortFilterStyle.Dropdown then
    local filterConfig = _systemFilterTpl:getFilterConfig(self._sortFilterTpl)
    for _, typeAndLimit in pairs(filterConfig) do
      local typeId, limit = table.unpack(typeAndLimit)
      local tpl_filterType = _systemFiltertypeTpl:getTplById(typeId)
      local idKey = _systemFiltertypeTpl:getFilterKey(tpl_filterType)
      local nameKey = _systemFiltertypeTpl:getFilterName(tpl_filterType)
      local iconKey = _systemFiltertypeTpl:getIconDisplay(tpl_filterType)
      local allContentTpl = L_SortFilterManager:getAllFilterContentTplByType(typeId)
      for index, v in ipairs(allContentTpl) do
        local isActiveLine = index ~= #allContentTpl
        table.insert(tmp, {
          type = typeId,
          id = v[idKey],
          txt_name = L_Config:provider(v[nameKey]),
          txt_name_h = L_Config:provider(v[nameKey]),
          go_line = isActiveLine
        })
      end
    end
  elseif self._sortStyle == L_SortFilterConst.SortFilterStyle.Dropdown then
    local sortTypeData = _systemFilterTpl:getSortType(self._sortFilterTpl)
    local index = 1
    for groupIndex, groupData in ipairs(sortTypeData) do
      for infoIndex, sortKey in ipairs(groupData) do
        local tpl_sortType = _systemSorttypeTpl:getTplById(sortKey)
        local isActiveLine = groupIndex ~= #sortTypeData or infoIndex ~= #groupData
        table.insert(tmp, {
          index = index,
          type = sortKey,
          txt_name = _systemSorttypeTpl:getSortTypeName(tpl_sortType),
          txt_name_h = _systemSorttypeTpl:getSortTypeName(tpl_sortType),
          go_line = isActiveLine
        })
        index = index + 1
      end
    end
  end
  self.bind.list_dropdown:clear()
  self.bind.list_dropdown:insert_array(tmp)
  self:setDropdownListActive()
end

function this:setDropdownListActive()
  if self._filterStyle == L_SortFilterConst.SortFilterStyle.Dropdown then
    for i, v in pairs(self.modules.list_dropdown) do
      local active = false
      if self._filterKeyDic[v.bind.type] and self._filterKeyDic[v.bind.type][1] == v.bind.id then
        active = true
      end
      v:setActive(active)
      if active then
        self.bind.txt_dropdown = v.bind.txt_name
      end
    end
  elseif self._sortStyle == L_SortFilterConst.SortFilterStyle.Dropdown then
    local firstKeyType = L_SortFilterManager:getNotDefaultFirstSortKey(self._systemId, self._sortKeyList)
    for i, v in pairs(self.modules.list_dropdown) do
      local active = v.bind.type == firstKeyType
      v:setActive(active)
      if active then
        self.bind.txt_dropdown = v.bind.txt_name
      end
    end
  end
end

function this:openMultiplyPage(sortFilterStyle)
  local param
  if self._filterStyle == sortFilterStyle then
    local function callback(filterKeyDic)
      self._filterKeyDic = filterKeyDic
      
      self._filterCallback(filterKeyDic)
      self.bindComponents.ani_btn_filter:SetBool("On", not table.isEmpty(self._filterKeyDic))
      self.bind.go_icon_on = not table.isEmpty(self._filterKeyDic) and true or false
    end
    
    param = {
      type = L_SortFilterConst.SortOrFilter.Filter,
      systemId = self._systemId,
      callback = callback,
      selectValue = self._filterKeyDic
    }
  elseif self._sortStyle == sortFilterStyle then
    local function callback(sortKeyList)
      self._sortKeyList = sortKeyList
      
      self._sortCallback(sortKeyList, self._isSortReverse)
      self.bindComponents.ani_btn_filter:SetBool("On", not table.isEmpty(sortKeyList))
    end
    
    param = {
      type = L_SortFilterConst.SortOrFilter.Sort,
      systemId = self._systemId,
      callback = callback,
      selectValue = self._sortKeyList
    }
  end
  L_UI:open("pageMultiplySortFilter", param)
end

function this:isOnFilter()
  return not table.isEmpty(self._filterKeyDic)
end

function this:checkDropdownShow()
  self._dropDownShow = not self._dropDownShow
  self.bind.isOn_arrow = self._dropDownShow
  if self._dropDownShow then
    self.bind.go_dropdownContent = true
    self.bindComponents.ani_content:Stop()
    self.bindComponents.ani_content:Play("anim_filter_dropdown_menu_show")
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_content)
  else
    self.bindComponents.ani_content:Stop()
    self.bindComponents.ani_content:Play("anim_filter_dropdown_menu_hide")
    L_TimerManager:newOrResetTimer(self, "hideContent", function()
      self.bind.go_dropdownContent = false
    end, 0.133)
  end
end

return this
