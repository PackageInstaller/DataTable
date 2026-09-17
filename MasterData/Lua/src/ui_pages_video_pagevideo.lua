local page = class("pageVideo", G_UIPageBase)
local CriWareStatus = CS.CriWare.CriMana.Player.Status

function page:bind()
  return {
    showSkipButton = false,
    videoTrans = nil,
    bgTrans = nil
  }
end

function page:methods()
  return {
    skipClick = function(self)
      self:onSkipVideo()
    end
  }
end

function page:escHandle()
end

function page:playVideoStart()
  self.videoObj = self.videoTrans:GetComponent(typeof(C_CriManaMovieControllerForUI))
  if self.videoObj and not self.videoObj:IsNull() then
    Unity.GameObject.Destroy(self.videoObj)
  end
  self.videoObj = self.videoTrans.gameObject:AddComponent(typeof(C_CriManaMovieControllerForUI))
  self.videoObj.player.statusChangeCallback = handler(self, page.statusChangeCallback)
  self.videoObj.moviePath = "Video\\Story\\ast_video_" .. self.storyId .. ".usm"
  self.videoObj.playOnStart = true
  self:adjustVideoSize()
end

local targetWidth = 1920
local targetHeight = 1080

function page:adjustVideoSize()
  local screenWidth = self.bgTrans.rect.size.x
  local screenHeight = self.bgTrans.rect.size.y
  if self.lastScreenHeight == screenHeight and self.lastScreenWidth == screenWidth then
    return
  end
  self.lastScreenHeight = screenHeight
  self.lastScreenWidth = screenWidth
  local screenAspect = screenWidth / screenHeight
  local targetAspect = targetWidth / targetHeight
  if screenAspect > targetAspect then
    local width = targetAspect * screenHeight
    self.videoTrans.sizeDelta = C_Vector2(width, screenHeight)
  else
    local height = screenWidth / targetAspect
    self.videoTrans.sizeDelta = C_Vector2(screenWidth, height)
  end
end

function page:update()
  self:adjustVideoSize()
end

function page:onSkipVideo()
  self:playVideoEnd()
end

function page:clear()
  if self.videoObj and not self.videoObj:IsNull() then
    self.videoObj.player.statusChangeCallback = nil
    Unity.GameObject.Destroy(self.videoObj)
    self.videoObj = nil
  end
  self.lastScreenWidth = nil
  self.lastScreenHeight = nil
end

function page:close(options)
  self.super.close(self, options)
  self:clear()
end

function page:playVideoEnd()
  self:clear()
  if self.callback then
    self.callback()
  end
end

function page:preOpen(options)
  self.bind.showSkipButton = options.showSkipButton
  self.storyId = options.id
  self.callback = options.callback
  self.playStatus = CriWareStatus.Stop
  self.videoTrans = self.uiBinding:GetRectTransform("videoTrans")
  self.bgTrans = self.uiBinding:GetRectTransform("bgTrans")
  self:clear()
  self:playVideoStart()
end

function page:statusChangeCallback(status)
  self.playStatus = status
  if status == CriWareStatus.Error then
    self:playVideoEnd()
  elseif status == CriWareStatus.PlayEnd then
    self:playVideoEnd()
  end
end

return page
