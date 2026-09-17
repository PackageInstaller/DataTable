local this = class("modulePhotoGroup_pet", require("ui.pages.photo.group.modulePhotoGroup_base"))
local EventSystem = Unity.EventSystems.EventSystem
local canShowPetMaxVal = L_PhotoStore.canShowPetMaxVal
local oneBoxMaxCount = L_PetStore.data.petBoxLimit or 24
local sliderBtnIns = 1
local MAX_TOGGLE_COUNT = 14
local posColor = {
  Green = C_Color.green,
  Red = C_Color.red
}
local subViewState = {
  none = 0,
  action = 1,
  face = 2
}

function this.bind()
  return {
    txt_curPetNum = "0",
    txt_maxPetNum = "10",
    list = {
      moduleName = "pages/photo/cell/cellPhotoPet"
    },
    size_list_pet = L_DeviceTpl:getIsPc() and C_Vector2(368, 770) or C_Vector2(368, 616),
    txt_listIndex = "",
    txt_petName = "",
    list_toggle = {
      moduleName = "pages/photo/cell/cellPhotoListToggle"
    },
    activePetCtrl = false,
    rotateSliderVal = 0,
    txt_rotateAngle = "",
    activeSureBtn = true,
    activeBackBtn = true,
    faceBtnIcon = "UI/Page/Photo/tex_photo_icon_happy.png",
    activeListView = true,
    activeActionView = false,
    activeFaceView = false,
    actionView = {
      moduleName = "pages/photo/group/modulePhotoGroup_petAction"
    },
    faceView = {
      moduleName = "pages/photo/group/modulePhotoGroup_petFace"
    },
    moduleTitle = {
      moduleName = "pages/photo/modulePhotoListTitle"
    },
    activeModuleTitle = false,
    activeBg = false,
    btnReturn = true,
    txtBoxName = "",
    active_bottom = true
  }
end

function this.methods()
  return {
    moduleTitle = {
      onClickToggle = function(self, isOn)
        self.clickToggleState = isOn
        if self.subViewState == subViewState.action then
          self:updateSubView(subViewState.face)
        elseif self.subViewState == subViewState.face then
          self:updateSubView(subViewState.action)
        end
        self.bind.actionView.module:updateTargetEntity(self.selectedEntity)
        self.bind.faceView.module:updateTargetEntity(self.selectedEntity)
      end
    },
    list = {
      onClick_handle = function(self, cell, guid)
        self:clickPet(cell, guid)
      end
    },
    onDragPetStart = function(self)
      self.draging = true
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Qibo_Put")
      L_PhotoManager:sendEvent(L_PhotoManager.event.changeStartAlpha)
    end,
    onDragPetEnd = function(self)
      self.draging = false
      self:onDragPet()
      L_PhotoManager:sendEvent(L_PhotoManager.event.changeEndAlpha)
    end,
    onClickLeft = function(self)
      self:moveBox(-1)
    end,
    onClickRight = function(self)
      self:moveBox(1)
    end,
    onClickRecycle = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Qibo_Button")
      self:onClickRecycle()
    end,
    onClickRecycleAll = function(self)
      for i, v in pairs(L_PhotoManager.entitys) do
        if L_PhotoManager:PetCaressBlock(v.entity) then
          return
        end
      end
      self:clearAllEntity()
    end,
    onClickBack = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Qibo_Button")
      self:onClickBack()
    end,
    onClickSure = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Qibo_Button")
      self:onClickSure()
    end,
    onClickSliderLeft = function(self)
      self:onClickSliderLeft()
    end,
    onClickSliderRight = function(self)
      self:onClickSliderRight()
    end,
    onValueChanged_slider = function(self, value)
      self:updateEntityRotateByVal(value)
    end,
    onClickFaceBtn = function(self)
      self:onClickFaceBtn()
    end,
    onSliderLeftLongPress = function(self)
      self:updateEntityRotate(sliderBtnIns * -1)
    end,
    onSliderRightLongPress = function(self)
      self:updateEntityRotate(sliderBtnIns)
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:initTimer()
  self.timer = Timer.repeated(0.02, self.update, self)
end

function this:clearTimer()
  if self.timer then
    self.timer:destroy()
  end
end

function this:open()
  self:initData()
  self:initPetBoxData()
  self.clickToggleState = false
  self.tempVe3Val = C_Vector3(0, 0, 0)
  self.subViewState = subViewState.none
  L_PhotoManager:addListener(L_PhotoManager.event.photoMenuStateChange, self.onEvent_photoMenuStateChange, self)
  L_PhotoManager:addListener(L_PhotoManager.event.addPhotoPetEntity, self.onEvent_addEntity, self)
  L_PhotoManager:addListener(L_PhotoManager.event.removePhotoPetEntity, self.onEvent_removeEntity, self)
  L_PhotoManager:addListener(L_PhotoManager.event.clearAllPhotoPetEntity, self.onEvent_clearAllEntity, self)
  L_PlayerManager:addListener(L_PlayerManager.event.playMount, self.onEvent_playMount, self)
  self:initPetList()
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.addPhotoPetEntity, self.onEvent_addEntity, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.removePhotoPetEntity, self.onEvent_removeEntity, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.clearAllPhotoPetEntity, self.onEvent_clearAllEntity, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.photoMenuStateChange, self.onEvent_photoMenuStateChange, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playMount, self.onEvent_playMount, self)
  self:clearAllEntity()
