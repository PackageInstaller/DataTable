local this = class("moduleSituationEdit_hero", require("ui.pages.situation.group.moduleSituationEditBase"))
local _situationTabTpl = L_GameTpl:getSituationTabTpl()

function this.bind()
  return {
    active_blur = true,
    activeHeroList = nil,
    heroList = {
      moduleName = "pages/situation/cell/cellSituationHeroItem"
    },
    dragHandler = {
      moduleName = "pages/situation/module/moduleSituationDragHandler"
    },
    activeDragHandler = nil,
    actionPanel = {
      moduleName = "pages/situation/module/moduleSituationActionPanel"
    },
    panelBg = false,
    txt_curNum = "",
    txt_maxNum = "",
    menuTabList = {
      moduleName = "pages/photo/modulePhotoMenuTabList"
    },
    active_tabList = false,
    active_closeBtn = true,
    active_openBtn = false,
    instruection = false
  }
end

function this.methods()
  return {
    heroList = {
      onClick = function(self, id, callback)
        self:addHero(id)
        if self.curSelId == id then
          return
        end
        self.curSelId = id
        if callback then
          callback()
        end
      end,
      onClickRemove = function(self, id)
        self:removeHero(id)
        self:refreshShowNum()
        self.curSelId = -1
      end
    },
    onClickCloseList = function(self)
      self.bind.activeHeroList = false
      self.bind.active_blur = false
      self.parent.bind.editTabId = -1
    end,
    dragHandler = {
      onClickCancel = function(self)
        self:removeHero(self.selectHeroConfigId)
      end,
      onClickConfirm = function(self)
        self:deSelectHero()
      end,
      onRotChanged = function(self, startY, endY)
        self:onRotChanged(startY, endY)
      end,
      onPosChanged = function(self, startPos, endPos)
        self:onPosChanged(startPos, endPos)
      end
    }
  }
end

function this:open()
  self:initModule()
end

function this:initModule()
  self.curSelId = -1
  self:refreshShowNum()
  self:initHeroList()
  self.bind.active_blur = true
  self.bind.activeHeroList = true
  self.modules.actionPanel:init(L_Const.situationGroup.hero)
end

function this:show()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.refreshItemBtns, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.refreshItemBtns, self)
  self:initTab()
  self:deSelectHero()
  self:refreshItemBtns()
end

function this:hide()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.refreshItemBtns, self)
  self:deSelectHero()
  self:refreshItemBtns()
end

function this:refresh()
end

function this:initHeroList()
  local all = L_HeroStore:getAllHero()
  self.allHero = {}
  for i, v in pairs(all) do
    local hero_id = L_HeroStore:getHeroGuid(v)
    if hero_id ~= L_HeroStore:getDefaultHeroGuid() then
      local data = {
        itemType = L_Const.resType.hero,
        itemId = L_HeroStore:getHeroConfigId(v),
        guid = hero_id
      }
      table.insert(self.allHero, data)
    end
  end
  table.sort(self.allHero, function(x, y)
    local a = x.guid
    local b = y.guid
    local configA = L_ItemTplManager:getHeroItem(x.itemId)
    local configB = L_ItemTplManager:getHeroItem(y.itemId)
    local priorityOrder = {
      function()
        return configA.quality, configB.quality
      end,
      function()
        return x.itemId, y.itemId
      end
    }
    for _, getPriorityValue in ipairs(priorityOrder) do
      local valueA, valueB = getPriorityValue()
      if valueA ~= valueB then
        return valueB < valueA
      end
    end
    return a < b
  end)
  local list = {}
  for _, v in pairs(self.allHero) do
    table.insert(list, {
      id = v.itemId,
      iconData = {
        itemType = L_Const.resType.hero,
        itemId = v.itemId,
        guid = v.guid,
        die = false,
        activeHead = false,
        ignorePet = true
      }
    })
  end
  self.bind.heroList:clear()
  self.bind.heroList:insert_array(list)
end

