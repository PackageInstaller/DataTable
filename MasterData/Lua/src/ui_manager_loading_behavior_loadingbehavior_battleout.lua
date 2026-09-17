local this = class("loadingBehavior_battleOut", require("ui.manager.loading.behavior.loadingBehavior"))

function this:open(options)
  this.super.open(self, options)
  local page = options.page
  self.bind = page.bind
  self.bindComponents = page.bindComponents
  self.imgFxOut = page.bindComponents.imgFxOut
  self.cuter = page.bindComponents.cuter
  self.gameObject = page.gameObject
end

function this:start()
  this.super.start(self)
  self.cuter:StartSceneCutOutAndCapture()
end

function this:complete()
  local t2d = self.cuter:RenderScreenTexture()
  self.imgFxOut.sprite = t2d:ToSprite()
  self.bind.goFxOut = true
  self.bind.goCutRoot = false
  if not table.isEmpty(L_BattleStore:getParseBattleReward()) then
    self.timerDic.settle = Timer.once(0.264, function()
      self.bind.csOrder = -1
      L_UI:open("pageBattleSettle")
      AzurWorld.PriorityQueueManager:Freeze(false, 2)
    end)
  end
  self.timerDic.complete = Timer.once(self:getCompleteDelayTime(), this.super.complete, self, self.gameObject)
end

function this:getCompleteDelayTime()
  return 1.25
end

return this
