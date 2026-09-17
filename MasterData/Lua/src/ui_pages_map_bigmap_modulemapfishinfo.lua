local this = class("moduleMapFishInfo", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    name = "",
    desc = "",
    txt_trace = "",
    remainNum = "",
    show_desc = true,
    rewardList = L_Const.ModuleInfo.CellIconBag
  }
end

function this.methods()
  return {
    onClick_trace = function(self, value)
      local curTracedNode = L_MapStore:getCurNodeTargetTracing()
      if table.isEmpty(curTracedNode) then
        self.parent:excuteNodeFunction()
      elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
        L_MapStore:disposeNodeTarget()
      else
        self.parent:excuteNodeFunction()
      end
    end
  }
end

function this:open()
  L_MapStore:listenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState, self)
end

function this:close()
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState)
end

function this:initModule(node)
  self.node = node
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  self.bind.desc = node.desc
  self.bind.name = node.name
  if self.bind.show_desc then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_desc)
  end
  local parentSize = self.bindComponents.rect_bg.rect.size.y
  local upSize = self.bindComponents.rect_insideDesc.rect.size.y
  self.bindComponents.rect_rewardWindow.sizeDelta = C_Vector2(501, parentSize - upSize - 260)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_rewardWindow)
  if node.rewardShow ~= nil and node.rewardShow.Count > 0 then
    local tmp = {}
    for i, v in pairs(node.rewardShow) do
      local list = L_MapManager:filterMarkRewardParse(2, v[1])
      local fishPondId = v[1]
      self.bind.remainNum = tostring(L_FishingManager:getFishPointFishCountSum(fishPondId))
      for i = 1, #list do
        local isLock = table.isEmpty(L_FishingStore:getFishHandbook(list[i].id))
        local cell = {
          itemType = list[i].type,
          itemId = list[i].id,
          itemNumTxt = list[i].name
        }
        if isLock then
          cell.itemNumTxt = "???"
          cell.customIcon = "UI/Atlas/FishingNew/tex_fishing_icon_fish.png"
          cell.noTip = true
        end
        table.insert(tmp, cell)
      end
    end
    self.bind.rewardList:clear()
    self.bind.rewardList:insert_array(tmp)
    self:refreshButtonState()
  end
end

function this:refreshButtonState()
  local curTracedNode = L_MapStore:getCurNodeTargetTracing()
  if table.isEmpty(curTracedNode) then
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
  elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_05")
  else
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
  end
end

return this
