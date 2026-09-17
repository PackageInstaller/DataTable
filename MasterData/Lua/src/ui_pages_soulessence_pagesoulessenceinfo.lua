local this = class("pageSoulEssenceInfo", G_UIPageBase)
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local GamepadArea = {Poster = 1, Anim = 2}
local GamepadAreaConfigs = {
  [GamepadArea.Poster] = {areaName = "Poster", shortCutGroupName = "Poster"},
  [GamepadArea.Anim] = {areaName = "Anim", shortCutGroupName = "Anim"}
}

function this.bind()
  return {
    textName = "",
    textDesc = "",
    qualityImage = "",
    path_cg = "",
    module_video = {
      moduleName = "pages/video/moduleVideo"
    },
    storyNodeActive = false,
    lockTipActive = false,
    playBtnActive = false,
    lockTips = "",
    lineActive = true,
    go_Skip = false,
    go_close = false,
    go_prefab = false,
    go_TopRight = false
  }
end

function this.methods()
  return {
    onClose = function(self)
      self:onClickClose()
    end,
    onClick_storyBtn = function(self)
      if math.isEmpty(self.storyId) then
        return
      end
      C_SoulEssenceMgr:req_CSProtoLiZiStoryRecored(self.options.id)
      AzurWorld.StoryMgr:PlayStory(self.storyId)
    end,
    onClick_storyLock = function(self)
      if math.isEmpty(self.taskId) then
        return
      end
      local data_tip = {
        txtContent = L_WordsTpl:getValue("ui_soulessence_story_task_jump"),
        confirmCallback = function()
          L_UI:backToRoot()
          L_UI:open("pageTask", {
            taskId = self.taskId
          })
        end
      }
      L_GameUtil.showCommonTip(data_tip)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  local options = self.options or {}
  self.options = options
  if self.csharpPage ~= nil then
    self.wait = self.csharpPage:AddWaitComponent()
    self.soulessenceId = self.options.id
    self.conf = _soulessenceTpl:getTplById(self.soulessenceId)
    self.bind.path_cg = _soulessenceTpl:getCgPath(self.conf)
    
    function self.bindComponents.prefabBox.loadCallBack()
      self.wait:WaitOver(true)
    end
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.firstOpen = true
  if options.callback then
    self._closeCB = options.callback
  end
  self.inputActionBinding = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UIInputActionBinding))
  self.gamepadArea = GamepadArea.Poster
  self.isGamepadShortcutVisible = false
  self.gamepadActiveTime = L_TimeUtil.getServerTime()
  self.timeCounter = L_TimeUtil.getServerTime()
  self.shortcutAdded = false
  L_UI:addListener(L_UI.pageEvent.showed, self.onShowed, self)
  self.updateTimer = Timer.repeated(0.1, self.updateHandler, self)
end

function this:open(options)
  C_UIMgr.pushPopUIRTStack(false)
  self:InitRect()
  self:refreshPage()
  self:configTouch("+")
end

function this:show()
  if self.firstOpen == false then
    self.bindComponents.ani_pageSoulEssenceInfo:Play("anim_heroes_soulessenceinfo_in")
    local animationSound = _soulessenceTpl:getAnimationSound(self.conf)
    local animationBgm = _soulessenceTpl:getAnimationBgm(self.conf)
    if animationSound ~= "" then
      self.animationSoundWrap = L_AudioUtil.playSound(animationSound)
    end
    if animationBgm ~= "" then
      self.animationBgmWrap = L_AudioUtil.playSound(animationBgm)
    end
  end
  self.firstOpen = false
end

function this:hide()
  if self.animationSoundWrap then
    L_AudioUtil.stopSound(self.animationSoundWrap)
  end
  if self.animationBgmWrap then
    L_AudioUtil.stopSound(self.animationBgmWrap)
  end
  L_AudioUtil.playSound("Stop_SFX_SoulEssence")
  L_AudioUtil.playSound("Stop_SFX_SoulEssence_In")
  L_AudioUtil.playSound("Stop_Music_SoulEssence")
end

function this:close(options)
  C_UIMgr.popUIRTStack()
  this.super.close(self, options)
  self:configTouch("-")
  if self._closeCB then
    self._closeCB()
  end
  self.inputActionBinding = nil
  L_UI:removeListener(L_UI.pageEvent.showed, self.onShowed, self)
  if self.updateTimer then
    Timer.remove(self.updateTimer)
    self.updateTimer = nil
  end
end

function this:onTopChange(options)
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  self.isTop = self.pageName == curPageName
end

