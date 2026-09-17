local this = class("moduleSituationActionPanel", G_UIModuleBase)
local _SpeedState = {
  [1] = {txt = "x0.5", value = 0.5},
  [2] = {txt = "x1", value = 1},
  [3] = {txt = "x1.5", value = 1.5},
  [4] = {txt = "x2", value = 2}
}
local _photoParamTpl = L_GameTpl:getPhotographParamTpl()

function this.bind()
  return {
    active_action = false,
    actionList = {
      moduleName = "pages/photo/cell/cellPhotoImage"
    },
    active_face = false,
    faceList = {
      moduleName = "pages/photo/cell/cellPhotoImage"
    },
    activeSlider = nil,
    activePlay = nil,
    activeStop = nil,
    txt_name = "",
    txt_speed = "",
    sliderVal = nil,
    curActionId = 0,
    curFaceId = 0
  }
end

function this.methods()
  return {
    actionList = {
      onClick_handle = function(self, id, name)
        self:onSelectAction(id, name)
      end
    },
    faceList = {
      onClick_handle = function(self, id, name)
        self:onSelectFace(id, name)
      end
    },
    onClickSpeed = function(self)
      self:onClickSpeed()
    end,
    onClickPlay = function(self)
      self:onClickPlay()
    end,
    onClickStop = function(self)
      self:onClickStop()
    end,
    onClickReset = function(self)
      self:onClickReset()
    end
  }
end

function this:open()
end

function this:show()
  self:refreshActionList(3)
end

function this:close()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
  self:stopTimer()
end

function this:initTplData()
  self.heroActionTpls = {}
  self.heroFaceTpls = {}
  self.petActionTpls = {}
  self.petFaceTpls = {}
  for i, v in pairs(_photoParamTpl.data) do
    if _photoParamTpl:getShow(v) then
      local groupId = _photoParamTpl:getGroupId(v)
      if groupId == 5 then
        table.insert(self.heroActionTpls, v)
      elseif groupId == 6 then
        table.insert(self.heroFaceTpls, v)
      elseif groupId == 12 then
        table.insert(self.petActionTpls, v)
      elseif groupId == 13 then
        table.insert(self.petFaceTpls, v)
      end
    end
  end
end

function this:refresh()
end

function this:init(type)
  self:initTplData()
  self.type = type
  if self.type == L_Const.situationGroup.hero then
  elseif self.type == L_Const.situationGroup.pet then
  end
  self:initActionList()
  self:initFaceList()
end

function this:bindContainer(container)
  self.speedIndex = 2
  self.bind.txt_name = ""
  self.bind.txt_speed = _SpeedState[self.speedIndex].txt
  self.gameObject:SetActive(container ~= nil)
  if container == nil then
    L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
    L_SituationStore:unListenCallFunc(L_SituationStore.event.onSave, self.onSave, self)
    self:onClickStop()
    self.animator = nil
    self.stateComponent = nil
    self:stopTimer()
    self.dataContainer = nil
  else
    if self.dataContainer == container then
      return
    end
    self.dataContainer = container
    self.bind.activeStop = false
    self.bind.activePlay = true
    L_SituationStore:unListenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
    L_SituationStore:listenCallFunc(L_SituationStore.event.undoCountChanged, self.onUndoChanged, self)
    L_SituationStore:unListenCallFunc(L_SituationStore.event.onSave, self.onSave, self)
    L_SituationStore:listenCallFunc(L_SituationStore.event.onSave, self.onSave, self)
    if self.type == L_Const.situationGroup.hero then
      self.animator = container.heroEntity:getAnimatorComponent(true)
      self.stateComponent = container.heroEntity:getStateComponent(true)
      self.actionId = container.data.actionId
      self.bind.curActionId = self.actionId
      local tpl = _photoParamTpl:getTplById(self.actionId)
      self.animName = _photoParamTpl:getParam(tpl)
      self.bind.txt_name = _photoParamTpl:getName(tpl)
      self.faceId = container.data.faceId
      self.bind.curFaceId = self.faceId
    elseif self.type == L_Const.situationGroup.pet then
      local petContainer = container
      self.animator = petContainer.petEntity:getAnimatorComponent(true)
      self.stateComponent = petContainer.petEntity:getStateComponent(true)
      self.actionId = petContainer.data.actionId
      self.bind.curActionId = self.actionId
      local tpl = _photoParamTpl:getTplById(self.actionId)
      self.animName = _photoParamTpl:getParam(tpl)
      self.bind.txt_name = _photoParamTpl:getName(tpl)
      self.faceId = petContainer.data.faceId
      self.bind.curFaceId = self.faceId
    end
    self.lastDataActionId = self.dataContainer.data.actionId
    self.lastDataFaceId = self.dataContainer.data.faceId
    self:initTimer()
  end
