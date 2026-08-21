local ChooseCsv = require("csvdata.choose_one")
local uiData = {
  csbFile = "ui/carbon/ChoicePointLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    btn1 = "btn1",
    btn2 = "btn2",
    text = "text",
    bg = "bg",
    title = "title",
    content = "content"
  }
}
local CarbonSelectLayer = class("CarbonSelectLayer", UIBase)

function CarbonSelectLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonSelectLayer:init(params)
  local chooseData = ChooseCsv[params.id]
  self.text:setString(chooseData.choose_desc)
  self.btn1:setCallback(function()
    params.callback(1, self)
  end)
  self.btn2:setCallback(function()
    params.callback(2, self)
  end)
  self.bg:setTexture(chooseData.desc_path)
  self.btn1:setTitleText(chooseData.chose1_content)
  self.btn2:setTitleText(chooseData.chose2_content)
  local choiceEff = UIHelper.createSpineNodeByRes("spine/ui/carbon/choice")
  choiceEff:addTo(self.title)
  choiceEff:setAnimation(0, "special", false)
  self.bg:setScaleY(0)
  self.bg:runAction(transition.sequence({
    cc.ScaleTo:create(0.2, 1, 1.05),
    cc.ScaleTo:create(0.16, 1, 0.95),
    cc.ScaleTo:create(0.16, 1, 1)
  }))
  self.content:setScaleY(0)
  self.content:runAction(transition.sequence({
    cc.DelayTime:create(0.1),
    cc.ScaleTo:create(0.2, 1, 1.05),
    cc.ScaleTo:create(0.16, 1, 0.95),
    cc.ScaleTo:create(0.16, 1, 1)
  }))
  self.text:opacity(0)
  self.text:setPositionX(self.text:getPositionX() + 40)
  self.text:runAction(transition.sequence({
    cc.DelayTime:create(0.4),
    cc.Spawn:create({
      cc.MoveBy:create(0.3, cc.p(-40, 0)),
      cc.FadeIn:create(0.3)
    })
  }))
  self.btn1:hide()
  self.btn1:opacity(0)
  self.btn1:setCascadeOpacityEnabled(true)
  self.btn1:setPositionX(self.btn1:getPositionX() + 25)
  self.btn1:runAction(transition.sequence({
    cc.DelayTime:create(0.6),
    cc.Show:create(),
    cc.Spawn:create({
      cc.MoveBy:create(0.3, cc.p(-25, 0)),
      cc.FadeIn:create(0.3)
    })
  }))
  self.btn2:hide()
  self.btn2:opacity(0)
  self.btn2:setCascadeOpacityEnabled(true)
  self.btn2:setPositionX(self.btn2:getPositionX() + 25)
  self.btn2:runAction(transition.sequence({
    cc.DelayTime:create(0.8),
    cc.Show:create(),
    cc.Spawn:create({
      cc.MoveBy:create(0.3, cc.p(-25, 0)),
      cc.FadeIn:create(0.3)
    })
  }))
end

function CarbonSelectLayer:showData()
end

return CarbonSelectLayer
