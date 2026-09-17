local this = class("modulePhotoGroup_hero", require("ui.pages.photo.group.modulePhotoGroup_base"))
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local putMax = L_GameClientTpl:getData("PHOTO_HERO_NUM", L_Const.GameTplType.int)

function this.bind()
  return {
    heroList = {
      moduleName = "pages/photo/cell/cellPhotoHeroItem"
    },
    txt_page = "",
    txt_count = "",
    isActive_pageBtn = false,
    isActive_next = true,
    isActive_back = true,
    isActive_drag = false
  }
end

function this.methods()
  return {
    onDrag_heroHandle = function(self, screenPos)
      self:onDragHeroHandle(screenPos)
    end,
    onStartDrag = function(self)
      self.isDragging = true
    end,
    onEndDrag = function(self)
      self.isDragging = false
    end,
    onClick_Put = function(self)
      self:onClickPut()
    end,
    onClick_Recycle = function(self)
      self:onClickRecycle()
    end,
    onClick_cancel = function(self)
      self:onClickCancel()
    end,
    onClick_Next = function(self)
    end,
    onClick_Back = function(self)
    end,
    onClick_takeOver = function(self)
      self:onClickTakeOver()
    end,
    heroList = {
      onClick = function(self, guid, callback)
        self:onSelectHero(guid)
        if self.curSelGuid == guid then
          return
        end
        self.curSelGuid = guid
        if callback then
          callback()
        end
      end,
      onClickRemove = function(self, id)
        self:removeHero(id)
      end
    },
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  self:create3DUINode()
  self.selectHeroGuid = 0
  self.heroPutInfo = {}
  self:initHeroData()
  self.curSelGuid = -1
  self.curPageIndex = 1
  L_PhotoManager.moduleGroupHero = self
end

function this:show()
  self:initHeroAllList()
  self.timer = Timer.repeated(0.015, self.update, self)
  self.timer:start()
  self:refreshHeroList()
  self._refreshHeroList = handler(self, self.refreshHeroList)
  L_PhotoManager:addListener(L_PhotoManager.event.photoSwitchHero, self._refreshHeroList)
end

function this:hide()
  self.timer:stop()
  Timer.remove(self.timer)
  self.uiNodeGo:SetActive(false)
  self:clearUnFinishOp()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoSwitchHero, self._refreshHeroList)
end

function this:refresh()
end

function this:close()
  if self.uiNodeGo ~= nil then
    C_GameObject.Destroy(self.uiNodeGo)
    self.uiNodeGo = nil
  end
  self:releaseAllHero()
  L_PhotoManager.moduleGroupHero = nil
end

function this:initHeroData()
  local all = L_HeroStore:getAllHero()
  self.allHero = {}
  self.heroPages = {}
  for i, v in pairs(all) do
    local hero_id = L_HeroStore:getHeroGuid(v)
    local data = {
      itemType = L_Const.resType.hero,
      itemId = L_HeroStore:getHeroConfigId(v),
      guid = hero_id
    }
    table.insert(self.allHero, data)
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
  self.minPage = 1
  self.maxPage = 1
  for i = 1, #self.allHero do
    local hero = self.allHero[i]
    local index = math.floor((i - 1) / 12) + 1
    if index > self.maxPage then
      self.maxPage = index
    end
    local list = self.heroPages[index]
    if list == nil then
      list = {}
      self.heroPages[index] = list
    end
    table.insert(list, hero)
  end
end

function this:initHeroList(index)
  self.bind.heroList:clear()
  local list = self.heroPages[index]
  local temp = {}
  for _, v in pairs(list) do
    table.insert(temp, {
      itemType = L_Const.resType.hero,
      itemId = v.itemId,
      guid = v.guid,
      die = false,
      activeHead = false,
      ignorePet = true
    })
  end
  self.bind.heroList:insert_array(temp)
end

