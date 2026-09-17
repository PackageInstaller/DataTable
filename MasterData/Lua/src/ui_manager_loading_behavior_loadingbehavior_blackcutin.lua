local this = class("loadingBehavior_blackCutIn", require("ui.manager.loading.behavior.loadingBehavior"))

function this:open(options)
  this.super.open(self, options)
  local page = options.page
  self.bind = page.bind
  self.bindComponents = page.bindComponents
  self.blackCutInTime = options.blackCutInTime or -1
  self.cuter = page.bindComponents.cuter
  self.imgBg = page.bindComponents.imgBg
  self.gameObject = page.gameObject
  self.rt = C_RenderTexture.GetTemporary(C_Screen.width, C_Screen.height)
end

function this:start()
  this.super.start(self)
  local uiCamera = C_CameraManager.uiCamera
  self.cuter:StartSceneCutOut(self.blackCutInTime)
  uiCamera:Capture(self.rt, false, false, function()
    self.imgBg.gameObject:ActiveTrans(true)
    self.imgBg.texture = self.rt
  end)
end

function this:complete()
  self.imgBg.gameObject:ActiveTrans(false)
  self.cuter:ContinueSceneCut()
  self.timerDic.complete = Timer.once(self.cuter.phaseTime2, this.super.complete, self, self.gameObject)
end

function this:onDestroy()
  C_RenderTexture.ReleaseTemporary(self.rt)
  self.imgBg.gameObject:ActiveTrans(false)
  this.super.onDestroy(self)
end

return this
