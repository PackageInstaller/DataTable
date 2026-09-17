local this = class("modulePhotoBev", G_UIModuleBase)
local _gameClientTpl = L_GameTpl:getGameClientTpl()
local cameraPreset = _gameClientTpl:getData("PHOTO_CAMERA_SNAPSHOT", L_Const.GameTplType.list_float)
local CAMERA_PRESET_TYPE = {
  FAR = 1,
  MIDDLE = 2,
  NEAR = 3
}

function this.bind()
  return {
    bevTabList = {
      moduleName = "pages/photo/modulePhotoBevTabList"
    },
    camTabList = {
      moduleName = "pages/photo/moduleChangeCamTabList"
    },
    filled_imgBev = 1
  }
end

function this.methods()
  return {
    onClick_jump = function(self)
      L_PlayerManager:fireJump()
    end,
    onClick_dodge = function(self)
      L_PlayerManager:fireEvade()
    end,
    onClick_Capture = function(self)
      self:onClickCapture()
    end
  }
end

function this:open()
  self.currentBevTabId = L_Const.photoBevMode.capture
  self:InitBevList()
  self:bindScreenTouch("+")
  self:bindCameraJoystick()
  self:resetScreen()
end

function this:close()
  self:bindScreenTouch("-")
  self:unbindCameraJoystick()
  if self.cameraJoystickTimer then
    Timer.remove(self.cameraJoystickTimer)
  end
end

function this:InitBevList()
  local tabList
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    tabList = {
      L_Const.photoBevMode.capture
    }
  else
    tabList = {
      L_Const.photoBevMode.capture,
      L_Const.photoBevMode.recording
    }
  end
  self.modules.bevTabList:setData(tabList, handler(self, self.triggerBev), L_Const.photoBevMode.capture)
  self:triggerBev(L_Const.photoBevMode.capture)
end

function this:InitChangeCamTabList()
  self.comTabId = CAMERA_PRESET_TYPE.MIDDLE
  self:switchCameraPreset(self.comTabId)
  local tabList = {
    CAMERA_PRESET_TYPE.FAR,
    CAMERA_PRESET_TYPE.MIDDLE,
    CAMERA_PRESET_TYPE.NEAR
  }
  self.modules.camTabList:setData(tabList, handler(self, self.onSelectCamTabId), CAMERA_PRESET_TYPE.MIDDLE)
end

function this:onSelectCamTabId(tabId)
  if self.comTabId == tabId then
    return
  end
  self.comTabId = tabId
  self:switchCameraPreset(tabId)
end

function this:switchCameraPreset(index)
  if index <= 0 or index > #cameraPreset then
    return
  end
  local dis = cameraPreset[index]
  local fixFollow = C_CameraManager.GetFixedFollow()
  local cameraController = C_CameraManager.GetTactics(C_ECameraType.Photo)
  if fixFollow then
    if index == 3 then
      C_CameraManager.GetTactics(C_ECameraType.Photo):SetCameraDis(dis, true)
      if C_CameraManager.isNeedShowFace then
        fixFollow:ZoomInWithTarget()
      end
    else
      fixFollow:ZoomOutWithTarget()
      cameraController:StopBehavior(CS.Lens.Gameplay.Modules.BigWorld.CameraBehaviorComponent.BehaviorEnum.EDis)
      cameraController:ResetDistanceLimit()
      cameraController:SetCameraDis(dis, true)
    end
  end
end

function this:bindCameraJoystick()
  local joystick = self.bindComponents.cameraJoystick
  joystick.onPointerDownHandler = L_CommonUtil.handle(self.onCameraJoystickDragStart, self)
  joystick.onPointerUpHandler = L_CommonUtil.handle(self.onCameraJoystickDragEnd, self)
end

function this:unbindCameraJoystick()
  local joystick = self.bindComponents.cameraJoystick
  joystick.onPointerDownHandler = nil
  joystick.onPointerUpHandler = nil
end

function this:onCameraJoystickDragStart()
  if not self.cameraJoystickTimer then
    self.cameraJoystickTimer = Timer.repeated(0, function()
      local joystick = self.bindComponents.cameraJoystick
      local num = 0.011
      self:setScreen(-joystick.Horizontal * num, joystick.Vertical * num)
    end)
  else
    self.cameraJoystickTimer:resume()
  end
  self.parent:translateGrid(true)
end

function this:onCameraJoystickDragEnd()
  if self.cameraJoystickTimer then
    self.cameraJoystickTimer:pause()
  end
  self.parent:translateGrid(false)
end

function this:bindScreenTouch(sign)
end

function this:onClickCapture()
  if not L_PhotoManager:checkPhotoCanTouchClick() then
    return
  end
  local mediator = L_PhotoManager:getMediator()
  if mediator.bevMode == L_Const.photoBevMode.capture then
    self:emit("onClick_capture")
  elseif mediator.bevMode == L_Const.photoBevMode.recording then
    if L_UI:getPage("pagePhotographScene") ~= nil then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_task_photo_01"))
      return
    end
    self:emit("onClick_recording", self.bindComponents.anim_bevNode, self.bind)
  end
end

function this:resetScreen()
  local _gameTpl = L_GameTpl:getGameConstTpl()
  self.screenBoard = {
    rangX = _gameTpl:getData("PHOTO_X_MAX", L_Const.GameTplType.float),
    rangY = _gameTpl:getData("PHOTO_Y_MAX", L_Const.GameTplType.float),
    speed = _gameTpl:getData("PHOTO_MOVE", L_Const.GameTplType.float),
    curX = 0.5,
    curY = 0.5
  }
  local tatics = C_CameraManager.GetTactics(C_ECameraType.Photo)
  if tatics ~= nil then
    tatics:SetCameraScreen(self.screenBoard.curX, self.screenBoard.curY, true)
  end
end

function this:setScreen(x, y)
  local tatics = C_CameraManager.GetTactics(C_ECameraType.Photo)
  x = self.screenBoard.curX + x
  y = self.screenBoard.curY + y
  self.screenBoard.curX = math.clamp(x, 0.5 - self.screenBoard.rangX, 0.5 + self.screenBoard.rangX)
  self.screenBoard.curY = math.clamp(y, 0.5 - self.screenBoard.rangY, 0.5 + self.screenBoard.rangY)
  tatics:SetCameraScreen(x, y, true)
end

function this:getMediators()
  local calls = {
    bevMode = handler(self, this.translateBev)
  }
  return calls
end

function this:triggerBev(tabId)
  if self.currentBevTabId == tabId then
    return
  end
  self.currentBevTabId = tabId
  local mediator = L_PhotoManager:getMediator()
  mediator.bevMode = tabId == 1 and L_Const.photoBevMode.capture or L_Const.photoBevMode.recording
  self.modules.bevTabList:setSelectTabId(self.currentBevTabId)
end

function this:translateBev(mode)
  if mode == L_Const.photoBevMode.capture then
    self.bind.filled_imgBev = 1
    self.bindComponents.anim_bevNode:Play("anim_pagephoto_bottom_out")
  elseif mode == L_Const.photoBevMode.recording then
    self.bind.filled_imgBev = 0
    self.bindComponents.anim_bevNode:Play("anim_pagephoto_bottom_in")
  end
end

return this
