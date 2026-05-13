local battleGuideRes = "battle_guide/"
local carbonGuildResPath = "ui/carbon/carbonGuide"
local uiData = {
  csbFile = "ui/guide/ModuleGuideLayer.csb",
  mask = true,
  order = NEW_GUIDE_LAYER_ORDER,
  widgets = {
    mainBg = "mainBg",
    cancel = "mainBg/cancel",
    confirm = "mainBg/confirm",
    des = "mainBg/des",
    name = "mainBg/name",
    title = "mainBg/title"
  }
}
local ModuleGuideLayer = class("ModuleGuideLayer", UIBase)

function ModuleGuideLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ModuleGuideLayer:init(params)
  self.mainBg:setScaleY(0)
  self.mainBg:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1, 1)))
  self.guideData = params.guideData
  self.des:setString(self.guideData.desc)
  self.name:setString(self.guideData.title)
  self.title:enableOutline(UIHelper.hex2rgb("#000000"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
  if self.guideData.guideId == 10024 then
    self.cancel:hide()
    self.confirm:pos(321, 53)
  end
  self.cancel:setCallback(function()
    game.role:saveGuideData({
      master = self.guideData.guideId,
      slave = 1,
      finish = 1,
      skip = 1
    })
    game.role.activeGuide[tostring(self.guideData.guideId)] = 1
    self:close()
    local mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      color = "#000000",
      opacity = 110
    })
    mask:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER)
    mask:setTouchEnabled(true)
    UIHelper.newImageView("ui/guide/hintbg.png"):center(mask):addTo(mask):scale(0.4):runAction(transition.sequence({
      cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)),
      cc.CallFunc:create(function()
        mask:setCallback(function()
          mask:removeFromParent()
          if params.cancelCall then
            params.cancelCall()
          end
        end)
      end)
    }))
  end)
  self.confirm:setCallback(function()
    game:enterScene("MainScene", {
      guideId = self.guideData.guideId,
      minorStep = 1
    })
  end)
end

function ModuleGuideLayer:showData(params)
end

return ModuleGuideLayer