end

function this:show()
  self:initTimer()
end

function this:hide()
  if self.bind.activePetCtrl then
    self:onClickBack()
  end
  self:clearTimer()
end

function this:onEvent_photoMenuStateChange(isBack, groupId)
  if isBack then
    self:selectPetEntity()
    self.timer:pause()
  elseif not isBack and groupId == L_Const.photoGroup.pet then
    self.timer:resume()
    self:refreshBoxList()
  end
end

function this:initData()
  self.bind.txt_curPetNum = "0"
  self.bind.txt_maxPetNum = tostring("/" .. canShowPetMaxVal)
  self:setCurSelectVal(0)
end

function this:setCurSelectVal(val)
  if self.curSelectVal == val then
    return
  end
  self.curSelectVal = val
end

function this:clearAllEntity()
  self:setCurSelectVal(0)
  self:selectPetEntity()
  L_PhotoManager:clearAllPhotoPetEntity()
  self.bind.txt_curPetNum = "0"
  self:refreshBoxList()
end

function this:update()
  if self.draging then
    self:onDragPet()
  else
    self:updateCtrlPos()
  end
  self:checkIsCanSet()
  self:checkSelectEntity()
  self:updatePetPos()
  self:refreshPetFacePos()
end

function this:checkIsCanSet(force)
  if not self.curSelectEntityInfo then
    self.isCanSet = false
    return
  end
  if not self.checkDict then
    self.checkDict = {}
    self.debugCollider = false
  end
  self:updateSelectedEntityPhotoWaterState()
  local isOnGround = self.selectedEntity:checkIsOnGround()
  if not isOnGround then
    self.isCanSet = false
  elseif self.selectedEntity.isPhotoInWater then
    self.isCanSet = false
  else
    local entityTrans = self.selectedEntity:getTransform()
    local entityPos = entityTrans.position
    local distance = self.selectedEntity.modelCollider.radius
    local hits = C_Physics.OverlapBox(entityPos, C_Vector3(distance, distance * 0.8, distance))
    table.clear(self.checkDict)
    local count = 0
    local pos, key
    for i = 0, hits.Length - 1 do
      local collider = hits[i]
      local layer = collider.gameObject.layer
      local isWaterCollider = layer == L_Const.layer.water
      if not collider.isTrigger and not isWaterCollider then
        pos = collider.transform.position
        key = string.format("%.2f_%.2f_%.2f", pos.x, pos.y, pos.z)
        if not self.checkDict[key] then
          self.checkDict[key] = true
          count = count + 1
        end
        if self.debugCollider then
          local id = collider:GetInstanceID()
          local name = collider.name
          if not string.find(name, id) then
            collider.name = name .. "_" .. id
          end
          printf("petPhotoEntity update %s", collider.name, collider.transform.position, id)
        end
      end
    end
    self.isCanSet = count <= 1
    if self.debugCollider then
      printf("petPhotoEntity update %s", count)
    end
  end