function this:escHandle()
  if C_InputManager.IsEnableGamePad and self.gamepadArea == GamepadArea.Anim then
    return
  end
  L_UI:close(self.pageName)
end

function this:refreshPage()
  local videoPath = _soulessenceTpl:getVideo(self.conf)
  local animationSound = _soulessenceTpl:getAnimationSound(self.conf)
  local animationBgm = _soulessenceTpl:getAnimationBgm(self.conf)
  self.bind.textName = _soulessenceTpl:getName(self.conf)
  self.bind.textDesc = _soulessenceTpl:getDesc(self.conf)
  local qual = _soulessenceTpl:getRarity(self.conf)
  self.bind.qualityImage = "PageSoulEssence/tex_herosoulessence_zk_icon_" .. qual
  self.bind.storyNodeActive = not self.options.isPreview
  if not self.options.isPreview then
    AzurWorld.RedDotMgr:BindRedDotRenderer(string.format("SoulEssenceStory_%s", self.soulessenceId), self.bindComponents.storyRedDot.gameObject)
  end
  if videoPath and videoPath ~= "" then
    self:setSpineActive(false)
    self.gamepadArea = GamepadArea.Anim
  else
    self:setSpineActive(true)
    self.gamepadArea = GamepadArea.Poster
  end
  self:setStoryNode(false)
  self.bind.go_Skip = true
  self.bind.go_close = false
  self.bind.go_TopRight = false
  self._videoModule = self.modules.module_video
  self._videoModule:playVideo(videoPath, function(duration)
    self.videoSoundWrap = L_AudioUtil.playSound(_soulessenceTpl:getVideoSound(self.conf))
    self:newOrResetTimer("onVideoEnd", function()
      if not self._isVideoEnd then
        self.bind.go_Skip = false
        self.bind.go_close = true
        self.bind.go_TopRight = true
        if self.videoSoundWrap then
          L_AudioUtil.stopSound(self.videoSoundWrap)
        end
        L_AudioUtil.playSound("Stop_SFX_SoulEssence_In")
        if animationSound ~= "" then
          self.animationSoundWrap = L_AudioUtil.playSound(animationSound)
        end
        if animationBgm ~= "" then
          self.animationBgmWrap = L_AudioUtil.playSound(animationBgm)
        end
        self.bindComponents.ani_pageSoulEssenceInfo:Play("anim_heroes_soulessenceinfo_in_1")
        self._isVideoEnd = true
        self:setStoryNode(true)
        self:setSpineActive(true)
        self.gamepadArea = GamepadArea.Poster
        self:refreshGamepadArea()
      end
    end, duration - 1)
  end, function()
    if not self._isVideoEnd then
      self.bind.go_Skip = false
      self.bind.go_close = true
      self.bind.go_TopRight = true
      if self.videoSoundWrap then
        L_AudioUtil.stopSound(self.videoSoundWrap)
      end
      L_AudioUtil.playSound("Stop_SFX_SoulEssence_In")
      if animationSound ~= "" then
        self.animationSoundWrap = L_AudioUtil.playSound(animationSound)
      end
      if animationBgm ~= "" then
        self.animationBgmWrap = L_AudioUtil.playSound(animationBgm)
      end
      self.bindComponents.ani_pageSoulEssenceInfo:Play("anim_heroes_soulessenceinfo_in")
      self._isVideoEnd = true
      self:setStoryNode(true)
      self:setSpineActive(true)
      self.gamepadArea = GamepadArea.Poster
      self:refreshGamepadArea()
    end
  end)
end

function this:setStoryNode(isShow)
  if self.options.isPreview then
    self.bind.storyNodeActive = false
    return
  end
  self.bind.storyNodeActive = isShow
  if not isShow then
    return
  end
  local spId = self.options.id
  local conf = _soulessenceTpl:getTplById(spId)
  self.bind.storyNodeActive = not math.isEmpty(_soulessenceTpl:getStory(conf))
  if not self.bind.storyNodeActive then
    return
  end
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_soulessenceTpl:getStoryLock(conf))
  self.bind.lockTipActive = not isComplete
  if not isComplete then
    self.bind.lockTips = L_ConditionManager:getDescs(_soulessenceTpl:getStoryLock(conf))[lockIndex]
  end
  self.bind.playBtnActive = not self.bind.lockTipActive
  self.taskId = _soulessenceTpl:getTask(conf)
  self.storyId = _soulessenceTpl:getStory(conf)
end

function this:setSpineActive(active)
  self.bind.go_prefab = active
end