function this:initHeroAllList()
  self.bind.heroList:clear()
  local list = self.allHero
  local temp = {}
  for _, v in pairs(self.allHero) do
    table.insert(temp, {
      id = v.itemId,
      guid = v.guid,
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
  self.bind.heroList:insert_array(temp)
end

function this:onSelectHero(guid)
  if C_PhotoPlayManager.isSwitching then
    L_FlyMsgManager:showNormalMsgByKey("notice_photo_waitforloading")
    return
  end
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    L_FlyMsgManager:showNormalMsgByKey("notice_photo_noputhero")
    return
  end
  if self.selectHeroGuid ~= 0 then
    L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_01")
    return
  end
  if self.heroPutInfo[guid] ~= nil then
    self:takeOver(guid)
    return
  end
  if self:getPutCount() >= putMax then
    L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_03")
    return
  end
  local mainControl = self:getMainControlEntity()
  if mainControl ~= nil and mainControl.entity ~= nil and guid == mainControl.entity.data.UUID then
    L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_02")
    return
  end
  self.heroPutInfo[guid] = {}
  self.selectHeroGuid = guid
  AzurWorld.photoMgr:CreateHero(guid, function(entity)
    self:onLoadHeroEntity(guid, entity)
  end)
  self:refreshHeroList()
end

function this:onLoadHeroEntity(guid, entity)
  if self.gameObject == nil and entity ~= nil then
    AzurWorld.photoMgr:ClearHero(entity)
    return
  end
  if entity == nil then
    self.selectHeroGuid = 0
    self.heroPutInfo[guid] = nil
    return
  end
  if not self.isShow then
    AzurWorld.photoMgr:RecycleHero(guid)
    return
  end
  local info = self.heroPutInfo[guid]
  info.entity = entity
  info.collider = entity.entity.model.gameObject:GetComponent(typeof(CS.UnityEngine.CapsuleCollider))
  self:refreshCurSelectHero(guid)
  self.canPut = self:checkCanPut(guid)
end

function this:refreshHeroList()
  for i, v in pairs(self.modules.heroList) do
    v:refreshBtns(false, false)
    local listGuid = v.bind.iconData.guid
    for guid, info in pairs(self.heroPutInfo) do
      if listGuid == guid then
        v:refreshBtns(true, false)
      end
    end
    if self:getMainControlEntity() ~= nil and listGuid == self:getMainControlEntity().entity.data.UUID then
      v:refreshBtns(true, true)
    end
  end
  local count = self:getPutCount()
  self.bind.txt_count = string.format("%s/%s", count, putMax)
end

function this:onDragHeroHandle(screenPos)
  if self.curSelectEntity == nil then
    return
  end
  if L_PhotoManager:HeroCaressBlock(self.curSelectEntity) then
    return
  end
  local isWater, hitWater = C_CameraManager.mainCamera:ScreenRaycastByLayers(C_Vector2(screenPos.x, screenPos.y), {"Water"}, 40, false)
  local success, hit = C_CameraManager.mainCamera:ScreenRaycastByLayers(C_Vector2(screenPos.x, screenPos.y), {"Default", "Terrain"}, 40, true)
  local info = self.heroPutInfo[self.selectHeroGuid]
  local setWater = isWater and info and info.collider
  if success and isWater then
    local height = info.collider.height * 0.7
    local sub = hit.point.y - hitWater.point.y
    if sub > -height then
      setWater = false
    end
  end
  if setWater then
    local height = info.collider.height * 0.7
    local isDownTerrain, hitTerrain = C_LuaUtility.RayCast(hitWater.point, C_Vector3.down, height, {"Terrain"}, true)
    if isDownTerrain then
      self.curSelectEntity.entity:SetPosition(hitTerrain.point + C_Vector3(0, 0.01, 0))
    else
      self.curSelectEntity.entity:SetPosition(hitWater.point + C_Vector3.down * height)
    end
    return
  end
  local mainPos = AzurWorld.playerMgr.myPlayerData.mainControlPosition
  local dir = hit.point - mainPos
  local distance = C_Vector3.Distance(mainPos, hit.point)
  local isAirWall, hitAirWall = C_LuaUtility.RayCast(mainPos, dir, distance, {"AirWall"}, true)
  success = success and not isAirWall
  if success then
    local pos = hit.point + C_Vector3(0, 0.01, 0)
    if hit.normal.y > 0.2 then
      self.curSelectEntity.entity:SetPosition(pos)
    end
  end
end

function this:onClickPut()
  if self.curSelectEntity == nil then
    return
  end
  if self.canPut then
    local info = self.heroPutInfo[self.selectHeroGuid]
    info.pos = L_Vector3.getRelativePos(self.curSelectEntity.transform:GetRawTransform())
    self:refreshCurSelectHero(nil)
  else
    L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_04")
  end
end

function this:onClickRecycle()
  if self.curSelectEntity == nil then
    return
  end
  if L_PhotoManager:HeroCaressBlock(self.curSelectEntity) then
    return
  end
  self.heroPutInfo[self.selectHeroGuid] = nil
  local machine = L_PhotoManager:getStateMachine(self.curSelectEntity.data.entityId)
  if machine then
    machine:reset()
  end
  AzurWorld.photoMgr:RecycleHero(self.selectHeroGuid)
  self:refreshCurSelectHero(nil)
  self:refreshHeroList()
end

function this:onClickCancel()
  if self.curSelectEntity == nil then
    return
  end
  if L_PhotoManager:HeroCaressBlock(self.curSelectEntity) then
    return
  end
  local info = self.heroPutInfo[self.selectHeroGuid]
  if info.pos == nil then
    self:onClickRecycle()
    return
  end
  self.curSelectEntity:SafeSetPosition(info.pos)
  self:refreshCurSelectHero(nil)
  self:refreshHeroList()
end

function this:onClickTakeOver()
  self:takeOver(self.selectHeroGuid)
end

function this:takeOver(guid)
  if self.heroPutInfo[guid] == nil then
    return
  end
  if self.heroPutInfo[guid].entity == nil then
    return
  end
  local canPut
  if guid == self.selectHeroGuid then
    canPut = self.canPut
  else
    canPut = self:checkCanPut(guid)
  end
  if not canPut then
    L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_04")
    return
  end
  local mainEntity = self:getMainControlEntity()
  self.heroPutInfo[mainEntity.entity.data.UUID] = {
    entity = mainEntity,
    pos = L_Vector3.getRelativePos(mainEntity.entity.transform:GetRawTransform()),
    collider = mainEntity.entity.transform.gameObject:GetComponent(typeof(CS.UnityEngine.CapsuleCollider))
  }
  local entity = self.heroPutInfo[guid].entity
  local eid = entity.entity.data.entityId
  AzurWorld.photoMgr:TakeOver(eid)
  L_PhotoManager:setMediatorTarget(entity)
  self.heroPutInfo[guid] = nil
  self:refreshCurSelectHero(nil)
  self:refreshHeroList()
end

function this:clearUnFinishOp()
  if self.curSelectEntity ~= nil then
    local info = self.heroPutInfo[self.selectHeroGuid]
    if info.pos == nil then
      AzurWorld.photoMgr:RecycleHero(self.selectHeroGuid)
      self.heroPutInfo[self.selectHeroGuid] = nil
    else
      self.curSelectEntity:SafeSetPosition(info.pos)
    end
  end
  local clear = {}
  for i, v in pairs(self.heroPutInfo) do
    if v.pos == nil then
      table.insert(clear, i)
    end
  end
  for _, v in pairs(clear) do
    self.heroPutInfo[v] = nil
  end
  self:refreshCurSelectHero(nil)
end

function this:checkCanPut(guid)
  if guid == nil or guid == 0 or self.heroPutInfo[guid] == nil or self.heroPutInfo[guid].entity == nil then
    return false
  end
  local entity = self.heroPutInfo[guid].entity
  local result = true
  result = result and (entity.characterMovement.isOnGround or entity.data.characterControlProperty:IsInWater())
  local info = self.heroPutInfo[guid]
  local capsule = info.collider
  local pos = L_Vector3.getRelativePos(entity.transform:GetRawTransform()) + L_Vector3.new(0, capsule.height / 2, 0)
  local hits = C_Physics.OverlapBox(pos, C_Vector3(capsule.radius, capsule.height, capsule.radius))
  for i = 0, hits.Length - 1 do
    local collider = hits[i]
    if not result then
      break
    end
    if collider.gameObject.layer == 7 and collider.gameObject ~= entity.transform.gameObject then
      result = false
    end
    if collider.gameObject.layer == 10 then
      result = false
    end
  end
  if result then
    self.posImg.color = C_Color.green
  else
    self.posImg.color = C_Color.red
  end
  return result
end

function this:releaseAllHero()
  AzurWorld.photoMgr:ClearAllHero()
  self.heroPutInfo = {}
end

function this:refreshCurSelectHero(guid)
  L_PhotoManager.selectEntityGuid = guid
  if guid == nil then
    self.selectHeroGuid = 0
    self.curSelectEntity = nil
    self.uiNodeGo:SetActive(false)
    self.bind.isActive_drag = false
    return
  end
  self.selectHeroGuid = guid
  self.bind.isActive_drag = true
  local info = self.heroPutInfo[self.selectHeroGuid]
  if info == nil then
    self.curSelectEntity = nil
    return
  end
  self.curSelectEntity = info.entity
  if info.pos ~= nil then
    info.pos = L_Vector3.getRelativePos(self.curSelectEntity.transform:GetRawTransform())
  end
  self:syncDragBtnPos()
  self:syncPosImg()
end

function this:syncDragBtnPos()
  if self.curSelectEntity == nil then
    return
  end
  local worldPos = self.curSelectEntity.transform.worldPosition
  local screenPos, v2
  if not self.isDragging then
    screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(worldPos)
    v2 = C_Vector2(screenPos.x, screenPos.y)
    if screenPos.z < 0 then
      v2.x = 9999
      v2.y = 9999
    end
    local _, pos = _screenPosToUI(self.bindComponents.HeroCtrl.transform.parent, v2, C_CameraManager.uiCamera)
    L_Vector3.setAnchored(self.bindComponents.HeroCtrl, pos)
  end
  local col = self.heroPutInfo[self.selectHeroGuid].collider
  worldPos = L_Vector3.getTemp(worldPos.x, worldPos.y + col.height, worldPos.z)
  screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(worldPos)
  v2 = C_Vector2(screenPos.x, screenPos.y)
  if not self.isDragging and screenPos.z < 0 then
    v2.x = 9999
    v2.y = 9999
  end
  local _, pos = _screenPosToUI(self.bindComponents.rectTakeOver.transform.parent, v2, C_CameraManager.uiCamera)
  L_Vector3.setAnchored(self.bindComponents.rectTakeOver, pos)
end

function this:syncPosImg()
  if self.uiNodeGo == nil or self.curSelectEntity == nil then
    return
  end
  if not self.uiNodeGo.activeSelf then
    self.uiNodeGo:SetActive(true)
  end
  local pos = L_Vector3.getRelativePos(self.curSelectEntity.transform:GetRawTransform())
  self.uiNodeTrs.position = pos + C_Vector3(0, 0.01, 0)
end

function this:clickSelectHero()
  if not Unity.Input.GetMouseButtonDown(0) then
    return
  end
  if Unity.EventSystems.EventSystem.current:IsPointerOverGameObject() then
    return
  end
  local mousePosition = CS.UnityEngine.Input.mousePosition
  local hits = C_CameraManager.mainCamera:ScreenRaycastAllByLayer(C_Vector2(mousePosition.x, mousePosition.y), {"Character"})
  if hits then
    for i = 0, hits.Length - 1 do
      local hit = hits[i]
      local hitObj = hit.collider.gameObject
      for guid, v in pairs(self.heroPutInfo) do
        if v.entity and v.entity.model.gameObject == hitObj then
          if not self.canPut and L_PhotoManager.selectEntityGuid ~= nil and L_PhotoManager.selectEntityGuid ~= guid then
            L_FlyMsgManager:showNormalMsgByKey("notice_modulePhotoGroup_hero_04")
            return
          end
          self:refreshCurSelectHero(guid)
          return
        end
      end
    end
  end
end

function this:update()
  self:syncDragBtnPos()
  self:syncPosImg()
  self:clickSelectHero()
  self.canPut = self:checkCanPut(self.selectHeroGuid)
  if self.curSelectEntity ~= nil then
    C_PhotoPlayManager:SetAnimatorParamRunning(self.curSelectEntity, false)
  end
end

function this:create3DUINode()
  if self.uiNodeGo ~= nil then
    return
  end
  local go = L_ResPool:syncGameObject("UI/Pages/Photo/petPos3D.prefab", C_LuaUtility.GetRootNode())
  self.uiNodeGo = go
  self.uiNodeTrs = go.transform
  self.posImg = self.uiNodeTrs:Find("petPos"):GetComponent(typeof(C_LImage))
  go:SetActive(false)
  local width = 30
  L_Vector3.setUISize(self.posImg.transform, L_Vector3.getTemp(width, width))
end

function this:onClickNext()
  self.curPageIndex = self.curPageIndex + 1
  self:initHeroList(self.curPageIndex)
  self:refreshPageInfo()
end

function this:onClickBack()
  self.curPageIndex = self.curPageIndex - 1
  self:initHeroList(self.curPageIndex)
  self:refreshPageInfo()
end

function this:refreshPageInfo()
  if self.minPage >= self.maxPage then
    self.bind.isActive_pageBtn = false
  else
    self.bind.isActive_pageBtn = true
    self.bind.txt_page = string.format("%d/%d", self.curPageIndex, self.maxPage)
    self.bind.isActive_next = self.curPageIndex ~= self.maxPage
    self.bind.isActive_back = self.curPageIndex ~= self.minPage
  end
  self:refreshHeroList()
end

function this:getPutCount()
  local count = 1
  for i, v in pairs(self.heroPutInfo) do
    count = count + 1
  end
  return count
end

function this:getMainControlEntity()
  local mainEntity = L_PhotoManager:getMediator().target
  return mainEntity
end

function this:clearPutHeroes()
  for i, v in pairs(self.heroPutInfo) do
    AzurWorld.photoMgr:RecycleHero(i)
  end
  self.heroPutInfo = {}
end

function this:removeHero(guid)
  local info = self.heroPutInfo[guid]
  if not info then
    return
  end
  local entity = info.entity
  if self:getMainControlEntity() ~= nil and guid == self:getMainControlEntity().entity.data.UUID then
    return
  end
  if entity == nil then
    return
  end
  if L_PhotoManager:HeroCaressBlock(entity) then
    return
  end
  self.heroPutInfo[guid] = nil
  if self.curSelectEntity == entity then
    self:refreshCurSelectHero(nil)
  end
  AzurWorld.photoMgr:RecycleHero(guid)
  self:refreshHeroList()
end

return this
