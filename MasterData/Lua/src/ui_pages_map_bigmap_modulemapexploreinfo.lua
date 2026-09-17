local this = class("moduleMapExploreInfo", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    icon = "",
    iconBg = "",
    name = "",
    mapAreaName = "",
    desc = "",
    show_desc = true,
    show_trace = false,
    show_teleport = false,
    txt_trace = ""
  }
end

function this.methods()
  return {
    onClick_trace = function(self, value)
      local curTracedNode = L_MapStore:getCurExploreNodeTargetTracing()
      if table.isEmpty(curTracedNode) then
        self.parent:excuteNodeFunction()
      elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
        L_MapStore:disposeExploreNodeTarget()
        self.parent:activeDetailPanel(false)
      else
        self.parent:excuteNodeFunction()
      end
    end,
    onClick_teleport = function(self)
      self.parent:excuteNodeFunction()
    end
  }
end

function this:open()
  L_MapStore:listenCallFunc(L_MapStore.event.refreshExploreNodeTrace, self.refreshButtonState, self)
end

function this:close()
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshExploreNodeTrace, self.refreshButtonState)
end

function this:initModule(node)
  self.bindComponents.iconBg.enabled = false
  self.node = node
  self.bind.icon = node.iconPath
  if node.iconBg and node.iconBg ~= "" then
    self.bind.iconBg = node.iconBg
    self.bindComponents.iconBg.enabled = true
  end
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  self.bind.desc = node.desc
  self.bind.name = node.name
  if self.bind.show_desc == true then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_desc)
  end
  local sceneTpl = _worldCityTpl:getTplById(node.sceneId)
  self.bind.mapAreaName = node.mapAreaName
  self.bind.show_trace = node.type ~= L_MapConst.mapSievingType.transfer and node.type ~= L_MapConst.mapSievingType.dungeon
  self.bind.show_teleport = node.type == L_MapConst.mapSievingType.transfer or node.type == L_MapConst.mapSievingType.dungeon
  local canTelePort = L_MapManager:getCanTelePortNodeEnum()
  if canTelePort[node.type] == 1 then
    self.bind.show_teleport = node.isUnLock == true and true or false
    self.bind.show_trace = node.isUnLock ~= true and true or false
  end
  self:refreshButtonState()
end

function this:refreshButtonState()
  if self.bind.show_trace == true then
    local curTracedNode = L_MapStore:getCurExploreNodeTargetTracing()
    if table.isEmpty(curTracedNode) then
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
    elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_05")
    else
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
    end
  end
end

return this