end

function this:initActionList()
  local tpls = self.type == L_Const.situationGroup.hero and self.heroActionTpls or self.petActionTpls
  local list = {}
  for i, v in pairs(tpls) do
    local data = {
      id = _photoParamTpl:getId(v),
      txtName = _photoParamTpl:getName(v),
      imgIcon = _photoParamTpl:getIcon(v),
      tabGroup = self.bindComponents.actionGroup
    }
    table.insert(list, data)
  end
  self.bind.actionList:clear()
  self.bind.actionList:insert_array(list)
end

function this:initFaceList()
  local tpls = self.type == L_Const.situationGroup.hero and self.heroFaceTpls or self.petFaceTpls
  local list = {}
  for i, v in pairs(tpls) do
    local data = {
      id = _photoParamTpl:getId(v),
      txtName = _photoParamTpl:getName(v),
      imgIcon = _photoParamTpl:getIcon(v),
      tabGroup = self.bindComponents.faceGroup
    }
    table.insert(list, data)
  end
  self.bind.faceList:clear()
  self.bind.faceList:insert_array(list)
end

function this:refreshActionList(tabId)
  if tabId == L_Const.photoTabType.ACTION then
    self.bind.active_action = true
    self.bind.active_face = false
    self.bind.activeSlider = true
  elseif tabId == L_Const.photoTabType.FACE then
    self.bind.active_action = false
    self.bind.active_face = true
    self.bind.activeSlider = false
  end
end

function this:onSelectAction(id, name)
  local tpl = _photoParamTpl:getTplById(id)
  local animName = _photoParamTpl:getParam(tpl)
  local has = self.animator:HasState(animName)
  if not has then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_resource_lack"))
    self.bind.curActionId = self.actionId
    return
  end
  self:playAction(id)
  self.bind.txt_name = name
end

function this:onSelectFace(id, name)
  if not self.isPause then
    self:onClickStop()
  end
  self:playFace(id)
  if self.type == L_Const.situationGroup.hero then
    local param = {
      heroConfigId = self.dataContainer.data.heroConfigId,
      preFaceId = self.dataContainer.data.faceId,
      curFaceId = self.faceId
    }
    if param.preFaceId == param.curFaceId then
      return
    end
    L_SituationManager:addSetHeroFaceCommand(param)
  elseif self.type == L_Const.situationGroup.pet then
    local param = {
      petGuid = self.dataContainer.data.petGuid,
      preFaceId = self.dataContainer.data.faceId,
      curFaceId = self.faceId
    }
    if param.preFaceId == param.curFaceId then
      return
    end
    L_SituationManager:addSetPetFaceCommand(param)
  end
end

function this:playAction(id)
  if id == self.actionId then
    return
  end
  self.actionId = id
  self.isPause = false
  local tpl = _photoParamTpl:getTplById(id)
  local animName = _photoParamTpl:getParam(tpl)
  self.animName = animName
  local state = self.stateComponent
  state:doSingleAction(self.animName, true, function()
  end, true, nil, nil, id, true)
  self:onClickPlay()
end

function this:onClickPlay()
  self.isPause = false
  local speed = _SpeedState[self.speedIndex].value
  self.animator:setSpeed(_SpeedState[self.speedIndex].value)
  self.bind.activePlay = false
  self.bind.activeStop = true
  if self.type == L_Const.situationGroup.hero then
    C_MediaPackUtility.ChangeEffectSpeed(self.dataContainer.heroEntity.csEntity, speed, true)
  end
end