end

function this:checkSelectEntity()
  if not Unity.Input.GetMouseButtonDown(0) then
    return
  end
  local mousePosition = CS.UnityEngine.Input.mousePosition
  local hits = C_CameraManager.mainCamera:ScreenRaycastAllByLayer(C_Vector2(mousePosition.x, mousePosition.y), {"Character"})
  if hits then
    local entitys = L_PhotoManager:getAllPhotoPetEntity()
    for i = 0, hits.Length - 1 do
      local hit = hits[i]
      local hitObj = hit.collider.gameObject
      for _, v in pairs(entitys or table.empty) do
        if v.entity and hitObj == v.entity.goModel then
          self:selectPetEntity(v)
          self:refreshBoxList(v.guid)
          return
        end
      end
    end
  end
end

function this:initPetBoxData()
  local boxList = self:createBoxListData()
  self.boxDataList = boxList
  self.maxBoxIndex = math.max(#boxList, 1)
  self.curBoxIndex = 1
end

function this:createBoxListData()
  local boxList = {}
  self.boxDataDict = {}
  self.boxIndex2RealIndex = {}
  local countList = L_PetStore:getPetBoxList()
  local curIndex = 1
  for boxIndex, list in ipairs(countList or table.empty) do
    for _, v in ipairs(list or table.empty) do
      local pet = L_PetStore:getPetItem(v)
      if not table.isEmpty(pet) then
        if not boxList[curIndex] then
          boxList[curIndex] = {}
        end
        local name = pet.pet_name
        if string.isEmpty(name) then
          local petConf = L_ItemTplManager:getPetItem(pet.id, pet:isSpecialPet())
          name = petConf.name
        end
        local data = {
          guid = pet.guid,
          boxIndex = boxIndex,
          choice = self.curSelectEntityInfo and self.curSelectEntityInfo.guid == pet.guid,
          name = name,
          selectNum = 0,
          isSet = false
        }
        table.insert(boxList[curIndex], data)
        self.boxDataDict[data.guid] = data
      end
    end
    if not table.isEmpty(boxList[curIndex]) then
      self.boxIndex2RealIndex[curIndex] = boxIndex
      curIndex = curIndex + 1
    end
  end
  return boxList
end

function this:initPetList()
  self:refreshBoxInfo(self.curBoxIndex)
  self.toggleCount = math.min(self.maxBoxIndex, MAX_TOGGLE_COUNT)
  self.windowStart = 1
  local toggleInitDatas = {}
  for i = 1, self.toggleCount do
    table.insert(toggleInitDatas, {})
  end
  self.bind.active_bottom = self.maxBoxIndex > 1
  self.bind.list_toggle:clear()
  self.bind.list_toggle:insert_array(toggleInitDatas)
  self:setPointListActive(self.curBoxIndex)
end

function this:refreshWindow(boxIndex)
  if boxIndex < self.windowStart then
    self.windowStart = boxIndex
  elseif boxIndex > self.windowStart + self.toggleCount - 1 then
    self.windowStart = boxIndex - self.toggleCount + 1
  end
  local maxStart = math.max(1, self.maxBoxIndex - self.toggleCount + 1)
  self.windowStart = math.clamp(self.windowStart, 1, maxStart)
end

function this:refreshBoxInfo(boxIndex)
  if not self.boxDataList then
    return
  end
  self.bind.list:clear()
  local realBoxIndex = self.boxIndex2RealIndex[boxIndex] or boxIndex
  self.bind.txtBoxName = L_PetStore:getPetBoxName(realBoxIndex)
  local list = self.boxDataList[boxIndex]
  if table.isEmpty(list) then
    return
  end
  self.bind.list:insert_array(list)
end

function this:setPointListActive(itemIndex)
  itemIndex = itemIndex or 1
  self:refreshWindow(itemIndex)
  local activeSlot = itemIndex - self.windowStart + 1
  for i = 1, self.toggleCount do
    local active = i == activeSlot
    self.bind.list_toggle:change(i, {
      on = active,
      off = not active
    })
  end
  local realBoxIndex = self.boxIndex2RealIndex[itemIndex] or itemIndex
  self.bind.txt_listIndex = self:indexChange(realBoxIndex)
  self.bind.txt_petName = self:getPetBoxName(realBoxIndex)
end

function this:getPetBoxName(index)
  local petBoxNameList = L_PetStore:getPetBoxNameList()
  return petBoxNameList[index] or ""
end

function this:indexChange(index)
  if index < 10 then
    return string.format("0%d", index)
  end
  return tostring(index)
end

function this:moveBox(ins)
  local newVal = self.curBoxIndex + ins
  if newVal > self.maxBoxIndex then
    newVal = 1
  elseif newVal < 1 then
    newVal = self.maxBoxIndex
  end
  if self.curBoxIndex == newVal then
    return
  end
  self.curBoxIndex = newVal
  self:refreshBoxInfo(self.curBoxIndex)
  self:setPointListActive(self.curBoxIndex)
end

function this:refreshBoxList(guid)
  guid = guid or self.curSelectEntityInfo and self.curSelectEntityInfo.guid
  for i, v in pairs(self.modules.list) do
    if not math.isEmpty(v.bind.guid) then
      local cell = v
      local isSelect = guid and guid == v.bind.guid or false
      cell:setGifPlay(isSelect)
      local data = self.boxDataDict[v.bind.guid]
      cell:changeSelectNum(data.selectNum, data.isSet)
    end
  end
end

function this:onEvent_addEntity(info)
  local data = self.boxDataDict[info.guid]
  if data then
    data.selectNum = data.selectNum + 1
    data.isSet = data.isSet and data.selectNum > 0
  end
  Timer.once(0, self.refreshBoxList, self)
end

function this:onEvent_removeEntity(info)
  local data = self.boxDataDict[info.guid]
  if data then
    data.selectNum = data.selectNum - 1
    data.isSet = data.isSet and data.selectNum > 0
  end
  self:refreshBoxList()
end

function this:onEvent_clearAllEntity()
  for guid, data in pairs(self.boxDataDict) do
    data.selectNum = 0
    data.isSet = false
  end
  self.bind.txt_curPetNum = "0"
  self:refreshBoxList()
end

function this:onEvent_playMount()
  self:selectPetEntity()
end

function this:clickPet(cell, guid)
  if AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).state:IsFlying() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_noput"))
    return
  end
  if L_PhotoManager:getPhotoPetEntityCount() >= canShowPetMaxVal then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_qibo_max"))
    return
  elseif self.curSelectEntityInfo and not self.curSelectEntityInfo.isSet then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_qibo_01"))
    return
  elseif not L_PhotoManager:checkPetCanSet(guid) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_qibo_02"))
    return
  end
  self.bind.txt_curPetNum = tostring(L_PhotoManager:getPhotoPetEntityCount() + 1)
  L_PhotoManager:addPhotoPetEntity(guid, function(info)
    self:selectPetEntity(info)
  end)
