local this = class("modulePhotoGroup_petAction", require("ui.pages.photo.group.modulePhotoGroup_action"))

function this:initDefaultId()
  self.defaultId = L_Const.photoParam.petDefAction
end

function this:getTargetEntity()
end

function this:onEvent_selectPhotoHeroChange()
end

function this:open()
  self:initDefaultId()
  self:updateTargetEntity()
  self.speedIdx = 2
  self:initGroupList(L_Const.photoGroup.petAction)
end

function this:show()
end

function this:animEvaluate(value)
  local state = self.animator:GetState(self.animName)
  local dt = (value - math.min(state.normalizedTime, 1)) * self.animLen
  self:setEntitySpeed(1, false)
  self.animator:Evaluate(dt)
end

function this:updateTargetEntity(target)
  self.target = target or self:getTargetEntity()
  if self.target then
    self.animator = self.target.csEntity.entity.data.animator
  else
    self.animator = nil
  end
  if self.animator then
    if self.timer then
      self.timer:start()
    else
      self.timer = Timer.repeated(0, self.update, self)
    end
  elseif self.timer then
    self.timer:stop()
  end
  if self.parent and self.parent.curSelectEntityInfo then
    self.actionId = self.parent.curSelectEntityInfo and self.parent.curSelectEntityInfo.actionId or self.defaultId
    self.bind.selectedId = self.actionId
  end
end

function this:setActionId(id)
  self.actionId = id
  local tpl = self.paramTpl:getTplById(self.actionId)
  self.animName = self.paramTpl:getParam(tpl)
  if self.parent.curSelectEntityInfo then
    self.parent.curSelectEntityInfo.actionId = id
  end
  self.bind.txtName = self.paramTpl:getName(tpl)
  self.speedIdx = 2
  self.bind.goSlider = self.actionId ~= self.defaultId
  self.bind.active_collect = false
end

function this:playAction(actionId)
  if self.actionId == actionId then
    return
  end
  if L_PhotoManager:PetCaressBlock(self.target) then
    self.bind.selectedId = self.defaultId
    self:setActionId(self.defaultId)
    return
  end
  if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
    self.bind.selectedId = self.defaultId
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_noaction"))
    return
  end
  self:setActionId(actionId)
  self:innerTranslateAnimState(true)
  local csEntity = self.target.csEntity
  local state = L_PhotoManager:getStateMachine(self.target.csEntity.entity.data.entityId)
  state:doSingleAction(self.animName, true, function()
    if csEntity and csEntity.entity then
      csEntity.entity.data.animator.lockState = false
    end
  end, true, nil, nil, actionId, nil, function()
    if csEntity and csEntity.entity then
      csEntity.entity.data.animator.lockState = true
    end
  end)
  self.animLen = self.animator:GetAnimatorStateLength(self.animName)
  self:setSpeed(2)
end

function this:setEntitySpeed(speed, isResume)
  self.animator.speed = speed
  C_MediaPackUtility.ChangeEffectSpeed(self.target.csEntity, speed, isResume)
end

return this
