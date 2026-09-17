local this = class("moduleEntrustAreaList", G_UIModuleBase)
local _dungeonEntrustAreaTpl = L_GameTpl:getDungeonEntrustAreaTpl()

function this.bind()
  return {
    table_EntrustAreaList = {
      moduleName = "pages/entrustTask/cellEntrustAreaList"
    },
    active_list = false,
    txt_now = ""
  }
end

function this:methods()
  return {
    onBtnClick = function(self)
      if self.bind.active_list == true then
        self.bind.active_list = false
      else
        self.bind.active_list = true
      end
    end
  }
end

function this:initData()
  self.data = {
    areaList = {},
    curAreaId = -1
  }
end

function this:setPage(page)
  self.modulePage = page
  self:initAreaList()
  self.areaId = self:mapAreaConfig()
  self:onCellBtnClick(self.areaId)
end

function this:open(options)
  if options then
    self.data = {
      curAreaId = options.curAreaId
    }
    self.modulePage = options.page
  end
end

function this:initAreaList()
  local areaInfo = {}
  table.insert(areaInfo, {
    name = L_WordsTpl:getValue("residual_code_moduleentrustarealist_01"),
    areaTplId = 0,
    onClickHandle = function(areaTplId)
      self:onCellBtnClick(areaTplId)
    end
  })
  local data = _dungeonEntrustAreaTpl:getData()
  for k, v in pairs(data) do
    local barName = _dungeonEntrustAreaTpl:getName(v)
    barName = barName or L_WordsTpl:getValue("residual_code_moduleentrustarealist_02")
    table.insert(areaInfo, {
      name = barName,
      areaTplId = v.id,
      onClickHandle = function(id)
        self:onCellBtnClick(id)
      end
    })
  end
  self.bind.table_EntrustAreaList:clear()
  self.bind.table_EntrustAreaList:insert_array(areaInfo)
end

function this:onCellBtnClick(id)
  if self.modulePage then
    self.modulePage:refreshShow(id)
  end
  if id == 0 then
    self.bind.txt_now = L_WordsTpl:getValue("residual_code_moduleentrustarealist_01")
  else
    self.bind.txt_now = _dungeonEntrustAreaTpl:getName(_dungeonEntrustAreaTpl:getTplById(id))
  end
  self:refreshAreaList(id)
  self.bind.active_list = false
end

function this:refreshAreaList(id)
  for i = 1, #self.bind.table_EntrustAreaList do
    local cell = self.bind.table_EntrustAreaList:getItemCls(i)
    cell:refreshSelection(id)
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
