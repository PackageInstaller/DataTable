local this = class("modulePetCatalogMap", G_UIModuleBase)
local _areaTpl = L_GameTpl:getAreaTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _petTpl = L_GameTpl:getPetTpl()

local function hasNodeList(list)
  if list == nil then
    return false
  end
  if type(list) == "userdata" and list.Count ~= nil then
    return list.Count > 0
  end
  return not table.isEmpty(list)
end

local function hasHabitatNodes(sceneId, petId, isNight)
  return hasNodeList(C_MapManager:getCurKiBoHabitatNode(sceneId, petId, isNight))
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.curSelectAreaIdx = 1
  self.isNight = false
end

function this.bind()
  return {
    moduleMap = {
      moduleName = "pages/map/petCatalogMap/modulePetCatalogMap"
    },
    nightSelActive = false,
    morningSelActive = true,
    bgBtnActive = false,
    dropTxt = "",
    listOptions = {
      moduleName = "pages/petCatalogue/cellPetMapItem"
    },
    toggleDrop = false,
    dropNightActive = true,
    dropDayActive = true,
    curOptionIconActive = false,
    txtLock = L_Lang:get(L_WordsTpl:getValue("notice_habitat_02")),
    lockActive = false,
    dropDownActive = false,
    txtTrack = "",
    TrackBtnActive = true,
    go_black1 = false,
    go_black2 = false
  }
end

function this.methods()
  return {
    onClickNight = function(self)
      self.bindComponents.animationPlayMapChange:SetMapChangeAnimationToEnd()
      self.parent:setBlur(false)
      self.bind.nightSelActive = true
      self.bind.morningSelActive = false
      self.isNight = true
      self:showPet(self._petId)
      self.bindComponents.animationPlayMapChange:DelayPlayMapChangeAnimation(100)
    end,
    onClickMorning = function(self)
      self.bindComponents.animationPlayMapChange:SetMapChangeAnimationToEnd()
      self.parent:setBlur(false)
      self.bind.nightSelActive = false
      self.bind.morningSelActive = true
      self.isNight = false
      self:showPet(self._petId)
      self.bindComponents.animationPlayMapChange:DelayPlayMapChangeAnimation(100)
    end,
    onClickDropDown = function(self)
      if not self.isDropping then
        self.bind.toggleDrop = true
        self.bind.bgBtnActive = true
        self.bind.dropNightActive = false
        self.bind.dropDayActive = false
        self.bind.dropDownActive = true
        Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.layoutChild)
        Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.layout)
        self.isDropping = true
      else
        self.bind.toggleDrop = false
        self.bind.bgBtnActive = false
        self.bind.dropNightActive = true
        self.bind.dropDayActive = true
        self.bind.dropDownActive = false
        self.isDropping = false
      end
    end,
    onClickBg = function(self)
      self.bind.toggleDrop = false
      self.bind.bgBtnActive = false
      self.bind.dropNightActive = true
      self.bind.dropDayActive = true
      self.bind.dropDownActive = false
      self.isDropping = false
    end,
    onClickTrack = function(self)
      self:onTackKibo()
    end
  }
end

function this:hideMapChangeVx()
  self.bind.go_black1 = false
  self.bind.go_black2 = false
end

function this:close(options)
  if self._blurDelayTimer then
    Timer.remove(self._blurDelayTimer)
    self._blurDelayTimer = nil
  end
  this.super.close(self, options)
end

function this:showPet(petId)
  self._petId = petId
  for i = 1, #self.mapList do
    local has = hasHabitatNodes(self.mapList[i].sceneId, petId, self.isNight)
    self.mapList[i].iconActive = has
    self.mapList[i].goSelect = i == self.curSelectAreaIdx
  end
  self.modules.moduleMap:setPetConfigId(petId, self.isNight)
  self.bind.listOptions:freshAll(self.mapList)
  self.bind.lockActive = not self.mapList[self.curSelectAreaIdx].iconActive
  self.bind.TrackBtnActive = self.mapList[self.curSelectAreaIdx].iconActive
  local needBlur = not self.mapList[self.curSelectAreaIdx].iconActive
  if self._blurDelayTimer then
    Timer.remove(self._blurDelayTimer)
    self._blurDelayTimer = nil
  end
  if needBlur then
    local curIdx = self.curSelectAreaIdx
    self._blurDelayTimer = Timer.once(0.6, function()
      self._blurDelayTimer = nil
      if self.curSelectAreaIdx == curIdx and self.mapList[curIdx] and not self.mapList[curIdx].iconActive then
        self.parent:setBlur(true)
      end
    end)
  else
    self.parent:setBlur(false)
  end
  self:refreshIcon()
  self:refreshTrackTxt(_petTpl:getName(_petTpl:getTplById(petId)))
