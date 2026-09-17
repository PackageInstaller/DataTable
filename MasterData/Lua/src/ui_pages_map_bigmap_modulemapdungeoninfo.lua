local this = class("moduleMapDungeonInfo", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.weekDay = {
    [1] = "ui_period_05",
    [2] = "ui_period_06",
    [3] = "ui_period_07",
    [4] = "ui_period_08",
    [5] = "ui_period_09",
    [6] = "ui_period_10",
    [7] = "ui_period_11"
  }
end

function this.bind()
  return {
    iconBgPath = "",
    icon = "",
    name = "",
    desc = "",
    txt_trace = "",
    show_desc = true,
    mapAreaName = "",
    cost = "",
    rewardGroupList = {
      moduleName = "pages/map/bigMap/cellRewardGroupInfo"
    },
    up = true,
    upTxt = "",
    staminaIcon = ""
  }
end

function this.methods()
  return {
    onClick_trace = function(self)
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
  local staminaData = L_ItemTplManager:getCurrencyItem(L_Const.currencyType.stamina)
  self.bind.staminaIcon = staminaData.icon
  L_MapStore:listenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState, self)
end

function this:close()
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState)
end

function this:initModule(node)
  self.node = node
  self.bind.icon = node.iconPath
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  if node.type == L_MapConst.mapSievingType.dynamicDungeon then
    self.bind.iconBgPath = node.iconBg or "UI/Atlas/MapNode/tex_icon_mapnode_suyahua.png"
  elseif node.type == L_MapConst.mapSievingType.dungeon then
    self.bind.iconBgPath = node.iconBg or "UI/Atlas/MapNode/tex_icon_mapnode_fuben.png"
  end
  self.bind.desc = node.desc
  self.bind.name = node.name
  local sceneTpl = _worldCityTpl:getTplById(node.sceneId)
  self.bind.mapAreaName = node.mapAreaName
  if self.bind.show_desc then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_desc)
  end
  local parentSize = self.bindComponents.rect_bg.sizeDelta.y
  local upSize = self.bindComponents.rect_insideDesc.sizeDelta.y
  self.bindComponents.rect_rewardWindow.sizeDelta = C_Vector2(501, parentSize - upSize - 250)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_rewardWindow)
  if not table.isEmpty(node.rewardShow) then
    local tmp = {}
    self.bind.up = false
    for i, v in pairs(node.rewardShow) do
      local rewardInfo = L_MapManager:filterMarkRewardParse(v[1], v[2])
      self.bind.cost = tostring(rewardInfo.cost)
      if not table.isEmpty(rewardInfo.upDuration) then
        self.bind.up = true
        local up_string = ""
        for i = #rewardInfo.upDuration, 1, -1 do
          up_string = string.format(L_WordsTpl:getValue("ui_period_12"), L_WordsTpl:getValue(self.weekDay[rewardInfo.upDuration[i]]), up_string)
        end
        up_string = L_WordsTpl:getValue("ui_moduleMapDungeonInfo_01", {
          [0] = up_string
        })
        self.bind.upTxt = up_string
      end
      table.insert(tmp, {
        desc = rewardInfo.name,
        reward = rewardInfo.rewardDisplay
      })
    end
    self.bind.rewardGroupList:clear()
    self.bind.rewardGroupList:insert_array(tmp)
  else
    self.bind.rewardGroupList:clear()
  end
  self:refreshButtonState()
end

function this:refreshButtonState()
  if self.node.type == L_MapConst.mapSievingType.dynamicDungeon then
    self:judgeCurNodeTraced()
  elseif self.node.type == L_MapConst.mapSievingType.dungeon then
    if self.node.isUnLock == true then
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapDungeonInfo_02")
    else
      self:judgeCurNodeTraced()
    end
  end
end

function this:judgeCurNodeTraced()
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