function this:onClickStop()
  self.isPause = true
  self.bind.activeStop = false
  self.bind.activePlay = true
  if self.dataContainer and L_CommonUtil.isValid(self.animator.animator) then
    self.animator:setSpeed(0)
    if self.type == L_Const.situationGroup.hero and self.dataContainer.heroEntity then
      C_MediaPackUtility.ChangeEffectSpeed(self.dataContainer.heroEntity.csEntity, 0, false)
    end
    if L_SituationManager.curSolution == nil then
      return
    end
    local state = self.animator:getState(self.animName)
    if self.type == L_Const.situationGroup.hero then
      if L_SituationManager:hasHero(self.dataContainer.data.heroConfigId) then
        local param = {
          heroConfigId = self.dataContainer.data.heroConfigId,
          preActionId = self.dataContainer.data.actionId,
          preActionTime = self.dataContainer.data.actionTime,
          curActionId = self.actionId,
          curActionTime = state and state.normalizedTime or 0,
          stopCommand = true
        }
        if param.curActionId == param.preActionId and param.curActionTime == param.preActionTime then
          return
        end
        L_SituationManager:addSetHeroActionCommand(param)
      end
    elseif self.type == L_Const.situationGroup.pet and L_SituationManager:hasPet(self.dataContainer.data.petGuid) then
      local param = {
        petGuid = self.dataContainer.data.petGuid,
        preActionId = self.dataContainer.data.actionId,
        preActionTime = self.dataContainer.data.actionTime,
        curActionId = self.actionId,
        curActionTime = state and state.normalizedTime or 0
      }
      if param.curActionId == param.preActionId and param.curActionTime == param.preActionTime then
        return
      end
      L_SituationManager:addSetPetActionCommand(param)
    end
  end
end

function this:onClickSpeed()
  self.speedIndex = self.speedIndex % 4 + 1
  self.bind.txt_speed = _SpeedState[self.speedIndex].txt
  local speed = _SpeedState[self.speedIndex].value
  self.animator:setSpeed(self.isPause and 0 or speed)
  if self.type == L_Const.situationGroup.hero and not self.isPause then
    C_MediaPackUtility.ChangeEffectSpeed(self.dataContainer.heroEntity.csEntity, speed, false)
  end
end

function this:initTimer()
  if self.timer then
    self.timer:start()
  else
    self.timer = Timer.repeated(0, self.update, self)
  end
end

function this:stopTimer()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:update()
  if self.animName and self.animator and self.dataContainer then
    if self.type == L_Const.situationGroup.hero then
      if L_SituationManager:hasHero(self.dataContainer.data.heroConfigId) then
        local state = self.animator:getState(self.animName)
        if state then
          self.bindComponents.slider:SetValueWithoutNotify(state.normalizedTime)
        end
      end
    elseif self.type == L_Const.situationGroup.pet and L_SituationManager:hasPet(self.dataContainer.data.petGuid) then
      local state = self.animator:getState(self.animName)
      if state then
        self.bindComponents.slider:SetValueWithoutNotify(state.normalizedTime)
      end
    end
  end
end

function this:playFace(id)
  self.faceId = id
end

function this:onClickReset()
  if self.type == L_Const.situationGroup.hero then
    local name = _photoParamTpl:getName(_photoParamTpl:getTplById(L_Const.photoParam.idle))
    self:onSelectAction(L_Const.photoParam.idle, name)
    self.bind.curActionId = L_Const.photoParam.idle
  elseif self.type == L_Const.situationGroup.pet then
    local name = _photoParamTpl:getName(_photoParamTpl:getTplById(L_Const.photoParam.petDefAction))
    self:onSelectAction(L_Const.photoParam.petDefAction, name)
    self.bind.curActionId = L_Const.photoParam.petDefAction
  end
end

function this:onUndoChanged()
  if self.dataContainer == nil then
    return
  end
  if self.type == L_Const.situationGroup.hero then
    if not L_SituationManager:hasHero(self.dataContainer.data.heroConfigId) then
      return
    end
  elseif self.type == L_Const.situationGroup.pet and not L_SituationManager:hasPet(self.dataContainer.data.petGuid) then
    return
  end
  local actionId = self.dataContainer.data.actionId
  local faceId = self.dataContainer.data.faceId
  if actionId == self.lastDataActionId and faceId == self.lastDataFaceId then
    return
  end
  self.lastDataActionId = actionId
  self.lastDataFaceId = faceId
  self.bind.curActionId = actionId
  local tpl = _photoParamTpl:getTplById(actionId)
  self.animName = _photoParamTpl:getParam(tpl)
  local speed = self.animator.animator.speed
  local isPause = speed == 0
  self.isPause = isPause
  self.bind.activeStop = not isPause
  self.bind.activePlay = isPause
  self.bind.txt_name = _photoParamTpl:getName(tpl)
  self.bind.curFaceId = faceId
end

function this:onSave()
  if not self.isPause then
    self:onClickStop()
  end
end

return this
