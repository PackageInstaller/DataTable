local LoginScene = class("LoginScene", function()
  return display.newScene("LoginScene")
end)

function LoginScene:ctor(params)
end

function LoginScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
  if (device.platform == "ios" or device.platform == "android") and not UserData.pvTag then
    self:showPV()
  else
    self:showUI()
  end
end

function LoginScene:showUI()
  self.layer = game:createView("login.LoginLayer")
end

function LoginScene:showPV()
  local visibleRect = cc.Director:getInstance():getOpenGLView():getVisibleRect()
  local centerPos = cc.p(visibleRect.x + visibleRect.width / 2, visibleRect.y + visibleRect.height / 2)
  _G.touchMaskEnabled = false
  local skipLayer = UIHelper.extend(ccui.Layout:create())
  local videoPlayer = ccexp.VideoPlayer:create()
  videoPlayer:addTo(self)
  videoPlayer:setPosition(centerPos)
  videoPlayer:setAnchorPoint(cc.p(0.5, 0.5))
  videoPlayer:setContentSize(cc.size(display.width, display.height))
  videoPlayer:setFullScreenEnabled(true)
  videoPlayer:setKeepAspectRatioEnabled(true)
  local frameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
  if frameSize.width == 2436 and frameSize.height == 1125 then
    videoPlayer:setContentSize(cc.size(frameSize.width, frameSize.height))
    videoPlayer:setKeepAspectRatioEnabled(false)
  end
  game.videoHandler = videoPlayer
  
  local function onVideoEventCallback(sener, eventType)
    if eventType == ccexp.VideoPlayerEvent.STOPPED or eventType == ccexp.VideoPlayerEvent.COMPLETED then
      skipLayer:removeSelf()
      scheduler.performWithDelayGlobal(function()
        videoPlayer:removeSelf()
        _G.touchMaskEnabled = true
      end, 0.03333333333333333)
      self:showUI()
      UserData.pvTag = true
      game.videoHandler = nil
      GameState.save(UserData)
    end
  end
  
  videoPlayer:addEventListener(onVideoEventCallback)
  videoPlayer:setFileName(cc.FileUtils:getInstance():fullPathForFilename("video/openvcr.mp4"))
  videoPlayer:setTouchable(true)
  videoPlayer:play()
  skipLayer:size(display.width, display.height):addTo(self)
  skipLayer:setCallback(function()
    videoPlayer:stop()
  end)
end

return LoginScene
