local this = class("moduleMapBossInfo", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    iconBgPath = "",
    icon = "",
    go_icon = true,
    go_down = true,
    name = "",
    desc = "",
    txt_trace = "",
    show_desc = true,
    mapAreaName = "",
    cost = "",
    rewardGroupList = {
      moduleName = "pages/map/bigMap/cellRewardGroupInfo"
    },
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

local _worldFilterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()

function this:initModule(node)
  local filterMarkId = 9701
  self.node = node
  if not AzurWorld.MapMgr:IsUnLockBossNodeByID(node.id) then
    local tpl = _worldFilterMarkTpl:getTplById(filterMarkId)
    node.name = _worldFilterMarkTpl:getName(tpl)
    node.desc = _worldFilterMarkTpl:getDes(tpl)
    node.iconPath = nil
    node.rewardShow = _worldFilterMarkTpl:getRewardShow(tpl)
    self.bind.go_down = false
  else
    self.bind.go_down = true
  end
  self.bind.go_icon = node.iconPath ~= nil and node.iconPath ~= ""
  self.bind.icon = node.iconPath
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  self.bind.iconBgPath = node.iconBg or "UI/Atlas/MapNode/tex_icon_mapnode_boss_sj.png"
  self.bind.desc = node.desc
  self.bind.name = node.name
  local sceneTpl = _worldCityTpl:getTplById(node.sceneId)
  local mapCurLv = L_WorldMapLvStore:getNowLevel(node.sceneId)
  local shouldUseCurrentMap = AzurWorld.ScanMgr:OnCheckScanBoss(node.param)
  if shouldUseCurrentMap then
    local lv = L_WorldMapLvStore:getLastLevel()
    if lv == nil then
      L_WorldMapLvStore:setLastLevel(mapCurLv)
    else
      mapCurLv = lv
    end
  else
    L_WorldMapLvStore:setLastLevel(mapCurLv)
  end
  self.bind.mapAreaName = node.mapAreaName
  if self.bind.show_desc then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_desc)
  end
  local parentSize = self.bindComponents.rect_bg.sizeDelta.y
  local upSize = self.bindComponents.rect_insideDesc.sizeDelta.y
  self.bindComponents.rect_rewardWindow.sizeDelta = C_Vector2(501, parentSize - upSize - 255)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_rewardWindow)
  if not table.isEmpty(node.rewardShow) then
    local tmp = {}
    for i, v in pairs(node.rewardShow) do
      if self.node.type == L_MapConst.mapSievingType.boss then
        if mapCurLv == i + 1 then
          local rewardInfo = L_MapManager:filterMarkRewardParse(1, v[1])
          self.bind.cost = tostring(rewardInfo.cost)
          table.insert(tmp, {
            desc = rewardInfo.name,
            reward = rewardInfo.rewardDisplay,
            clientSortRwdList = rewardInfo.rewardDisplay
          })
        end
      else
        local rewardInfo = L_MapManager:filterMarkRewardParse(1, v[1])
        self.bind.cost = tostring(rewardInfo.cost)
        table.insert(tmp, {
          desc = rewardInfo.name,
          reward = rewardInfo.rewardDisplay,
          clientSortRwdList = rewardInfo.rewardDisplay
        })
      end
    end
    self.bind.rewardGroupList:clear()
    self.bind.rewardGroupList:insert_array(tmp)
  else
    self.bind.rewardGroupList:clear()
  end
  self:refreshButtonState()
end

function this:refreshButtonState()
  if self.node.type == L_MapConst.mapSievingType.dungeonBoss then
    if self.node.isUnLock == true then
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapDungeonInfo_02")
    else
      self:judgeCurNodeTraced()
    end
    return
  end
  self:judgeCurNodeTraced()
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