function this:InitRect()
  self.imgScale = 1
  local width = self.bindComponents.rect_move.rect.width
  local height = self.bindComponents.rect_move.rect.height
  local showW = self.bindComponents.rect_Bgmask.rect.width
  local showH = self.bindComponents.rect_Bgmask.rect.height
  self.showSize = L_Vector3.new(showW / 2, showH / 2)
  self.halfX = width * 0.5
  self.halfY = height * 0.5
end

function this:configTouch(operator)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function this:onUI_dragStartHandle(gesture)
end

function this:onUI_dragHandle(gesture)
  if self.bindComponents == nil or self.bindComponents.rect_move == nil then
    return
  end
  self:setMapPosition(gesture.deltaPosition)
end

function this:setMapPosition(deltaPos)
  local imgPos = L_Vector3.getAnchored(self.bindComponents.rect_move)
  imgPos.x = imgPos.x + deltaPos.x
  imgPos.y = imgPos.y + deltaPos.y
  imgPos = self:clampImgPos(imgPos)
  L_Vector3.setAnchored(self.bindComponents.rect_move, imgPos)
end

function this:clampImgPos(imgPos)
  local offsetX = self.halfX * self.imgScale - self.showSize.x
  local offsetY = self.halfY * self.imgScale - self.showSize.y
  if offsetX < 0 then
    imgPos.x = 0
  else
    imgPos.x = math.clamp(imgPos.x, -offsetX, offsetX)
  end
  if offsetY < 0 then
    imgPos.y = 0
  else
    imgPos.y = math.clamp(imgPos.y, -offsetY, offsetY)
  end
  return imgPos
end

function this:onUI_dragEndHandle(gesture)
end

function this:onClickClose()
  L_UI:close(self.pageName)
end

function this:onShowed()
  self:refreshGamepadArea()
end

function this:updateHandler()
  if self.isOpen and self.isShow and self.isTop then
    self:update()
  end
end

function this:update()
  if self.gamepadArea ~= GamepadArea.Poster then
    return
  end
  if L_TimeUtil.getServerTime() - self.timeCounter > 0.2 then
    self.timeCounter = L_TimeUtil.getServerTime()
    if self.isGamepadShortcutVisible then
      if C_InputManager.IsGamepadActive then
        self.gamepadActiveTime = L_TimeUtil.getServerTime()
      else
        local inactivedTime = L_TimeUtil.getServerTime() - self.gamepadActiveTime
        if 3.0 < inactivedTime then
          self.isGamepadShortcutVisible = false
          self.inputActionBinding.inputIconEnabled = false
          self:changeGamepadBottonCutsGroup(nil)
        end
      end
    elseif C_InputManager.IsGamepadActive then
      self.isGamepadShortcutVisible = true
      self.inputActionBinding.inputIconEnabled = true
      self:changeGamepadBottonCutsGroup(GamepadAreaConfigs[GamepadArea.Poster].areaName)
    end
  end
end

function this:refreshGamepadArea()
  if self.gamepadArea == GamepadArea.Poster then
    self.gamepadActiveTime = L_TimeUtil.getServerTime()
    self.isGamepadShortcutVisible = true
    self:changeGamepadInputArea(GamepadAreaConfigs[GamepadArea.Poster].areaName)
    self.inputActionBinding.inputIconEnabled = true
    self:changeGamepadBottonCutsGroup(GamepadAreaConfigs[GamepadArea.Poster].shortCutGroupName)
    self.bind.go_close = not C_InputManager.IsEnableGamePad
    self.bind.go_TopRight = not C_InputManager.IsEnableGamePad
  elseif self.gamepadArea == GamepadArea.Anim then
    self:changeGamepadInputArea(GamepadAreaConfigs[GamepadArea.Anim].areaName)
    self.inputActionBinding.inputIconEnabled = true
    self:changeGamepadBottonCutsGroup(GamepadAreaConfigs[GamepadArea.Anim].shortCutGroupName)
  end
end

function this:changeGamepadInputArea(areaName)
  local pageName = tostring(self.pageName)
  local ok, err = pcall(function()
    CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:ReplaceArea(pageName, areaName)
  end)
  if not ok then
    C_MJLog.LogError("changeGamepadInputArea Invoke. UIPageAreaStateMachine.ReplaceArea failed with error: " .. tostring(err))
    return
  end
end

function this:changeGamepadBottonCutsGroup(shortCutGroupName)
  if shortCutGroupName == nil then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange)
  else
    local pageName = tostring(self.pageName)
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {moduleOrPageName = pageName, changeGroupName = shortCutGroupName}
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
  end
end

return this