end

function this:isJumpAction()
  self.isJumpGoto = true
end

function this:setArea(areaId, noVX)
  local name
  local curSenceTime = C_GameTime:GetSceneTimeOfDay()
  self.isNight = not (600 < curSenceTime) or not (curSenceTime < 1800)
  self.bind.nightSelActive = self.isNight
  self.bind.morningSelActive = not self.isNight
  if not self.availableMap[areaId] then
    self.modules.moduleMap:setAreaId(100000)
    name = L_Lang:get(_worldAreaTpl:getName(_worldAreaTpl:getTplById(100000)))
  else
    self.modules.moduleMap:setAreaId(areaId)
    name = L_Lang:get(_worldAreaTpl:getName(_worldAreaTpl:getTplById(areaId)))
  end
  for i, info in pairs(self.mapList) do
    if info.areaId == areaId then
      self.curSelectAreaIdx = i
      break
    end
  end
  self.bind.dropTxt = tostring(name)
  self.bindComponents.animationPlayMapChange:SetMapChangeAnimationToEnd()
  self.isJumpGoto = false
  if self._petId then
    self:showPet(self._petId)
  end
  if not self.isJumpGoto and not noVX then
    self.parent:setBlur(false)
    self.bindComponents.animationPlayMapChange:DelayPlayMapChangeAnimation(100)
  end
end

function this:initMap()
  self.availableMap = {}
  self.mapList = {}
  for areaId, areaData in pairs(_areaTpl.data) do
    if areaData.isShowName then
      self.availableMap[areaData.worldAreaId] = true
      local isLock
      local conds = areaData.unlockCondition
      if conds then
        local complete = L_ConditionManager:isComplete(areaData.unlockCondition)
        isLock = not complete
      else
        isLock = false
      end
      table.insert(self.mapList, {
        idx = areaData.sortID,
        areaId = areaData.worldAreaId,
        sceneId = areaData.sceneId,
        name = L_Lang:get(areaData.areaName),
        isLock = isLock,
        goIcon = false,
        onClickCb = function(cell)
          self:onClickItem(cell)
        end
      })
    end
  end
  self.curSelectAreaIdx = 1
  table.sort(self.mapList, function(a, b)
    if a.idx == b.idx then
      return a.areaId < b.areaId
    end
    return a.idx < b.idx
  end)
  for i = 1, #self.mapList do
    self.mapList[i].realIdx = i
    self.mapList[i].goSelect = i == self.curSelectAreaIdx
  end
  self.mapList[#self.mapList].goLine = false
  self.bind.listOptions:clear()
  self.bind.listOptions:insert_array(self.mapList)
  self.bind.dropTxt = L_Lang:get(self.mapList[self.curSelectAreaIdx].name)
end

function this:onClickItem(cell)
  self:hideDropList()
  self.bind.toggleDrop = false
  local oldCell = self.bind.listOptions:getItemCls(self.curSelectAreaIdx)
  local newCell = self.bind.listOptions:getItemCls(cell.bind.realIdx)
  if oldCell then
    oldCell.bind.goSelect = false
  end
  if newCell then
    newCell.bind.goSelect = true
  end
  self.curSelectAreaIdx = cell.bind.realIdx
  self.bind.dropTxt = self.mapList[self.curSelectAreaIdx].name
  self:setArea(cell.bind.areaId)
  self.bind.curOptionIconActive = self.mapList[self.curSelectAreaIdx].iconActive
  self.bind.dropNightActive = true
  self.bind.dropDayActive = true
end

function this:hideDropList()
  self.bind.toggleDrop = false
  self.bind.bgBtnActive = false
  self.bind.dropNightActive = true
  self.bind.dropDayActive = true
  self.bind.dropDownActive = false
  self.isDropping = false
end

function this:onTackKibo()
  C_MapManager:trackBoki(self._petId)
end

function this:refreshIcon()
  self.bind.curOptionIconActive = self.mapList[self.curSelectAreaIdx].iconActive
end

function this:refreshTrackTxt(txt)
  self.bind.txtTrack = txt
end

return this
