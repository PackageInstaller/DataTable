local this = class("moduleStandeePhotoGroup_action", require("ui.pages.photo.group.modulePhotoGroup_action"))
local _SpeedState = {
  [1] = {txt = "x0.5", value = 0.5},
  [2] = {txt = "x1", value = 1},
  [3] = {txt = "x1.5", value = 1.5},
  [4] = {txt = "x2", value = 2}
}

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    selectedId = 0,
    sliderVal = 0,
    goSlider = false,
    goBtnStop = false,
    goBtnResume = true,
    txtSpeed = _SpeedState[2].txt,
    txtName = "",
    list = {
      moduleName = "pages/photo/cell/cellPhotoImage"
    }
  }
end

function this.methods()
  return {
    onValueChanged_slider = function(self, value)
      if self.draging then
        self:animEvaluate(value)
      end
    end,
    onSliderDown = function(self)
      self.draging = true
      self:translateAnimState(false)
    end,
    onSliderUp = function(self)
      self.draging = false
    end,
    onClick_stop = function(self)
      self:translateAnimState(false)
    end,
    onClick_resume = function(self)
      self:translateAnimState(true)
    end,
    onClickSpeed = function(self)
      self:setSpeed(self.speedIdx + 1)
    end,
    list = {
      onClick_handle = function(self, id)
        self:playAction(id)
      end
    },
    onClickCancel = function(self)
      self:onClickCancel()
    end
  }
end

function this:open()
  self:initGroupList(L_Const.photoGroup.action)
  self.speedIdx = 2
  self:selectDefault()
end

function this:initGroupList(groupId)
  local list = self.paramTpl:getListByGroupId(groupId)
  local content = {}
  for index, tpl in ipairs(list) do
    local data = {}
    self:packList(data, tpl, index)
    table.insert(content, data)
  end
  self.bind.list:clear()
  self.bind.list:insert_array(content)
  return content
end

function this:bindHero(hero)
  self.hero = hero
  self.target = hero.entity
  self.animator = self.target:getAnimatorComponent(true)
  self:selectDefault()
  self:initTimer()
  self.actionId = 0
  self:playAction(self.idleId)
end

function this:selectDefault()
  self.defaultId = L_Const.photoParam.idle
  self.idleId = L_Const.photoParam.idle
  self.bind.selectedId = self.idleId
  self:setActionId(self.idleId)
end

function this:playAction(actionId)
  if self.actionId == actionId then
    return
  end
  local tpl = self.paramTpl:getTplById(actionId)
  local animName = self.paramTpl:getParam(tpl)
  local has = self.animator:HasState(animName)
  if not has then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_resource_lack"))
    self.bind.selectedId = self.actionId
    return
  end
  self:setActionId(actionId)
  self:innerTranslateAnimState(true)
  self.animator:play(self.animName)
  self.animLen = self.animator.animator:GetAnimatorStateLength(self.animName)
end

function this:rePlay()
  self.animator:play(self.animName)
end

function this:setActionId(id)
  self.actionId = id
  local tpl = self.paramTpl:getTplById(self.actionId)
  self.animName = self.paramTpl:getParam(tpl)
  if self.hero and self.hero.configId == 101014 and id == L_Const.photoParam.personalAction then
    self.animName = "Personal3"
  end
  self.bind.txtName = self.paramTpl:getName(tpl)
  self.speedIdx = 2
  self.bind.txtSpeed = _SpeedState[self.speedIdx].txt
  self.bind.goSlider = self.actionId ~= L_Const.photoParam.idle
end

function this:getTargetEntity()
  return self.target
end

function this:setEntitySpeed(speed, isResume)
  self.animator:setSpeed(speed)
end

function this:show()
  if self.timer then
    self.timer:start()
  end
end

function this:hide()
  if self.timer then
    self.timer:stop()
  end
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:initTimer()
  if self.timer then
    self.timer:start()
  else
    self.timer = Timer.repeated(0, self.update, self)
  end
end

function this:update()
  if not self.animName or self.draging or not self.target then
    return
  end
  local isShow = self.actionId ~= self.defaultId
  if isShow then
    local state = self.animator:getState(self.animName)
    self.bind.sliderVal = state.normalizedTime
  end
  if not self.isPuase and isShow then
    local curName = self.animator.animator:GetCurrentStateName(0)
    if curName ~= self.animName then
      self:rePlay()
      return
    end
    local state = self.animator:getState(self.animName)
    if not state.isLooping and state.normalizedTime >= 0.999 then
      self:rePlay()
    end
  end
end

function this:pause()
  local isShow = self.actionId ~= self.defaultId
  if isShow then
    self:translateAnimState(false)
  end
end

function this:onClickCancel()
  self:playAction(self.defaultId)
  self.bind.selectedId = self.defaultId
end

return this
