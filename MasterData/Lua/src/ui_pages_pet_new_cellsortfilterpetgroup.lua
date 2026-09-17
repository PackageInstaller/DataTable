local this = class("cellSortFilterPetGroup", G_UIModuleBase)
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()
local _petTalentTpl = L_GameTpl:getPetTalentTpl()
local _petGradeTpl = L_GameTpl:getPetGradeTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local GridStyle = {
  Large = 1,
  Normal = 2,
  Small = 3,
  LargeNum = 2,
  NormalNum = 3,
  SmallNum = 4,
  LargeCellSize = C_Vector2(318.3725, 69.403),
  NormalCellSize = C_Vector2(218.6325, 69.403),
  SmallCellSize = C_Vector2(157.1894, 69.403),
  LargeSpacing = C_Vector2(13.99, 9.6),
  NormalSpacing = C_Vector2(-1.7, 9.6),
  SmallSpacing = C_Vector2(8.09, 9.6),
  QiBoQualityIconPos = C_Vector2(0, 0),
  QiBoGradeIconPos = C_Vector2(-1.2, 5.4),
  MainElementIconPos = C_Vector2(0, 0)
}

function this.bind()
  return {
    txt_title = nil,
    list_option = {
      moduleName = "pages/pet/new/cellSortFilterPetOption"
    },
    list_optionHor = {
      moduleName = "pages/pet/new/cellSortFilterPetOption"
    },
    go_selectNumLimit = true,
    txt_selectNumLimit = nil,
    active_listGrid = true,
    active_listHor = false
  }
end

