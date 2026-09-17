local this = class("cellReleaseFilterGroup", G_UIModuleBase)
local systemFilterTypeTpl = L_GameTpl:getSystemFiltertypeTpl()
local selectSubIdList = {}

function this.bind()
  return {
    txt_title = nil,
    go_content = true,
    isOn_arrow = true,
    list_option = {
      moduleName = "pages/pet/cellReleaseFilterOption"
    }
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
      onClick_select = function(self, id, active)
        self:setOptionListActive(id, active)
      end
    }
  }
end

function this:open()
end

function this:refresh()
  self:initOptionList()
end

function this:initOptionList()
  if not self.isBind then
    return
  end
  local data = {}
  local filterTypeTpl = systemFilterTypeTpl:getTplById(self.bind.type)
  local subIds = systemFilterTypeTpl:getFilterContent(filterTypeTpl)
  self.bind.txt_title = systemFilterTypeTpl:getFilterTypeName(filterTypeTpl)
  local keepOneSelected = self.bind.keepOneSelected
  local defaultSelectId = 0
  if keepOneSelected then
    defaultSelectId = subIds[1]
  end
  for _, v in ipairs(subIds) do
    local optionData = {
      subId = v,
      go_active = v == defaultSelectId,
      go_item_on = false,
      go_item_off = false,
      keepOneSelected = keepOneSelected
    }
    local filterOptionHandle = self.bind.filterOptionHandle
    if filterOptionHandle then
      filterOptionHandle(self.bind.type, optionData)
    end
    table.insert(data, optionData)
    if v == defaultSelectId then
      table.insert(selectSubIdList, v)
    end
  end
  self.bind.list_option:clear()
  self.bind.list_option:insert_array(data)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_list_option)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_cellSortFilterGroup)
end

function this:setOptionListActive(subId, active)
  if not active and self.bind.keepOneSelected then
    return
  end
  if self.bind.keepOneSelected then
    table.clear(selectSubIdList)
    for _, v in ipairs(self.modules.list_option) do
      v:setActive(v.bind.subId == subId)
      v:setActiveSingleOrMultiOn(false)
    end
    table.insert(selectSubIdList, subId)
  else
    for _, v in ipairs(self.modules.list_option) do
      if v.bind.subId == subId then
        v:setActive(active)
      end
      v:setActiveSingleOrMultiOn(false)
    end
    if active then
      table.insert(selectSubIdList, subId)
    else
      table.removeBy(selectSubIdList, subId)
    end
  end
end

function this:getSelectValueList()
  if not table.isEmpty(self._selectValueList) then
    return self._selectValueList
  end
end

function this:getSelectSubIdList()
  local res = {}
  for _, v in ipairs(self.modules.list_option) do
    if v.bind.go_active then
      table.insert(res, v.bind.subId)
    end
  end
  return res
end

return this
