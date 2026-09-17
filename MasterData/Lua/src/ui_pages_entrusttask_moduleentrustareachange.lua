local this = class("moduleEntrustAreaChange", G_UIModuleBase)
local _dungeonEntrustAreaTpl = L_GameTpl:getDungeonEntrustAreaTpl()

function this.bind()
  return {txt_now = ""}
end

function this:methods()
  return {
    onLeftClick = function(self)
      if not self.areaData or #self.areaData == 0 then
        return
      end
      self.currentIndex = self.currentIndex - 1
      if self.currentIndex < 1 then
        self.currentIndex = #self.areaData
      end
      local currentAreaInfo = self.areaData[self.currentIndex]
      if currentAreaInfo then
        self:onCellBtnClick(currentAreaInfo.areaTplId)
      end
    end,
    onRightClick = function(self)
      if not self.areaData or #self.areaData == 0 then
        return
      end
      self.currentIndex = self.currentIndex + 1
      if self.currentIndex > #self.areaData then
        self.currentIndex = 1
      end
      local currentAreaInfo = self.areaData[self.currentIndex]
      if currentAreaInfo then
        self:onCellBtnClick(currentAreaInfo.areaTplId)
      end
    end
  }
end

function this:initData()
  self.areaData = {}
  self.currentIndex = 1
end

function this:setPage(page)
  self.modulePage = page
  self:initAreaList()
  self.currentIndex = 1
  local currentAreaInfo = self.areaData[self.currentIndex]
  if currentAreaInfo then
    self:onCellBtnClick(currentAreaInfo.areaTplId)
  end
end

function this:open(options)
  if options then
    self.modulePage = options.page
  end
end

function this:initAreaList()
  self.areaData = {}
  table.insert(self.areaData, {
    name = L_WordsTpl:getValue("common_all"),
    areaTplId = 0
  })
  local tempAreaList = {}
  local data = _dungeonEntrustAreaTpl:getData()
  for _, areaConfig in pairs(data) do
    if self:checkShow(areaConfig) then
      local areas = _dungeonEntrustAreaTpl:getAreaScope(areaConfig)
      local id = _dungeonEntrustAreaTpl:getId(areaConfig)
      if self.modulePage:checkHaveData(id) then
        table.insert(tempAreaList, areaConfig)
      end
    end
  end
  table.sort(tempAreaList, function(a, b)
    return a.id < b.id
  end)
  for _, areaConfig in ipairs(tempAreaList) do
    local barName = _dungeonEntrustAreaTpl:getName(areaConfig) or L_WordsTpl:getValue("residual_code_moduleentrustareachange_01")
    table.insert(self.areaData, {
      name = barName,
      areaTplId = areaConfig.id
    })
  end
end

function this:checkShow(areaConfig)
  if not areaConfig then
    return false
  end
  if areaConfig and areaConfig.id == 99 then
    return false
  end
  return true
end

function this:onCellBtnClick(id)
  if self.modulePage then
    self.modulePage:refreshShow(id)
  end
  if id == 0 then
    self.bind.txt_now = L_WordsTpl:getValue("residual_code_moduleentrustareachange_02")
  else
    self.bind.txt_now = _dungeonEntrustAreaTpl:getName(_dungeonEntrustAreaTpl:getTplById(id))
  end
end

function this:mapAreaConfig()
  local runtimeId = AzurWorld.areaManager:GetMapAreaId()
  if runtimeId == 100000 then
    return 1
  elseif runtimeId == 200000 then
    return 2
  else
    return 2
  end
end

return this