function this.methods()
  return {
    list_option = {
      onClick_select = function(self, bind)
        self:handleOptionClick(self, bind)
      end
    },
    list_optionHor = {
      onClick_select = function(self, bind)
        self:handleOptionClick(self, bind)
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
  local tpl_filterType = _systemFiltertypeTpl:getTplById(self.bind.type)
  local idKey = _systemFiltertypeTpl:getFilterKey(tpl_filterType)
  local nameKey = _systemFiltertypeTpl:getFilterName(tpl_filterType)
  local iconKey = _systemFiltertypeTpl:getIconDisplay(tpl_filterType)
  local allContentTpl = L_SortFilterManager:getAllFilterContentTplByType(self.bind.type)
  
  local function buildOptionData(v)
    local name = L_Config:provider(v[nameKey])
    local imgPath
    if not string.isEmpty(iconKey) then
      imgPath = v[iconKey]
    end
    local optionData = {
      id = v[idKey],
      name = name,
      showIcon = imgPath ~= nil,
      iconOnPath = imgPath,
      iconOffPath = imgPath
    }
    return optionData
  end
  
  local function insertOptionData(optionData, v)
    local filterOptionHandle = self.bind.filterOptionHandle
    if filterOptionHandle then
      filterOptionHandle(self.bind.type, optionData, v)
    end
    table.insert(tmp, optionData)
  end
  
  local gridStyle = GridStyle.Normal
  
  local function refreshGridStyle(gridStyle)
    if gridStyle == GridStyle.Small then
      self.bindComponents.grid_list.constraintCount = GridStyle.SmallNum
      self.bindComponents.grid_list.cellSize = GridStyle.SmallCellSize
      self.bindComponents.grid_list.spacing = GridStyle.SmallSpacing
    elseif gridStyle == GridStyle.Large then
      self.bindComponents.grid_list.constraintCount = GridStyle.LargeNum
      self.bindComponents.grid_list.cellSize = GridStyle.LargeCellSize
      self.bindComponents.grid_list.spacing = GridStyle.LargeSpacing
    else
      self.bindComponents.grid_list.constraintCount = GridStyle.NormalNum
      self.bindComponents.grid_list.cellSize = GridStyle.NormalCellSize
      self.bindComponents.grid_list.spacing = GridStyle.NormalSpacing
    end
  end
  
  if self.bind.type == L_SortFilterConst.FilterType.Gene then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      optionData.useLarge = true
      insertOptionData(optionData, v)
      gridStyle = GridStyle.Large
    end
  elseif self.bind.type == L_SortFilterConst.FilterType.QiBoQuality then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      for _, tpl in ipairs(_petTalentTpl:getAllList() or {}) do
        if _petTalentTpl:getFilterContentId(tpl) == optionData.id then
          local iconPath = _petTalentTpl:getIcon(tpl)
          optionData.iconOnPath = iconPath or optionData.iconOnPath
          optionData.iconOffPath = iconPath or optionData.iconOffPath
          break
        end
      end
      optionData.showIcon = optionData.iconOnPath ~= nil
      optionData.iconPos = GridStyle.QiBoQualityIconPos
      insertOptionData(optionData, v)
    end
  elseif self.bind.type == L_SortFilterConst.FilterType.QiBoGrade then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      local gradeIcon = _petGradeTpl:getGradeIcon(v)
      optionData.useBgPath = true
      optionData.iconOnPath = gradeIcon[1]
      optionData.bgPath = gradeIcon[2]
      optionData.iconOffPath = gradeIcon[3]
      optionData.showIcon = true
      local _, color = C_ColorUtility.TryParseHtmlString("#4f525d")
      optionData.iconOffColor = color
      optionData.iconPos = GridStyle.QiBoGradeIconPos
      insertOptionData(optionData, v)
    end
  elseif self.bind.type == L_SortFilterConst.FilterType.MainElement then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      local elementPetBox = _elementTypeTpl:getElementPetBox(v)
      local _, elementOffColor = C_ColorUtility.TryParseHtmlString(_elementTypeTpl:getElementColor(v))
      optionData.useBgPath = true
      optionData.iconOnPath = elementPetBox[1]
      optionData.bgPath = elementPetBox[2]
      optionData.iconOffPath = elementPetBox[3]
      optionData.showIcon = true
      optionData.iconPos = GridStyle.MainElementIconPos
      optionData.elementOffColor = elementOffColor
      optionData.isElement = true
      insertOptionData(optionData, v)
    end
  elseif self.bind.type == L_SortFilterConst.FilterType.QiBoSpecialType then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      if i ~= #allContentTpl then
        optionData.useSmall = true
      else
        optionData.useLarge = true
      end
      insertOptionData(optionData, v)
    end
  elseif self.bind.type == L_SortFilterConst.FilterType.BattleTag then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      optionData.useSmall = true
      insertOptionData(optionData, v)
      gridStyle = GridStyle.Small
    end
  elseif self.bind.type == L_SortFilterConst.FilterType.LockedStatus then
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      optionData.useLarge = true
      insertOptionData(optionData, v)
      gridStyle = GridStyle.Large
    end
  else
    for i, v in pairs(allContentTpl) do
      local optionData = buildOptionData(v)
      insertOptionData(optionData, v)
    end
  end
  refreshGridStyle(gridStyle)
  if self.bind.type == L_SortFilterConst.FilterType.QiBoSpecialType then
    self.bind.active_listGrid = false
    self.bind.active_listHor = true
    self.bind.list_optionHor:clear()
    self.bind.list_optionHor:insert_array(tmp)
  else
    self.bind.active_listGrid = true
    self.bind.active_listHor = false
    self.bind.list_option:clear()
    self.bind.list_option:insert_array(tmp)
  end
end

function this:setOptionListActive(selectList)
  local defaultList = self.bind.defaultList or {}
  self._selectValueList = selectList or defaultList
  for i, v in ipairs(self.modules.list_option) do
    local node, index = table.ipairsFind(self._selectValueList, function(value)
      return value == v.bind.id
    end)
    v:setActive(index ~= nil)
  end
  for i, v in ipairs(self.modules.list_optionHor) do
    local node, index = table.ipairsFind(self._selectValueList, function(value)
      return value == v.bind.id
    end)
    v:setActive(index ~= nil)
  end
  self:updateCurSelectNum()
end

function this:updateCurSelectNum()
  local count = #self._selectValueList
  if self.bind.selectLimit >= 1 then
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

function this:handleOptionClick(self, bind)
  local optionIsOn = bind.go_active
  local limitReached = #self._selectValueList >= self.bind.selectLimit
  if limitReached and self.bind.selectLimit > 1 and not optionIsOn then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_filter_select_num_limit"))
    return
  end
  if optionIsOn then
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

return this