end

function this:selectPetEntity(info, forceRemove)
  local entity = info and info.entity
  if entity and self.selectedEntity == entity then
    return
  end
  local oldEntityInfo = self.curSelectEntityInfo
  local oldEntity = self.selectedEntity
  local haveSelect = entity ~= nil
  if oldEntity and (not oldEntityInfo.isSet or forceRemove) then
    self.curSelectEntityInfo.waitDel = true
  end
  self:beforeChangeSelect(self.curSelectEntityInfo, info)
  self.curSelectEntityInfo = info
  self.selectedEntity = entity
  self.bind.activePetCtrl = haveSelect
  L_PhotoManager.selectEntityGuid = info and info.guid
  self:afterChangeSelect(haveSelect)
  self:updateCtrlPos()
  self:syncRotateSliderVal()
  if oldEntity and (not oldEntityInfo.isSet or forceRemove) then
    L_PhotoManager:removePhotoPetEntity(oldEntityInfo.index)
  end
end

function this:beforeChangeSelect(oldEntityInfo, newEntityInfo)
  local isEntityChange = oldEntityInfo ~= newEntityInfo
  if isEntityChange then
    self:resetEnityInfoChange()
  end
  self:activeEntityUI(oldEntityInfo and oldEntityInfo.entity, false)
  self:activeEntityUI(newEntityInfo and newEntityInfo.entity, true)
