local this = class("moduleMapFilter", G_UIModuleBase)
local _filterTpl = L_GameTpl:getWorldFilterTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    filterPageActive = false,
    toggle_selectAll = false,
    listFilter = {
      moduleName = "pages/map/bigMap/cellMapFilterItem"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:hideFilterPage()
    end,
    onClick_empty = function(self)
      self:hideFilterPage()
    end,
    onClick_ChooseAll = function(self, isOn)
      self:onChooseAll(isOn)
    end
  }
end

function this:open()
end

function this:close()
  self.filters = nil
  self.fData = nil
end

function this:showFilterPage(mapData)
  self.mapData = mapData
  self.filters = {}
  for id, tpl in pairs(_filterTpl:getConfig()) do
    local screeningShow = _filterTpl:getScreeningShow(tpl)
    if not math.isEmpty(screeningShow) and id ~= L_MapConst.mapSievingType.all then
      if id == L_MapConst.mapSievingType.selfNode then
        local nodeData = _mapNodeTpl:getAllData()
        for i, _ in pairs(nodeData) do
          local phyId = self:getSelfNodeId(i)
          self.filters[phyId] = not self.mapData:getFilterType(phyId)
        end
      else
        self.filters[id] = not self.mapData:getFilterType(id)
      end
    end
  end
  self:SetActive(true)
  self:initFilterPage()
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
end

function this:hideFilterPage()
  self:SetActive(false)
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(true)
end

function this:initFilterPage()
  self.fData = {}
  local selectAll = true
  for id, tpl in pairs(_filterTpl:getConfig()) do
    local screeningShow = _filterTpl:getScreeningShow(tpl)
    if not math.isEmpty(screeningShow) and id ~= L_MapConst.mapSievingType.all then
      local cellIsOn = false
      if id == L_MapConst.mapSievingType.selfNode then
        local selfNodesData = _mapNodeTpl:getAllData()
        for i, tpl in pairs(selfNodesData) do
          local icon = _mapNodeTpl:getIcon(tpl)
          local name = _mapNodeTpl:getName(tpl)
          cellIsOn = self.filters[self:getSelfNodeId(i)]
          table.insert(self.fData, {
            type = self:getSelfNodeId(i),
            img_icon = icon,
            img_iconOff = icon,
            txtName = name,
            isOn = cellIsOn,
            clickCb = function(cell, isOn)
              self:refreshFilter(cell, isOn)
            end
          })
        end
      else
        local icon = _filterTpl:getScreeningIcon(tpl)
        local name = _filterTpl:getName(tpl)
        cellIsOn = self.filters[id] or false
        table.insert(self.fData, {
          type = id,
          img_icon = icon,
          img_iconOff = icon,
          txtName = name,
          isOn = cellIsOn,
          clickCb = function(cell, isOn)
            self:refreshFilter(cell, isOn)
          end
        })
      end
      if not cellIsOn then
        selectAll = false
      end
    end
  end
  self.bind.toggle_selectAll = selectAll
  table.sort(self.fData, function(a, b)
    return a.type < b.type
  end)
  self.bind.listFilter:clear()
  self.bind.listFilter:insert_array(self.fData)
end

function this:refreshFilter(cell, isOn)
  self.filters[cell.bind.type] = isOn
  local bigMap = self.parent
  if bigMap then
    bigMap:refreshMarksByFilter({
      [cell.bind.type] = isOn
    })
  end
  local selectAll = true
  if not isOn then
    selectAll = false
  else
    for i, v in pairs(self.filters) do
      if v == false then
        selectAll = false
        break
      end
    end
  end
  self.bind.toggle_selectAll = selectAll
end

function this:onChooseAll(isOn)
  for i = 1, #self.fData do
    local cell = self.bind.listFilter:getItemCls(i)
    cell:setCheckState(isOn)
    self.filters[cell.bind.type] = isOn
  end
  local bigMap = self.parent
  if bigMap then
    bigMap:refreshMarksByFilter(self.filters)
  end
end

function this:getSelfNodeId(idx)
  return L_MapConst.mapSievingType.selfNode + idx / 10
end

function this:getSelfNodeIndex(id)
  return math.round((id - L_MapConst.mapSievingType.selfNode) * 10)
end

return this
