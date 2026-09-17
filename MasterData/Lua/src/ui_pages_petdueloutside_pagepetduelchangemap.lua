local cls = class("pagePetDuelChangeMap", G_UIPageBase)
local _kiboDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _kiboDuelpvpTpl = L_GameTpl:getKiboDuelPvpTpl()

function cls.bind()
  return {
    txt_mapName = "",
    img_mapDetail = "",
    toggle_randomMap = false,
    leftMapGrid = {
      moduleName = "pages/petDuelOutside/cellPetDuelMap"
    },
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function cls.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        if self.callback then
          self.callback(self.selectId, self.mapId2dungeonId[self.selectId])
        end
        L_UI:close(self.pageName)
      end
    },
    onclick_selectMap = function(self)
      if self.callback then
        self.callback(self.selectId, self.mapId2dungeonId[self.selectId])
      end
      L_UI:close(self.pageName)
    end,
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function cls:preOpen(options)
  self.callback = options.callback
  self.close_callback = options.close_callback
  self.gameMode = options.gameMode
  self:initCommonTipModule()
  local data = _kiboDuelMapTpl:getData()
  local _data = {}
  self.mapId2dungeonId = {}
  local dungeonData = _dungeonTpl:getKiboArenaPvpDungeonData()
  for _, dungeon in pairs(dungeonData) do
    local pvpId = _dungeonTpl:getgameplayID(dungeon)
    local conf = _kiboDuelpvpTpl:getTplById(pvpId)
    if conf ~= nil then
      local mapId = _kiboDuelpvpTpl:getMap(conf)
      table.insert(_data, mapId)
      self.mapId2dungeonId[mapId] = dungeon.id
    end
  end
  self.mapId2dungeonId[0] = 0
  
  local function _callback(cell)
    self.selectId = cell.mapId
    self:refreshMapView(cell.mapId, cell.isRandom)
    for i = 1, #self.bind.leftMapGrid do
      self.bind.leftMapGrid:change(i, {
        selectMapId = cell.mapId
      })
    end
  end
  
  local maps = {}
  self.selectId = options.mapId
  self:refreshMapView(self.selectId, self.selectId == 0)
  table.insert(maps, {
    mapId = 0,
    isRandom = true,
    selectMapId = self.selectId,
    callback = _callback
  })
  for _, mapId in pairs(_data) do
    if data[mapId] ~= nil and data[mapId].mapMode == self.gameMode then
      table.insert(maps, {
        mapId = mapId,
        isRandom = false,
        selectMapId = self.selectId,
        callback = _callback
      })
    end
  end
  self.bind.leftMapGrid:clear()
  self.bind.leftMapGrid:insert_array(maps)
end

function cls:initCommonTipModule()
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    hideConfirm = false,
    hideCancel = false,
    txtTitle = L_WordsTpl:getValue("ui_kiboDuel_90")
  })
end

function cls:refreshMapView(mapId, isRandom)
  self.selectDungeonId = mapId == 0 and 0 or self.mapId2dungeonId[self.selectId]
  self.bind.toggle_randomMap = isRandom
  if not isRandom then
    local mapTpl = _kiboDuelMapTpl:getTplById(mapId)
    self.bind.txt_mapName = _kiboDuelMapTpl:getName(mapTpl)
    local mapTpl = _kiboDuelMapTpl:getTplById(mapId)
    local worldAreaId = _kiboDuelMapTpl:getWorldAreaId(mapTpl)
    if worldAreaId == nil then
      return
    end
    local areaTpl = _worldAreaTpl:getTplById(worldAreaId)
    if areaTpl == nil then
      return
    end
    self.bind.img_mapDetail = _worldAreaTpl:getAreaMap(areaTpl)
  end
end

function cls:close()
  if self.close_callback then
    self.close_callback()
  end
  cls.super.close(self)
end

return cls
