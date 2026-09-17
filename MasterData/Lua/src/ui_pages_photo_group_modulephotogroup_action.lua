local this = class("modulePhotoGroup_action", require("ui.pages.photo.group.modulePhotoGroup_base"))
local _SpeedState = {
  [1] = {txt = "x0.5", value = 0.5},
  [2] = {txt = "x1", value = 1},
  [3] = {txt = "x1.5", value = 1.5},
  [4] = {txt = "x2", value = 2}
}
local photoTypeTpl = L_GameTpl:getPhotographTypeTpl()

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
    },
    active_tab = true,
    curTabId = 0,
    tabList = {
      moduleName = "pages/photo/cell/cellPhotoMenuTab"
    },
    active_collect = false
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
      self:translateAnimState(false)
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
    onClickTab = function(self, id)
      self:onSelectTab(id)
    end,
    onValueChangedCollect = function(self, isOn)
      self:onClickCollect(isOn)
    end,
    onClickCancel = function(self)
      self:onClickCancel()
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:open()
  self:filterActionConfig()
  self:initDefaultId()
  self:updateTargetEntity()
  self:initSelect()
  self.speedIdx = 2
  L_PhotoManager:addListener(L_PhotoManager.event.selectPhotoHeroChange, self.onEvent_selectPhotoHeroChange, self)
  L_PhotoManager:addListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
  L_PhotoManager:addListener(L_PhotoManager.event.exitSingleAction, self.onEvent_exitSingleAction, self)
end

function this:show()
  self:initTabList()
  this.super.show(self)
  self.bind.curTabId = 101
  self:initList(self.bind.curTabId)
  self:setSelectState()
  if self.tempDirty then
    self.tempDirty = false
    self:initSelect()
  end
  if self.timer then
    self.timer:start()
  end
end

function this:hide()
  self.bind.curTabId = 0
  this.super.hide(self)
  if self.timer then
    self.timer:stop()
  end
end

function this:initTabList()
  local list = {}
  for i, v in pairs(photoTypeTpl.data) do
    if photoTypeTpl:getTypeId(v) == L_Const.photoGroup.action then
      local temp = {
        tabId = photoTypeTpl:getId(v),
        txt_name = photoTypeTpl:getTypeName(v),
        sort = photoTypeTpl:getSequence(v),
        tabGroup = self.bindComponents.tabListGroup
      }
      table.insert(list, temp)
    end
  end
  table.sort(list, function(a, b)
    return a.sort < b.sort
  end)
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(list)
end

function this:onSelectTab(id)
  self:initList(id)
end

function this:filterActionConfig()
  local list = self.paramTpl:getListByGroupId(L_Const.photoGroup.action)
  self.actionDict = {}
  for i, tpl in pairs(list) do
    local subGroup = self.paramTpl:getType(tpl)
    local id = self.paramTpl:getId(tpl)
    local c = self.actionDict[subGroup]
    if c == nil then
      self.actionDict[subGroup] = {}
      c = self.actionDict[subGroup]
    end
    if id == L_Const.photoParam.personalAction and C_PhotoPlayUtil.IsMainControlInPLatform() then
    else
      table.insert(c, id)
    end
  end
end

function this:initList(tabId)
  if self.actionDict == nil then
    self:filterActionConfig()
  end
  for _, v in pairs(self.modules.list) do
    v:clearTabGroup()
  end
  local dataList = {}
  local actionIdList = self.actionDict[tabId]
  if actionIdList ~= nil then
    for i, v in pairs(actionIdList) do
      local id = v
      if id ~= self.defaultId then
        local tpl = self.paramTpl:getTplById(id)
        local data = {}
        self:packList(data, tpl)
        local collectData = L_PhotoManager:checkCollectAction(tpl.id)
        data.isCollect = collectData.isOn
        data.collectTime = collectData.time
        data.sortIndex = tpl.sequence
        table.insert(dataList, data)
      end
    end
  end
  table.sort(dataList, function(a, b)
    if a.isCollect ~= b.isCollect then
      return a.isCollect
    end
    if a.isCollect and b.isCollect and a.collectTime ~= b.collectTime then
      return a.collectTime > b.collectTime
    end
    return a.sortIndex < b.sortIndex
  end)
  self.bind.list:clear()
  self.bind.list:insert_array(dataList)
  self.bind.active_tab = false
end

function this:initSelect()
  local args = self:getUseArgs(L_Const.photoTemplateSettingParam.action)
  local initId = args and args.val or self.defaultId
  self.actionId = initId
  self.bind.selectedId = initId
  self:setActionId(initId)
  if args then
    self.bind.sliderVal = args.sliderValue
    self.bind.goBtnStop = false
    self.bind.goBtnResume = true
  else
    self.bind.goBtnStop = true
    self.bind.goBtnResume = false
  end
end

function this:resetHero()
  self:updateTargetEntity()
  self:setSelectState()
end

function this:onEvent_selectPhotoHeroChange(heroID)
  if not self.isBind or not heroID then
    return
  end
  self:resetHero()
end

function this:onEvent_photoTemplateChange()
  self.tempDirty = true
end

function this:setActionId(id)
  self.actionId = id
  local tpl = self.paramTpl:getTplById(self.actionId)
  self.animName = self.paramTpl:getParam(tpl)
  self.bind.txtName = self.paramTpl:getName(tpl)
  L_PhotoManager:getMediator().playActionId = id
  self.speedIdx = 2
  self.bind.goSlider = self.actionId ~= self.defaultId
  if self.bind.goSlider then
    self.bind.active_collect = true
    local collectData = L_PhotoManager:checkCollectAction(self.actionId)
    if collectData then
      self.bindComponents.tog_collect:SetIsOnWithoutNotify(collectData.isOn)
    end
  else
    self.bind.active_collect = false
  end