end

function this:afterChangeSelect(haveSelect)
  if haveSelect then
    self.selectedEntity:setColliderIsTrigger(true)
    self:checkIsCanSet(true)
  else
    self:updateSubView(subViewState.none)
  end
  self.bind.actionView.module:updateTargetEntity(self.selectedEntity)
  self.bind.faceView.module:updateTargetEntity(self.selectedEntity)
end

function this:refreshPetFacePos()
  if not self.tempVecter2 then
    self.tempVecter2 = {x = 0, y = 0}
  end
  if self.selectedEntity then
    local pos = self.selectedEntity.goModel.transform.position
    local height = self.selectedEntity.modelCollider.height
    local worldPos = L_Vector3.getTemp(pos.x, pos.y + height, pos.z)
    local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(worldPos)
    if 0 >= screenPos.z then
      self.tempVecter2.x = 9999
      self.tempVecter2.y = 9999
    else
      self.tempVecter2.x = screenPos.x
      self.tempVecter2.y = screenPos.y
    end
    local _, uiPos = C_RectTransformUtility.ScreenPointToLocalPointInRectangle(self.bindComponents.transPetCtrl, self.tempVecter2, C_CameraManager.uiCamera)
    L_Vector3.setLocalPos(self.bindComponents.transPetFace, uiPos)
  end
end

function this:activeEntityUI(entity, isShow)
  if entity then
    entity:activeUINode(isShow)
  end
end

function this:checkSelectEntityCanSet()
  return self.isCanSet
end

function this:updatePetPos()
  if not self.selectedEntity then
    return
  end
  if not self:checkSelectEntityCanSet() then
    self.selectedEntity:setPetPosImgColor(posColor.Red)
  else
    self.selectedEntity:setPetPosImgColor(posColor.Green)
  end
end

function this:updateSelectedEntityPhotoWaterState(rayScreenPos, terrainHit, terrainSuccess)
  if not self.selectedEntity then
    return false
  end
  if not rayScreenPos then
    local entityPos = self.selectedEntity.goModel.transform.position
    local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(entityPos)
    if screenPos.z <= 0 then
      self.selectedEntity.isPhotoInWater = false
      return false
    end
    rayScreenPos = C_Vector2(screenPos.x, screenPos.y)
  end
  local success = terrainSuccess
  local hit = terrainHit
  if success == nil then
    success, hit = C_CameraManager.mainCamera:ScreenRaycastByLayers(rayScreenPos, {"Default", "Terrain"}, 60, true)
  end
  local isWater, hitWater = C_CameraManager.mainCamera:ScreenRaycastByLayers(rayScreenPos, {"Water"}, 60, false)
  self.selectedEntity.isPhotoInWater = false
  if success then
    local waterY = isWater and hitWater and hitWater.point.y or nil
    local terrainY = hit.point.y
    local waterDistance = isWater and hitWater and hitWater.distance or nil
    local terrainDistance = hit.distance
    local isWaterAboveTerrain = waterY and waterY > terrainY + 0.05
    local isSameSurface = waterY and 0.05 >= math.abs(waterY - terrainY)
    local isWaterBeforeOrSameHit = waterDistance and waterDistance <= terrainDistance + 0.2
    if isWater and hitWater and (isWaterAboveTerrain or isSameSurface and isWaterBeforeOrSameHit) then
      self.selectedEntity.isPhotoInWater = true
    end
  end
  return self.selectedEntity.isPhotoInWater
