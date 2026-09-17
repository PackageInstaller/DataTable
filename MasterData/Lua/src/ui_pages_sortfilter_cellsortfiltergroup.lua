local this = class("cellSortFilterGroup", G_UIModuleBase)
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()
local _systemSorttypeTpl = L_GameTpl:getSystemSorttypeTpl()

function this.bind()
  return {
    txt_title = nil,
    go_content = true,
    isOn_arrow = true,
    list_option = {
      moduleName = "pages/sortFilter/cellSortFilterOption"
    },
    go_selectNumLimit = true,
    txt_selectNumLimit = nil
  }
end

function this.methods()
  return {
    onClick_title = function(self)
      self.bind.go_content = not self.bind.go_content
      self.bind.isOn_arrow = self.bind.go_content
      L_GameUtil.forceRebuildLayout(self.bindComponents.rect_cellSortFilterGroup)
      self:emit("onClick_title", self.uiBinding, self.bind.go_content)
    end,
    list_option = {
      onClick_select = function(self, bind)
        local hasGoActive = bind.go_active
        if self.bind.sortOrFilter == L_SortFilterConst.SortOrFilter.Sort and self.bind.sortHandle then
          self.bind.sortHandle(self, hasGoActive, bind.id)
          return
        end
        local limitReached = #self._selectValueList >= self.bind.selectLimit
        if limitReached and self.bind.selectLimit > 1 and not hasGoActive then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_filter_select_num_limit"))
          return
        end
        if hasGoActive then
          if self.bind.selectLimit == 1 and self.bind.keepOneSelected then
            return
          end
          local node, index = table.ipairsFind(self._selectValueList, function(v)
            return v == bind.id
          end)
          table.remove(self._selectValueList, index)
        else
          if limitReached and self.bind.selectLimit == 1 then
            self._selectValueList = {}
          end
          table.insert(self._selectValueList, bind.id)
        end
        self:setOptionListActive(self._selectValueList)
      end
    }
  }
end

function this:open()
  self:initOptionList()
  self:setOptionListActive(self.bind.selectValue)
end

function this:initOptionList()
  local tmp = {}
  if self.bind.customOptions then
    for _, v in ipairs(self.bind.customOptions) do
      local icon = v.img_item_off
      local hasIcon = icon and not string.isEmpty(icon)
      table.insert(tmp, {
        id = v.id,
        name = v.name or v.txt_name,
        showIcon = hasIcon,
        iconStr = icon,
        txt_name = v.txt_name or v.name or "",
        maskType = v.maskType or 0
      })
    end
    self.bind.list_option:clear()
    self.bind.list_option:insert_array(tmp)
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_list_option)
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_cellSortFilterGroup)
    return
  end
  if self.bind.sortOrFilter == L_SortFilterConst.SortOrFilter.Filter then
    local tpl_filterType = _systemFiltertypeTpl:getTplById(self.bind.type)
    local idKey = _systemFiltertypeTpl:getFilterKey(tpl_filterType)
    local nameKey = _systemFiltertypeTpl:getFilterName(tpl_filterType)
    local iconKey = _systemFiltertypeTpl:getIconDisplay(tpl_filterType)
    local needIcon = not string.isEmpty(iconKey)
    local maskType = _systemFiltertypeTpl:getMaskType(tpl_filterType) or 0
    local allContentTpl = L_SortFilterManager:getAllFilterContentTplByType(self.bind.type)
    for i, v in pairs(allContentTpl) do
      local name = L_Config:provider(v[nameKey])
      local imgPath
      if needIcon then
        imgPath = v[iconKey]
      end
      local optionData = {
        id = v[idKey],
        name = name,
        showIcon = imgPath ~= nil,
        iconStr = imgPath,
        txt_name = name,
        maskType = maskType
      }
      local filterOptionHandle = self.bind.filterOptionHandle
      if filterOptionHandle then
        filterOptionHandle(self.bind.type, optionData, v)
      end
      table.insert(tmp, optionData)
    end
  else
    for i, type in ipairs(self.bind.sortTypeData) do
      local tpl_filterType = _systemSorttypeTpl:getTplById(type)
      local name = _systemSorttypeTpl:getSortTypeName(tpl_filterType)
      local icon = _systemSorttypeTpl:getIcon(tpl_filterType)
      local hasIcon = icon and not string.isEmpty(icon)
      local maskType = _systemSorttypeTpl:getMaskType(tpl_filterType) or 0
      table.insert(tmp, {
        id = type,
        name = name,
        showIcon = hasIcon,
        iconStr = icon,
        txt_name = name,
        maskType = maskType,
        useSortImg = true
      })
    end
  end
  self.bind.list_option:clear()
  self.bind.list_option:insert_array(tmp)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_list_option)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_cellSortFilterGroup)
end

function this:setOptionListActive(selectList)
  local defaultList = self.bind.defaultList or {}
  self._selectValueList = selectList or defaultList
  local isSort = self.bind.sortOrFilter == L_SortFilterConst.SortOrFilter.Sort
  for i, v in ipairs(self.modules.list_option) do
    local node, index = table.ipairsFind(self._selectValueList, function(value)
      return value == v.bind.id
    end)
    v:setActive(index ~= nil)
    if isSort then
      if self.bind.selectLimit ~= 1 then
        v:SetIsSort()
        v:setSortIndex(self.bind.selectLimit ~= 1 and index ~= nil, index)
      else
        v:setActiveSingleOrMultiOn(self.bind.selectLimit == 1)
      end
    else
      v:setActiveSingleOrMultiOn(self.bind.selectLimit == 1)
      v:setSortIndex(false)
    end
  end
  self:updateCurSelectNum()
end

function this:updateCurSelectNum()
  local count = #self._selectValueList
  if self.bind.sortOrFilter == L_SortFilterConst.SortOrFilter.Filter and self.bind.selectLimit >= 1 then
    self.bind.go_selectNumLimit = not self.bind.hideSelectLimit
    self.bind.txt_selectNumLimit = count .. "/" .. self.bind.selectLimit
  else
    self.bind.go_selectNumLimit = false
  end
end

function this:getSelectValueList()
  if not table.isEmpty(self._selectValueList) then
    return self._selectValueList
  end
end

return this