end

function this:setSpeed(idx)
  if not _SpeedState[idx] then
    idx = 1
  end
  self.speedIdx = idx
  local state = _SpeedState[idx]
  self.bind.txtSpeed = state.txt
  if not self.isPuase then
    self:setEntitySpeed(state.value, false)
  end
end

function this:setEntitySpeed(speed, isResume)
  self.animator.speed = speed
  C_MediaPackUtility.ChangeEffectSpeed(self.target, speed, isResume)
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  L_PhotoManager:removeListener(L_PhotoManager.event.selectPhotoHeroChange, self.onEvent_selectPhotoHeroChange, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.exitSingleAction, self.onEvent_exitSingleAction, self)
end

function this:update()
  if not self.animName or self.draging or not self.target then
    return
  end
  local isShow = self.actionId ~= self.defaultId
  if isShow then
    local state = self.animator:GetState(self.animName)
    self.bind.sliderVal = state.normalizedTime
  end
end

function this:initDefaultId()
  self.defaultId = L_Const.photoParam.idle
end

function this:getTargetEntity()
  return L_PhotoManager:getMediator().target
end

function this:updateTargetEntity(target)
  self.target = target or self:getTargetEntity()
  if self.target then
    self.animator = self.target.entity.data.animator
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
end

function this:playAction(actionId)
  if self.actionId == actionId then
    return
  end
  if L_PhotoManager:HeroCaressBlock(self.target) then
    self.bind.selectedId = -1
    self:setActionId(self.defaultId)
    return
  end
  local isMount = AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
  local isSwimming = AzurWorld.playerMgr.myPlayerData:GetIsSwimming()
  if isMount or isSwimming then
    self.bind.selectedId = -1
    L_FlyMsgManager:showNormalMsg(isMount and L_WordsTpl:getValue("notice_photo_noaction") or L_WordsTpl:getValue("notice_photo_action_forbidden"))
    return
  end
  local isIdle = AzurWorld.playerMgr.myPlayerData:GetIsIdle()
  if not isIdle then
    self.bind.selectedId = -1
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_action_forbidden"))
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
  local state = L_PhotoManager:getStateMachine(self.target.entity.data.entityId)
  if actionId == self.defaultId then
    if state then
      state:reset()
    end
  else
    state:doSingleAction(self.animName, true, function()
      C_LuaUtility.EnableEntityGrounderIK(self.target, true)
    end, true, nil, nil, actionId, nil, function()
      C_LuaUtility.EnableEntityGrounderIK(self.target, false)
    end)
  end
  self.animLen = self.animator:GetAnimatorStateLength(self.animName)
  self:setSpeed(2)
end

function this:innerTranslateAnimState(isReady)
  self.bind.goBtnStop = isReady
  self.bind.goBtnResume = not isReady
  self.isPuase = not isReady
  if isReady then
    local state = _SpeedState[self.speedIdx]
    self:setEntitySpeed(state.value, true)
  else
    self:setEntitySpeed(0, false)
  end
end

function this:translateAnimState(isReLoad)
  self:innerTranslateAnimState(isReLoad)
end

function this:animEvaluate(value)
  local state
  if self.animator.getState then
    state = self.animator:getState(self.animName)
  elseif self.animator.GetState then
    state = self.animator:GetState(self.animName)
  end
  local dt = (value - math.min(state.normalizedTime, 1)) * self.animLen
  self:setEntitySpeed(1, false)
  C_MediaPackUtility.AnimatorTimelineEvaluate(self.target, dt)
end

function this:setSelectState()
  self.target = self:getTargetEntity()
  if self.target then
    self.animator = self.target.entity.data.animator
  else
    self.animator = nil
    return
  end
  local mediator = L_PhotoManager:getMediator()
  if mediator then
    local state = L_PhotoManager:getStateMachine(self.target.entity.data.entityId)
    local curState = state:getCurState()
    if curState.stateType == L_Const.stateType.singlePhotoAction and curState.args.actionId then
      self:setActionId(curState.args.actionId)
      self.bind.selectedId = curState.args.actionId
      local speed = self.animator.speed
      if speed == 0 then
        self.isPuase = true
        self:setSpeed(2)
      else
        self.isPuase = false
        for i, v in pairs(_SpeedState) do
          if v.value == speed then
            self:setSpeed(i)
            break
          end
        end
      end
      self.bind.goBtnStop = not self.isPuase
      self.bind.goBtnResume = self.isPuase
    else
      self.bind.selectedId = -1
      self:setActionId(501)
    end
  end
end

function this:onClickCollect(isOn)
  L_PhotoManager:setCollectAction(self.actionId, isOn)
  for i, v in pairs(self.modules.list) do
    if v.bind.id == self.actionId then
      v.bind.isCollect = isOn
    end
  end
end

function this:onClickCancel()
  if L_PhotoManager:HeroCaressBlock(self.target) then
    self.bind.selectedId = -1
    self:setActionId(self.defaultId)
    return
  end
  self:playAction(self.defaultId)
  self.bind.selectedId = -1
  self.bindComponents.tabGroup:DeselectAll()
end

function this:onEvent_exitSingleAction(entity)
  if entity == self.target and self.target ~= nil then
    self:setActionId(self.defaultId)
    self.bind.selectedId = -1
    self.bindComponents.tabGroup:DeselectAll()
  end
end

return this