function this:addHero(id)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(0, id)
  local data = {
    heroConfigId = id,
    clothingId = clothingId,
    pos = L_SituationManager:getLookPos(),
    rot = L_Vector3.new(0, 0, 0),
    actionId = L_Const.photoParam.idle,
    actionTime = 0,
    faceId = L_Const.photoParam.defaultFace
  }
  L_SituationManager:addCreateHeroCommand(data)
  self:refreshShowNum()
  self:refreshItemBtns()
end

function this:removeHero(id)
  if id == nil then
    return
  end
  local data = {heroConfigId = id}
  L_SituationManager:addRemoveHeroCommand(data)
  self:refreshItemBtns()
  if self.curSelectHeroContainer and self.curSelectHeroContainer.data.heroConfigId == id then
    self:deSelectHero()
  end
end

function this:initTab()
  self.currentActionTabId = L_Const.photoTabType.ACTION
  local tabList = {
    L_Const.photoTabType.ACTION,
    L_Const.photoTabType.FACE
  }
  self.modules.menuTabList:setData(tabList, handler(self, self.onSelectActionTabId), self.currentActionTabId)
  self:refreshSituationAction(self.currentActionTabId)
  self.modules.menuTabList:setSelectTabId(self.currentActionTabId)
end

function this:onSelectActionTabId(tabId)
  if self.currentActionTabId == tabId then
    return
  end
  self.currentActionTabId = tabId
  self:refreshSituationAction(tabId)
end

function this:refreshSituationAction(tabId)
  self.modules.actionPanel:refreshActionList(tabId)
end

function this:refreshShowNum()
  self.bind.txt_curNum = string.format("%d", L_SituationManager:getCount(L_Const.situationGroup.hero))
  local tpl_situationTab = _situationTabTpl:getTplById(L_Const.situationGroup.hero)
  self.bind.txt_maxNum = string.format("/%d", _situationTabTpl:getNumber(tpl_situationTab))
end

function this:refreshItemBtns()
  for _, v in pairs(self.modules.heroList) do
    v:refreshBtns()
  end
  if self.selectHeroConfigId then
    local has = L_SituationManager:hasHero(self.selectHeroConfigId)
    if not has then
      self:deSelectHero()
    end
  end
  self:refreshShowNum()
end

function this:selectHero(heroContainer)
  if heroContainer == self.curSelectHeroContainer then
    return
  end
  self:deSelectHero()
  self.curSelectHeroContainer = heroContainer
  self.selectHeroConfigId = heroContainer.data.heroConfigId
  self.bind.activeDragHandler = true
  self.modules.dragHandler:show()
  self.modules.dragHandler:bindObj(self.curSelectHeroContainer.heroObj)
  self.modules.dragHandler.bind.activeCancel = not L_GameUtil.isDefaultHero(heroContainer.data.heroConfigId)
  self.modules.actionPanel:bindContainer(heroContainer)
  self.bind.panelBg = true
  for _, v in pairs(self.modules.heroList) do
    local cell = v
    cell:refreshSelectRoot(self.selectHeroConfigId)
  end
  self.bind.active_tabList = true
end

function this:deSelectHero()
  self.selectHeroConfigId = nil
  self.curSelectHeroContainer = nil
  self.bind.activeDragHandler = false
  self.modules.dragHandler:bindObj(nil)
  self.modules.actionPanel:bindContainer(nil)
  self.bind.panelBg = false
  for _, v in pairs(self.modules.heroList) do
    local cell = v
    cell:refreshSelectRoot(nil)
  end
  self.bind.active_tabList = false
  self.curSelId = -1
end

function this:onPosChanged(startPos, endPos)
  local param = {
    heroConfigId = self.curSelectHeroContainer.data.heroConfigId,
    startPos = startPos,
    endPos = endPos
  }
  L_SituationManager:addMoveHeroCommand(param)
end

function this:onRotChanged(startY, endY)
  local param = {
    heroConfigId = self.curSelectHeroContainer.data.heroConfigId,
    startRotate = L_Vector3.new(0, startY, 0),
    endRotate = L_Vector3.new(0, endY, 0)
  }
  L_SituationManager:addRotateHeroCommand(param)
end

function this:update()
end

function this:close()
end

return this