end

function this:onDragPet()
  if self.selectedEntity then
    if L_PhotoManager:PetCaressBlock(self.selectedEntity) then
      return
    end
    local pos = self.bindComponents.transPetCtrl.position
    local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(pos)
    local rayScreenPos = C_Vector2(screenPos.x, screenPos.y)
    local success, hit = C_CameraManager.mainCamera:ScreenRaycastByLayers(rayScreenPos, {"Default", "Terrain"}, 60, true)
    if success then
      self:updateSelectedEntityPhotoWaterState(rayScreenPos, hit, success)
      self.selectedEntity.csEntity.entity:SafeSetPosition(hit.point)
      if self.debugCollider then
        printf("petPhotoEntity hit %s", hit.collider.name)
      end
    end
  end
end

function this:applyEnityInfoChange()
  if not self.curSelectEntityInfo then
    return
  end
  self.curSelectEntityInfo.isSet = true
  local data = self.boxDataDict[self.curSelectEntityInfo.guid]
  if data then
    data.isSet = true
  end
  local entity = self.curSelectEntityInfo.entity
  if entity then
    self.curSelectEntityInfo.cachePos = entity.goModel.transform.position
    self.curSelectEntityInfo.cacheRotation = entity:getRotation()
    entity:setColliderIsTrigger(false)
  end
end

function this:resetEnityInfoChange()
  if not self.curSelectEntityInfo then
    return
  end
  local entity = self.curSelectEntityInfo.entity
  if entity and not self.curSelectEntityInfo.waitDel then
    entity:setPosition(self.curSelectEntityInfo.cachePos)
    entity:setRotation(self.curSelectEntityInfo.cacheRotation)
    self.bind.rotateSliderVal = self.curSelectEntityInfo.cacheRotation.y
    if self.curSelectEntityInfo.isSet then
      entity:setColliderIsTrigger(false)
    end
  end
end

function this:onClickSure()
  if not self:checkSelectEntityCanSet() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_qibo_03"))
    return
  end
  self:applyEnityInfoChange()
  self:selectPetEntity()
  self:refreshBoxList()
end

function this:onClickBack()
  if L_PhotoManager:PetCaressBlock(self.selectedEntity) then
    return
  end
  if self.curSelectEntityInfo and not self.curSelectEntityInfo.isSet then
    self.curSelectEntityInfo.waitDel = true
  end
  self:resetEnityInfoChange()
  self:selectPetEntity()
  self:refreshBoxList()
end

function this:onClickSliderLeft()
  if L_PhotoManager:PetCaressBlock(self.curSelectEntityInfo.entity) then
    return
  end
  self:updateEntityRotate(-sliderBtnIns)
end

function this:onClickSliderRight()
  if L_PhotoManager:PetCaressBlock(self.curSelectEntityInfo.entity) then
    return
  end
  self:updateEntityRotate(sliderBtnIns)
end

function this:onClickRecycle()
  if self.curSelectEntityInfo and L_PhotoManager:PetCaressBlock(self.curSelectEntityInfo.entity) then
    return
  end
  if self.bind.activePetCtrl and self.curSelectEntityInfo then
    self:selectPetEntity(nil, true)
    self.bind.txt_curPetNum = tostring(L_PhotoManager:getPhotoPetEntityCount())
    self:refreshBoxList()
  end
end

function this:onClickFaceBtn()
  if not self.selectedEntity then
    return
  end
  if self.subViewState == subViewState.none then
    self:updateSubView(self.clickToggleState and subViewState.face or subViewState.action)
  else
    self:updateSubView(subViewState.none)
  end
  self.bind.actionView.module:updateTargetEntity(self.selectedEntity)
  self.bind.faceView.module:updateTargetEntity(self.selectedEntity)
