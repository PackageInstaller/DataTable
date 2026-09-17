local this = class("moduleMapKiboInfo", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _enemyPackTpl = L_GameTpl:getEnemyPackTpl()
local _dropTpl = L_GameTpl:getDropTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
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
    staminaIcon = ""
  }
end

function this.methods()
  return {
    onClick_trace = function(self)
      self:onClickTrace()
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
  local petCfg = _petTpl:getTplById(node.petId)
  if node.petId then
    self.bind.name = _petTpl:getName(petCfg)
    self.bind.desc = _petTpl:getDesc(petCfg)
  end
  local sceneTpl = _worldCityTpl:getTplById(node.sceneId)
  local mapCurLv = L_WorldMapLvStore:getNowLevel(node.sceneId)
  self.bind.mapAreaName = _worldCityTpl:getCity(sceneTpl)
  if self.bind.show_desc then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_desc)
  end
  local parentSize = self.bindComponents.rect_bg.rect.size.y
  local upSize = self.bindComponents.rect_insideDesc.rect.size.y
  self.bindComponents.rect_rewardWindow.sizeDelta = C_Vector2(501, parentSize - upSize - 255)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_rewardWindow)
  if node.enemyPackId then
    local tmp = {}
    local reward = {}
    local _drop = _enemyPackTpl:getDropId(_enemyPackTpl:getTplById(node.enemyPackId))
    for _, v in pairs(_drop) do
      local dropGroup = _dropTpl:getDropGroup(v)
      for _, v in pairs(dropGroup) do
        local itemId = _dropTpl:getItemId(v)
        local itemType = _dropTpl:getType(v)
        local rewardMinNum = _dropTpl:getMinValue(v)
        local rewardMaxNum = _dropTpl:getMaxValue(v)
        table.insert(tmp, {
          itemType,
          itemId,
          rewardMinNum,
          rewardMaxNum
        })
      end
    end
    table.insert(reward, {desc = "", reward = tmp})
    self.bind.rewardGroupList:clear()
    self.bind.rewardGroupList:insert_array(reward)
  end
  self:refreshButtonState()
  self:refreshKiboGroup(node.type)
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

function this:triggerTarck()
  print("triggerTarck")
  self.parent:excuteNodeFunction()
  self:refreshButtonState()
end

function this:onClickTrace()
  local curTracedNode = L_MapStore:getCurNodeTargetTracing()
  if table.isEmpty(curTracedNode) then
    self.parent:excuteNodeFunction()
    local node, mapAreaId = L_MapManager:getCurTrackKiboNode(self.node.petId)
    L_MapStore:setTrackKiboNode(node)
  elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
    L_MapStore:disposeNodeTarget()
  else
    self.parent:excuteNodeFunction()
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

function this:refreshKiboGroup(type)
  if type == L_MapConst.mapSievingType.kiboGroup then
    self.bindComponents.img_icon:SetNativeSize()
    self.bindComponents.rect_icon:SetScale(1, 1, 1)
    self.bindComponents.rect_icon.anchorMin = C_Vector2(0.5, 0.5)
    self.bindComponents.rect_icon.anchorMax = C_Vector2(0.5, 0.5)
    self.bindComponents.rect_icon.pivot = C_Vector2(0.5, 0.5)
    self.bindComponents.rect_icon.anchoredPosition = C_Vector2(0, 0)
  end
end

return this
