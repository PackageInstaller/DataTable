local this = class("loadingBehavior_battleIn", require("ui.manager.loading.behavior.loadingBehavior"))

function this:open(options)
  this.super.open(self, options)
  local page = options.page
  self.bind = page.bind
  self.bindComponents = page.bindComponents
  self.imgFxIn = page.bindComponents.imgFxIn
  self.cuter = page.bindComponents.cuter
  self.gameObject = page.gameObject
end

function this:start()
  this.super.start(self)
  self.cuter:StartSceneCutIn()
end

function this:updateProgressMax(options)
  self.timerDic.max = Timer.once(0.1, self.complete, self, self.gameObject)
end

function this:complete()
  local t2d = self.cuter:RenderScreenTexture()
  self.imgFxIn.sprite = t2d:ToSprite()
  self.bind.goFxIn = true
  self.bind.goCutRoot = false
  self.timerDic.complete = Timer.once(self:getCompleteDelayTime(), this.super.complete, self, self.gameObject)
end

function this:getCompleteDelayTime()
  return 1.25
end

return this