end

function this:updateSubView(state)
  if self.subViewState == state then
    return
  end
  self.subViewState = state
  local showSubView = self.subViewState ~= subViewState.none
  self.bind.faceBtnIcon = showSubView and "UI/Page/Photo/tex_photo_icon_emoticon.png" or "UI/Page/Photo/tex_photo_icon_happy.png"
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    mediator.isPetAction = showSubView
  end
  L_PhotoManager:sendEvent(L_PhotoManager.event.photoMenuForceRefresh)
  if not showSubView then
    self.bind.activeListView = true
    self.bind.activeActionView = false
    self.bind.activeFaceView = false
    self.bind.activeModuleTitle = false
    self.bind.activeBg = false
    self.bind.btnReturn = true
    if L_DeviceTpl:getIsMobile() then
      self.bind.size_list_pet = C_Vector2(368, 616)
    end
    return
  end
  local isShowActionView = self.subViewState == subViewState.action
  self.bind.activeListView = true
  self.bind.activeModuleTitle = true
  self.bind.activeBg = true
  self.bind.btnReturn = false
  self.bind.activeActionView = isShowActionView
  self.bind.activeFaceView = not isShowActionView
  if L_DeviceTpl:getIsMobile() then
    self.bind.size_list_pet = C_Vector2(368, 516)
  end
end

function this:updateCtrlPos()
  if self.selectedEntity then
    local pos = self.selectedEntity.goModel.transform.position
    local viewPos = C_CameraManager.mainCamera:WorldToViewportPoint(pos)
    if viewPos.z < 0 then
      local uiPos = C_Vector2(9999, 9999)
      self.bindComponents.transPetCtrl.anchoredPosition = uiPos
    else
      local sizeDelta = L_UI:getRoot().sizeDelta
      local uiPos = C_Vector2((viewPos.x - 0.5) * sizeDelta.x, (viewPos.y - 0.5) * sizeDelta.y)
      self.bindComponents.transPetCtrl.anchoredPosition = uiPos
    end
  end
end

function this:updateEntityRotateByVal(val)
  if L_PhotoManager:PetCaressBlock(self.curSelectEntityInfo.entity) then
    self:syncRotateSliderVal()
    return
  end
  if self.curSelectEntityInfo then
    val = self:parseSliderVal(val)
    self:refreshRotateSlider(val)
    self:rotateEntity(val)
  end
end

function this:updateEntityRotate(diff)
  if self.curSelectEntityInfo then
    local val = (self.bind.rotateSliderVal or self.curSelectEntityInfo.cacheRotation.y) + (diff or 0)
    val = self:parseSliderVal(val)
    self:refreshRotateSlider(val)
    self:rotateEntity(val)
  end
end

function this:syncRotateSliderVal()
  if not self.curSelectEntityInfo then
    return
  end
  local v = self.curSelectEntityInfo.entity.gameObject.transform.rotation.eulerAngles.y
  local val = self:parseSliderVal(v)
  self.bind.rotateSliderVal = val
  self:refreshRotateSlider(self.bind.rotateSliderVal)
end

function this:parseSliderVal(val)
  val = val or self.curSelectEntityInfo and self.curSelectEntityInfo.cacheRotation.y or 0
  val = math.clamp(val, 0, 359)
  val = math.ceil(val)
  return val
end

function this:refreshRotateSlider(val)
  if not self.curSelectEntityInfo then
    return
  end
  self.bind.rotateSliderVal = val
  self.bind.txt_rotateAngle = string.format("%s°", val)
end

function this:rotateEntity(val)
  local rot = self.curSelectEntityInfo.cacheRotation
  self.tempVe3Val.x = 0
  self.tempVe3Val.y = val
  self.tempVe3Val.z = 0
  self.selectedEntity:setLogicRotation(self.tempVe3Val)
end

return this
